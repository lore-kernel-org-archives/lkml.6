Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFCAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E7320861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALn6C5Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeINOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:41:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40438 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeINOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:41:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207-v6so1232920wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEH4jVqkUl3lnG88nstg7rVeBaef4UAyC9dL+iAx1u0=;
        b=ALn6C5Nmuvj7kEULKLIVuzKJhS8jNOlMUbd409J3+kCFIp5eiXtFf0N37OWFcb1PBX
         /SbFa5tKQVwWCrdv3Jl/laAcDpVqM8i6vUb8rsPYjs8ARsRoVfnkdj79SA6ru1op5lk1
         WKsu/K3hYDPkbYIddOY4zvsSXMSezdBaLE6TFwvrFr9KTW3oFql45mQ63Jl8iyBc2Gtx
         k7mpX6kXKYi/qqfuiQ1zyGudP/0rTMSW8zafhNT5r5QQxpuaYucXynY6PY7+V9u+5HKt
         0p86xLIOAC+ScthkJjZPNQPohUjUdKuQ7qKknOqQWvpGUTrIuPGUWucbBJ1o06b2bDlb
         S4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEH4jVqkUl3lnG88nstg7rVeBaef4UAyC9dL+iAx1u0=;
        b=a38G2skgJ99cB0kTlQsLBA0DXuX8lwrjTPdKUZu0+KvtHHHPCY9kncesalMQLmvUsN
         K3SsBdJvJa6lmbHRMJuggFB7n2w/BrMtkHMkkwio5j53RQFaxusa02UkTDjVi6QYhATj
         oY8apDeSRcYDbyg7p0zWuySszm4RIXK+GlneuB680oQ0GgYaC90Vu1FT6Bh90QioTdTB
         cNWgI+0lUL4pETR+6Z2CVlpKNnh0oEw19vWgR85JUlswue9BlHXG/EssQYiZHkzXCZsw
         2O0L7/O5EBoamXU6SNGgqNZElEFsSbYUjgJQMaRdsqX1AjTS6HbS0c6VmJzHiHWszN/f
         6M3A==
X-Gm-Message-State: APzg51DRUDVB42Q03faQLmvUl2tADM17CO9xfpoCnXqafdFQjiO2CCF/
        tKNwJhlzcmqmXczr6hNEzj0=
X-Google-Smtp-Source: ANB0VdYWf+XpdwCWHq5nY0GNSQI2lq++knasWa4mWycQo9m2eDk2xWKNmq3eSKF7q0whbsVFAusyIQ==
X-Received: by 2002:a1c:3b56:: with SMTP id i83-v6mr1483651wma.66.1536917256213;
        Fri, 14 Sep 2018 02:27:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e133-v6sm2927741wma.33.2018.09.14.02.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 02:27:35 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:27:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V5 0/8] x86: infrastructure to enable FSGSBASE
Message-ID: <20180914092732.GA90840@gmail.com>
References: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> Resending the patchset that was posted before [6].
> 
> Given feedbacks from [1], it was suggested to separate two parts
> and to (re-)submit this patchset first.
> 
> To facilitate FSGSBASE, Andy's FS/GS base read fix is first
> ordered, then some helper functions and refactoring work
> are included. Cleanup for the vDSO initialization is
> for preparing per-CPU base finder that will be used in the
> paranoid entry, when FSGSBASE enabled.
> 
> Changes from V4 [5]:
> * Change patch ordering; putting the fix first before introducing
> the helper functions
> * Cleanup further for vDSO CPU initialization codes
> 
> Changes from V3 [4]:
> * Unify CPU number initialization
> 
> Changes from V2 [3]:
> * Bisect the CPU number initialization patch
> * Drop patches for introducing i386 CPU_NUMBER and switching
> write_rdtscp_aux() to use wrmsr_safe()
> 
> Changes from V1 [2]:
> * Rename the x86-64 CPU_NUMBER segment from PER_CPU
> * Add i386 CPU_NUMBER equivalent to x86-64 at GDT entry 23
> * Add additional helper function to store CPU number
> * Switch write_rdtscp_aux() to use wrmsr_safe()
> 
> [1] FSGSBASE patch set V2: 
>     https://lore.kernel.org/patchwork/cover/912063/
> [2] infrastructure for FSGSBASE 
>     V1: https://lore.kernel.org/patchwork/cover/913139/
> [3] V2: https://lore.kernel.org/patchwork/cover/913644/
> [4] V3: https://lore.kernel.org/patchwork/cover/949775/
> [5] V4: https://lore.kernel.org/patchwork/cover/951712/
> [6] V5: https://lore.kernel.org/patchwork/cover/956526/
> 
> Andy Lutomirski (1):
>   x86/arch_prctl/64: Make ptrace read FS/GS base accurately
> 
> Chang S. Bae (7):
>   x86/fsgsbase/64: Introduce FS/GS base helper functions
>   x86/fsgsbase/64: Make ptrace use FS/GS base helpers
>   x86/fsgsbase/64: Use FS/GS base helpers in core dump
>   x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
>   x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
>   x86/vdso: Introduce helper functions for CPU and node number
>   x86/vdso: Move out the CPU initialization
> 
>  arch/x86/entry/vdso/vgetcpu.c   |   9 +-
>  arch/x86/entry/vdso/vma.c       |  38 +--------
>  arch/x86/include/asm/elf.h      |   6 +-
>  arch/x86/include/asm/fsgsbase.h |  47 +++++++++++
>  arch/x86/include/asm/segment.h  |  46 +++++++++-
>  arch/x86/include/asm/vgtod.h    |  26 ------
>  arch/x86/kernel/cpu/common.c    |  24 ++++++
>  arch/x86/kernel/process_64.c    | 183 +++++++++++++++++++++++++++++++---------
>  arch/x86/kernel/ptrace.c        |  28 ++----
>  9 files changed, 270 insertions(+), 137 deletions(-)
>  create mode 100644 arch/x86/include/asm/fsgsbase.h

Looks mostly good, here's a couple of details I noticed before I almost applied the series:


 - Please use a single, unified name-space for all the new FS/GS helpers, such as:

	x86_fsbase_read_cpu()
	x86_fsbase_read_task()
	x86_fsbase_write_cpu()
	x86_fsbase_write_cpu_inactive()
	x86_fsbase_write_task()

	x86_gsbase_read_cpu()
	x86_gsbase_read_task()
	x86_gsbase_write_task()

	x86_fsgsbase_load()		# was: load_fsgs()
	x86_fsgsbase_read_task()	# was: task_seg_base()

        etc.

 - Please port patch #7 to latest -tip, it's conflicting with:

     e78e5a91456f: x86/vdso: Fix lsl operand order

   The resolution is to preserve the modified code.

Also some style nits:

 - Please fix the inconsistent capitalization of 'CPU' in various places, comments, 
   descriptions, etc.

 - Comments should start with a capital letter, like sentences do. Right now there's a mixed 
   style of:

+               /*
+                * If performance here mattered, we could protect the LDT
+                * with RCU.  This is a slow path, though, so we can just
+                * take the mutex.
+                */

+       /*
+        * set the selector to 0 as a notion, that the segment base is
+        * overwritten, which will be checked for skipping the segment load
+        * during context switch.
+        */


 - Please refer to functions in changelogs and comments with fn_name(), not just fn_name. For 
   example:

      x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to

   But there's more examples.

 - Please read your own patches once again and fix typos in comments and changelogs, such as:

+        * correctly wrt barrier() and to keep gcc from cleverly


Thanks,

	Ingo
