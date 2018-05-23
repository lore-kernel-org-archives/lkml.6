Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3988127-1527065616-2-6365640768745118229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enrofr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527065616; b=Xxb1OykoFZywXx4qFQ1U6/ckYMfnNyUsMVQGqA4Zlw8N/ZiBN6
    4oCFaP2xxa8bffPTAriL6pCGUekVXaJ5E4uQEA8dZJGghkIRk1JsIgiL+odQoi3V
    kSbyY7x/XTSQUyjrkZhdMXRGkYKLs5neBl+f7ZVz1Ldjtvt6C3OdnsUhrsiwTRQp
    GS/a4zlBfVE5X0Cb5lH6f+XTuSyOdOrSwfFhLi7FcegrTjA9pP3FNLFcaCHcemQp
    eDQI/JSzgegCrltRAJPCvnjUGfc5ogBDYz19WjcmWOUB00uGeoZSUB5td20G5RLv
    zsWuhW4phSKy3clDjQoIIKFc4DOWEFRtwoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527065616; bh=tbl+225U3/x2p4oQdLzQyhR9CKWaB+
    +h+KSQY9tHcnE=; b=bdKzdSw3JH2bExxLOQdZLRNjVC8GqmuHD/PlM6kIvYZnBQ
    1yJ8dzMyhRwFf3aKvO04+9HdLTvIMUkmbSw90AMzTmZorRvsoLG6eqdfrEXlByvp
    3qbZKhTk9edt4zndUHnlZy9WtcoTkphDIzT9UiOhGmGgorRV85CkgrPFY2t4uHAU
    cRCNgyBxcAxXfe6Qe4Tg2D/vBdzxUa/Iiogl4AqqZRl8+EVUMdIXOYlxsQ0n40N6
    jq4PVKWr4TsBo0cdcUPndsmt3FLT+hIsB6asqmMXJ6/05xWd9RZaCXjupCcdAV1z
    1FbsMz4UIFJwPcdIPIj+KjFHZjXIfVxMD3N8WCbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIfwybxlO4rmqn30ZiJQOo4SN5QRnZS29MKpiAqzhYZVvXgEZNU9nh9iPKVQGVu992mR8QnPhtAxJMy8PkbDLXjCWjuLUrIt9wF3QpYCGdP922mJCjCf
    evHf3Eptu3krw0adEVDSsDP3wXbfn4tlTnrRdTt2ZfGTnPppNaa/vc3SKRS1xWxx+a5Kxz5ktpBtKWrTWfGF+FdKB7Ew41CSkBIVrZOZ/RIHP2GH9/6Srmxr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=aT_BuWeTq_lEKkUIRHAA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbeEWIxd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 04:53:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:13749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754488AbeEWIx3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 04:53:29 -0400
X-UUID: 38db6135bd6645f3997b66eb51802c19-20180523
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [next, PATCH 2/6] usb: mtu3: fix uncontinuous SeqN issue after disable EP
Date: Wed, 23 May 2018 16:53:16 +0800
Message-ID: <bd37d1585905360069baf2f3009b715258be56ac.1527065109.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reset EP when disable it to reset data toggle for U2 EP, and
SeqN, flow control status etc for U3 EP, this can avoid
issue of uncontinuous SeqN

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 65ff53a..279f9cd 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -195,6 +195,16 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_DEV_LINK_INTR_ENABLE, SSUSB_DEV_SPEED_CHG_INTR);
 }
 
+/* reset: u2 - data toggle, u3 - SeqN, flow control status etc */
+static void mtu3_ep_reset(struct mtu3_ep *mep)
+{
+	struct mtu3 *mtu = mep->mtu;
+	u32 rst_bit = EP_RST(mep->is_in, mep->epnum);
+
+	mtu3_setbits(mtu->mac_base, U3D_EP_RST, rst_bit);
+	mtu3_clrbits(mtu->mac_base, U3D_EP_RST, rst_bit);
+}
+
 /* set/clear the stall and toggle bits for non-ep0 */
 void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 {
@@ -220,8 +230,7 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 	}
 
 	if (!set) {
-		mtu3_setbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
-		mtu3_clrbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
+		mtu3_ep_reset(mep);
 		mep->flags &= ~MTU3_EP_STALL;
 	} else {
 		mep->flags |= MTU3_EP_STALL;
@@ -400,6 +409,7 @@ void mtu3_deconfig_ep(struct mtu3 *mtu, struct mtu3_ep *mep)
 		mtu3_setbits(mbase, U3D_QIECR0, QMU_RX_DONE_INT(epnum));
 	}
 
+	mtu3_ep_reset(mep);
 	ep_fifo_free(mep);
 
 	dev_dbg(mtu->dev, "%s: %s\n", __func__, mep->name);
-- 
1.9.1

