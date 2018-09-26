Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9863620676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="F+cGQ2Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9863620676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeI0GGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:06:39 -0400
Received: from onstation.org ([52.200.56.107]:46876 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeI0GGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:06:39 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 61E861020;
        Wed, 26 Sep 2018 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538005874;
        bh=u94u44HD64MaAnIIEtVVArmSrt6ysWYhzd5HSpmwiHE=;
        h=From:To:Cc:Subject:Date:From;
        b=F+cGQ2BcwTq2MajL9+2lgm3tCKnxf/mH0EbRZ+jr99ZJ7rmzLIYRrmm2mnto3wzx9
         +Rj0LF3hwGUt96lB7O4R7NLFY28Pg/r4dYuMXbWVsrZ4zMSA6L3wb3uJlzS4so050e
         Nrgziq1aSQ7K0USRERvD+SBXxLnlfB1EH652DzMI=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     masneyb@onstation.org, jonathan@marek.ca, ctatlor97@gmail.com
Subject: [PATCH v2 0/3] treewide: add vibrator support for various MSM SOCs
Date:   Wed, 26 Sep 2018 19:51:09 -0400
Message-Id: <20180926235112.25710-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the vibrator found on various Qualcomm
MSM SOCs. This is based on work from:

Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd060f8b52087a68ab93583292b5

Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
Android 3.4.0 sources:
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c

Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

Changes since v1
- Update device tree binding document based on feedback from Rob
  Herring.
- Changed the driver description to: Qualcomm PWM driver for the MSM
  vibrator.

Brian Masney (3):
  dt-bindings: pwm: msm-vibrator: new bindings for MSM vibrator PWM
  pwm: msm-vibrator: new driver for the vibrator found on various MSM
    SOCs
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    vibrator

 .../bindings/pwm/pwm-msm-vibrator.txt         |  38 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  39 +++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-msm-vibrator.c                | 227 ++++++++++++++++++
 5 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-msm-vibrator.txt
 create mode 100644 drivers/pwm/pwm-msm-vibrator.c

-- 
2.17.1

