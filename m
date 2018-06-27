Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F51C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608EA24F86
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LB4UV766";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hW/jrimd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608EA24F86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeF0VsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:48:13 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37537 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeF0VsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:48:12 -0400
Received: by mail-yw0-f194.google.com with SMTP id m201-v6so1247114ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XGy0r7hssiY1u+8NvuQoK9ktD0/Nx7V57YPZ3ccGjgI=;
        b=LB4UV766rdZBK3WebT7Q2ldqqQ6IlC1lYlrQ2xyJghk6TaHwO84wtrNmV1E/puB4iy
         +3tbIacTgg3m6mMWIuBq/MI4yHlZOMO7XQfk8gUplAnCQGsZw1mq+zkUTYFemOeKOxiq
         FWonS4U8+wnynEPGzHCOlI3zGJKq5pjg4FbgFGFTyjtNflS4VBfj1Z7gZuktWytANBVN
         qIwEqyYkyAhS63pAQO80YLJWOjB/U9FCbYYtEhG7MPwk3AVYQ2my9h8nRGLQ3Ze9DCle
         5auPoR77vfbMTyUd47efSMca3R/2t3K7Dntfa015qdCF2j1zuO1TEWTX5Ik704dP+Fft
         vCtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XGy0r7hssiY1u+8NvuQoK9ktD0/Nx7V57YPZ3ccGjgI=;
        b=hW/jrimd9EVzYehLIgHdxKLVByBIqkrKonUCeeeTc07CGKEijflZCtLiltSRkrUF3q
         N5P4EO/J39B/eNaxrlbpiZyoZeIdvXhD4GaBS5vBajaboztnZmM5Z+2szOx8AZaPH9Yt
         +rA9drfB7acfU+9h0obVaePA9JW1UXWhM4z48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XGy0r7hssiY1u+8NvuQoK9ktD0/Nx7V57YPZ3ccGjgI=;
        b=V29bpd/3zMLKOENRcQ8W8P8nHM9AczrABohYUWOT39GGHrr9WkO9YLufi3J9rBRJKw
         YcJvAT5pIwuzo63304ZJw1CmEwr7j7bAA+6ROneujUDKdT+3mNUtkwUE56G194MyVnR6
         PQeHhJk7/U54Y1HxGrm4oPJ2zXxJREqMJE6KbSlROyUigTCsLyd/xA6YzQaj2R4uxS8T
         o2z5tv9TWmpQSa/a8hVYSgpWb3ZcYwynvJJu8P8DNmtwMx1ILlFlRbcMthqYKfaP5GuX
         TnpTUWSej5V1kq0bPlwIsPqk+RKgU385GM5QYC+OBDAMLHzdEJpxMKl2HRGKR/oN0q/F
         Aijw==
X-Gm-Message-State: APt69E2qLSVCa39V2lbr6Rpgvwhhd4m1T4ZeGQTtURfG8OHuArkEYLbT
        RkIG4503YhXatJqRHzt1GtqSKp7w+ASQPuPwf7p/1cEj
X-Google-Smtp-Source: AAOMgpeO+gtXsUTMs8HrLBryq6xFNeI1I3779eA59J4lX4ZmzPHq9o1PiFB4/7QSXikBq43xFT3CYiGijTsqUPbkeLs=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr3916683ywa.116.1530136091469;
 Wed, 27 Jun 2018 14:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 14:48:10
 -0700 (PDT)
In-Reply-To: <20180618175033.GA2627@beast>
References: <20180618175033.GA2627@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 14:48:10 -0700
X-Google-Sender-Auth: LN-_E9dbBnv-WtAQGzcfkSrxxdE
Message-ID: <CAGXu5j+Su3fObnuzntQ7Tp8W6jfMt1hc=h-3Xhidgx--Nau1Ew@mail.gmail.com>
Subject: Re: [PATCH] dm: writecache: Use 2-factor allocator arguments
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:50 AM, Kees Cook <keescook@chromium.org> wrote:
> This adjusts the allocator calls to use the 2-factor argument style, as
> already done treewide for better defense against allocator overflows.
> Additionally adjusts style nit to avoid assignments in test expressions.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping -- I'd like to make sure this makes it into 4.18. All
other 2-factor allocations have been fixed in the kernel.

-Kees

> ---
>  drivers/md/dm-writecache.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 5961c7794ef3..7773f4c75701 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -259,7 +259,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>         if (da != p) {
>                 long i;
>                 wc->memory_map = NULL;
> -               pages = kvmalloc(p * sizeof(struct page *), GFP_KERNEL);
> +               pages = kvmalloc_array(p, sizeof(struct page *), GFP_KERNEL);
>                 if (!pages) {
>                         r = -ENOMEM;
>                         goto err2;
> @@ -859,7 +859,8 @@ static int writecache_alloc_entries(struct dm_writecache *wc)
>
>         if (wc->entries)
>                 return 0;
> -       wc->entries = vmalloc(sizeof(struct wc_entry) * wc->n_blocks);
> +       wc->entries = vmalloc(array_size(sizeof(struct wc_entry),
> +                                        wc->n_blocks));
>         if (!wc->entries)
>                 return -ENOMEM;
>         for (b = 0; b < wc->n_blocks; b++) {
> @@ -1480,10 +1481,13 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>                 bio_set_dev(&wb->bio, wc->dev->bdev);
>                 wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
>                 wb->page_offset = PAGE_SIZE;
> -               if (max_pages <= WB_LIST_INLINE ||
> -                   unlikely(!(wb->wc_list = kmalloc(max_pages * sizeof(struct wc_entry *),
> -                                                    GFP_NOIO | __GFP_NORETRY |
> -                                                    __GFP_NOMEMALLOC | __GFP_NOWARN)))) {
> +               if (max_pages > WB_LIST_INLINE)
> +                       wb->wc_list = kmalloc_array(max_pages,
> +                                                   sizeof(struct wc_entry *),
> +                                                   GFP_NOIO | __GFP_NORETRY |
> +                                                   __GFP_NOMEMALLOC |
> +                                                   __GFP_NOWARN);
> +               if (max_pages <= WB_LIST_INLINE || !wb->wc_list) {
>                         wb->wc_list = wb->wc_list_inline;
>                         max_pages = WB_LIST_INLINE;
>                 }
> --
> 2.17.0
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
