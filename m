Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35F5217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZx2foau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBESAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:00:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfBESAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:00:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so3644726lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF0fBb4b0gGeqw5Pum9BEghVkBH1EpKo8dGQBjyIKKE=;
        b=OZx2foauO1KqgioQVd5yHQmV6Iirn/lW6MQK6Z8VBrH8uH8PEk3bDUjxZ0gLhP8L1V
         qMLUDUEDJFB7USm4lnEFEM8F9LFsDWPvweMPqRtukuaS8v1euLsw2fwPTwmyByiv6YUS
         1z7OIgQYSilEkIOZHSVw39EjjNSDzmH52D3LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF0fBb4b0gGeqw5Pum9BEghVkBH1EpKo8dGQBjyIKKE=;
        b=XhTlcJ3tjxuHuqH/z1LrhUiS4YBFVtCUVcI73j4ysLcjo0AJj5EaGvhpjGOMiKd/F1
         Z5d0mBr+evhibhVOCMPwYj0wWoa9BczkQ7yu7tt2YFus9eFc9wOEWzMSxBj1TBux4U4N
         CPcS7bJYQLupnaRF+CdKacmYx1lHX3W/Kk8YQJTdGKmLTcw5mCie3e+i8yPR0eKMfhKh
         6rChRALRW5zbOavV/BVUQMgKd1s8x6S3TOl5vOU9F4hlV3UOZaUjCiTSl7FCN10dZDjR
         W7NHurm8kMuwnW+MMivcA29r3ONAMRp+w6ErsnfqDGDCRTLksAiOKD7lwVbugSbkM9Gj
         8odQ==
X-Gm-Message-State: AHQUAubeJaSicnY7is2WQ4HqHMIreSbPmnrVjwEmsWW0HsZ1BL+ki+PQ
        Ec8ga5/UjCCsoz1CFpnWsowHalPjtYQ=
X-Google-Smtp-Source: AHgI3IZKjCmuuN/rKIGM9SoGTL1oL3twoUR8X6VEuEpQyp9KSUDDx5si5g5pM8bHN/iRIJZYEFSCFg==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr3619390ljc.66.1549389631331;
        Tue, 05 Feb 2019 10:00:31 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q3sm3839654lff.42.2019.02.05.10.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 10:00:30 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id k19-v6so3639413lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:00:29 -0800 (PST)
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr3984779ljg.64.1549389629312;
 Tue, 05 Feb 2019 10:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-7-evgreen@chromium.org>
 <154904378780.169292.8490930189606724579@swboyd.mtv.corp.google.com>
In-Reply-To: <154904378780.169292.8490930189606724579@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Feb 2019 09:59:52 -0800
X-Gmail-Original-Message-ID: <CAE=gft5HKEGyGyFm2f+DY61xVn5dZyF4TMydMOCX4hi-QTiD8Q@mail.gmail.com>
Message-ID: <CAE=gft5HKEGyGyFm2f+DY61xVn5dZyF4TMydMOCX4hi-QTiD8Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] scsi: ufs: qcom: Expose the reset controller for PHY
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 9:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-23 14:11:34)
> > Expose a reset controller that the phy can use to perform its
> > initialization in a single callback.
> >
> > Also, change the use of the phy functions from ufs-qcom such that
> > phy_poweron actually fires up the phy, and phy_poweroff actually
> > powers it down.
>
> This looks like two patches. One introduces a reset controller and the
> other changes the phy functions somehow. Can this be split up and then
> the commit text for the second half to change the phy functions can
> explain a little more of the theory behind how it's OK to change the
> code flow that way?

Sure, I can split the change in two.

>
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> > Note: This change depends on the remaining changes in this series,
> > since UFS PHY reset now needs to be done by the PHY driver.
>
> What does it depend on? Is there a bisection hole introduced here? An by
> bisection hole I mean more than the problem that an older DT is used
> with this new code.

Everything still builds, but there is a functional bisection hole here
in that UFS won't come up if you have this change but not the
following changes. The problem is that this change removes the reset
assert/deassert from ufs-qcom, and it's not until the next change that
the PHY is taught to use the reset controller to do those required
resets. Technically it's "phy: qcom-qmp: Utilize UFS reset controller"
that does the needed reset assert/deassert for qmp-phy, and "phy:
qcom-ufs: Refactor all init steps into phy_poweron" for the older
phy-qcom-ufs.

