Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDAAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28402086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCxS/Sr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfBVEJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:09:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40127 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVEJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:09:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id x187so725801oia.7;
        Thu, 21 Feb 2019 20:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bycRX4I29Wrw7oszg3KAoss4RKsaX6OjLGMSDEGtcZc=;
        b=bCxS/Sr2MAOEOIRbJE7Debn6P4FcpFSm10wH49pSWO37UPsSN7JNAMEZk/yXVyTn9h
         qJcANW2Vgof9V5xuXuAx/jehtoCD0T1vKscb072PaBwfilZwM7cScVKHdyXBGlo32BjM
         wBeJlKVWB9lgAm2+ZvfFFL9gbNi0dIcESedLeLP2safobRyNm842F7vGmId0TcYjJota
         gJ7PhMiD2/42Qq5dl4sZ6GJROM4AMfBbkfG7gd/E+z0u+pBLbW+Xa+EP+j6Tui8EoODQ
         rMfIHR+8oLjH3L0ZIkvpyItfDm3i/mqwqcATD5QBBfhoWVgIEjxEV0+ggYBOYQ/I2EFK
         Sb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bycRX4I29Wrw7oszg3KAoss4RKsaX6OjLGMSDEGtcZc=;
        b=sevQxTIrm8VDlH7zGKcW/MZl5Oh31mIFvSv99yUxd1NLUiJhW1pGDbNkbmAr9Oh4uS
         eJJ1Ohgk3KJIpynJRfm8yDlM8zVniBZW6Fz2c6XHM+M2zXZFeQuuNNMoMew5OEhdMeKR
         tgxA8BQvlKJBfFhvwSewtwJECVfpMqrjCBYZYFd1SY3cY1DC4re8HwXGtybZJj1Znl/e
         Urv7hIEE1jbw8ffDXHskmf3rD8B3H5+hg2RBh+fBrquoDH6IkGBSmD0jn3rvhL5XGUoN
         8sbrhUcCmEXD2lRIrK1fd2D6437t5jqj8bOggUb3IZl5T2YHCr4F3+UsbtKBVfdaTguR
         XRag==
X-Gm-Message-State: AHQUAuY9/duKG28BJ2wYZpWnrx4lpJeqcWb+Y7oJCcMvuFalR4tODiDC
        5Xfedra4Ijt7PISe8lkDNYSMInrE
X-Google-Smtp-Source: AHgI3IaceBSWoymKRP3SaKnbKMWkDDFN9Gwy6t8Q2GAkGULOGGJ/EwTg0vNx+mwn5f8hD7S3hdbA6A==
X-Received: by 2002:aca:d702:: with SMTP id o2mr1312627oig.113.1550808587546;
        Thu, 21 Feb 2019 20:09:47 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id r1sm167836otk.48.2019.02.21.20.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 20:09:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/4] net: dsa: mv88e6xxx: Fix -Wformat-security warnings
Date:   Thu, 21 Feb 2019 20:09:27 -0800
Message-Id: <20190222040929.16657-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222040929.16657-1-f.fainelli@gmail.com>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are not specifying an explicit format argument but instead passing a
string litteral which causes these two warnings to show up:

drivers/net/dsa/mv88e6xxx/chip.c: In function
'mv88e6xxx_irq_poll_setup':
drivers/net/dsa/mv88e6xxx/chip.c:483:2: warning: format not a string
literal and no format arguments [-Wformat-security]
  chip->kworker = kthread_create_worker(0, dev_name(chip->dev));
  ^~~~
drivers/net/dsa/mv88e6xxx/ptp.c: In function 'mv88e6xxx_ptp_setup':
drivers/net/dsa/mv88e6xxx/ptp.c:403:4: warning: format not a string
literal and no format arguments [-Wformat-security]
    dev_name(chip->dev));
    ^~~~~~~~
  LD [M]  drivers/net/dsa/mv88e6xxx/mv88e6xxx.o

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index cc7ce06b6d58..3f9a3fc52a0e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -480,7 +480,7 @@ static int mv88e6xxx_irq_poll_setup(struct mv88e6xxx_chip *chip)
 	kthread_init_delayed_work(&chip->irq_poll_work,
 				  mv88e6xxx_irq_poll);
 
-	chip->kworker = kthread_create_worker(0, dev_name(chip->dev));
+	chip->kworker = kthread_create_worker(0, "%s", dev_name(chip->dev));
 	if (IS_ERR(chip->kworker))
 		return PTR_ERR(chip->kworker);
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 4b336d8d4c67..42872d21857b 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -400,7 +400,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 
 	chip->ptp_clock_info.owner = THIS_MODULE;
 	snprintf(chip->ptp_clock_info.name, sizeof(chip->ptp_clock_info.name),
-		 dev_name(chip->dev));
+		 "%s", dev_name(chip->dev));
 	chip->ptp_clock_info.max_adj	= 1000000;
 
 	chip->ptp_clock_info.n_ext_ts	= ptp_ops->n_ext_ts;
-- 
2.19.1

