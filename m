Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C09C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BEB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ufl/m0Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BEB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbeJ3Hsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:48:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40044 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbeJ3Hsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:48:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id n3-v6so7390103lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAaDmrAhiPIUs37kgOYsuLv6czEMDqu6UUWI/wc1ByU=;
        b=Ufl/m0SeikOBfA0wbXyLlcAUlbpY+4/mTTOt7gzUSr81A2a+YoPJgRRjxxXTSOWlIZ
         ikIJtQRPgWeuKPvFzD8+Uq6IGlG8wraAwAYXbU31iOL+/geSyeury0NDOBBjbpbdecFo
         XfToOUDJu4vmX2mLNjbS8CthKmztMudI/zrsSV9YcZrNTYun0wAEE7BHbc13gFFdtleU
         esssIvtr6DRBAugWSfo3HTqd9FK4tXMXHIM0lTFCLBOosS2kizGF+ptvmcIR+SAhvJb9
         0ZvIciQQ1Nwivg6KBxX+RvtslGMRNZWAGfZtOHkaUSExWDP0Sl6AoZ2VjEornFc3yc3m
         eJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAaDmrAhiPIUs37kgOYsuLv6czEMDqu6UUWI/wc1ByU=;
        b=Gi1Ds7JOapJR3kMOf+5zlLgVSDqZHjhEqcPogD+3D6qdYEyLx0lW86+jwwu7beK3AC
         ga1U0qz+vRX6jjN4SmD7PC7ZFfT6NFiFC14XYSozCXYlBdrELE9a/StQZi8q1ixLc0PF
         B8XjDJS0kKiVmdTu8bEny93Yklq7bCuHOtvdFtrLqs+TShhiPU7yuB3vXPcXeh/M48/0
         uZE2Q4xeMxDQnlweaie2aCPz05JDTezuSKlLn012yttkswgW/kMUKNtnUq5XDQVmSPYx
         BvtWVALiF6RYDtqoiRWQ36JbrDmNI1mMtseSfGoMTMoiK8nWpS6wb73C6XNkHBE0+SvD
         Qa5w==
X-Gm-Message-State: AGRZ1gKY7aEpusWbiTzzBAOAN02glO8oCtgx8iN4waPpbO0+/GszLfui
        pUnuu97SWrxJqV0e/PIEcYBX7oOtGGAGosTxpuYF
X-Google-Smtp-Source: AJdET5cnY5C2KXoS4EiIdSfvk2LmTIDoCW3vGKR3yeiE06YWN40lhCG+NEticxkPmLs9zP9UMMq67yqYqxfcQ45eNUc=
X-Received: by 2002:a19:1a41:: with SMTP id a62-v6mr372254lfa.40.1540853875709;
 Mon, 29 Oct 2018 15:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181029104854.17432-1-david.abdurachmanov@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Oct 2018 18:57:44 -0400
Message-ID: <CAHC9VhSdOJunU18-FxbdmTuEmwtwzSbaBwt71P-F5hP3sLW-Ag@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: add audit support
To:     david.abdurachmanov@gmail.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 6:49 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> This patchset adds system call audit support on riscv (riscv32 &
> riscv64).
>
> The pachset was prepared on top of v4.19 tag.
>
> audit-userspace changes were submitted. See:
> https://github.com/linux-audit/audit-userspace/pull/73
>
> Tested the following manually:
> - auditctl (checked several different example rules from internet)
> - aulast
> - aulastlog
> - ausearch
> - ausyscall
> - aureport
> - autrace (compared some syscalls to strace: order and return
>   value/input arguments seem to be correct)
> - /proc/self/loginuid (required by DNF [package manager])
>
> I looked into audit-testsuite and with some adjustments results are:
>
> Failed 4/14 test programs. 19/88 subtests failed.
>
> The failing tests were due to missing CONFIG_IP_NF_MANGLE, 'id -Z' not
> printing categories (don't know why), not having loadable kernel module
> support enablled and syscall_socketcall not being relevant for new arches.
>
> audit-testsuite with adjustments:
> https://github.com/davidlt/audit-testsuite/tree/riscv64
>
> Depends on:
> [PATCH 1/2] Move EM_RISCV into elf-em.h
> http://lists.infradead.org/pipermail/linux-riscv/2018-October/001885.html
>
> This should solve DNF issues in Fedora 29/RISCV.
>
> David Abdurachmanov (2):
>   riscv: add audit support
>   riscv: audit: add audit hook in do_syscall_trace_enter/exit()
>
>  arch/riscv/Kconfig                   |  1 +
>  arch/riscv/include/asm/ptrace.h      |  5 +++++
>  arch/riscv/include/asm/syscall.h     | 10 ++++++++++
>  arch/riscv/include/asm/thread_info.h |  6 ++++++
>  arch/riscv/kernel/entry.S            |  4 ++--
>  arch/riscv/kernel/ptrace.c           |  5 +++++
>  include/uapi/linux/audit.h           |  2 ++
>  7 files changed, 31 insertions(+), 2 deletions(-)

Thanks for the patches David, I'll be able to take a closer look next
week once the merge window is closed.

-- 
paul moore
www.paul-moore.com
