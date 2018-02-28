Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833556-2-2864433862479803444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833555; b=cvWALqHFiSxsnr7gMbQHC6jlGee3Und6iJNDwm2F+K+W9dN
    yXaX4wxauK4HC698WlkR2mecWwiuaPv5CtA4B9mFAOvyGTq6yF+Xv/4j/h2RYzTs
    y6HTemv4EkvUL1qeNozFbLueA10LZyu33w3Nk2KhTXavpnSSQar+e05B4IEgeX9b
    5B+7APKKVp/Sg/g+6HrH30NDpJooDFONhGddX38WwJg8dr050TnvQ5ssyZC7mpUD
    Pin4/NMobSIlvzc5aNJnmqXreUmC4g3VQUPgg0YUcS3tHH86X+lh3jCcJNS6iY9s
    PXHcDrPBknJPf4drrTW5wD6m86z2OOIYoBY7oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833555; bh=U3IHPtSvwhz9pHMfL3d
    WsmAvl+9GVQZtBP0NzadBSoY=; b=iRI9lWIJU82Wdo2ld8PYiQTOuj8cLzYnPgM
    q3GYBLfGo/dd+4oOzHTRiHRKV1nFEZalDCHVQ/PfbecMAGUI18Q65TJ1ZtK7GypO
    Lzw0qB3w1HAfiXMLgjYT2t37Om7joGYHkGuQ4KS9hGeaBaB4M0+Mu2FucgebrWhw
    jEld6oGS0XnSKw9jLJTa/6kFN3s/diTE3AZeZ+Dzwl0IVN5I4yyGHMbiqYtbyNVn
    HIRIhAMLlBTguTu7O4dBDTyo/M8nnTASdThRFKmkSz1HxeFw9ajXPoMRBdj2ds17
    AW0my/6m2teGp/Z/TkYYhIxtfdpJTyt+NY5smxyWhgErWlpD4DQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933850AbeB1P7N (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:59:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34608 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932418AbeB1P7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:59:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.186829863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 189/254] Input: 88pm860x-ts - fix child-node lookup
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 906bf7daa0618d0ef39f4872ca42218c29a3631f upstream.

Fix child node-lookup during probe, which ended up searching the whole
device tree depth-first starting at parent rather than just matching on
its children.

To make things worse, the parent node was prematurely freed, while the
child node was leaked.

Fixes: 2e57d56747e6 ("mfd: 88pm860x: Device tree support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/touchscreen/88pm860x-ts.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -126,7 +126,7 @@ static int pm860x_touch_dt_init(struct p
 	int data, n, ret;
 	if (!np)
 		return -ENODEV;
-	np = of_find_node_by_name(np, "touch");
+	np = of_get_child_by_name(np, "touch");
 	if (!np) {
 		dev_err(&pdev->dev, "Can't find touch node\n");
 		return -EINVAL;
@@ -144,13 +144,13 @@ static int pm860x_touch_dt_init(struct p
 	if (data) {
 		ret = pm860x_reg_write(i2c, PM8607_GPADC_MISC1, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	/* set tsi prebias time */
 	if (!of_property_read_u32(np, "marvell,88pm860x-tsi-prebias", &data)) {
 		ret = pm860x_reg_write(i2c, PM8607_TSI_PREBIAS, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	/* set prebias & prechg time of pen detect */
 	data = 0;
@@ -161,10 +161,18 @@ static int pm860x_touch_dt_init(struct p
 	if (data) {
 		ret = pm860x_reg_write(i2c, PM8607_PD_PREBIAS, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	of_property_read_u32(np, "marvell,88pm860x-resistor-X", res_x);
+
+	of_node_put(np);
+
 	return 0;
+
+err_put_node:
+	of_node_put(np);
+
+	return -EINVAL;
 }
 #else
 #define pm860x_touch_dt_init(x, y, z)	(-1)
