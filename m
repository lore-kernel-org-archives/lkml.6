Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC07C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169220693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="eJov9CPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1169220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964783AbeFRRvN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:51:13 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32859 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:51:12 -0400
Received: by mail-io0-f175.google.com with SMTP id d185-v6so17624452ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U+VtV7Y6jgftswiqAhm6NqOP8JwJgrqQRiCIW31sYgo=;
        b=eJov9CPVVrqifrOmW2tF/ZabegngskAnQuIaYG/y/k1vKUUjDCBsrthcoKDQvsEvPM
         jrAzPlUwYRa2YOITIMHkMYGr6S8cDHdej8kuBdSjf6Iy2a2m8BFD3pYB9uelr4kXgv32
         /QTNCS4+TTbGzIuHPIexUmp7U78vXeQGYSUIaq1el6MO0fvjCY0CG6WXeR8r0ee2s7Jl
         cz4XdKgcVPnc/IIf68sSo+cigtmEJUs+8aJpdqdStPOZUf6sLNNjVklNL5BZbanuyb++
         LGUF/sOUgYBhweZqFgJ4MLwvWuE4C0jWvwIR5H0PCjztbVuvisVQmxPWub9+TMM3ZkeI
         vH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U+VtV7Y6jgftswiqAhm6NqOP8JwJgrqQRiCIW31sYgo=;
        b=BJKJUgjB4esmuwk+kr8pBG/0WQkeAMuYXxZwWJVLY82Ht9MVZlr8RYeNn8hL2pJXpK
         9b3T+pNSg1iVwYMYDIWtZBKTdKjZVh8gtN3ItfFyHmUXWjivwVKm5pwpkTisHASrOxjP
         LubtyG2Q7GibiWLhPr664tp0Sc59D+UZcVNraEYA6FC8lHTw0A/sdynYz15LDIDv4AQ3
         s1AAIvbwE/4OVlJkAaOTG534QLqv4pndMFNPD0TSwV7BWGeHc1qduQIllFr0JEPmbByf
         V8ByWhfob9x2xhZ4tduobAlHuJ7p7z3O6iX1X/2PoWPRb/6fPhVMLeP4V6bb0ebibTl2
         2qbA==
X-Gm-Message-State: APt69E2FAZJAvVf5s0ojmEW/YcLkKmnoUeOAcf2LZXb2ueob4Ju0ZZM9
        H+iq7Eeh8WUI4PvI6jvK3qUdgGd4GT6e8cE4bYVvAQ==
X-Google-Smtp-Source: ADUXVKI8vspKhpmykVK6Mx+gvq7kHoGUBb+FUtAGsq32DdoI+xYH5+G0l+5BMRorkG67HIq7rM+eTGS2awoD/HiGCfU=
X-Received: by 2002:a6b:e315:: with SMTP id u21-v6mr11529180ioc.196.1529344271394;
 Mon, 18 Jun 2018 10:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:50:30
 -0700 (PDT)
In-Reply-To: <20180618165840.gikljqhaxtiiw27x@two.firstfloor.org>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org> <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
 <20180618165840.gikljqhaxtiiw27x@two.firstfloor.org>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 Jun 2018 13:50:30 -0400
Message-ID: <CABV8kRxqAjCDsQL7M2OLm8Tircsx7Xb2bdgDJ5XPJ3Ff=EjzUQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So we're talking about a workaround for broken software. The question
> is how wide spread is it?

For rr to work, it tries to replicate the process state *exactly*. That means:

1. The same instructions executed in the same order
2. The exact same register state at those instructions
3. The same memory state, bit-by-bit

In particular 1) means that any extra instructions executed/not executed
will cause a replay divergence (in practice rr uses retired conditional
branches rather than instructions, because the instruction counter is
not accurate, while the branch one is). This alone causes a problem
for the present case, because glibc branches on the xcr0 value before
it branches on the cpuid value for AVX512. Glibc does check for the
correct cpuid before calling xgetbv, so one possible thing to do is to
completely disable xsave during recording by disabling it in CPUID, but
that would make rr quite a bit less useful, since it wouldn't be able to
record any bugs that require AVX to be used. However, the xsave
problem is worse, because xcr0 determines how much memory
`xsave` writes, so if we emulate cpuid, to pretend that AVX512
does not exist, and the user space application uses that to
determine the size of the required buffer, we now suddenly
overflow that buffer (unless the user space application uses
cpuid to compute a minimal RFBM for xsave, which no application
seems to do).

> Do memory contents which are never read by the application matter?

In theory, no. However, in practice, I've seen most memory
divergences (esp if on the stack), end up causing control flow divergences
down the line, because some code somewhere picks up the uninitialized
memory and branches on it.

Hope that helps,
Keno