I was trying to keep changes in different components separate. Let me
refactor it into a way that makes more sense from a functional
perspective. The downside is that a couple of changes will touch three
drivers (both PHYs and the UFS controller) in a single change. But the
upside is that it's probably easier to review, and there will be no
bisection hole.

>
> >
> > Changes in v2:
> > - Remove include of reset.h (Stephen)
>
> Usually we include headers in both the C file and the header files that
> use structs from header files. It wouldn't hurt to include
> reset-controller.h in the ufs-qcom.c file. For one thing, it would help
> a grep find reset controller drivers trim based on files ending in .c
> instead of having to figure out which C file includes the .h file where
> the reset-controller header is included.

Sure, will do.

>
> > - Fix error print of phy_power_on (Stephen)
> > - Comment for reset controller warnings on id != 0 (Stephen)
> > - Add static to ufs_qcom_reset_ops (Stephen).
> >
> >  drivers/scsi/ufs/Kconfig    |   1 +
> >  drivers/scsi/ufs/ufs-qcom.c | 111 ++++++++++++++++++++++--------------
> >  drivers/scsi/ufs/ufs-qcom.h |   4 ++
> >  3 files changed, 72 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 3aeadb14aae1e..277ed6ad71c9b 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -255,11 +260,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >         if (is_rate_B)
> >                 phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> >
> > -       /* Assert PHY reset and apply PHY calibration values */
> > -       ufs_qcom_assert_reset(hba);
> > -       /* provide 1ms delay to let the reset pulse propagate */
> > -       usleep_range(1000, 1100);
> > -
> >         /* phy initialization - calibrate the phy */
> >         ret = phy_init(phy);
> >         if (ret) {
> > @@ -268,15 +268,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >                 goto out;
> >         }
> >
> > -       /* De-assert PHY reset and start serdes */
> > -       ufs_qcom_deassert_reset(hba);
> > -
> > -       /*
> > -        * after reset deassertion, phy will need all ref clocks,
> > -        * voltage, current to settle down before starting serdes.
> > -        */
> > -       usleep_range(1000, 1100);
> > -
> >         /* power on phy - start serdes and phy's power and clocks */
> >         ret = phy_power_on(phy);
> >         if (ret) {
> > @@ -290,7 +281,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >         return 0;
> >
> >  out_disable_phy:
> > -       ufs_qcom_assert_reset(hba);
> >         phy_exit(phy);
> >  out:
> >         return ret;
> > @@ -554,21 +544,10 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> >                 ufs_qcom_disable_lane_clks(host);
> >                 phy_power_off(phy);
> >
> > -               /* Assert PHY soft reset */
> > -               ufs_qcom_assert_reset(hba);
> > -               goto out;
> > -       }
> > -
> > -       /*
> > -        * If UniPro link is not active, PHY ref_clk, main PHY analog power
> > -        * rail and low noise analog power rail for PLL can be switched off.
> > -        */
> > -       if (!ufs_qcom_is_link_active(hba)) {
> > +       } else if (!ufs_qcom_is_link_active(hba)) {
> >                 ufs_qcom_disable_lane_clks(host);
> > -               phy_power_off(phy);
> >         }
> >
> > -out:
> >         return ret;
> >  }
> >
> > @@ -578,21 +557,26 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> >         struct phy *phy = host->generic_phy;
> >         int err;
> >
> > -       err = phy_power_on(phy);
> > -       if (err) {
> > -               dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
> > -                       __func__, err);
> > -               goto out;
> > -       }
> > +       if (ufs_qcom_is_link_off(hba)) {
> > +               err = phy_power_on(phy);
> > +               if (err) {
> > +                       dev_err(hba->dev, "%s: failed PHY power on: %d\n",
> > +                               __func__, err);
> > +                       return err;
> > +               }
> >
> > -       err = ufs_qcom_enable_lane_clks(host);
> > -       if (err)
> > -               goto out;
> > +               err = ufs_qcom_enable_lane_clks(host);
> > +               if (err)
> > +                       return err;
> >
> > -       hba->is_sys_suspended = false;
> > +       } else if (!ufs_qcom_is_link_active(hba)) {
> > +               err = ufs_qcom_enable_lane_clks(host);
> > +               if (err)
> > +                       return err;
> > +       }
> >
> > -out:
> > -       return err;
> > +       hba->is_sys_suspended = false;
> > +       return 0;
> >  }
> >
> >  struct ufs_qcom_dev_params {
> > @@ -1118,8 +1102,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >                 return 0;
> >
> >         if (on && (status == POST_CHANGE)) {
> > -               phy_power_on(host->generic_phy);
> > -
> >                 /* enable the device ref clock for HS mode*/
> >                 if (ufshcd_is_hs_mode(&hba->pwr_info))
> >                         ufs_qcom_dev_ref_clk_ctrl(host, true);
> > @@ -1131,9 +1113,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >                 if (!ufs_qcom_is_link_active(hba)) {
> >                         /* disable device ref_clk */
> >                         ufs_qcom_dev_ref_clk_ctrl(host, false);
> > -
> > -                       /* powering off PHY during aggressive clk gating */
> > -                       phy_power_off(host->generic_phy);
> >                 }
> >
> >                 vote = host->bus_vote.min_bw_vote;
>
> All the above hunks should probably be another patch with a motivation
> and explanation about what's going on in the commit text.

Ok.

>
> > @@ -1147,6 +1126,41 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >         return err;
> >  }
> >
> > +static int
> > +ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +       struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> > +
> > +       /* Currently this code only knows about a single reset. */
>
> Ultra nitpick: Drop the full stop to be consistent with single line
> comment style in this function?

Ok. Maybe I'll add the period to the other comment in this function,
so that the two functions are consistent with each other.

>
> > +       WARN_ON(id);
> > +       ufs_qcom_assert_reset(host->hba);
> > +       /* provide 1ms delay to let the reset pulse propagate */
> > +       usleep_range(1000, 1100);
> > +       return 0;
> > +}
> > +
> > +static int
> > +ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +       struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> > +
> > +       /* Currently this code only knows about a single reset. */
>
> Well now it's different!

