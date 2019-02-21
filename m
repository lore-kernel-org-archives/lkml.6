Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B04FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB18206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a73TWtFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBUU7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:59:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38433 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:59:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id p15so5165698qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HsirSaHgF3nrHLdsnlGzjR+XNKpSzn5MWdsXjHuCW8=;
        b=a73TWtFB23q7YILKBQK6H3cNILUIRSrXiZqFLyL0ZAo1023eRTxXAaVETCI9CMyEW0
         rJArQNgXojK0TGiog3oJk58B80cOgu3O63+7Zk28yxD+OEvUqs+UsXwfh/oyRK5w/v7b
         W/0XtfWHOzI7xJJBKWjQ79Gj8dU83olkiS0h/EATZyLvXbXQQXZ8tGJNrjua51OZ1T5d
         J99+2mxglYWTc2hBqqmf7x5zdLtEbHrIibqgNw2hgxuZkA0YkyDf1MPPr/YPXebghnql
         OVvxKkDwcur1Wjb+tMkfr0vzWLBjet4NPDnNIGTqdPh12E3Hg0Ev2fE0/G3WHzmPKhsN
         lDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HsirSaHgF3nrHLdsnlGzjR+XNKpSzn5MWdsXjHuCW8=;
        b=FWzP77MGfGMiXvMs4W/1Obp1Ex6FfdyMVMdxpcMRIplUkMoQxV282K6qd3JV04sBn3
         XD7NOsZk3HiYDWg4g3VV5fFvVWAafLmU9sD1V5XVaCVcaWXZjKsS4eRM9KIJK6d78+71
         /nf3B+NJyMr9IiYzlR+AL4GzURFjuM4gvQLR/KWdgVEwLeyg4aSXlO6fbVB28ptg/tgb
         IoGfFv7VwM2iNx6rPhYPK5OD9fdrj9I/e+a9bALqMD1OvPepxB9k2T9n7QP5+vTA7ySs
         H5wV/sbX7QCCmn+EGHmU1ZCgDGUe33vV9g90zQGH63CccHNqsa4Tm/B+rpSIV8vQi4fE
         1dEQ==
X-Gm-Message-State: AHQUAubIT8gQ1RVwdme965cX/9RDx64L1GpPWzcVAxbv3/RbKQK32vOk
        0xQwCB20/f0W1DPBhnrdBHm+T1rqpq/H/0watN4=
X-Google-Smtp-Source: AHgI3IYnrl6/w7gDDnXr3YQYGShHPAHMWAMRjqVkY18kuiRzm1xHl63g49lUDUWBqxkEB8g5WDKn26avTfAmC2bed5Q=
X-Received: by 2002:a37:c403:: with SMTP id d3mr421649qki.54.1550782739144;
 Thu, 21 Feb 2019 12:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20190214205723.9011-1-robimarko@gmail.com> <97e48e85-9700-53e3-0f7a-eeac6f93f721@microchip.com>
In-Reply-To: <97e48e85-9700-53e3-0f7a-eeac6f93f721@microchip.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 21 Feb 2019 21:58:47 +0100
Message-ID: <CAOX2RU5MsnNLseBRqcp1KqbmQ+5_KzRyTQ_rGQB2DsrW_v-3iA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add Winbond w25q16jv support
To:     Tudor.Ambarus@microchip.com
Cc:     =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        bbrezillon@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 at 21:29, <Tudor.Ambarus@microchip.com> wrote:>>
Hi, Robert,>> On 02/14/2019 10:57 PM, Robert Marko wrote:> >
Datasheet: https://www.winbond.com/resource-files/w25q16jv%20spi%20revg%2003222018%20plus.pdf>
>> > Testing done on Mikrotik Routerboard RB450Gx4 board under 4.19.19
kernel.>> It is preferable to do the test on spi-nor/nextUnfortunately
I cant do that as OpenWrt has a considerable amount of patches that
would need to be ported and we are only moving from LTS to LTS version
and we are currently on 4.19.
> >
> > Test board does not support Dual or Quad modes.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 6e13bbd1aaa5..0e958f48db1b 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1975,6 +1975,11 @@ static const struct flash_info spi_nor_ids[] = {
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >       },
> > +     {
> > +             "w25q16jv", INFO(0xef7015, 0, 64 * 1024,  32,
> > +                     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > +                     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>
> You'll need a way to differentiate between W25Q16JV-IQ/JQ and W25Q16JV-IM/JM.
Hm, from what I understood JV is the series and suffix only indictes
the package.
They should all have the same JEDEC ID and features.
>
> And I would prefer to have the new entries ordered alphabetically as much as
> possible. This one should fit just before w25q20cl. Manufacturers are naming
> flashes based on a product identification system. The flashes are presented in
> alphabetical order, we should do the same.
I agree, will reorder and send a v2.
>
> Cheers,
> ta
