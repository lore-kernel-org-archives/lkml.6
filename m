Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830A020818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T53ZR8Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfBESAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:00:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43183 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBESAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:00:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id j1so3302673lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aw4p7nuM5af9f3g6GevmObu+alQDBhl4FBTwUoKEb8o=;
        b=T53ZR8XztND5DbsLe+FDfvqPtGg0oeoHAhRcF+BzwnKLynzj4KwGhoVVOF/++9RNiQ
         OjXNE4LqTxxyycqo/hSxKbXJq0ULTgaNZs7ykYy/NSBhBFgjVQeZpok7gdbG3MoBBINx
         xI5dLPAcso7ILZUeJwsKlknKakQY+m67UWO3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aw4p7nuM5af9f3g6GevmObu+alQDBhl4FBTwUoKEb8o=;
        b=RtllG/DxivfSpMHWx49z6gWV//IWpbgpcfYR2pPAhAE4gUUSPmvEnKP0Wc0qx6nEtD
         Eaj9SrOpf1mP+R0qccm9iDv3qgkrAgRr8V1YYW5zYm0w25egvPStakdBOm/bYEmWIlqd
         t7GiiE/8LmlKJO9y3q1C07WkgyquZiJ7/ouKOW9KT8EjN+V+8OI7dv2N0L08f2MeexaM
         tQeDi4RDQZJI2RyzDc8ckd6fXYz6J6ISBRDH+zZn1NfV7grYgywNxw/2GEZbZcTLsHqi
         kVLz3V20PAcU6IMqxXFILSojMeaEyDQUmBwmm6G25suMINC994GTbCri9LQHk4NHzaxj
         ZygQ==
X-Gm-Message-State: AHQUAuYVlGJ3U5AU0gvHZcmIx8b62PuobfSYWd3jPflDpeJzAUh/JzgT
        4uBPdIvHMDBhUPga3FosSJsM+AOrpeo=
X-Google-Smtp-Source: AHgI3IaKsOusXS9p3bS6xbjifeSvpwDMgviJqhSnnK/U+7HZWiP4PJgMrA+WYKg79CkmWybJ09B/WQ==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr3816453lfb.118.1549389644093;
        Tue, 05 Feb 2019 10:00:44 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y25sm3840816lfg.4.2019.02.05.10.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 10:00:43 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f5so3281743lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:00:42 -0800 (PST)
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr3991571lfe.154.1549389641641;
 Tue, 05 Feb 2019 10:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-8-evgreen@chromium.org>
 <154904400541.169292.16178504232098968369@swboyd.mtv.corp.google.com>
In-Reply-To: <154904400541.169292.16178504232098968369@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Feb 2019 10:00:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Mh-bShB2sHehiS=k21ciDXAnkjQbq8Odpn0bMZCd75Q@mail.gmail.com>
Message-ID: <CAE=gft4Mh-bShB2sHehiS=k21ciDXAnkjQbq8Odpn0bMZCd75Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] phy: qcom-qmp: Utilize UFS reset controller
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 10:00 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-23 14:11:35)
> > @@ -1144,6 +1150,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >
> >         .is_dual_lane_phy       = true,
> >         .no_pcs_sw_reset        = true,
> > +
> > +       .has_ufsphy_reset       = true,
>
> Is this the same as .no_pcs_sw_reset implying that .has_ufsphy_reset? Or
> it's possible to have no resets at all? I'd think there's a reset in the
> phy or in the pcs and so we could just have one bit telling us which
> type of reset to perform.

Ok. I guess pcs_sw_reset is the same reset as this bit that seems to
bubble up in the ufs-qcom controller? If some new crazy qcom chip
comes up that has both resets or no resets, this should be pretty
simple to disentangle.

>
> >  };
> >
> >  static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
> > @@ -1314,6 +1322,9 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
> >                 return 0;
> >         }
> >
> > +       if (qmp->ufs_reset)
> > +               reset_control_assert(qmp->ufs_reset);
> > +
> >         if (cfg->has_phy_com_ctrl) {
> >                 qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
> >                              SERDES_START | PCS_START);
> > @@ -1351,6 +1362,33 @@ static int qcom_qmp_phy_init(struct phy *phy)
> >
> >         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> >
> > +       if (cfg->has_ufsphy_reset) {
> > +               /*
> > +                * Get UFS reset, which is delayed until now to avoid a
> > +                * circular dependency where UFS needs its PHY, but the PHY
> > +                * needs this UFS reset.
> > +                */
> > +               if (!qmp->ufs_reset) {
> > +                       qmp->ufs_reset =
> > +                               devm_reset_control_get_exclusive(qmp->dev,
> > +                                                                "ufsphy");
> > +
> > +                       if (IS_ERR(qmp->ufs_reset)) {
> > +                               dev_err(qmp->dev,
> > +                                       "failed to get UFS reset: %d\n",
> > +                                       PTR_ERR(qmp->ufs_reset));
> > +
> > +                               ret = PTR_ERR(qmp->ufs_reset);
>
> Do this ret conversion once and then print it after?

Yeah, good idea.

>
> > +                               qmp->ufs_reset = NULL;
> > +                               return ret;
> > +                       }
> > +               }
> > +
> > +               ret = reset_control_assert(qmp->ufs_reset);
> > +               if (ret)
> > +                       goto err_lane_rst;
> > +       }
> > +
> >         ret = qcom_qmp_phy_com_init(qphy);
> >         if (ret)
> >                 return ret;
