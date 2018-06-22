Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43323C29
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPdCwylE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F43323C29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeFVB65 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:58:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53766 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934244AbeFVB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:58:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so549646wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZGWmSsqob4UebOy5XsVOPy1aYICOQVGw4aRi5H71Wk=;
        b=hPdCwylEJpBBmixeOrRDMmdhSaBLulordH55qYNyivSJC1O5WKPNxgTO0dqTjoI1KH
         /vqhOdu3qLA0C3yP/2/lsVp99FmPbB2rPnJkZItVQ4+WQSBrzxkJFn8iyJjgE6DBXbw0
         lAvWY+kNnnQao5kjQRZskWUTE8C8GVRpN9CU+c+kA+kONGKQrpMOKPRuc6DaO0KYzhAl
         r11N/tvcFH+5wxt11zt1JefPm8E/FLaedjOCHNYJ7Bs1eqDn87iUtt+Jo95TScjRAuK/
         JuuhyBvZ89K7cq3KdxlhYxvkeEqRCFI8Losfdqq9ir8FsZyPpfEVdex2hGVxtj7LFQzW
         IZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZGWmSsqob4UebOy5XsVOPy1aYICOQVGw4aRi5H71Wk=;
        b=rNxnHiRHq8wzNr64V400CcH+AqKfErtuFV6lD7anQXHMgxxYuWAl08JEaTMr+b8/Ki
         opTbxWk8fxrsdMtIc61RTW2WiKDvA2uiivciQpauHBrsUG/U20/y0LBhPSk3t2yqdPMD
         HZDkItMn/KE+AaRgXuKqyH1kbdl/Y/kfOq+MJZNAKbDFa+qkiSjrtyqkaF4yE+dpJgsr
         audENg+ex6L3TbRQpyB1/tveOEgl5fLpSvVEVsI24kMFRAflmsEaTKazOa6d0SO7BhZN
         jToEfM+m6xv57H6VVml+5jpa7bFiQ68YDY3WMl74JbmNfbMvd7rfbgRQJJ4XNYCWxYf7
         PVxA==
X-Gm-Message-State: APt69E1KvUfAB6eYJkwB3vpH79gAF/aztbtMvBZMeDxr9C3rWRWK+1tU
        7L5gqaOfX/gPmZkuLCaesp8=
X-Google-Smtp-Source: ADUXVKKB9zerfXxG5gqkg0tfQlrnNKUp2l10kvB+UGJixWYl8ye67dPnUzwCUBNaWIo/AIHdzonU4g==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr13496wmd.133.1529632734135;
        Thu, 21 Jun 2018 18:58:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d102-v6sm685057wma.10.2018.06.21.18.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 18:58:53 -0700 (PDT)
Date:   Fri, 22 Jun 2018 03:58:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 0/7] x86/ptrace: regset access to the GDT and LDT
Message-ID: <20180622015851.GA10254@gmail.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin, Intel <h.peter.anvin@intel.com> wrote:

> From: "H. Peter Anvin" <hpa@linux.intel.com>
> 
> Give a debugger access to the visible part of the GDT and LDT.  This
> allows a debugger to find out what a particular segment descriptor
> corresponds to; e.g. if %cs is 16, 32, or 64 bits.
> 
> v3:
> 	Requalify LDT segments for selectors that have actually changed.
> 
> v2:
> 	Add missing change to elf.h for the very last patch.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Markus T. Metzger <markus.t.metzger@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> 
>  arch/x86/Kconfig               |   4 +
>  arch/x86/include/asm/desc.h    |  24 +++-
>  arch/x86/include/asm/ldt.h     |  16 +++
>  arch/x86/include/asm/segment.h |  10 ++
>  arch/x86/kernel/Makefile       |   3 +-
>  arch/x86/kernel/ldt.c          | 283 ++++++++++++++++++++++++++++++++---------
>  arch/x86/kernel/ptrace.c       | 103 ++++++++++++++-
>  arch/x86/kernel/tls.c          | 102 +++++----------
>  arch/x86/kernel/tls.h          |   8 +-
>  include/uapi/linux/elf.h       |   2 +
>  10 files changed, 413 insertions(+), 142 deletions(-)

Ok, this looks mostly good to me at a quick glance, but could you please do one 
more iteration and more explicitly describe where you change/extend existing ABIs?

I.e. instead of a terse and somewhat vague summary:

> x86/tls,ptrace: provide regset access to the GDT
>
> Give a debugger access to the visible part of the GDT and LDT.  This
> allows a debugger to find out what a particular segment descriptor
> corresponds to; e.g. if %cs is 16, 32, or 64 bits.

Please make it really explicit how the ABI is affected, both in the title and in 
the description, and also _explain_ how this helps us over what we had before, 
plus also list limitations of the new ABI.

I.e. something like:

   x86/tls, ptrace: Extend the ptrace ABI with the new REGSET_GDT method

   Add the new REGSET_GDT ptrace variant to PTRACE_{GET|SET}REGSET,
   to give read and write access to the GDT:

   - Previously only certain parts of the GDT were visible, and only via random
     ABIs and instructions - there was no architectured access to all of it.

   - The SETREGSET variant is only allowed to change the TLS area of the GDT.

(or so.)

This is important not just for documentation and library support purposes, but 
also to be able to review it properly, to match 'intent' to 'implementation'.

(It might also help later on in finding bugs/quirks, if any.)

Please do this for all patches in the series that change the ABI.

Thanks,

	Ingo
