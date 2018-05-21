Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeEUWLC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:11:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36183 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbeEUVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:19:34 -0400
X-Google-Smtp-Source: AB8JxZq9Iq564knrAC9jRIXK4wwf5ob5gHXV1p8Y+MoBDbQQjSL1PMqle2fTQHX8/SgXmPEdw52VBQ==
Date: Mon, 21 May 2018 14:19:31 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Song Liu <songliubraving@fb.com>
cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
In-Reply-To: <20180521193853.3089484-1-songliubraving@fb.com>
Message-ID: <alpine.DEB.2.21.1805211419210.41872@chino.kir.corp.google.com>
References: <20180521193853.3089484-1-songliubraving@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018, Song Liu wrote:

> khugepaged_enter_vma_merge() is using a different approach to check
> whether a vma is valid for khugepaged_enter():
> 
>     if (!vma->anon_vma)
>             /*
>              * Not yet faulted in so we will register later in the
>              * page fault if needed.
>              */
>             return 0;
>     if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>             /* khugepaged not yet working on file or special mappings */
>             return 0;
> 
> This check has some problems. One of the obvious problems is that
> it doesn't check shmem_file(), so that vma backed with shmem files
> will not call khugepaged_enter().
> 
> This patch fixes these problems by reusing hugepage_vma_check() in
> khugepaged_enter_vma_merge().
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: David Rientjes <rientjes@google.com>
