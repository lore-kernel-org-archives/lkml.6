Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF42C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AADB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbKqi+cT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AADB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbeKFRMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:12:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37563 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:12:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so8096958lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtOpj3MTJGeL9R8C8HB/rmGu74uiY687ebEOUaPjfHw=;
        b=RbKqi+cTWkOE7LA1yhlK2vikXPMsptjf9XxQQt4o4Hsdbr2yMelhgLcE/v2H/NODLg
         eW+4Ijfixna26QTDZrLJTVyOb44dLrEj7180YAdl8TXJM1jubQ+4QDVkJVZsSuVBuUGA
         rBPwI1AbwQpGPfH9cxZpNZdprypb+aq1+N6/x42DlMHUO5PQumskcqrT+sK4jBcQQVti
         AmzwtUBQcznYzXeey8ehplUl7RXblT2t75XfYJBpMPPfjxncBRdu/MKEbKc1iVBDIGQF
         8D0K390/PXSNofV+WRxwho0MLZBTBDchac9Y/CxvOke4G8J1SAFUAOePi6P3T2sHWzk6
         HHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtOpj3MTJGeL9R8C8HB/rmGu74uiY687ebEOUaPjfHw=;
        b=JBEnjjjm6CE9klf4Mhb8CIqP5RRIMNSEC7Ecqp/LV4vfOyH5DVzv+OYe44mkS/cN14
         MTK+BUbOygtrAfumVyOJeufx698ZR8Rv3+PNxJVLKQYY2T07zsM90HVwdHAFzoCX/amu
         JqsTyiPLlXP59+2QRy+nQCRGqblNmEgFIYjDB0eVwkyyBeSdS1S2syvg2H20/JCKAsrM
         /VUcPThectXDAdfq4pCkHKv+05O2M6R2FYSZ2z7/XLmmpA+c7u/dJwhusWm5WzJ6LU4F
         +kKolESDa2oNJ1Ya4Fj4iPVyX4iOZ3Dafa76S3I9AFckgPTfMbrVdeexI5oQEq0f/C5A
         ziEg==
X-Gm-Message-State: AGRZ1gJOYjX3DCqXx5tdSJzC7GXSZa2TDWLeg9og/TWOhkPBviejCn3K
        2+jDyOXJFILJ1ngQ9oAseRoNNyxIViuxvJQAmlXqEWFURIc=
X-Google-Smtp-Source: AJdET5c7vfoGfNZ0Sv/5dvhRKq+gfUD3cqGspfJm0S1ik4UAK4xyMjYgZtDjiK2o0oMWoqSEKt1gyjp4wpRKBz8skVk=
X-Received: by 2002:a19:9fcd:: with SMTP id i196mr14483248lfe.82.1541490531146;
 Mon, 05 Nov 2018 23:48:51 -0800 (PST)
MIME-Version: 1.0
References: <1530853846-30215-1-git-send-email-ks77sj@gmail.com>
In-Reply-To: <1530853846-30215-1-git-send-email-ks77sj@gmail.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Tue, 6 Nov 2018 08:48:39 +0100
Message-ID: <CAMJBoFPGZ_pYFQTXb06U4QxM1ibUhmdxr6efwZigXdUo=4S=Vw@mail.gmail.com>
Subject: Re: [PATCH] z3fold: fix wrong handling of headless pages
To:     =?UTF-8?B?6rmA7KKF7ISd?= <ks77sj@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jongseok,

Den fre 6 juli 2018 kl 07:11 skrev Jongseok Kim <ks77sj@gmail.com>:
>
> During the processing of headless pages in z3fold_reclaim_page(),
> there was a problem that the zhdr pointed to another page
> or a page was already released in z3fold_free(). So, the wrong page
> is encoded in headless, or test_bit does not work properly
> in z3fold_reclaim_page(). This patch fixed these problems.

thank you for your work, we've now got a more comprehensive solution:
https://lkml.org/lkml/2018/11/5/726

Would you please confirm that it works for you? Also, would you be
okay with dropping your patch in favor of the new one?

~Vitaly

> Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
> ---
>  mm/z3fold.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4b366d1..201a8ac 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -746,6 +746,9 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>         }
>
>         if (bud == HEADLESS) {
> +               if (test_bit(UNDER_RECLAIM, &page->private))
> +                       return;
> +
>                 spin_lock(&pool->lock);
>                 list_del(&page->lru);
>                 spin_unlock(&pool->lock);
> @@ -836,20 +839,20 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                 }
>                 list_for_each_prev(pos, &pool->lru) {
>                         page = list_entry(pos, struct page, lru);
> +                       zhdr = page_address(page);
>                         if (test_bit(PAGE_HEADLESS, &page->private))
>                                 /* candidate found */
>                                 break;
>
> -                       zhdr = page_address(page);
>                         if (!z3fold_page_trylock(zhdr))
>                                 continue; /* can't evict at this point */
>                         kref_get(&zhdr->refcount);
>                         list_del_init(&zhdr->buddy);
>                         zhdr->cpu = -1;
> -                       set_bit(UNDER_RECLAIM, &page->private);
>                         break;
>                 }
>
> +               set_bit(UNDER_RECLAIM, &page->private);
>                 list_del_init(&page->lru);
>                 spin_unlock(&pool->lock);
>
> @@ -898,6 +901,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                 if (test_bit(PAGE_HEADLESS, &page->private)) {
>                         if (ret == 0) {
>                                 free_z3fold_page(page);
> +                               atomic64_dec(&pool->pages_nr);
>                                 return 0;
>                         }
>                         spin_lock(&pool->lock);
> --
> 2.7.4
>
