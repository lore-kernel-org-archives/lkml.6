Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE81C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7B217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETb0R6Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBESBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:01:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38013 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBESBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:01:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so3688391lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3m9mi7KxG4u1pidpRW7R+cktKHyFe50Fs+mrKjaH30=;
        b=ETb0R6AlXOPSHKEk6hO/hnh1yVGkF9z+s3aQX/p8ciY+9udWoFeBrVmJmKBIZ5OlTg
         KE8u86xV2irwEt+Fhq6RHmGdT00Mb3zYVyyNv40134BJ11HcZoHQFoBXr1HL1tSxuXjv
         dDU1qg009ks6QfQVQ8zVwwXLGjO96hnr+T7mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3m9mi7KxG4u1pidpRW7R+cktKHyFe50Fs+mrKjaH30=;
        b=naOejJwLIz7TuXO/mvTBXAknOekU9K/9BYPkPROtZjH9rKwZtZJZrmONtJl+m/4r+X
         pxsgTiCDCIDs1NyBWM8/OlP/r5p6VyUaqXuwGOIUGjwEAwSzfk2p4kgi1YRPge3lTx/m
         EdLkS0tGb0w8Ry3Dv8cdPj8pNrzCcuaaj3NcEQXf0nBD+mh9FFbvbu3nmQLBqWIjLpMw
         35oSKey/YwaByfbVrE8+Nb7SFxbsnAKCjBl6pbQx+RCGS3ZSX7L7ZjebYk3O9yv4Mp5q
         2WrtixrCDWp/NJ3pvXeGNUZyVd7I1yTYJEEDRwuJbBvs3WEGeHmy9J52m0HopvayPS2w
         M+zw==
X-Gm-Message-State: AHQUAuY3zckADyEKIFStBxTUxKIUcjtlFSEHC2bI9KuPrN7uQFNlq4kD
        bD00GA7qfslA/3qEzYouH8Ht9Xwv+qs=
X-Google-Smtp-Source: AHgI3Ib/qfXFbeLbo0DkbTMC6G6Q0OWFTY6NhMxFUWwyNInn2u2RTDoMtz0cwT5+GmgvG1sRfWc9Og==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr3589696ljb.177.1549389664653;
        Tue, 05 Feb 2019 10:01:04 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s9-v6sm3349052lja.12.2019.02.05.10.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 10:01:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 132-v6so1104463ljf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:01:03 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr3788418lji.60.1549389662824;
 Tue, 05 Feb 2019 10:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-10-evgreen@chromium.org>
 <154904662124.169292.12336150037537548096@swboyd.mtv.corp.google.com>
In-Reply-To: <154904662124.169292.12336150037537548096@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Feb 2019 10:00:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft7-G1vSNGjvA9OhSyQefjWJFmHiP0uxJK1qMZ8K8Bk5mw@mail.gmail.com>
Message-ID: <CAE=gft7-G1vSNGjvA9OhSyQefjWJFmHiP0uxJK1qMZ8K8Bk5mw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] phy: qcom-ufs: Refactor all init steps into phy_poweron
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
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 10:43 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-23 14:11:37)
> > The phy code was using implicit sequencing between the PHY driver
> > and the UFS driver to implement certain hardware requirements.
> > Specifically, the PHY reset register in the UFS controller needs
> > to be deasserted before serdes start occurs in the PHY.
> >
> > Before this change, the code was doing this by utilizing the two
> > phy callbacks, phy_init and phy_poweron, as "init step 1" and
>
> Nitpick: Can you please indicate functions with () and variables with
> ''? So write phy_init() and phy_poweron(), etc.

Sure.

>
> > "init step 2", where the UFS driver would deassert reset between
> > these two steps.
> >
> > This makes it challenging to power off the regulators in suspend,
> > as regulators are initialized in init, not in poweron, but only
> > poweroff is called during suspend, not exit.
> >
> > Consolidate the initialization code into phy_poweron, and utilize
> > the reset controller exported from the UFS driver to explicitly
> > perform all the steps needed to initialize the PHY.
>
> Also mention that a new callback is introduced, 'calibrate', that
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > index f798fb64de94e..109ddd67be829 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
>
> Just forward declare struct reset_control instead of including this.

It looks like convention in this driver is to include everything in
this header, phy-qcom-ufs.c includes nothing but this file, and
similarly for the 14nm and 20nm variants. So maybe I should stay
following suit rather than being that one dude who plops his include
in a different spot.

>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > @@ -96,11 +97,10 @@ struct ufs_qcom_phy {
> >         char name[UFS_QCOM_PHY_NAME_LEN];
> >         struct ufs_qcom_phy_calibration *cached_regs;
> >         int cached_regs_table_size;
> > -       bool is_powered_on;
> > -       bool is_started;
> >         struct ufs_qcom_phy_specific_ops *phy_spec_ops;
> >
> >         enum phy_mode mode;
> > +       struct reset_control *ufs_reset;
> >  };
> >
> >  /**
>
> For some reason I get the feeling that this patch should be combined
> with something else from the controller. Does this complete the
> conversion but the patches before this one sort of wreck the state of
> reset and init/poweron phases so that they can't stand on their own?
> Maybe if the reset was introduced, and then a patch to get the resets
> was put in place, and then a final patch to rewrite the phy and
> controller at the same time would make more sense to read.

Yeah, let me try this refactoring.
