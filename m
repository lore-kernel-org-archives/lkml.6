Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0211C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2CA20C0A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="voVnQbN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2CA20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeGGVLb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:11:31 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36604 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbeGGVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:11:30 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so13835209iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrOpyc5rDKIjDlKF+xN2pAYFHea0QHsKze6etqUfdEw=;
        b=voVnQbN2aYM39/7N4vh9Wl7y6IOgl+os4AdwAPHhgV5M8rYQrEUT8MacR5dWhkAK2N
         ry9qwTGi6M8UVI01tqhZn/zPLJ4MpVrFIV6mKQVgCeH0adox4MapNX/JeIXQ7Ev/nIQG
         FmkHTuflHU5bAxkMDcNJnbNDmD3UmZxtudmW2DZ3cI83ooS0PCRh7LIkhDlCmfuZV2Js
         zVajBtSA2lv7CZT+mEC4BLu0xHK7yAX9SA8IbuaaLKy8Vz52x16UzYkzY7LDqmMUMHjL
         9izI0YlWv1RNT/6pj+G8Zg/Vmc3GV1ev1joGiAekC/kHIRWZWNkdi/LOS1qt3VKlVLY9
         oAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrOpyc5rDKIjDlKF+xN2pAYFHea0QHsKze6etqUfdEw=;
        b=EAq5kZv9miLzJdi4pKUz/UVE0t5of7WQlDoeGmGwCUapaAzDtxc82q9vrXL5Ii9xl2
         oJtvwhIdfZCDlXUcFMc9KDRZUacKqpMLbekc55DngSmVOomkhU2Aj8Qbs9F8cZqsNkFy
         26kFahteSLxKVu83C2OtnU0SRN9tq8NXb5AlRWgdHhKpm9ssdB+xcVak42nKDIPqDzet
         LOfaaYm6UyJ2p7aCfBr5gCoozXRsYhfLPKk+TI00Xw5TM3jYCsn/4inhQDBhQDTsOlGe
         njJDbqlLOx2mXYPM/Idl+GTms0tgLGw8FMdFKGLR5kDKPv3+L/JKcxwwuIKuN2cPQxQW
         J/Cw==
X-Gm-Message-State: AOUpUlFqGvDY/2qoDoi7hsAPW8P7+/OEzZfBTWOy7Dv4YtGuFrkQzvSe
        sjfPqedWGgEQO5giGqO8cpWy1pcdCSCw/KO9rfg=
X-Google-Smtp-Source: AAOMgpeAy3/hZVGzlTvvkpObHk6mWQcpWUj5kNk+ZsssXqcp9A5zyMowsn1cu3DSP67aDddu6DWYVUiyMfs77e1Cqws=
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr4144497iov.56.1530997889506;
 Sat, 07 Jul 2018 14:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180622035151.6676-1-ying.huang@intel.com> <20180622035151.6676-2-ying.huang@intel.com>
In-Reply-To: <20180622035151.6676-2-ying.huang@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 7 Jul 2018 14:11:18 -0700
Message-ID: <CAA9_cmcwczyEb=+3F7HtDDqZA-3rdqgw=gkYipDtx5r+4Kd5Tw@mail.gmail.com>
Subject: Re: [PATCH -mm -v4 01/21] mm, THP, swap: Enable PMD swap operations
 for CONFIG_THP_SWAP
To:     ying.huang@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, hughd@google.com,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, zi.yan@cs.rutgers.edu,
        daniel.m.jordan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> From: Huang Ying <ying.huang@intel.com>
>
> Previously, the PMD swap operations are only enabled for
> CONFIG_ARCH_ENABLE_THP_MIGRATION.  Because they are only used by the
> THP migration support.  We will support PMD swap mapping to the huge
> swap cluster and swapin the THP as a whole.  That will be enabled via
> CONFIG_THP_SWAP and needs these PMD swap operations.  So enable the
> PMD swap operations for CONFIG_THP_SWAP too.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  arch/x86/include/asm/pgtable.h |  2 +-
>  include/asm-generic/pgtable.h  |  2 +-
>  include/linux/swapops.h        | 44 ++++++++++++++++++++++--------------------
>  3 files changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 99ecde23c3ec..13bf58838daf 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1224,7 +1224,7 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>         return pte_clear_flags(pte, _PAGE_SWP_SOFT_DIRTY);
>  }
>
> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_THP_SWAP)

How about introducing a new config symbol representing the common
infrastructure between the two and have them select that symbol.

Would that also allow us to clean up the usage of
CONFIG_ARCH_ENABLE_THP_MIGRATION in fs/proc/task_mmu.c? In other
words, what's the point of having nice ifdef'd alternatives in header
files when ifdefs are still showing up in C files, all of it should be
optionally determined by header files.
