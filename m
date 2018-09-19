Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A4EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26452150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="n8sG0Bzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26452150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeISUsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:48:01 -0400
Received: from onstation.org ([52.200.56.107]:45512 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbeISUsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:48:01 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6B8FA62E;
        Wed, 19 Sep 2018 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1537369778;
        bh=oS9VTfRzGWLeL3pBtVnMIUAgBk6e/XtvREr6+rMKZiI=;
        h=From:To:Cc:Subject:Date:From;
        b=n8sG0Bzo3n9RMupfq6ebxyS0PB7ayYE/jNbi6mh11WbBPUUK93i11go8yctLtDzj5
         LhBP4eW7RlH0HqZHJQkouL6jP7cVo+4OzuTKBaJa2yGWoovIMPl7VmV0V0c25JD7RM
         a6RemMhy49woiJ24PfAtcOK4OvBiMkUSB+nub9BM=
From:   Brian Masney <masneyb@onstation.org>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sebastian.reichel@collabora.co.uk, masneyb@onstation.org
Subject: [PATCH 0/3] treewide: add vibrator support for various MSM SOCs
Date:   Wed, 19 Sep 2018 11:09:09 -0400
Message-Id: <20180919150912.8948-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the vibrator found on various Qualcomm
MSM SOCs. The driver was tested on a LG Nexus 5 (hammerhead) phone. This
is based on work from:

Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd060f8b52087a68ab93583292b5

Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
Android 3.4.0 sources:
https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-lollipop-wear-release/drivers/misc/msm_pwm_vibrator.c

Driver was tested using rumble-test from:
https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

Brian Masney (3):
  dt-bindings: pwm: msm-vibrator: new bindings for MSM vibrator driver
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

