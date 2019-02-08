Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC64C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5D2083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D69zF0pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBHTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:07:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34519 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHTH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:07:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so3368689lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfejaHpZmo2POgKHhciov/2gbV778q8rFoRZsivspvs=;
        b=D69zF0pEc9ddJmZOUXouOOjRBloG4H50zHYf1lAqKVb8Ju26x/7ciyAzH0dA0v37G/
         F5WIApnDqBORM/W2pZ8WQA3cuAVAjt+t71PaqR7i/RpS8wthVy+Upj62ncEQWaT8e2g4
         sL6FZJx3obppa3mZynh/LojUrww9ZbA+ngGvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfejaHpZmo2POgKHhciov/2gbV778q8rFoRZsivspvs=;
        b=U/nk1EgMpQvgqtuu5Jjy9I8qDAt6xU1s2i2mDzBFcQWzJOQ2rPxev2frZrmEyZbDVA
         rsC9UUHaSfbFyXchKbSQjQXnt8VM4g0VnMzHigEAeZ4QyMg3sVfSAJ9cbDzlbrDMAed9
         kw7an91M8iM30nSBFXR+X5XFbr2CLl3ygisK5Y8PgdHUEq/qPoc2eYFsnZ697h2iTyGS
         WDNbRNfcGatDiEoFpj2u9a5x2iorZpRZwQQYqWK8AT9XkwVHtBMy09M+alEt+xVdevzD
         vJI19fJ5ZlG6rHyUZube5U0P8ib0/3/UIjeHtvUQXUTR6y0pXkyAASPoQErdkVmOIRxf
         sPxg==
X-Gm-Message-State: AHQUAuZej4kmaOGIm1REgEkWBndRsXB4sqmftHPFkQ8Z7TxRRCsRqUAV
        WGeby67eMdwmKxHCt0tIGpP3EgWLCHE=
X-Google-Smtp-Source: AHgI3Ia4lLVZ2F2amdQDHnPVOFxjyw1WCsYDcIZJwHlf+lG7dmDxpmmBmOHoALZ6oF782cr4dvpyBQ==
X-Received: by 2002:a19:d554:: with SMTP id m81mr14233852lfg.164.1549652844621;
        Fri, 08 Feb 2019 11:07:24 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m191sm562303lfe.92.2019.02.08.11.07.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:07:24 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id t14so3330573lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:07:24 -0800 (PST)
X-Received: by 2002:a19:c942:: with SMTP id z63mr2779875lff.162.1549652425610;
 Fri, 08 Feb 2019 11:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20190205185902.106085-1-evgreen@chromium.org> <20190205185902.106085-8-evgreen@chromium.org>
 <154948878332.115909.8361746129233481633@swboyd.mtv.corp.google.com>
In-Reply-To: <154948878332.115909.8361746129233481633@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 8 Feb 2019 10:59:49 -0800
X-Gmail-Original-Message-ID: <CAE=gft5H1mWdi3iL22v2reD7AK4rwxwSq=YX2DpykAcys8fyZg@mail.gmail.com>
Message-ID: <CAE=gft5H1mWdi3iL22v2reD7AK4rwxwSq=YX2DpykAcys8fyZg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] phy: qcom: Utilize UFS reset controller
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        SCSI <linux-scsi@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 1:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-02-05 10:59:01)
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
> > index aef40f7a41d4..b05f89d734f0 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
> > @@ -67,6 +67,16 @@ static int ufs_qcom_phy_qmp_20nm_init(struct phy *generic_phy)
> >         bool is_rate_B = false;
> >         int ret;
> >
> > +       ret = ufs_qcom_phy_get_reset(phy_common);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (phy_common->ufs_reset) {
> > +               ret = reset_control_assert(phy_common->ufs_reset);
>
> It looks like you can always call this and set phy_common->ufs_reset to
> NULL when it should be a no-op. But it would never be NULL because we
> would always fail earlier in ufs_qcom_phy_get_reset()?

True, I'll do this unconditionally.

>
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         if (phy_common->mode == PHY_MODE_UFS_HS_B)
> >                 is_rate_B = true;
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
> > index f2979ccad00a..9cc8aa0b7a4f 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> > @@ -147,6 +147,22 @@ struct phy *ufs_qcom_phy_generic_probe(struct platform_device *pdev,
> >  }
> >  EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
> >
> > +int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
> > +{
> > +       struct reset_control *reset;
> > +
> > +       if (phy_common->ufs_reset)
> > +               return 0;
> > +
> > +       reset = devm_reset_control_get_exclusive_by_index(phy_common->dev, 0);
> > +       if (IS_ERR(reset))
> > +               return PTR_ERR(reset);
> > +
> > +       phy_common->ufs_reset = reset;
> > +       return 0;
>
> I find this API weird that it doesn't return the pointer to the reset
> controller. It would be more kernel idiomatic if it returned the pointer
> and used error pointers.
>
> Are there now two places where we're getting the reset controller? I'm
> confused now.

Yeah, this was never meant to be an API, just a little static helper
function. But in order to structure the changes so that this change is
strictly "move the reset" (and not "combine init and poweron"), I had
to export this function and use it in the 14nm and 20nm init
functions. Those drivers do init() entirely themselves, and don't call
the common driver. In the next change, those init functions smoosh
into the common power_on() here, and then this function goes from
exported back to static. ... so yeah, temporary scaffolding to make
the series clearer.

>
> > +}
> > +EXPORT_SYMBOL_GPL(ufs_qcom_phy_get_reset);
> > +
> >  static int __ufs_qcom_phy_clk_get(struct device *dev,
> >                          const char *name, struct clk **clk_out, bool err_print)
> >  {
> > @@ -533,6 +549,14 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
> >         if (phy_common->is_powered_on)
> >                 return 0;
> >
> > +       if (phy_common->ufs_reset) {
> > +               err = reset_control_deassert(phy_common->ufs_reset);
> > +               if (err) {
> > +                       dev_err(dev, "Failed to assert UFS PHY reset");
> > +                       return err;
> > +               }
> > +       }
> > +
> >         if (!phy_common->is_started) {
> >                 err = ufs_qcom_phy_start_serdes(phy_common);
> >                 if (err)
> > @@ -620,6 +644,9 @@ int ufs_qcom_phy_power_off(struct phy *generic_phy)
> >
> >         ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_pll);
> >         ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_phy);
> > +       if (phy_common->ufs_reset)
> > +               reset_control_assert(phy_common->ufs_reset);
>
> All these ifs can go away basically.

Righto.


>
> > +
> >         phy_common->is_powered_on = false;
> >
> >         return 0;
