Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69F2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as3DDm8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfBSVYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:24:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40470 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfBSVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:24:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so4216030wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjQnR7W4bi473rcLkgASnoHLlD2X3fmlSX69EZkK6ms=;
        b=as3DDm8OzAE593jT40zyiS7qhgd3zsuiV53NXhwpQuWdJbnBIqLYDVBmUxTYd7KsIW
         N7GODrTeT86sakk8+V09WKQ9bBdw31t8hiDkWUpfse1G6wRs5UhhRAmvJ8dJ26ZLAOsU
         tpLUh8xR7XzG+uqa0eAI12cmmwoaXp7F8m3aOnsgjMvQUzqo/sFD5DOGMdzG5dvL0TYK
         rRfOimarBAdBkTZSjGRquQs+M1SUheIFDnf3HWeBMYbnPiAQiZd2Ok9ReAg8r2RIb0VM
         FPRjNtE/33vMFPiWrGrcR75Wdfc2FmgKTMX9f3T2SJIyKx3YXMDKfIhMkS2znfTDTyNz
         BocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjQnR7W4bi473rcLkgASnoHLlD2X3fmlSX69EZkK6ms=;
        b=P1X3xjbpYlQaTpK3r6/pYGu84DZsCM/3b5r2oizlI8OUFEAc9Trfl6AzDaHdpQM3tC
         dVECmEOfxg3ud3p3cMe/g8QMQ8ByWjKfHsmc/VJR4K0jAWO3Zys4H0B/0ChbxOy0iB9S
         Zao5maXbtt8Zn6Pu+GeNdTwh9igOgfr42IQj3PcMLTgOARAPZngZLyIpzEWrPP2aZxe0
         FK0EXEOyP6htnJL7GwmtrQKTMr366edG//KTNNw6aGCaWGLYIXDwzmHaI4An28wC7KDE
         gcNE3av+ML91xxBFrUFmYD5lXjKXJny5xphs8eOKN4aMo2aijbgg8oW6XyP6W1WbArYk
         GiKA==
X-Gm-Message-State: AHQUAuZ0h/BLLstmqSejCVKH7PsPI2hqOzCq0fYIK3XtBPxegvo8qjvs
        OidGo0S7ho/LevJdXrBx1pNe9XpL
X-Google-Smtp-Source: AHgI3IZFZ+l49hhIDLGKsddOJgLLiybM604xwakzhXTyEYPj70XrrKtbHmj41EMRqa/G4NYnTtLilQ==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr4336212wmc.8.1550611489062;
        Tue, 19 Feb 2019 13:24:49 -0800 (PST)
Received: from localhost.localdomain ([46.216.153.243])
        by smtp.gmail.com with ESMTPSA id c129sm4035151wma.48.2019.02.19.13.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 13:24:47 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwCsf-00053X-8z; Wed, 20 Feb 2019 00:24:45 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and external charger tweaks
Date:   Wed, 20 Feb 2019 00:24:39 +0300
Message-Id: <20190219212441.19391-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At implementation of charging support for Lenovo Yoga Book (Intel Cherry Trail
based with Whiskey Cove PMIC), two pitfalls were found:

- for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
  should be set in 0 (and set to 1 for Host mode). Pick up its definition
  and logic from from Intel code drop[1];

- "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
  connected to one of PMIC outputs controlled by CHGDISCTRL register.
  Enable charging at driver initialization. Pick up this from Lenovo's code
  drop[2,3].

v2 changes:
- Disable HW control mode of CHGDISCTRL at driver probing and restore
  initial state at exit.
- Switch CE output off if OTG host mode is enabled.
- Save and restore CHGRCTRL0 register also.

[1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
[2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
[3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch

Yauhen Kharuzhy (2):
  extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
  extcon intel-cht-wc: Enable external charger

 drivers/extcon/extcon-intel-cht-wc.c | 129 ++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

-- 
2.20.1

