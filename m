Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 181A3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FF120891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJfJ3sEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FF120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936172AbeFODGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:06:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35986 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936083AbeFODGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:06:23 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so3803012pgd.3;
        Thu, 14 Jun 2018 20:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Zu8okhZ+JgXbxnClJmzHQA9v1+tQIUxRMiDNgSd0ag=;
        b=TJfJ3sEjZ14ql+5AC6DBRK+g5oR2k8WfDbsZYHmYhdrgzGJfwiKuaDEgSRR+bfKCzZ
         +aD+IlI6wYzmCT6dySzSsQdy1gHL4NykVXv3b1eDDy7LyCweEbI+IBTMqy8SkpP03017
         cX2DNvV60SPQIxTfLY1iOK3gJNcA/2y186/gc1XlnMx7GFnncUjeSUr8TW+mcWVMMDUs
         bQrjGoFtHYrQFiivhB8faYW0f89s3tlPajQmeD/hS7Jn+kCvqEjjWnreiLqIWPCyk4jq
         wPJ4h4q5DmYGcjb3prXBb8UoTPNIVfk0g4Wr6QmIe4n6A1Q2ZHTxLyvNHdMAhdVkEzfb
         q4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Zu8okhZ+JgXbxnClJmzHQA9v1+tQIUxRMiDNgSd0ag=;
        b=NPW327cJ8vn4gH+w7jgFAxH/OfXYL4fs6HIh6vgvpo5hOOgBkKTVrMVTfAq7toqKkV
         spM+mD7zW/Q7mqBPlyNbj2h9MkROQZbubcGUU85OhCZXh3trBLABCTNigMxnO6ZO61El
         fAxpncRtP5rLEq301BIQWtKyHHwezcLlxCm1C+GHVlcmjyP1NNXrjsv73YuvZ64TiTrr
         PbdIaSv278Xm37t86dSiRdmD6kBj4WkFHTxCWcqZlwrbqk7xwx7gPU41zVAVrvW4m54G
         3IBxqDh9rjYnqDiq3YxOEz13FmFVpgXxIWJ3Fgl13i523ZD95i6k5oXEYK+Nz7e/wctA
         V0iA==
X-Gm-Message-State: APt69E3wb1MWrTBAN0z2S4vAOXjAyjdrR2lpU6yTCy+1RXFsdEDsNoQJ
        XZlQ5BjlAtTNUXwxaIGaG24=
X-Google-Smtp-Source: ADUXVKJCXGbK/w2CA9ZqHGSWOofnu1i2eJvzfO/rLTF8SpZCAUH3tnbQd0dlq3+bfnh2e8HZiLjx9w==
X-Received: by 2002:a63:583:: with SMTP id 125-v6mr4452108pgf.385.1529031983325;
        Thu, 14 Jun 2018 20:06:23 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id h9-v6sm13981970pfj.77.2018.06.14.20.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 20:06:22 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Santosh Raspatur <santosh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: cxgb3: add error handling for sysfs_create_group
Date:   Fri, 15 Jun 2018 11:06:17 +0800
Message-Id: <1529031977-57911-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Turn off led when sysfs_create_group fails
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2edfdbd..7b795ed 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3362,10 +3362,17 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = sysfs_create_group(&adapter->port[0]->dev.kobj,
 				 &cxgb3_attr_group);
+	if (err) {
+		dev_err(&pdev->dev, "cannot create sysfs group\n");
+		goto out_close_led;
+	}
 
 	print_port_info(adapter, ai);
 	return 0;
 
+out_close_led:
+	t3_set_reg_field(adapter, A_T3DBG_GPIO_EN, F_GPIO0_OUT_VAL, 0);
+
 out_free_dev:
 	iounmap(adapter->regs);
 	for (i = ai->nports0 + ai->nports1 - 1; i >= 0; --i)
-- 
2.7.4

