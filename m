Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621A5206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621A5206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIMOrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:47:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeIMOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:47:36 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbies-1fPh1P0WT8-00dByY; Thu, 13 Sep 2018 11:38:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: add EXTCON dependency for qcom
Date:   Thu, 13 Sep 2018 11:37:31 +0200
Message-Id: <20180913093843.884284-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:FH5Xl0G0I6KYvWVGe8HJ305OPqLUtHLvR7RlKAjO/9qNREHqkbQ
 waMVfBCTgLwipChcPH6co8mVO11gJJrG5dxvOLZI9v0+uRFHmiK5lsv6kYqXNGEgWWPsuFf
 x9nYS8S/iTT1ZcGEkVvYN9hITzQ4+6i9bFLTE1hKZg6wWOpo7rlCwIQMyyanD18pDxwZ9AM
 +rLolx8yhIPx+JRxAhDaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WOin64x8hLY=:8Zm5hVylzWQ+ys7zcCvz42
 WPAn4iQ2UIElCalykTmPwN+pC0wq7xteINuWeR/ZlytnA6J4JfjNk4puu9Gd+Q8NUmZuI/jX4
 9R5+jghpOUmwgAvhJZzh2lGmbfL3NAKp2XEFE2kATQapoREhMLm0wcnU0fStpeRp+b3eUZ+UI
 9icM0AvBR6qI5Bj/RJsnGBo7h/nOucqEoJGl0jSbB2K4IgAE/kveHR6lolusZdfkBuUna0tPy
 zO0FaNgBtKlqirbssP6EmSDF9eqkP2Lsw32dG0Qq4IbxaGOf3almC8EXRqv8D3lGK9c5Q+7mA
 PqkjQ5xPk1WIOpBi57wvoaDSCUYiyfwPXjaKjDcM2Ws4rnjk5eO0hIL6PdXkIQ3fDoGCuOcJT
 DAnjO91fizvIgfc0xaZr1O0fl3EZj/lEs31XgyBOl2dD9b454aYXpPzbi3ImRBmliNXDil2LL
 B7XCkymkfppGsaDCDzW5eWbLP7Fim2bLLdxe0PcKA2dlK6KGogdh3b9amR0GquE9nVsR2OPTy
 hkLwO8rJOKlsTTHfkgVX/YV11BGJVemUIeSiYyixWOH/C9gztN/RFzesm5mkS96SJv6q1MHC6
 xzwT89j7A57cLzyp28n4+sajjSH329U98rNHOtVP2h5SNZyUznDfA49fG/xN50WRuG+7Ez2kR
 feMEiv/ltNnasQXvjkQqiNhRu5DIIsVrhhy/LtXEfO/xeDKMHkibtTRoB67MVBIEjCew=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the omap back-end, we get a link error with CONFIG_EXTCON=m
when building the qcom back-end into the kernel:

drivers/usb/dwc3/dwc3-qcom.o: In function `dwc3_qcom_probe':
dwc3-qcom.c:(.text+0x13dc): undefined reference to `extcon_get_edev_by_phandle'
dwc3-qcom.c:(.text+0x1b18): undefined reference to `devm_extcon_register_notifier'
dwc3-qcom.c:(.text+0x1b9c): undefined reference to `extcon_get_state'

Do the same thing as OMAP and add an explicit dependency on
EXTCON.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 518ead12458d..1a0404fda596 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -113,7 +113,7 @@ config USB_DWC3_ST
 
 config USB_DWC3_QCOM
 	tristate "Qualcomm Platform"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON && (ARCH_QCOM || COMPILE_TEST)
 	depends on OF
 	default USB_DWC3
 	help
-- 
2.18.0

