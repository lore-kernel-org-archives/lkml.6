Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE48C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56C12404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOrHZGDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C12404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeGEU4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:56:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43422 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754637AbeGEU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:56:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so19453846oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9Ns5xydRo1qsqLuAyooO/hIpd/x2MpQovj1Vn8gIGc=;
        b=ZOrHZGDBQqxjvYqXNTqOfGd2h13uB+QxADYmyJG+kBSPQavLfPrLz2BaTwBwCNloeT
         6f4DpF197XKnAquQajSwLqa+SjdhPyXBK1QqOSggFKr0sMU7Rm23D2MYuynssO4OKZRV
         iW8kInB3VekgzNQC6Tg5pEzfeYBTNqygf2GXXd/T8T0RCWpwLEDOj9A5g9SnydUjosue
         fjXxJCkLZdtwx4AxYiOycgYzXAysa28QILqH5jkZpma9HCD/rR7sAUe0zIMEZDMKfnZK
         Qu4xaDIaI4FF+w1pHd4PntKob3yoeSNgQIorY11KbMyZ9Ir0Ho7pWs3xD9X0BgnCFdGP
         EpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9Ns5xydRo1qsqLuAyooO/hIpd/x2MpQovj1Vn8gIGc=;
        b=uHWntJSwW79Qpfojz7mntKVBGL+6BEvWiKFVlKwdt5LSA6+J0qgbnuNGB0XL5lFde9
         /UToN1+n5jEe0cUDZzauij/qiP92cyAWhx7lePQYvUia8RQnxSeZt+5OiSzigP632PCa
         RRXoKKLKPkDx3NWL62IRtx+Qd6RC2VeTdpLFYlub0GOhsagO/fUC5s7IkZkjcjs3B6SJ
         Qj8Am/AWA5SKfcZ2GAScjNgDwjEOyZbRbpKEtz+GxJenPRptzhOxwS/k/TL0T5lv8m74
         e5eSKAlLSa/iOLP0FN5EoQUX1MRhOzgrVRhCHeo9ivcyfqf7ptJ6wFPoCLVcyocpQbI/
         TQYQ==
X-Gm-Message-State: APt69E3i9oD7qeyKWg/6vu0ql3FzFAGmK9F6vD6qRnGCwzFEqaebIQUo
        m9IYD6si7i1EXrPAst9hNjs7kOBKEKWq9KZ3zr+PVHmA
X-Google-Smtp-Source: AAOMgpfCkvSLcYKuFdTBV5r5ZM0lkfIHBEds0bu0BebSS70NJ/PYpClCOlF3VW4oVkOF6MM8Hqoly1HrIZINWqIPy9E=
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr8983496oig.142.1530824186965;
 Thu, 05 Jul 2018 13:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <1530808048-9494-1-git-send-email-xiubli@redhat.com> <1530808048-9494-3-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530808048-9494-3-git-send-email-xiubli@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 5 Jul 2018 22:56:00 +0200
Message-ID: <CAG48ez1Ze1Q08HtyC8PyhW5msQ8qwFDy6eDj8s9k_j4vmG7nJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] uio: fix crash after the device is unregistered
To:     xiubli@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 10:53 PM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> For the target_core_user use case, after the device is unregistered
> it maybe still opened in user space, then the kernel will crash, like:
>
[...]
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  drivers/uio/uio.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 86 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 33c3bfe..2b9268a 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
[...]
> @@ -720,30 +775,46 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>
>         vma->vm_private_data = idev;
>
> +       mutex_lock(&idev->info_lock);
> +       if (!idev->info) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
>         mi = uio_find_mem_index(vma);
> -       if (mi < 0)
> -               return -EINVAL;
> +       if (mi < 0) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
>
>         requested_pages = vma_pages(vma);
>         actual_pages = ((idev->info->mem[mi].addr & ~PAGE_MASK)
>                         + idev->info->mem[mi].size + PAGE_SIZE -1) >> PAGE_SHIFT;
> -       if (requested_pages > actual_pages)
> -               return -EINVAL;
> +       if (requested_pages > actual_pages) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
>
>         if (idev->info->mmap) {
>                 ret = idev->info->mmap(idev->info, vma);
> -               return ret;
> +               goto out;
>         }
>
>         switch (idev->info->mem[mi].memtype) {
>                 case UIO_MEM_PHYS:
> -                       return uio_mmap_physical(vma);
> +                       ret = uio_mmap_physical(vma);
> +                       break;
>                 case UIO_MEM_LOGICAL:
>                 case UIO_MEM_VIRTUAL:
> -                       return uio_mmap_logical(vma);
> +                       ret = uio_mmap_logical(vma);
> +                       break;
>                 default:
> -                       return -EINVAL;
> +                       ret = -EINVAL;
>         }
> +
> +out:
> +       mutex_lock(&idev->info_lock);

This is probably supposed to be mutex_unlock(...)?
