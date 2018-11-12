Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC67C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D26223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="numwVFBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D26223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeKMCVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:21:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43146 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeKMCVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:21:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so8135829lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43BxuzNc4524qU/znys73ykza2ZaFxC6mmrB9EdAkz8=;
        b=numwVFBgMsucLxSwNRwPNmrg55rPBd6JbDVSItc2iiY4ApjMw+uw6ACFZrBXCPrVPK
         sTFK17iceBBNukPaVtqAGnVqg7HkcB0cfzfjmNWu6CxmwPQ9TASSVG6FtL1DPRiajIe/
         qhQ6okQfI/RtW7jifmIx+rX1oZqj0A23M2GucZYgr+j72YJ3dNQRcBX0gKpeN/R/4Vn9
         zOUV3C+drkBrUPEc1aPPNb1XL5XOug8YFQhxqPCWvOhgEnduGC1B7tflOm6Ect178fOe
         mx30ZLXTxJzz1uS9d5ZPbhjrjHRurP9uZkXjYFs5tWjQ/ePkrCIF0jM1/DcGp3sUUtIu
         MmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43BxuzNc4524qU/znys73ykza2ZaFxC6mmrB9EdAkz8=;
        b=jxu1RD91fcgESnoX/Kw1bRgvgQz9MQ7kdXBcv9o3PTJMwyrxyRoc+TFASSFs7O7quF
         MY0mb2IIqpGbSOnwZbisPUzA+UgeAsyxTnZWF5QoPMLXTTUfpOhy0GE4CKv1OAfE67Xb
         ue5+aN8ELq1pu9PlB7qN6PeoArGGoO9bnEtrc51sfS3bIdm4uDtxhAy0Ab/LOiKX9oUJ
         cBjvyRxSX6v8tZ48psDBJUiHmitlO9H0UJQ/psHJT8EtjTD5qjO78n8vYAjAJmFTDUNZ
         9KmwCt1LMQEVF0cbmHBIyiza08HQW0rQzWly3RMXvmm9OqsKeuk0TYLaeSMI1TG0hgEW
         dciA==
X-Gm-Message-State: AGRZ1gKy1LMxYQx4t+ifETBlbBb8OyeonJ0V+ogkCHKF1Trdull/yX5C
        jhjgc4Y+mYgLSMuCFg3tJfwrguZMAQ8bqsxbPRU=
X-Google-Smtp-Source: AJdET5ewPPoc5BgEsBnBvVc2Pnfye0DwudqbrbmI8yq5Vr50sCrMy6qxXrDyPwEUoHqwMZQF48OpCk12cLJPbI2f9So=
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr1232928ljj.6.1542040036991;
 Mon, 12 Nov 2018 08:27:16 -0800 (PST)
MIME-Version: 1.0
References: <CGME20180823084348eucas1p2157ab1089290298cf43647e522b8be4f@eucas1p2.samsung.com>
 <1535013819-1646-1-git-send-email-huijin.park@samsung.com> <20181031150225.175ec1d4@bbrezillon>
In-Reply-To: <20181031150225.175ec1d4@bbrezillon>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Tue, 13 Nov 2018 01:27:05 +0900
Message-ID: <CAMy0x0nSjhRrG913NBeood68NfYAYngg=PAL+pmy4U4=WRuJxg@mail.gmail.com>
Subject: Re: [PATCH] mtd: change len type from signed to unsigned type
To:     boris.brezillon@bootlin.com
Cc:     huijin.park@samsung.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, Oct 31, 2018 at 11:02 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Hi Huijin,
>
> On Thu, 23 Aug 2018 04:43:39 -0400
> Huijin Park <huijin.park@samsung.com> wrote:
>
> > From: "huijin.park" <huijin.park@samsung.com>
> >
> > assign of a signed value which has type 'int' to a variable of
> > a bigger unsigned integer type 'uint64_t'.
>
> Why are you mentioning u64? AFAICT, the len passed to erase_write() is
> always an unsigned int.

It's my mistake.
Messages about u64 are not related to this patch.

>
> > this is ok most of the time, but can lead to unexpectedly large
> > resulting value if the original signed value is negative.
> > in addtion, the callers of the erase_write() pass the len parameter
>
>   ^In addition,
>
> > as unsigned type.
> >
> > Signed-off-by: huijin.park <huijin.park@samsung.com>
> > ---
> >  drivers/mtd/mtdblock.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> > index a5b1933..b2d5ed1 100644
> > --- a/drivers/mtd/mtdblock.c
> > +++ b/drivers/mtd/mtdblock.c
> > @@ -56,7 +56,7 @@ struct mtdblk_dev {
> >   */
> >
> >  static int erase_write (struct mtd_info *mtd, unsigned long pos,
> > -                     int len, const char *buf)
> > +                     unsigned int len, const char *buf)
>
> The diff looks good, but the commit message is not clear at all. Can
> you reword it?
>
> Thanks,
>
> Boris
>
> >  {
> >       struct erase_info erase;
> >       size_t retlen;
>

I will send again patch after reword the commit message.

Thanks & best regards,

Huijin
