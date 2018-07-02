Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC092543E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FejGQgFa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jur1W5qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC092543E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeGBQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:00:09 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34376 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeGBQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:00:07 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so5276955ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7FjjkQR0nDSDpZQ0S++NFbdPBmXNUpA3auVp5tW5uzQ=;
        b=FejGQgFaey7Kjgx37qkeOXdLQ3mKblu0me4FJwmNXOYN/wuAB4ePPHh5SbJ7o6Zyl8
         P6Gk+zwxkC9ps5twWdxkholHnskJfFwg/e845RaaObBaZx8Whp/M2MDKW6D9ZjV6lOGO
         4B50hbjI0dX52alZ9MGnoDFft+i1RlC6mc+GkQcfLL6TRq9QUIZXVB4q8PxXcZIi7yaz
         XRM8xSu36E3cTKBZxbdI6NvkNO/WUJktaeDkOjK3C27/PdkAjDSlidYzmf2RKbct+5VA
         QHUmiFB007KNX6XQgbeXiIPjXII/ItuaeoDDf2KtHeqUoYCRr5to8+xix9j32MRoaPdj
         NOng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7FjjkQR0nDSDpZQ0S++NFbdPBmXNUpA3auVp5tW5uzQ=;
        b=Jur1W5qK9B9eHBUNnPhCrLt6TDqP4G9Fd9dbfO3Gjy3iAI0h1cjEuobqsrVT+RlOz+
         5D6tNi4WvkCdz7MSHIiP2Vfm05//1FpUD1dntqLyXOQs92fBQ50yO3F2hnepHW408H8l
         diyvEAXESzsGTwopZoMv81AbO62xN/bjWS0y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7FjjkQR0nDSDpZQ0S++NFbdPBmXNUpA3auVp5tW5uzQ=;
        b=VSZnVKnD4g5i1IzUgJ/XfjMWE9DtNHE86fpYYM33o811JjFFcM/plQQqOKD/2XQwEY
         YqtwEjWNWmxy6tZV6F2Z8xrOaOXSEeYtkzIKSzlJdHTv1VnZ35ss+GM47a/TEQ1Scizp
         Q2laOXDmvv1YagP3w/OdQW9wQ9/UE18KE9TBhBUJDDvPvtcygESFsEwjDFvhdazqGHDG
         gbS2XjOebUB+PpJJqGDissckOOBfrdYK591/8YRKUGT3P8s5r4qAv3Y1BvlHm4GfZJ+a
         JcHvQ9DOQSRxF4xlvq7GUplvQ8TsB7a7iGztYuM4Tn2mk/Wsy+9/oy4JdR+lYub9UHpR
         KFQg==
X-Gm-Message-State: APt69E20ANmeuOkT5ZxaQO77DnMxgIQXontGOiKy1xIa1pjapPg96c7Z
        YC/bVECPuhfnh+XpQx99EZHuyvM29+bRMG0gQhfkvQ==
X-Google-Smtp-Source: AAOMgpfU/EqwwR85v6PZvH7FFtM5fDQcny6OXvaBx5HuU2EneADwsAyoPeBhJhORQE5bkz+GebcdEpEmEfqI8YDC/FM=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr3050738ybr.463.1530547206412;
 Mon, 02 Jul 2018 09:00:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:00:05 -0700 (PDT)
In-Reply-To: <20180701212051.29486-1-richard@nod.at>
References: <20180701212051.29486-1-richard@nod.at>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 09:00:05 -0700
X-Google-Sender-Auth: 679meJRnA_6ZO7fi_L4Gxwt79wc
Message-ID: <CAGXu5jJyeoKdqo86+tWoq1n34sELSAXQu8LSBpEbiu2oFg2JPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 2:20 PM, Richard Weinberger <richard@nod.at> wrote:
> This reverts commit 353748a359f1821ee934afc579cf04572406b420.
> It bypassed the linux-mtd review process and fixes the issue not as it
> should.

Ah, sorry, I thought you were CCed on the original report.

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/journal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 07b4956e0425..da8afdfccaa6 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1282,11 +1282,10 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>                               int *new_len)
>  {
>         void *buf;
> -       int err, compr_type;
> -       u32 dlen, out_len, old_dlen;
> +       int err, dlen, compr_type, out_len, old_dlen;

What's wrong with making these unsigned?

>
>         out_len = le32_to_cpu(dn->size);
> -       buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
> +       buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
>         if (!buf)
>                 return -ENOMEM;

Please leave the kmalloc() -> kmalloc_array() change, as that has
happened treewide already. We don't want to have any multiplications
in the size argument for the allocators (i.e. they should use 2-factor
arg version like here, or use array_size() for things like vmalloc()).

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
