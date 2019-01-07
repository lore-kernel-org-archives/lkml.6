Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9550EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD872087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7AsFt5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAGXBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:01:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35875 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:01:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so2445675qtn.3;
        Mon, 07 Jan 2019 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0h0Ha7r0BaRhtlNIOmdmovDFXMe2CkC1Z2XLUJXCAeg=;
        b=d7AsFt5cYvoY3mCX2evgEfoR630LCPgXzriCrDL6hMyEpQX8kLLAb1l8jKuATzKQwg
         61mk5ZFyih3jObZHTjFFN9jQZq1mTMWzRxq0UnT8rgBWj+YhACwBAWQkzFXU+f41cTur
         dcMhRq41G49xrVUt2RmNsZI95X/Bqa3KvUJcSfcl6c8ZLnmysC4OyYdmAjSBVKVPiAI+
         uwumJkjqRIEOUi59FoORYRrgRJtE1pUfZW53SYrlXajWNg99QXXV67aOTU83PRzBf0D5
         PuVU8R9STYfeJWDQpXtiAUwO+mqKCSEvfkPrYFmRcYoqOa/+z25B38XeYiumlKBViEqy
         mtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0h0Ha7r0BaRhtlNIOmdmovDFXMe2CkC1Z2XLUJXCAeg=;
        b=ufwfEfBSwAHi7bvSRtHTWVcwecjYBTqNUP1WTqLuodZeaFvmOht208lb1EWnyMDrSC
         x+xiENPPE8LnCdoRlearw42o6NHWznDNOhFadEbBoG1jLvvIipk2E6bXptKnBi/UHd97
         qkTecAn+ivrGtrbGtqP5J/ot8FB+hBtKgnXO/j0+bKBtz1b/0dJkCeCFgqbLUHoQ1vXY
         RnXi2yxBBcAXeBhsue/H7XwKjNnhAPu+lBl27IqufXwGjslW+7xH54vfnki1uv6rdCMq
         VfyzWXS9aLpNFNSZUgjCf5aMkT6blm9Uh2hGECsS7fJO+jMJYGBHT9Ld9Qb5viHNNDpp
         CDFA==
X-Gm-Message-State: AA+aEWblDyG7zjP/EOH5stO7bnPATd6o4XM0Th+nqCCdpm7mnSn/KFrr
        V9dhKVPKYpC5BA6HRqhyp3yLkpvd7pYCXA6Vsqma4joL
X-Google-Smtp-Source: AFSGD/VvZtvB0pgk8tzZAMYUuB6JFL7faMqYnkgFGbvHX/13h/Tzuf6CTvZsLsWNuHHiW3rEY9c6XPd7rao87Uqewdc=
X-Received: by 2002:aed:2798:: with SMTP id a24mr61551842qtd.138.1546902092691;
 Mon, 07 Jan 2019 15:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20190107174538.GA7255@embeddedor>
In-Reply-To: <20190107174538.GA7255@embeddedor>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 7 Jan 2019 15:01:21 -0800
Message-ID: <CAPhsuW7a_F_K1cJdrGHLhnuCdpeN365n1BG-QawmxKWaZajGeA@mail.gmail.com>
Subject: Re: [PATCH] md-linear: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:35 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  drivers/md/md-linear.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index d45c697c0ebe..5998d78aa189 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -96,8 +96,7 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
>         int i, cnt;
>         bool discard_supported = false;
>
> -       conf = kzalloc (sizeof (*conf) + raid_disks*sizeof(struct dev_info),
> -                       GFP_KERNEL);
> +       conf = kzalloc(struct_size(conf, disks, raid_disks), GFP_KERNEL);
>         if (!conf)
>                 return NULL;
>
> --
> 2.20.1
>
