Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481798-2-3196846160730331798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481797; b=o1ivWjVKcOfBe6/jlGKKZixSOKVWGU1I5EQHAZEj2Euu8O3+Ms
    CrefEXtDal6M0UpaRlMCFtFn+FmD2zes5F5H5B70b+FmVn5Z2aiKOUuq4eTqqdhB
    OXWbAKmYyuDAIK2gMV2ERNCe9JKzj/EhKAWyRPrco0xuIAwjSxxhtqAQYN/Js28m
    5X+yePWy4mFPn4OdLviCxW8qTRN2BoixQfiHb5EQHj9yfk1dI9KHzk/w+sGQ3czM
    reoselfrvSRs3QjjxtGhU+poApomXYGchk1Ql0jBg+hUgOihmlIYhewdylbC8I4u
    RHtGKZSqRgKubAf6CLzOnI9f7d8lGqqO+gJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481797; bh=jv4aME7JhEchRlNbQWqlsgpYfiCR3D
    MKSY9raGPBfuU=; b=aHvViSet7Q3k3winHAjDAl5LoQ3i46IcCxnAF5EerqXvgs
    UJKhN81Ags4AoDJMmdHuIA+lLsgoUiN9j7TqlFYYckG0i8nJjVq/fBQLBBqy0SBC
    /iSsfVHC3ap0vCyPjwzcM9nIxrSPhm5O+ytGjWPgS32kvaMZUbAcoyI4MClNwIz1
    S7lVmakyy2/O13WuGLrXBizh+3cyHr9mSC0o297f4r91GBSchXKQGswXEhDs/ORn
    rvxk7gjjB/uIPToMg9kMiAwhfHTBibXh7TKjMO2NVC3uu44JXROepOgcN7OL8t5C
    HjMwnyfZuN+UNZ6S9R4EATSLx9H6aCjvtSSdgBMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO5y3pJyGEd6Itzd/LqPbLg7MP2XqWC9335VUqSqlg9Pk59T0TbuNwsSl9DoWErX0PeHsnHK3mv8WZefXLLvMS1kLoWxgbLNnDuJ+If8XqeJxl8FEsKX
    kmKcKCOP2D5WwkK229YP77Cw/Wp61Lcp7/IKLeeFIAjE5EDNB6X9UqNDv/X/xQBWIN//WwE5vzJI+FzXvrvJozk4v6AF3Q2DLB/I20Q9+Ut/VX/SQHk2+/PS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=SMg-zceUvSRekMsZMH0A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=ST-jHhOKWsTCqRlWije3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeDKVXO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:23:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbeDKSit (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 028/121] usb: chipidea: properly handle host or gadget initialization failure
Date: Wed, 11 Apr 2018 20:35:31 +0200
Message-Id: <20180411183457.814688900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <jszhang@marvell.com>


[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error != -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/core.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -553,7 +553,7 @@ static inline void ci_role_destroy(struc
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
 
@@ -653,20 +653,28 @@ static int ci_hdrc_probe(struct platform
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
 		ret = ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret = -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
 
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
@@ -676,7 +684,7 @@ static int ci_hdrc_probe(struct platform
 		ret = ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret = %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
 
@@ -727,7 +735,12 @@ static int ci_hdrc_probe(struct platform
 
 	free_irq(ci->irq, ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	usb_phy_shutdown(ci->transceiver);
 
