Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EEDC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2E2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 19:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAE2MqXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F2E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOC5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:57:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39037 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeJOC5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:57:13 -0400
Received: by mail-it1-f195.google.com with SMTP id m15so1386996itl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7/1Oefmkv5n9dD7s//XENk5JjUK05frQxhbQHWnIAM=;
        b=OAE2MqXE8g9wmV7Uff/cA+Qhf+z40YlAjQdGU0KYzb7qvdajn+gGMdz40brhQUkR+O
         /Zp4pUSOtaEv24KrRqTlvarVSmANtEAD2eviTYT4VMRd2szGGGtI0E4ZxuWYF461/CUX
         NnqFnBFORjF35w0qVl9kTApEBZSG8kwYVcM0CFMuIFYBUyr6PotAJ3rK7wt6j5No6J++
         A/P4SEszes1ZtoNcypgzWY3eXwapLjsX2mVSSsHKnEf49Sef5VrexR3Zw7viyTwa0zuC
         Au1WEgLM8HHmGyB1KbHsCs42Prb/uaYy4xDx4tZ6+ZDAKW5dhHmgz6/UEeD9L16Ai0Q1
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7/1Oefmkv5n9dD7s//XENk5JjUK05frQxhbQHWnIAM=;
        b=Mxm4LSdy+K6mz8H11mUcKoEovl4Rkq0b6pqedSNeSsKLuT+j8eI/rO7Zfv/I/vc801
         oz98AiKrEs94u2DThx+kuSI/bmAuhayGfdVp4FKchBE0FkPSNDHC0XL3YCW95Kga3FeK
         fZPyqCPJGigU430dPqd6Bwr1UzMGdeal6dzi3aBmBSwnJw4Sd3noVwX9CdNmts3ChNqJ
         VOiF5U8rZ0012vpq16bCYD4J118l4rTFJ/ejnTXed14jVMvqlX6G1sLoHbxDTbz3q2Ob
         fWwSrdCLW9MGCLsTTFITKGSUu6cgNVjDAQoRfgT4H8am9hkTm036niXw692pjUyqfKLr
         BxnQ==
X-Gm-Message-State: ABuFfog16i5JIqsXnWpVxLf/TF9H/d9z54ycwQwtZMjLsX+gkzr/DvcG
        TwpXaxsWr/6RdpTv3wOZmWFdj2lifXRbVfSIcJtEioA7
X-Google-Smtp-Source: ACcGV62slgmE88P5fL9ceebZ1BLNnzw+w1lGc92ml1fVN3PB74arfqMThe0W2KR1EOTsZTQLG0Vm+8c++EJekiRmDEE=
X-Received: by 2002:a02:85a3:: with SMTP id d32-v6mr11794133jai.69.1539544512890;
 Sun, 14 Oct 2018 12:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181014183510.18908-1-ubizjak@gmail.com> <20181014184735.GC7667@zn.tnic>
In-Reply-To: <20181014184735.GC7667@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 14 Oct 2018 21:15:00 +0200
Message-ID: <CAFULd4YZyQUjdVbLiM-HUCL_dbvA_oKNhDCXbAKr2L8y0cvSrA@mail.gmail.com>
Subject: Re: [PATCH] x86: Use assembly instruction mnemonics instead of .byte
 streams in arch_hweight.h
To:     bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 8:47 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Oct 14, 2018 at 08:35:10PM +0200, Uros Bizjak wrote:
> > Recently the minimum required version of binutils was changed to 2.20,
> > which supports popcnt instruction mnemonics. The patch removes
> > all .byte #defines and uses real instruction mnemonics instead.
>
> What is "real insertion mnemonics" ?

The ChangeLog says "real INSTRUCTION mnemonics", e.g. POPCNTQ and POPCNTL.

> To me it looks like this patch replaces our defines with binutils'
> defines and frankly, if it ain't broke, why fix it...

The compiler will generate the register name with the correct implied
width (e.g. %rax for long, %eax for int), so the assembler will be
able to cross check if operands fit the instruction (this issue
happened in KVM, see [1]). And there will be a couple of ugly #defines
less.

[1] https://www.spinics.net/lists/kvm/msg176184.html

Uros.
