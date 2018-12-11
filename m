Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA29C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BACC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BACC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLKKHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:07:04 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:07:03 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8GAQ-1hadeC0Z9s-014A9f; Tue, 11 Dec 2018 11:06:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: mark PM functions as __maybe_unused
Date:   Tue, 11 Dec 2018 11:06:25 +0100
Message-Id: <20181211100645.650975-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vbe4JORRczYACtMLZonY6MMYnWxsKK66PVNaQtM1+V516jMzpjS
 wvVoNaKXH8JApCYiVE8Bd4ogv2yyM71uaGxnczxSbkcHQz2oGkpBxNQrqVxAvjeqFGI0MMy
 wOC2TVtK+r2C3bCcQjbzIDH8kCScuQJE3sw2YGA21DH77+aKtNYooA9UgE9OBVlXEcwz6EZ
 qv75KNK8vH4iQVybZZXbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JtnZJLwW2rw=:TBRP0Lv4qqPkQBuEm5oVQ0
 zllSqVS7S2s9qk1Vaelmr3+mNcKAenLxZz88HfoFk/ppZy/xW8vBBPHTFGEb77W9rYHtLa54W
 JgBCup+ZbKx+v+/nitPTtI2z2ytt08ePVxgpYuzzWtHquXR9EYDPwwesd0dvgedumviArub5t
 bpLBySuZ+6nslHOJAk/h3ots+57im9lyjhgmgEhuYHuiu2qRbM2oql33UHt5NtYJZ+rArlIvC
 8Gea5Mydmsgwi30tYmKlTG08kedGxAQA4gZLMHtJlV2XRRIuEXz8sY8rAW9rYxF1DEHt4NZen
 sf6ASUj09+KcRD8hYdHWVidtR8YlRdeHYb7+FesmVjo1TuINGDihytDdLhbQ5TyrW6MQgbE4Z
 dJWQdeMgtzoR4oUppK57ojkR9eRt1g3dilRHqJLJICehLoSPti5XyVlJ0x4FrUlJ1uz4CE2Op
 ggqBSzjX92rnAC8DkQU7kQzeTj6OxwdlvxFN/+dD5OUyOtqZrHbZGUL2nT71UxQKZIV1yusE8
 WxxHKot5eqwVecYmkBY7NTmA4c19DA/7cQpygrcJ6qqMd2FtCwKTyHBnGr61oSr69vudvvH/q
 b2PmGF+qxSXcMjBsMUi2UF6fQ8sbiAHwRN0HRRCGxjmH7I6Re+Vyl+tcGKRm6vtp9PPxWvelD
 nMsRwScOd/lcWuyySuYRir5PZNOWfCfiM2hcDfpV71dCHdV2Qo/6hiXvN6OOII/zFXnU0geyz
 gQWUhoGjv0hqq/9rbYUAMLV5rpAUb9YxzGNRLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM, we get a new build warning here:

drivers/usb/renesas_usbhs/common.c:860:12: error: 'usbhsc_resume' defined but not used [-Werror=unused-function]
 static int usbhsc_resume(struct device *dev)
            ^~~~~~~~~~~~~
drivers/usb/renesas_usbhs/common.c:844:12: error: 'usbhsc_suspend' defined but not used [-Werror=unused-function]
 static int usbhsc_suspend(struct device *dev)
            ^~~~~~~~~~~~~~

No idea why this never happened before, but it's trivial to work
around by marking the functions as __maybe_unused so the compiler
can silently discard them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/renesas_usbhs/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 02c1d2bf4f86..2ff7991f4517 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -841,7 +841,7 @@ static int usbhs_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int usbhsc_suspend(struct device *dev)
+static __maybe_unused int usbhsc_suspend(struct device *dev)
 {
 	struct usbhs_priv *priv = dev_get_drvdata(dev);
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
@@ -857,7 +857,7 @@ static int usbhsc_suspend(struct device *dev)
 	return 0;
 }
 
-static int usbhsc_resume(struct device *dev)
+static __maybe_unused int usbhsc_resume(struct device *dev)
 {
 	struct usbhs_priv *priv = dev_get_drvdata(dev);
 	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
-- 
2.20.0

