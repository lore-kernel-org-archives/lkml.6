Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90533206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVj95GUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90533206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIJLqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:46:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42233 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeIJLqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:46:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so16889791ljc.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbBxFe0xK+s20JWOw/cIA6RQnjfYFIU6HEC6Qkzxc5U=;
        b=CVj95GURbnt2ouf1lxL/y64LwYx18CUnEtJJUjFMYcCoOMCrE7s06Z90lYv1Mx4piI
         Pu2UGpOdoESYp47KalwVYDB0RUrAr48HZLitFwOaacpo5ATfUVhVdXjj8XbjeV2D39n4
         Agwa8LrQ2jWO/Z7bqS0ZWn6D+I/fGYUQFD9E+zeuLKSa4BZiJLF0b05Sr8OXpqv+Ajuv
         XTShT6OjGfXAhcmgHA1g09VWohtEd3rNTqwasr3rEAWh+KkHhCzLq+NvDqbVLuNKDaDN
         VN7zjLPE8parIJJHtNEG8Mexx+KTu1E1G0tktkQxPPI0fq8bwIytkogEEhguxjhPLxTD
         0bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbBxFe0xK+s20JWOw/cIA6RQnjfYFIU6HEC6Qkzxc5U=;
        b=YbFBlW0WPRA6z8C4bgYAQrpkAKMktvnogqYqNsDS7nmFzWyoah4Ejs5X70hL0qDTRt
         Syx80dVdgc1lh7Ag4WvJZUfd5r0kSnXb8/w+fjTPprj47PUOM6hCsVYM9+7KLroH4cay
         1E7fHPzzCvLjLq7NSiBkC4S/FvzH31BOgFt3T5xyzJOCZRmcxpU7OYW+dXXDYTsF80Su
         i6cNUbVVsv+Gu2I5x4p+oStfD5rT53koWXQMfckL8XfwV24oG84I3yfqlyE2oS9NHRIT
         P6W6mrwHGRiGll6E1GUREu6HS3LihZYjUel4hmBL+w3a54fLc3dtcvHrGuOckcg2yno2
         IflA==
X-Gm-Message-State: APzg51Dbw4VdG/NW9v64SKi5UxzziNBU8fi1fIH0dh/owz8WEuYhWoe5
        E5RXMP4rEO4NOZyEUaMuSRTWNq7zL6Y0b6EFEZe3RRjT
X-Google-Smtp-Source: ANB0VdYaA0T3EJw4857y/OjnOtISbEoizLYw1FAGHDODZ4kLeXu5XvhExmlT2M7SgoXmDbT+DnZgkN7lX9OgjTrsWDQ=
X-Received: by 2002:a2e:860d:: with SMTP id a13-v6mr12009767lji.43.1536562424443;
 Sun, 09 Sep 2018 23:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180901165850.GA28874@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180901165850.GA28874@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 10 Sep 2018 12:23:32 +0530
Message-ID: <CAFqt6zZ+YzxRgF77aNjpiVqtXqhhhJa3Pnn15XQ+3=ZOy_BCOA@mail.gmail.com>
Subject: Re: [PATCH] uio: convert to vm_fault_t
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 10:25 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> As part of commit 9b85e95a3080 ("uio: Change return
> type to vm_fault_t") in 4.19-rc1, this conversion
> was missed. Now converted 'ret' to vm_fault_t type.

Greg, this was missed. Yes, this is not a regression fix,
but can we get this patch in 4.19-rc-X else it might go untraced
and later generate compile error when actual vm_fault_t will be
introduced ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/uio/uio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 70a7981..8fae1a4 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -668,7 +668,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
>         struct page *page;
>         unsigned long offset;
>         void *addr;
> -       int ret = 0;
> +       vm_fault_t ret = 0;
>         int mi;
>
>         mutex_lock(&idev->info_lock);
> --
> 1.9.1
>
