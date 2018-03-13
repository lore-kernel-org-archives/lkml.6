Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4028677-1520974892-5-15289986514658034503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520974891; b=alaNMq6c02DxqK8cuHA2mnLxNyVxxtdWivtzySEpDFmNNbh
    S0W+Sy8/sK4k400XrQCJZtJQ7R6z4WLjLjNizhuE7RpkTb4L/2EN6HSpe/gDPwZs
    0K6A9BAcCYcw+7/EjA7crp7syvDbIQRT90y9XQFx907peW5U7szRW6mM78xtGczf
    TeqljYjrki1+La9WE1Jsz9YkNeZmVpMV3+Ezn1KNlahSsUnJmFDAO27NYz3Ap9Ea
    fTYyGe7Kjc1vpmQF6YM2ZDHM7vJi2t2hTBSGEGZC2vBpYUxxqK7sLAti35PJgS71
    u+6WS5nxKbfAUdGKoZ0yWjBv715uWmtNT4y3xlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520974891; bh=u
    fIcjWyCa4HBPcMa5IwHDKCntGX/ssT/SmXGls5dkmI=; b=a7RtAn6eew/NKJxu4
    L7OG6wrIS8rvMDOdrtFMqcFr+BJOPKrOOLO3Aco5tQq7YOiiDkaFkI8+JVdZ4BYY
    itS4GmypFa2REqOcVW7wmFXICHPUOeYHuEZ50re+b63TJoSk+N33+dNlaohPauHy
    o+FG653pk4E7W7ps4mg8jC/Y6v7js7FgnpYIt2kQCyhOReZtUrGm0t5qQLXmx0p4
    t4n0PFDHV1qzv3fgfeloqnm2UnJ9E9H/hY4bGErBIqsXLenCiMSs4cBrU7s/bWzA
    fNSv/SLFmzu8mATagjXDMUvHYSEGrE2GDVjnpaVjeDYmwm84x/v4sTnASqtX1ix3
    y+H/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wanadoo.fr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=wanadoo.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Mar 2018 22:01:21 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: martyn@welchs.me.uk, manohar.vanga@gmail.com, gregkh@linuxfoundation.org
Subject: [PATCH] staging: vme: vme_user: Fix some error handling paths in
 'vme_user_probe()'
Date: Tue, 13 Mar 2018 22:01:13 +0100
Message-Id: <20180313210113.11624-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2 gotos in error handling paths branch to the wrong label.
Fix it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/vme/devices/vme_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
index 3242dee8246f..6a33aaa1a49f 100644
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -558,7 +558,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 	vme_user_cdev->owner = THIS_MODULE;
 	err = cdev_add(vme_user_cdev, MKDEV(VME_MAJOR, 0), VME_DEVS);
 	if (err)
-		goto err_char;
+		goto err_class;
 
 	/* Request slave resources and allocate buffers (128kB wide) */
 	for (i = SLAVE_MINOR; i < (SLAVE_MAX + 1); i++) {
@@ -618,7 +618,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 	if (IS_ERR(vme_user_sysfs_class)) {
 		dev_err(&vdev->dev, "Error creating vme_user class.\n");
 		err = PTR_ERR(vme_user_sysfs_class);
-		goto err_class;
+		goto err_master;
 	}
 
 	/* Add sysfs Entries */
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
