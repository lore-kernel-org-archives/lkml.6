Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D54EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485FC222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOwCW/ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbfBMX0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40534 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbfBMX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so1952052pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pElnodFdKG+v6XH9vX+eTEemSmnJPk/UTDU6j7fos9g=;
        b=kOwCW/aemgmD/ezHrbKIb/LlrSYO9kXLlGwCM5+3ql/JmBxcMhgveh5C4fa5QQEsEV
         Qbt/ALkbQzJXfvTL2SuC9JGlP7N9x4gTcz56cmux17VktubV3Ub/XQP7a8swv/fOoE4R
         ME4ChKKcY0CjeCES1xwj2HwEAuElyuNXzkhLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pElnodFdKG+v6XH9vX+eTEemSmnJPk/UTDU6j7fos9g=;
        b=KqDNJheN0j16hMVZ6viodb8B7Eov8o4/JvIvR0XQH0kHnflakhvaD7Id2Gbx02UKn8
         Xu4mL+K1SQvcm2Y+Ig3ZRqY6TmFJnyj4C4aCIOaEOa0D7tj4dJgw9e8NNKolB8vYmHrA
         N61gRqAuyZhpbnZZ5w6M43bum4mW4UDGlcsTLgVuKKJhxPmXRHfniv2F2QAuCr3rL4R0
         qDGxVr1FFrkFCkoMVwxw72Lg0QO0MqfL++JWE+CAEPtGJJs8Tg0p4VIlKllVRe9qoPr2
         AVYlQXSRI+H7IreZwMOCYR7q6Y6g5+Cr93un7XSGiy1dfopNRopPZQ6td+VyaIQKGsAv
         RCwA==
X-Gm-Message-State: AHQUAubcVqDddump0rfQuKmKdwtKheTXk6+I4MTyNqdtQOyXr+HKN8xb
        KeDN+1zq8jjdnvSAx1qQfy+SIQ==
X-Google-Smtp-Source: AHgI3IYbQHQOdjUzn3fTwUmmeh6cwPPL48mZszwibbtlTI7T8tgNKIar2B1DK13Al6blezIX0QNhLQ==
X-Received: by 2002:aa7:8c8c:: with SMTP id p12mr802429pfd.0.1550100373120;
        Wed, 13 Feb 2019 15:26:13 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:12 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-scsi@vger.kernel.org, David Brown <david.brown@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        devicetree@vger.kernel.org, liwei <liwei213@huawei.com>,
        linux-arm-msm@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v4 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
Date:   Wed, 13 Feb 2019 15:25:18 -0800
Message-Id: <20190213232526.26995-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal with this series is to enable shutting off regulators that power
UFS during system suspend.

In "the good life" version of this, we'd just disable the regulators
in phy_poweroff() and be done with it. Unfortunately, that's not symmetric,
as regulators are not enabled during phy_poweron(). Ok, so you might think
we could just move the regulator enable and anything else that needs to
come along into phy_poweron(), so that we can then undo it all in
phy_poweroff(). That's where things get tricky.

The qcom-qmp-phy overloaded the phy_init() and phy_poweron() callbacks,
basically to mean "init phase 1" and "init phase 2". There are two phases
because they have this phy_reset bit outside of the phy (in the UFS
controller registers), and they need to make sure this bit is toggled at
specific points in the phy init sequence. So there's this implicit
sequence in the init dance between ufs-qcom.c and phy-qcom-qmp.c:
1) ufs-qcom asserts the PHY reset bit.
2) phy-qcom-qmp phy_init() does most of its initialization, but exits early.
3) ufs-qcom deasserts the PHY reset bit.
4) phy-qcom-qmp phy_poweron() finishes its initialization.

This init dance is very difficult to follow in the code (since it's split
between two drivers and not spelled out well), and arguably represents a
deficiency in the hardware description of these devices.

In this series I'm proposing tweaking the bindings for the Qualcomm
UFS controller and PHY. In it we expose a reset controller from the
UFS controller, that is then picked up and used from the PHY code.
With this, the phy code can be reorganized to complete its initialization
in a single function, removing the implicit two-phase overloading.

Then I can move most of the phy initialization, including enabling
the regulators, into phy_poweron(). Now, when phy_poweroff() is called,
the phy actually powers off. This finally disables the regulators
and allows me to save power in system suspend.

Because the UFS PHY reset bit is now toggled in the PHY, rather
than in ufs-qcom, this also percolated to all other PHYs using
ufs-qcom, which from what I can see is just 8996.

I removed the calls to phy_poweroff() during clock gating. This
was originally dialing down a clock or two, while leaving the phy powered.
I've now changed the semantics of phy_poweroff() to, well, actually power off.
This works great for userlands that have set UFS's spm_lvl to 5 (off) like
I have, but maybe changes power consumption for devices that have spm_lvl
set to 3. I could try to use phy_init() and phy_poweron() as the two
different possible transitions (fully off, and clocks off respectively),
but I'm not sure if it actually matters, and I like the idea that
phy_poweroff() really does power the thing off.

Also, I don't have an 8996 device to test. If someone is able to test this
out and perhaps point out any (hopefully obvious) bugs in the 8996 portion,
I'd be grateful.

This patch is based atop phy-next, plus the UFS DT nodes, which are now
patch 3, 4, 5 of [1].

[1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/

Changes in v4:
- Do reset_control_* unconditionally since null is handled (Stephen).
- Keep doing reset_control* unconditionally through refactor (Stephen).

Changes in v3:
- Refactor to only expose the reset controller in one change (Stephen).
- Add period to comment (Stephen).
- Reset err to 0 in ignored error case (Stephen).
- Add include of reset-controller.h (Stephen)
- Refactored to move reset control in a single commit (Stephen)
- Use no_pcs_sw_reset as an indicator of UFS reset in qmp-phy (Stephen).
- Assign ret = PTR_ERR() earlier, for better reuse (Stephen).
- Refactor init => poweron for all PHYs and UFS in one step (Stephen)

Changes in v2:
- Added resets to example (Stephen).
- Remove include of reset.h (Stephen)
- Fix error print of phy_power_on (Stephen)
- Comment for reset controller warnings on id != 0 (Stephen)
- Add static to ufs_qcom_reset_ops (Stephen).
- Use devm_* to get the reset (Stephen)
- Clear ufs_reset on error getting it
- Remove needless error print (Stephen)
- Use devm_ to get the reset (Stephen)
- Removed whitespace changes (Stephen)

Evan Green (8):
  dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
  dt-bindings: phy-qcom-qmp: Add UFS PHY reset
  dt-bindings: phy: qcom-ufs: Add resets property
  arm64: dts: sdm845: Add UFS PHY reset
  arm64: dts: msm8996: Add UFS PHY reset controller
  scsi: ufs: qcom: Expose the reset controller for PHY
  phy: qcom: Utilize UFS reset controller
  phy: ufs-qcom: Refactor all init steps into phy_poweron

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   6 +-
 .../devicetree/bindings/ufs/ufs-qcom.txt      |   5 +-
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |   3 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 112 +++++++++--------
 drivers/phy/qualcomm/phy-qcom-ufs-i.h         |   5 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c  |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c  |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs.c           |  57 ++++++---
 drivers/scsi/ufs/Kconfig                      |   1 +
 drivers/scsi/ufs/ufs-qcom.c                   | 114 +++++++++++-------
 drivers/scsi/ufs/ufs-qcom.h                   |   4 +
 13 files changed, 193 insertions(+), 171 deletions(-)

-- 
2.20.1

