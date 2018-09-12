Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77480C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5F820833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfZxp75R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5F820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIMBQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:16:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39936 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:16:22 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so4799854ita.5;
        Wed, 12 Sep 2018 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSfpsA0Q70HozHrFTrC9rwszRbkG1c1eaqp/odjfo0M=;
        b=OfZxp75RJqJf5apPkgjLi+RNUsrV7iUZV4atSpaKZT5XlDGPpUU+JkpZD8OZTxaGu4
         pLrWkBaYGdlEWHQE+fFwLVbYbo1XYaXezZIaisFTzwUVgswPkQ0EAwdCG5Quo4+CAo93
         8INRx24bVkB4823eOPoxelHAhL1n3grIvJxedLaHLOkN+tJDlxUSE3MJI315s/+CyhtG
         plsxYi+ICWLFVAA9uDLWDKPVtRaWG6Cl3zDfEds6e/HgA0FGF37EtxwsvOEpwk20x7hw
         HfySQnvg/ud1KIExiFD3+ILrYxM/lEBw4ksvSGQRzndzxdYPcEv9/Gd/W5QGhkNPHDiI
         uPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSfpsA0Q70HozHrFTrC9rwszRbkG1c1eaqp/odjfo0M=;
        b=qlStJXY4M5LVT0iIl8a8WJxrofnFFfoTM4EPVxNc7YQtRxTCQPBspEjf7sDc2c9AKr
         fwjsMXnXiV2u86tZ2kbwr8MTMSbFq3CsExgCUHbQgivtAKPkfHDxXmfobEOnZm34uOBZ
         FC72YgnqNVkOTpKD2cdIsfZRNrMsFINrWP/gwaNdXiptS06U0djB3w4YBn7jh+IN21VD
         0GlLlcoxVHA2cyXfB6+UYzUpbCYNizmprFmGOvIiQ0WS/PyFAhEBBclIJaK0+ogSjHE/
         sO6erfgTwAL232SfqVysBsWj72E+tJklmeEEj9fLmUnspfDxS8HjnjXNqyPDXg9Aucsd
         z3Ig==
X-Gm-Message-State: APzg51B/VDRQxR32NzUjoT8OIeGRMzn8T7OlIirCJifYGEf0OucE2n1K
        BghhrlxrGAgzFeeFmYjtiozfDAs86xtRdIBaI+i8KBkM
X-Google-Smtp-Source: ANB0Vda6H49g4R4i+Tn1IBaVOQGcW3IvGVdMhmBXW+/SMYuPsa4WFGVUKqH0MqRFtwXiMKhoYa41OoAPKL1/+SZEzqg=
X-Received: by 2002:a02:7123:: with SMTP id n35-v6mr3601905jac.91.1536783013348;
 Wed, 12 Sep 2018 13:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
From:   Vegard Nossum <vegard.nossum@gmail.com>
Date:   Wed, 12 Sep 2018 22:10:00 +0200
Message-ID: <CAOMGZ=F2RBqZT8sDR8pMi1OBefTEUKXA5_CsF7p0zQr4a39aaA@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Fix mlocking THP page with migration enabled
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, zi.yan@cs.rutgers.edu,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, vbabka@suse.cz,
        aarcange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 at 12:34, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> A transparent huge page is represented by a single entry on an LRU list.
> Therefore, we can only make unevictable an entire compound page, not
> individual subpages.
>
> If a user tries to mlock() part of a huge page, we want the rest of the
> page to be reclaimable.
>
> We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
> PMD on border of VM_LOCKED VMA will be split into PTE table.
>
> Introduction of THP migration breaks the rules around mlocking THP
> pages. If we had a single PMD mapping of the page in mlocked VMA, the
> page will get mlocked, regardless of PTE mappings of the page.
>
> For tmpfs/shmem it's easy to fix by checking PageDoubleMap() in
> remove_migration_pmd().
>
> Anon THP pages can only be shared between processes via fork(). Mlocked
> page can only be shared if parent mlocked it before forking, otherwise
> CoW will be triggered on mlock().
>
> For Anon-THP, we can fix the issue by munlocking the page on removing PTE
> migration entry for the page. PTEs for the page will always come after
> mlocked PMD: rmap walks VMAs from oldest to newest.
>
> Test-case:
>
>         #include <unistd.h>
>         #include <sys/mman.h>
>         #include <sys/wait.h>
>         #include <linux/mempolicy.h>
>         #include <numaif.h>
>
>         int main(void)
>         {
>                 unsigned long nodemask = 4;
>                 void *addr;
>
>                 addr = mmap((void *)0x20000000UL, 2UL << 20, PROT_READ | PROT_WRITE,
>                         MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);
>
>                 if (fork()) {
>                         wait(NULL);
>                         return 0;
>                 }
>
>                 mlock(addr, 4UL << 10);
>                 mbind(addr, 2UL << 20, MPOL_PREFERRED | MPOL_F_RELATIVE_NODES,
>                         &nodemask, 4, MPOL_MF_MOVE | MPOL_MF_MOVE_ALL);

MPOL_MF_MOVE_ALL is actually not required to trigger the bug.

>
>                 return 0;
>         }
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>

Would you mind putting vegard.nossum@oracle.com instead?

> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")

The commit I bisected the problem to was actually a different one:

commit c8633798497ce894c22ab083eb884c8294c537b2
Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date:   Fri Sep 8 16:11:08 2017 -0700

    mm: mempolicy: mbind and migrate_pages support thp migration

But maybe you had a good reason to choose the other one instead. They
are close together in any case, so I guess it would be hard to find a
kernel with one commit and not the other.

> Cc: <stable@vger.kernel.org> [v4.14+]
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>

You could also add:

Link: https://lkml.org/lkml/2018/8/30/464

Thanks for debugging this.


Vegard
