Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3309B26D4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ci57ArSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3309B26D4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeFZPkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:40:51 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:39050 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeFZPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:40:49 -0400
Received: by mail-it0-f46.google.com with SMTP id p185-v6so2961308itp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/XOJJOFAvJ9zEKXndZeKcn97r6QfIrvYAM4E66H2hg=;
        b=Ci57ArSCEpW+b1xczntg4es7Ua0raraqjYcwKDuJpnjuhCt5Rnqv3tSHjBg03Zw33C
         Ds5oscCfh/QDa6EhHJPI71gPfZUdGhZTOWBAF2aoNPuQgDrjZlWF2pmwfrG3bGpt7sVE
         x2SV6XuL73fd/EFPO0LhKq2ILBafGEnkORyvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/XOJJOFAvJ9zEKXndZeKcn97r6QfIrvYAM4E66H2hg=;
        b=RryVfDheQze4Urb5UOXxIavFnLwoGAMETsyC8BQnRRxes7cbj6FwnmITmNnE18aJTw
         ND9CnPkJS+DC2yDuiyBAIWdlsN7DID0Orq7gqvZ2z9bxxotH341RnG5HrJUpmSpXVrVG
         drAG46uG4d+8tQLwGp/16RH1VrzBRweaHBl6OoZXaP8F7n9GZWR39cfapBUqhqj/P4YR
         cLgVEIizSkwpioZvScXYco35o9O0hpTNqzO7S+/ixVPRGF+Cumfz1aObWCOARml6nwWl
         8mAQpOywwNcRTdzKjbWRuHfFcaioHWP2S3sytFsaSzRyUd0YoB8SdPd4S8+zL6AfjTrd
         Svrw==
X-Gm-Message-State: APt69E2tLXM2X5KUQ4iosBpzeWzy7U1M4GfxpXa2R3a5Oc2hKrr7FFgF
        fcsOsWeylwMpNkSkJ5oTWga3JTpgFvZ1iiK/w6Lr5A==
X-Google-Smtp-Source: AAOMgpdPXftUIYtpW2uPKo/WiLuK4zPGirT1lQBc4bKnrd5jxDkFu9Y1efVbuhTuoVa8fBzAh/O1aI1xrtx5oX3VThk=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr1739650jas.72.1530027649093;
 Tue, 26 Jun 2018 08:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
 <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com> <20180625163147.GA7112@roeck-us.net>
In-Reply-To: <20180625163147.GA7112@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jun 2018 08:40:37 -0700
Message-ID: <CA+55aFwZ1+HEYjo52OmX-aXEJ5iaGMakhJEZq1uY=CVKGdBSgg@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mcroce@redhat.com,
        sbrivio@redhat.com, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 9:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Yes, looks like they tried again with c24fb5e68ebf ("bpfilter: fix user
> mode helper cross compilation"), but it still doesn't work.

That was a different issue - an actual cross-build environment.

The problem on x86-64 cross-building to i386 is that the *compiler* is
the same, but the flags are not, and the games the Makefile plays
aren't sufficient. It plays with changing HOSTCC to CC in order to get
he right target compiler, but since the difference between i386 and
x86-64 is not the compiler but the "-m64" in the cflags, it doesn't
actually do what it intended to do.

We'll get it sorted, I think. The problem is that the current Makefile
infrastructure doesn't have any support for building a stand-alone
binary for the target, which is why the code plays games with HOSTCC
(to use the infrastructure that does binaries for the host, but using
the target compiler).

So it's all a bit hacky right now, and the hacks come back and bite us
for the x86-64/i386 case.

               Linus
