Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16CDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85766214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="gR/zZavk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfBDOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:38:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40858 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfBDOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:38:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so77106oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hE4P+KtbkIDEo8Lq8LirA+lBCYJX0HyoYvS1ea+soVo=;
        b=gR/zZavk3CYa4DG+Ph3OjsiOWR7TLgXCMFT4CmXfn2xyMbzSDl01rXjLTDmotJVr3Y
         jLQECb2aQLuL5PEvld4Khkq/T9BmZjbqCTpHIH+sajbTZXjc9vO06gVdAFbyL9YbzEV2
         OKXD98b7dmLfmW7/W6moS1XkS8RkcWEU30akRoZqggEkFMd1HIHNxKfyMOMq4tDuInjr
         TK3G4vXUkuWCL7ajhGQphRXXbAkrsi9C/hHPd7nqnsXKOQ3dE75MdpUiXp/6jBO1ohBM
         IxJXbiYW6iqt8df6Gi/+7/N0J+gzbiqhFdMcloI8pLeiVspBHeIosJYf9hXv78lQKUgK
         O9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hE4P+KtbkIDEo8Lq8LirA+lBCYJX0HyoYvS1ea+soVo=;
        b=KksDLueYKVJeQQbitcQz6+KpnGHWo70ICE6KXV7YImXrwxAJIIVeUQ7UTSHN8qbjRm
         Rv7qctc5BD8kLoVJvDqnp3qLj0RgLPYNLHQgh13yqbdhWZVngPf4Jq+qkX7shGCXxsAR
         mS4qUcDXv4Zq/3AHOYuO/AP09JG16z7MOnnW64l7Bakxa58xkTt6FKa0gur3odlZhqx/
         D0JfErB+QnT4w2881T3G/vi/6a6TBfMmi+eObWgAaLWh8CRUdldm4Cu0X9VYUQHCJVEW
         815WrOuPgm0h2qXrN1EEGugv67AbNciZNO18cWkRkQR/vQEcJ//dHbZ8GsNQ8jV0IjYT
         LdeA==
X-Gm-Message-State: AJcUukfL8uTUUe5G827M7JHJOzw99pQ8tX+391wQEEyaRnigfBcNwuuU
        e+gDeR7VTKyirJPkgWm6RMqTC5ilnD0N2meHv/leqA==
X-Google-Smtp-Source: ALg8bN5KquqFlYTgdJC/ellz83ijzDv/em8YEw1FVNV8LvRiqMW03VSTlb5X+p+9a2MOdkcGENiQmXRdq1ATZTpccH0=
X-Received: by 2002:a9d:2186:: with SMTP id s6mr39476545otb.346.1549291107471;
 Mon, 04 Feb 2019 06:38:27 -0800 (PST)
MIME-Version: 1.0
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
In-Reply-To: <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
From:   Lars Persson <lists@bofh.nu>
Date:   Mon, 4 Feb 2019 15:38:16 +0100
Message-ID: <CADnJP=vsum7_YYWBpknpahTQFAzm7G40_E2dLMB_poFEhPKEfw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge or THP
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, lersek@redhat.com, alex.williamson@redhat.com,
        aarcange@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:07 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> LTP proc01 testcase has been observed to rarely trigger crashes
> on arm64:
>     page_mapped+0x78/0xb4
>     stable_page_flags+0x27c/0x338
>     kpageflags_read+0xfc/0x164
>     proc_reg_read+0x7c/0xb8
>     __vfs_read+0x58/0x178
>     vfs_read+0x90/0x14c
>     SyS_read+0x60/0xc0
>
> Issue is that page_mapped() assumes that if compound page is not
> huge, then it must be THP. But if this is 'normal' compound page
> (COMPOUND_PAGE_DTOR), then following loop can keep running
> (for HPAGE_PMD_NR iterations) until it tries to read from memory
> that isn't mapped and triggers a panic:
>         for (i = 0; i < hpage_nr_pages(page); i++) {
>                 if (atomic_read(&page[i]._mapcount) >= 0)
>                         return true;
>         }
>
> I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> with a custom kernel module [1] which:
> - allocates compound page (PAGEC) of order 1
> - allocates 2 normal pages (COPY), which are initialized to 0xff
>   (to satisfy _mapcount >= 0)
> - 2 PAGEC page structs are copied to address of first COPY page
> - second page of COPY is marked as not present
> - call to page_mapped(COPY) now triggers fault on access to 2nd
>   COPY page at offset 0x30 (_mapcount)
>
> [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
>
> Fix the loop to iterate for "1 << compound_order" pages.
>
> Debugged-by: Laszlo Ersek <lersek@redhat.com>
> Suggested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Changes in v2:
> - change the loop instead so we check also mapcount of subpages
>
> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..5c9c7359ee8a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -478,7 +478,7 @@ bool page_mapped(struct page *page)
>                 return true;
>         if (PageHuge(page))
>                 return false;
> -       for (i = 0; i < hpage_nr_pages(page); i++) {
> +       for (i = 0; i < (1 << compound_order(page)); i++) {
>                 if (atomic_read(&page[i]._mapcount) >= 0)
>                         return true;
>         }
> --
> 1.8.3.1

Hi all

This patch landed in the 4.9-stable tree starting from 4.9.151 and it
broke our MIPS1004kc system with CONFIG_HIGHMEM=y.

The breakage consists of random processes dying with SIGILL or SIGSEGV
when we stress test the system with high memory pressure and explicit
memory compaction requested through /proc/sys/vm/compact_memory.
Reverting this patch fixes the crashes.

We can put some effort on debugging if there are no obvious
explanations for this. Keep in mind that this is 32-bit system with
HIGHMEM.

BR,
 Lars
