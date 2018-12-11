Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782C32081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeLKFqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:46:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58158 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeLKFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:46:20 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gWas7-0004y9-1b
        for linux-kernel@vger.kernel.org; Tue, 11 Dec 2018 05:46:19 +0000
Received: by mail-wr1-f71.google.com with SMTP id w16so4409591wrk.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 21:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc62lPpReKanVnXBgIZYjooZr5Gd0lxAuQ8vSRxTRts=;
        b=htKrpuN++DJ4P3VI6w7pbKVssag9/mSjPxwXbe1wlBrF9wl+qLZ2XLyxEtH1mo46id
         aO9Ynuy1npGZR0aZfELscOV3KvKKPgnoDQWW3wo1sw3HtriPSpMbkJicxyUItFmcOIXD
         UMIU6xtz889TuZZ73KBb28F9ja2Zf+gUafLhsI0P1BCcRMVVl9eNB0Di0IMbnQfyDBwb
         vcV41iJJQqddYTcFOcW26wISUnMwl1ZGfqU4gc8961UCyNIbLu3vWTq+qVKuULKYHltO
         E43cfFDAEV6sXEXsQMbr5C9TpP4SmB7PrBB/YXKfVXKcjQQWlEGI2smlNTiwXWavEVVJ
         o0GA==
X-Gm-Message-State: AA+aEWY+lCNHrMgZU1F5hz16m6j1e5lHdi4anFCYONMGFE0fOI+2Y5C7
        sxlqg6tb7FNdGqdkRAyKHh40l+OnkAOIs4kLg2vEX+S4ht1Hoymcaul04Mk681jc1gKjLoZMR6y
        PX8/f03kSX0WgrQ3DD4M0npSl0fP/AAkrV9Y+Enzkvg==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr921973wme.119.1544507178468;
        Mon, 10 Dec 2018 21:46:18 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V581xCPqG73cENKr4Aeq8xptuKH7+klUPR7Gq08BDS5Z0LWW65qhH7Unq0JZsxNsph9JOfMw==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr921948wme.119.1544507178103;
        Mon, 10 Dec 2018 21:46:18 -0800 (PST)
Received: from gmail.com ([2a02:8070:88c2:4000:69e7:45c9:1529:166d])
        by smtp.gmail.com with ESMTPSA id x8sm3990713wmd.45.2018.12.10.21.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 21:46:17 -0800 (PST)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Tue, 11 Dec 2018 06:46:16 +0100
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181211054615.f2oefxhf6cuvx5ex@gmail.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:23:39PM -0800, Andy Lutomirski wrote:
> Hi all-
> 
> I'm seriously considering sending a patch to remove x32 support from
> upstream Linux.  Here are some problems with it:
> 
> 1. It's not entirely clear that it has users.  As far as I know, it's
> supported on Gentoo and Debian, and the Debian popcon graph for x32
> has been falling off dramatically.  I don't think that any enterprise
> distro has ever supported x32.
> 
> 2. The way that system calls work is very strange.  Most syscalls on
> x32 enter through their *native* (i.e. not COMPAT_SYSCALL_DEFINE)
> entry point, and this is intentional.  For example, adjtimex() uses
> the native entry, not the compat entry, because x32's struct timex
> matches the x86_64 layout.  But a handful of syscalls have separate
> entry points -- these are the syscalls starting at 512.  These enter
> through the COMPAT_SYSCALL_DEFINE entry points.
> 
> The x32 syscalls that are *not* in the 512 range violate all semblance
> of kernel syscall convention.  In the syscall handlers,
> in_compat_syscall() returns true, but the COMPAT_SYSCALL_DEFINE entry
> is not invoked.   This is nutty and risks breaking things when people
> refactor their syscall implementations.  And no one tests these
> things.  Similarly, if someone calls any of the syscalls below 512 but
> sets bit 31 in RAX, then the native entry will be called with
> in_compat_set().
> 
> Conversely, if you call a syscall in the 512 range with bit 31
> *clear*, then the compat entry is set with in_compat_syscall()
> *clear*.  This is also nutty.
> 
> Finally, the kernel has a weird distinction between CONFIG_X86_X32_ABI
> and and CONFIG_X86_X32, which I suspect results in incorrect builds if
> the host doesn't have an x32 toolchain installed.
> 
> I propose that we make CONFIG_X86_X32 depend on BROKEN for a release
> or two and then remove all the code if no one complains.  If anyone

Based on the discussion we had at the beginning of the pidfd_send_signal
syscall patchset I think this is a good idea. For once, the complex
compat handling can make adding new syscalls that need to rely on compat
types because of precedent established by older syscalls icky.

> wants to re-add it, IMO they're welcome to do so, but they need to do
> it in a way that is maintainable.
> 
> --Andy
