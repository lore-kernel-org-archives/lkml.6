Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14019C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35402083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQpYfNsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35402083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeIAWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 18:19:47 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38258 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeIAWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 18:19:46 -0400
Received: by mail-it0-f54.google.com with SMTP id p129-v6so11051580ite.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkaw6RQ/Tt0ARhRLyp5aIwQggZ3L2hw/OvJe7JcgkfE=;
        b=KQpYfNsLWczfNSl+PSwRtzawMMYsuOWckBoMJS7t9Bkp5wF9Ih61ug+35i1Tvjz+Bw
         rH3vcLdrrEdUwNsdUwFtzVMzOcG2I78gOmDzw86msZLcjMd4yB12IJhdlEoCnpK4Tt6E
         YKRqKYAOZ48DOXfgchwq8Yq2LI/QA7nUS9V0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkaw6RQ/Tt0ARhRLyp5aIwQggZ3L2hw/OvJe7JcgkfE=;
        b=Zr3rkx4S2j29vzmTx7h8C6pN8dHuHkmZ1ef35GAwW4m0pTbnOM8TTPOeEsMRpp4vUZ
         FQO93FI3h8P+4dfjHwMl19fNRcK5GBEX+men+1vsKX1A7R1kJEdfsOpTbEeLVYzT72DZ
         fXJ3Z8hhTchGjFIQ2LqLwDHaRomu7+N6D4HlamS1Y8MB6v6hkv4VZNsKPOhXcOOoHB6/
         mopF9xgEyizn64siFX39JbCfIIiVrAcnK73ToNqS2UFdD+fOtTcMYqNH0iEYpfVz1Kyj
         +eXsx3PG6hk1Gyyaia0KoNFBKH+I1oqC1dRid9Q4j6lPkF+XyiXMMa09S8Kn09tj1/vd
         YtXA==
X-Gm-Message-State: APzg51AAsq+d1uhLoTXffiGHQUmvpEi4LPfy1ZGKRny412aAhSiSboHo
        lDi/fpiuTrRUXky2fAarVgMG61ZboLBUE4VVNQ4=
X-Google-Smtp-Source: ANB0VdaHsy/SVP9Nw9+SGzdruIFRMlytRCZjcex+F33q0Ulyeph3SCfIO/n38SSqt5RjF8TeLKDI4dEvEvjRso0gVGQ=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr15568747jal.72.1535825217299;
 Sat, 01 Sep 2018 11:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
In-Reply-To: <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Sep 2018 11:06:46 -0700
Message-ID: <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding a few new people the the cc.

  The issue is the worry about software-speculative accesses (ie
things like CONFIG_DCACHE_WORD_ACCESS - not talking about the hw
speculation now) accessing past RAM into possibly contiguous IO ]

On Sat, Sep 1, 2018 at 10:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you have a machine with RAM that touches IO, you need to disable
> the last page, exactly the same way we disable and marked reserved the
> first page at zero.
>
> I thought we already did that.

We don't seem to do that.

And it's not just the last page, it's _any_ last page in a region that
bumps up to IO. That's actually much more common in the low 4G area on
PC's, I suspect, although the reserved BIOS ranges always tend to be
there.

I suspect it should be trivial to do - maybe in
e820__memblock_setup()? That's where we already trim partial pages
etc.

In fact, I think this might be done as an extension of commit
124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved"), except making sure that non-RAM regions mark one
page _previous_ as reserved too.

I assume memory hotplug might have the same issue, and checking
whether ARM64 and powerpc perhaps might have already done something
like this (or might need to add it).

We discussed long ago the case of user space mapping IO in user space,
and decided we didn't care. But the kernel should probably explicitly
make sure we don't either, even if I can't recall having ever seen a
machine that actually maps IO contiguously to RAM. The layout always
tends to end up having holes anyway.

              Linus
