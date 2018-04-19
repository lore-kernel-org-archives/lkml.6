Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3240820-1524146900-2-9577716337956808915
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524146900; b=pT4zxgLHKIZk3EfqTIX/sJIeP0ThouqTEPh7u2KecV2ddrJW1K
    GGEzfTOpr5ZmCRASIZWEiR7QmHitw8TSLM2HhybG2YMBuIOO37kUFi4laS94IPWk
    PTMGoqVs1JaHSlKlLgQcaCHb4Ol9IKeO1GYSzTokoHqF2DI4Oeei38JKO0ex4d3w
    OdCGPeqPZYMdq7L2vh6klDrubvz/aRCthgBrEAaX40Ztv8xD7WkUtvXu+/NzyRMC
    vgWUHPmcIeQBovIZLN7TEBdwqShYtKcr62Uc77DiQhOP1jqW9kv7K8pfag5da4kF
    eGvJIVidfUjJ8Ij3BbjomryxKvtq2zChkJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524146900; bh=
    R+5E0oVjwtiL6LfRjDZJHHkPuXN+zSU4qc6SYxs/GQk=; b=XrOdHBN4vnXbiVbY
    DVfjguXsWcXbDN7W6R05GzQc+itjRBcKC9c490WKncinYhcR6w+qHQuWU+CluDV3
    rCzyNSOJsCVR7/DfVy0HHeyZUcFXibx6UbnqB7JygBVkRKo0lyhdd9KqCMC5qrZh
    m/6r6qJktZKTKZU8jQ9maDXmC94TxQ1pfse7c1QvY+a7jNHT+sr3jzrhlPY8/plg
    cIEiuui3RD4y4WbpIdNr1KC+CJzC/zzcF9/A8/uB4redyGH6lmXnaUcRrOu3qEyd
    gl0uMmymHDKbCdD/JkYK9tGi//DrSBWWhAvH745ZwysMgrRd0pKcbzPLqxUwmCXM
    D1OAnw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOuiNnfM5OvrtDyPfplxB869dhunuE9OkM6RmCdxb2cdH/26UQJGa33lNR/zpjtFk6L67SmWvFaGORGMAdEQKSZB3iuot+N352FxluAz0fw+bP1WH8xf
    1Sr4pwBZudhjRzg3Y2MPdrHRoJbKnINRi37MVEqnMBgWo4BBlEIFelPVuhbUlhAxK8+5MszRaYiZH7Ifn2tpTUN2wUUcSfqc4RzaBrDef1rMXnoz/IhGJdNK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LDBv8-xUAAAA:8
    a=VwQbUJbxAAAA:8 a=TfsKkDOJGvE6wVcqPHgA:9 a=x8gzFH9gYPwA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeDSOHQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:07:16 -0400
Received: from sauhun.de ([88.99.104.3]:45342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753375AbeDSOHO (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:14 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 55/61] usb: mtu3: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:25 +0200
Message-Id: <20180419140641.27926-56-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/usb/mtu3/mtu3_plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 628d5ce356ca..46551f6d16fd 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -447,8 +447,7 @@ static int mtu3_remove(struct platform_device *pdev)
  */
 static int __maybe_unused mtu3_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
+	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
 
@@ -466,8 +465,7 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
 
 static int __maybe_unused mtu3_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssusb_mtk *ssusb = platform_get_drvdata(pdev);
+	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
-- 
2.11.0

