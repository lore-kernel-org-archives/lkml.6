Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-68257-1521114053-2-7232559787797185599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521114052; b=Wn81sNnWm/p9y1Iy2dK787CnI6UHw9tNDYUKEpQfk5iVp2i
    0zfTfp1TWXZqMJEF1qLYrCbCbHK2aUgDLfT06YzQzuVpkXGsMvXS0c9yTbTMIc2W
    eZFspMeV3rdcMM3l/OygdZMAFHMLQfIILWjJ+HdXVKCdBeYlRSwIZlRQUZYFE1t8
    5a+vLq9hZoOh/8y5l0kTFAiBu2AMD30L6y3r48hXXwwBDmn2i+ydxGXuFn038FZu
    L8Rig/3Zd0IbeaUcHgmITNQIkO0lpaIaWg1ZaRq1tqksMBm9S1NsER1IsEyr4vjF
    swcXqhazHPNw0l+u7ZQqSJoIm/YJ/kSw7O294qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521114052; bh=hQETnEo5ocIisFwc9kl/Bh6VXZ
    IWar7fgFcCehqeW9E=; b=Csb1/xyDj1hFerbSD0+ngmGCmhmlzeO0gYw0133frq
    PPPPy7JPkHSLzE33KgigGAfTFlHbtckDab+t08WDkXlUnpfAaQrCYO9iUDYoolLX
    GYGm+JhGgcejqKu+4kCxjVTNri+90sX4aEoCDoQDQH7Zw6AvREBWS0DJ7SB4ZGRq
    spSei7PmFHd2524nqciV/UkYE7lajm1YozDjEpHZOWxf3W2iRaS+pfHQsxrkkyvr
    82CYQYgIyYS2Dq/1WEylbfPbIPKC8ZBvawP2TWAtLav5ODbpb5nNfpE2jwJsZ189
    HSQLtSdUNO+/bozI7ATdm2CHR6wGLArSCjj5iH59Y2DQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=UVOi7nQe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=UVOi7nQe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeCOLks (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:40:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:32444 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCOLkr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 07:40:47 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2FBe0AU027015
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc3: use local copy of resource to fix-up register offset
Date: Thu, 15 Mar 2018 20:39:57 +0900
Message-Id: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is not a good idea to modify the resource from the platform device.
Modify its local copy to pass it to devm_ioremap_resource() so that we
do not need to restore it in the failure path and the remove hook.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/usb/dwc3/core.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f1d838a..e9083a3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1164,7 +1164,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
-	struct resource		*res;
+	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
 
 	int			ret;
@@ -1189,20 +1189,19 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->xhci_resources[0].flags = res->flags;
 	dwc->xhci_resources[0].name = res->name;
 
-	res->start += DWC3_GLOBALS_REGS_START;
-
 	/*
 	 * Request memory region but exclude xHCI regs,
 	 * since it will be requested by the xhci-plat driver.
 	 */
-	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs)) {
-		ret = PTR_ERR(regs);
-		goto err0;
-	}
+	dwc_res = *res;
+	dwc_res.start += DWC3_GLOBALS_REGS_START;
+
+	regs = devm_ioremap_resource(dev, &dwc_res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(res);
+	dwc->regs_size	= resource_size(&dwc_res);
 
 	dwc3_get_properties(dwc);
 
@@ -1269,29 +1268,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-err0:
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
-
 	return ret;
 }
 
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	pm_runtime_get_sync(&pdev->dev);
-	/*
-	 * restore res->start back to its original value so that, in case the
-	 * probe is deferred, we don't end up getting error in request the
-	 * memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
-- 
2.7.4

