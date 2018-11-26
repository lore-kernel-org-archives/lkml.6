Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23120855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS1osmv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeK0FN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:13:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35451 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeK0FN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:13:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so19497211wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AWiJNbeu4dSJlG6a0/1yZTmLo+Cq2qEVE1m9kOodvnk=;
        b=vS1osmv/MtpKb8LA+A1+5vCb+cW6bIudhWPq3eXSux0N2NCCo47Z355r3gqMaQV6EU
         NLtDL0zXQXmRk9IomMIgOc/T+3VRlDn/T5y4rgjUu+w4pITBAL+t1F/6s48PdnuvrtpJ
         ajwGxCgB+D8QpFZue8AedKyatkGsLdOfzyMxdygAiLD2rZwg6EbB2STfv4HFvHavZzqk
         BaoztGbh8QKJcwIWFezwyGTqi1SD9sVI8ApeecbupgmyciiwF3xwo5GeML3LbijCoEc1
         w9j2BdYdML+Py9TBNLnGEFV4vxPDgLrhmy5TL53ZlDVqtjBjEqBMgIvoynaRIqUl9BfP
         M6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AWiJNbeu4dSJlG6a0/1yZTmLo+Cq2qEVE1m9kOodvnk=;
        b=sVauzY2b75TFZn64f+MWhq1eq0LjB5NCts9LHCUcOgW8brdpDh3zy6kgHwwVoO04h1
         0JvWX2fI9nlh8uULdMivPFBxPBCsN/Xx/zYS9uxTVX4hbPyjQqtinYrCNOUOwNR3mdY1
         qhoyMI5EKftSf88HOHSGorOmk5EpbalYsRLKqfgx5QaUGYlJuue9lR86eCVnOJsBnSdt
         YRx140ib74CYiBOjOp7TBCjXkNrzsM+puKZKiGYktCzFucG7QzN9AXrReH+gtuckwUV5
         u/A+4wJyxNvwnaduIoHEnlLlrJ1gQnHvxR4RbkstidvCUf9JQSBOQnQ03F4Ow56AQ6LO
         NyDg==
X-Gm-Message-State: AA+aEWZSNkeXacrdDdWoon4Fa3wCBsNhECx1/+pEsTtOgdK2s3Q05MI7
        r9NSLa8PelVJDDdtOC0GVHs=
X-Google-Smtp-Source: AFSGD/USHxZsLMgy4MBEN3IhZmakqHmtl4wWcz2ftxAqsmX82aQaD+sXcqNov4FT9DndeEJ9uzQleQ==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr24242031wmf.14.1543256312979;
        Mon, 26 Nov 2018 10:18:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id r76-v6sm2023851wmb.21.2018.11.26.10.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:18:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux@wolf-entwicklungen.de, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: pi433: add missing call to cdev_del()
Date:   Mon, 26 Nov 2018 19:18:20 +0100
Message-Id: <20181126181820.24224-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cdev_add() fails, cdev_del() should be called.
Add the missing cdev_del() call as pointed out by
Dan Carpenter.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Use goto and label.

 drivers/staging/pi433/pi433_if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d72de2105053..b2314636dc89 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1254,7 +1254,7 @@ static int pi433_probe(struct spi_device *spi)
 	retval = cdev_add(device->cdev, device->devt, 1);
 	if (retval) {
 		dev_dbg(device->dev, "register of cdev failed");
-		goto cdev_failed;
+		goto del_cdev;
 	}
 
 	/* spi setup */
@@ -1262,6 +1262,8 @@ static int pi433_probe(struct spi_device *spi)
 
 	return 0;
 
+del_cdev:
+	cdev_del(device->cdev);
 cdev_failed:
 	kthread_stop(device->tx_task_struct);
 send_thread_failed:
-- 
2.19.2

