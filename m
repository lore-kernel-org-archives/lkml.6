Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2FBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3379720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cm1EAPb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfAVWpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:45:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46393 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfAVWpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:45:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so117375lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHQwJO3HLNGiK+CT5RrJqI51ihD6uy2aYAHy9bquWEM=;
        b=Cm1EAPb/ENdQUTtUNhdf5CFpw4t+1PFGgor3CX3VITOk4eSfncb6OLvEkw852jlEyu
         6exUHgXPIcs+/AINOHzhVf1xO/lNyhJi70V2KjFIH0WykfFmLQQJUWtgcHip3xhxQCiQ
         7dNmAnNTkQeOrSkLvFYH/Kz6ISSs0J40llqag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHQwJO3HLNGiK+CT5RrJqI51ihD6uy2aYAHy9bquWEM=;
        b=Il3oUnH04a9lJiHX3En4O8eVyqvk7Dz96jGvaEQug1kp5WItHUAKhheYhOj6GYQpqv
         4GeNyxQGuXlf+eQ29IHQU1h0McnlWc5u6ELfSqipcR5btkT9xpOrCc3yyDpfVY1o0SuC
         kmUI5vmKLCq66IpGcL249xJNMIJsS4BbTG6X1MldQCxcYdVwdWkySAPahuzSrO6VHeTn
         8rhkNacz+iSSx7qWDtMpv4zo8yWE3nAKPlf5+eoIK4c9DGHMLBSK4c3sWcSfBaQf6hLV
         i0OH1SE4BkXRQHzyNtPkQ/81kUTkN0Q09evTzEf3+2DPVlDIFNGJlQYYgIjEpqrv/jSD
         GKdA==
X-Gm-Message-State: AJcUukcaQWZU5U6oo1v//l4pfIByCroc2LDbxWrVIRM8aFYQS3z9MDil
        MzjhN5e+HwS/ZoTyBOioV4FiruefJFg=
X-Google-Smtp-Source: ALg8bN49s4lqjq6RZ29SYX9xY0M6G+3BTW5xnPgQdFMzGCw2InbGYNXn2k/fjbzkeDwocNCT7gU8tg==
X-Received: by 2002:a19:690d:: with SMTP id e13mr21970573lfc.84.1548197131730;
        Tue, 22 Jan 2019 14:45:31 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 12-v6sm194439ljf.96.2019.01.22.14.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 14:45:30 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n18so145295lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:45:29 -0800 (PST)
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr21836374lfc.27.1548197129244;
 Tue, 22 Jan 2019 14:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-9-evgreen@chromium.org>
 <154785540598.169631.18430427073255279078@swboyd.mtv.corp.google.com>
In-Reply-To: <154785540598.169631.18430427073255279078@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 14:44:53 -0800
X-Gmail-Original-Message-ID: <CAE=gft5jM-icC2tAs0boPWYNJKfn9i3ZPiLe_=q-6Lmb8kC9nQ@mail.gmail.com>
Message-ID: <CAE=gft5jM-icC2tAs0boPWYNJKfn9i3ZPiLe_=q-6Lmb8kC9nQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] phy: qcom-ufs: Refactor all init steps into phy_poweron
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:50 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-11 15:01:29)
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
> > index f2979ccad00a3..a4cff17fef925 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> > @@ -147,6 +147,21 @@ struct phy *ufs_qcom_phy_generic_probe(struct platform_device *pdev,
> >  }
> >  EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
> >
> > +static int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
> > +{
> > +       struct reset_control *reset;
> > +
> > +       if (phy_common->ufs_reset)
> > +               return 0;
> > +
> > +       reset = of_reset_control_get_by_index(phy_common->dev->of_node, 0);
>
> Same question about using non-DT specific APIs to get the reset control
> here.

Will fix.

>
> > +       if (IS_ERR(reset))
> > +               return PTR_ERR(reset);
> > +
> > +       phy_common->ufs_reset = reset;
> > +       return 0;
> > +}
> > +
> >  static int __ufs_qcom_phy_clk_get(struct device *dev,
> >                          const char *name, struct clk **clk_out, bool err_print)
> >  {
> > @@ -528,23 +543,42 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
> >  {
> >         struct ufs_qcom_phy *phy_common = get_ufs_qcom_phy(generic_phy);
> >         struct device *dev = phy_common->dev;
> > +       bool is_rate_B = false;
> >         int err;
> >
> > -       if (phy_common->is_powered_on)
> > -               return 0;
> > +       err = ufs_qcom_phy_get_reset(phy_common);
> > +       if (err)
> > +               return err;
> >
> > -       if (!phy_common->is_started) {
> > -               err = ufs_qcom_phy_start_serdes(phy_common);
> > +       if (phy_common->ufs_reset) {
> > +               err = reset_control_assert(phy_common->ufs_reset);
> >                 if (err)
> >                         return err;
> > +       }
> >
> > -               err = ufs_qcom_phy_is_pcs_ready(phy_common);
> > -               if (err)
> > -                       return err;
> > +       if (phy_common->mode == PHY_MODE_UFS_HS_B)
> > +               is_rate_B = true;
> >
> > -               phy_common->is_started = true;
> > +       err = phy_common->phy_spec_ops->calibrate(phy_common, is_rate_B);
>
> Is there always a calibrate phys_spec_ops function assigned?

Yeah. This whole table is only used to support phy-qcom-ufs-qmp-14nm.c
and phy-qcom-ufs-qmp-20nm.c. I don't even see any device trees using
phy-qcom-ufs-qmp-20nm.c. So it seemed okay to assume it was populated.
