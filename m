Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016A021486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dePuGJ48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016A021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJSToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:44:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40985 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:44:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so1141069qke.8;
        Fri, 19 Oct 2018 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMp2uAnUhfM01Hv5BXda1P5I6vge9AFG4+PbEOl9n4I=;
        b=dePuGJ481WNaJtIvzhmER7VLX1AU31u9rTCOILESfD7QN7En6Rh2CrKD1lbym5xj6I
         Dpdm3AfqGX2GU6UhvKnBLLso8F4UVO0eqONJBzDc2sfynHG0BXeKgHtYFXird+QGULgJ
         TXDdytoHxlSNVVdu7+t5I5MroJFj0rhRlDpSYpzoKT8u3bh3fPiD2ijaIBtJ11Z6J/qU
         Gac7G6z4b/tk3y6oY3/qa1xcoBcCaB9qV322aSeE0ChwPtM+TexoqqAShI1oTrms2gLf
         /sqti+Ht8uQgvRmqysAxH9k/dlgJfXPp6shksZCEgQoJU2dxRsFwvXLMHfqpX3KDrgK1
         wC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMp2uAnUhfM01Hv5BXda1P5I6vge9AFG4+PbEOl9n4I=;
        b=ZUL+Mut06/1n4U4bvVOO5pVt+s706Mn3gBcfDC1ejJ1aOjEUMaz9E/SBe6AWW4nY/E
         RUTKfaIBGtf6DmCWeMJyBSpclWWBpODV5gcp/wBWPzyWas3hhjHUwaLmMkAbMMt5tTx0
         nO04hAxlv0vMhBGe3utPK7fGF3/ys0zIpCk2uo0qWBoo2mbjELARy4OPfstnoEy4lEm6
         +4mF/6pP3JblX9R8ndvsEYnJXfEgA4VSSppcZTrDf8LHBLOpy2PDeyNihG+1yxuYtNcv
         EvluYccWGqNKpOtE8SMO3EOZDxbbiOprr6d0aRquGMH9206tdpT+ksyeRLgSpDfJKQYw
         Xg5Q==
X-Gm-Message-State: ABuFfogRbQRaf7+BOM30wMUm4Kcy0DD4MBgv8f248qRj0koRT1dXHJyE
        NmDDHnkbmWXpkInNVPqF7BhkFIczyoqGADvIAwI=
X-Google-Smtp-Source: ACcGV63WdonvR78G2SRAF+U8ZLTuqfs1+8KSaDTDOdxSHhbgSp4VuUM2LRQw7OvmTkNuJEbyhEl1wpalFfTghFBWUXM=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr32357016qkg.70.1539949108770;
 Fri, 19 Oct 2018 04:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180926052115.21223-1-natechancellor@gmail.com> <DB5PR05MB1640104C32067C3BE43CA529A2150@DB5PR05MB1640.eurprd05.prod.outlook.com>
In-Reply-To: <DB5PR05MB1640104C32067C3BE43CA529A2150@DB5PR05MB1640.eurprd05.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 14:38:17 +0300
Message-ID: <CAHp75VeS0sodYAY_OTfi8HvLvaE8eHHv1JL9BGoLxrsxwzBnSA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: mlx-platform: Properly use mlxplat_mlxcpld_msn201x_items
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     natechancellor@gmail.com, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:43 AM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Nathan Chancellor <natechancellor@gmail.com>
> > Sent: Wednesday, September 26, 2018 8:21 AM
> > To: Vadim Pasternak <vadimp@mellanox.com>; Darren Hart
> > <dvhart@infradead.org>; Andy Shevchenko <andy@infradead.org>
> > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; Nathan
> > Chancellor <natechancellor@gmail.com>
> > Subject: [PATCH] platform/x86: mlx-platform: Properly use
> > mlxplat_mlxcpld_msn201x_items
> >
> > Clang warns that mlxplat_mlxcpld_msn201x_items is not going to be emitted in
> > the final assembly because it's only used in ARRAY_SIZE right now, which is a
> > compile time evaluation since the array's size is known.
> >
> > drivers/platform/x86/mlx-platform.c:555:32: warning: variable
> > 'mlxplat_mlxcpld_msn201x_items' is not needed and will not be emitted [-
> > Wunneeded-internal-declaration] static struct mlxreg_core_item
> > mlxplat_mlxcpld_msn201x_items[] = {
> >                                ^
> > 1 warning generated.
> >
> > It appears this was a copy and paste mistake from when this item was first
> > added. Use the definition in mlxplat_mlxcpld_msn201x_data so that Clang no
> > longer warns.
> >

Pushed and applied, thanks!

> > Link: https://github.com/ClangBuiltLinux/linux/issues/141
> > Fixes: a49a41482f61 ("platform/x86: mlx-platform: Add support for new
> > msn201x system type")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
>
> Acked-by: Vadim Pasternak <vadimp@mellanox.com>
>
> >  drivers/platform/x86/mlx-platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-
> > platform.c
> > index d89936c93ba0..c2c3a1a19879 100644
> > --- a/drivers/platform/x86/mlx-platform.c
> > +++ b/drivers/platform/x86/mlx-platform.c
> > @@ -575,7 +575,7 @@ static struct mlxreg_core_item
> > mlxplat_mlxcpld_msn201x_items[] = {
> >
> >  static
> >  struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data = {
> > -     .items = mlxplat_mlxcpld_msn21xx_items,
> > +     .items = mlxplat_mlxcpld_msn201x_items,
> >       .counter = ARRAY_SIZE(mlxplat_mlxcpld_msn201x_items),
> >       .cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
> >       .mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
> > --
> > 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