Not anymore!

>
> > +       WARN_ON(id);
> > +       ufs_qcom_deassert_reset(host->hba);
> > +
> > +       /*
> > +        * after reset deassertion, phy will need all ref clocks,
> > +        * voltage, current to settle down before starting serdes.
> > +        */
> > +       usleep_range(1000, 1100);
> > +       return 0;
> > +}
> > +
> > +const static struct reset_control_ops ufs_qcom_reset_ops = {
>
> const goes after static. Funny, there are some other grep hits for
> 'const static' in the kernel, but it's a small minority. Maybe those
> should be fixed.

Ok. Apparently there are historical reasons why nearly all compilers
accept any order of these two classes of keywords. Which means I never
remember what the right way is :)

>
> > +       .assert = ufs_qcom_reset_assert,
> > +       .deassert = ufs_qcom_reset_deassert,
> > +};
> > +
> >  #define        ANDROID_BOOT_DEV_MAX    30
> >  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> >
>
> Ooh Android!
>
> > @@ -1191,6 +1205,15 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >         host->hba = hba;
> >         ufshcd_set_variant(hba, host);
> >
> > +       /* Fire up the reset controller. Failure here is non-fatal. */
> > +       host->rcdev.of_node = dev->of_node;
> > +       host->rcdev.ops = &ufs_qcom_reset_ops;
> > +       host->rcdev.owner = dev->driver->owner;
> > +       host->rcdev.nr_resets = 1;
> > +       err = devm_reset_controller_register(dev, &host->rcdev);
> > +       if (err)
> > +               dev_warn(dev, "Failed to register reset controller\n");
>
> reset err to 0 because we don't care to fail here (it's just a warn, not
> a dev_err)?

Sure.

>
> > +
> >         /*
> >          * voting/devoting device ref_clk source is time consuming hence
> >          * skip devoting it during aggressive clock gating. This clock
