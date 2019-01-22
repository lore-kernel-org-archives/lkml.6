Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80721C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1BD217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGZ1Y4BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAVWmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:42:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45693 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfAVWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:42:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so117459lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CUfxIFjCLwXNeOGQDC9ZCki02WYGCOOurAekz4sYGQ=;
        b=hGZ1Y4BHQ9qYXy4VSGzhGdB1HC/KiciK5qRggVc4SLTSv5dNBUorS79XytceYO+3rg
         CVkrWdsaympS94nndoG10j997A4lD+q15bkY5Pbqc9HKpRLTOGHzCKcneZDLjsYXtlbP
         VRHgBkl4Wh4jwvvCZ+Vm10/QMwn0eI0p5l+HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CUfxIFjCLwXNeOGQDC9ZCki02WYGCOOurAekz4sYGQ=;
        b=dx1dX3KVvyz5V5Kf7lqpBkcD+beIJSa2G93cNi5n1a4HDHxGubjeVqeoCguMpmQMTC
         Sd8BmBnPLcBw449OSJtcNk+1uLx1UfXcV8tzgjDV7A2syvghrDkNwvAm+D0b6weN+idM
         GVpleieL7RENxCZ+aEoxHa51rfmS5l5MEZ3BKviPS/LjQLaVTj9EjKJs2McndWGFmKdF
         cS5q62v4vc3wv0Q4T0BCYtmOfYi7p2f1DW1rcWrsj3J/fsQmWXHdcN9M7TQti4c0KbIA
         rSh80+9xEv+xNstbA+mMWl0vRgkmn72xFrnsLTEveqJBZaQ+IqG7YCarmvc2c/L8BrV5
         a3/w==
X-Gm-Message-State: AJcUukcR4T6dCJZpgxwkMLOTcTeBqfhQArLgOnfZ7aSXySxNQv4iMSsO
        k2YV3LQeAQcJ465EIr8TixqIbe1rL7c=
X-Google-Smtp-Source: ALg8bN4of1e3WRXE0OvxUYJjIvB0Cn5VrrL4vyNPicrqk2W7wniyVZezl2uQlMKtrlfdAYKYfI3Gww==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr21479150lfj.126.1548196928278;
        Tue, 22 Jan 2019 14:42:08 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q3sm191298lff.42.2019.01.22.14.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 14:42:07 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id l10so128069lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:42:06 -0800 (PST)
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr21829996lfc.27.1548196926275;
 Tue, 22 Jan 2019 14:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-7-evgreen@chromium.org>
 <154785081323.169631.13477061319849880987@swboyd.mtv.corp.google.com>
In-Reply-To: <154785081323.169631.13477061319849880987@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 14:41:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft4An9V8C-K-p8FtEpk5G6JsMvOAxGBHrgR_XuagGeMnXg@mail.gmail.com>
Message-ID: <CAE=gft4An9V8C-K-p8FtEpk5G6JsMvOAxGBHrgR_XuagGeMnXg@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] phy: qcom-qmp: Utilize UFS reset controller
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-11 15:01:27)
> > @@ -1214,6 +1225,32 @@ static int qcom_qmp_phy_init(struct phy *phy)
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
> > +                       qmp->ufs_reset = of_reset_control_get(qmp->dev->of_node,
>
> Can you use devm_reset_control_get()? Put another way, why is this DT
> specific instead of using a firmware/platform agnostic API?

Sure, will fix. (Though sadly of_* is peppered all over the place in
this file for lane resets, pipe clocks, and more).

>
> > +                                                             "ufsphy");
> > +
> > +                       if (IS_ERR(qmp->ufs_reset)) {
> > +                               dev_err(qmp->dev,
> > +                                       "failed to get UFS reset: %d\n",
> > +                                       PTR_ERR(qmp->ufs_reset));
> > +
> > +                               return PTR_ERR(qmp->ufs_reset);
> > +                       }
> > +               }
> > +
> > +               ret = reset_control_assert(qmp->ufs_reset);
> > +               if (ret) {
> > +                       dev_err(qmp->dev, "ufsphy reset deassert failed\n");
>
> It's an assert though. Maybe just ignore the error message because the
> user won't be able to do anything anyway?
>

Fair enough. I'll remove the print from here and the deassert later.
-Evan
