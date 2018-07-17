Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0E20C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8v/5Fg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC0E20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbeGQCk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33887 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeGQCk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so8262457pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zq45ImM/3kfZVyZWiENMbA0c0j0oq1HjXSaMfDLcgFc=;
        b=Z8v/5Fg0cH41oLXd4M2HvEPsK3WqNT4T1aezvlcVsoIrtaZpPldzhMOD6s7Xs7BbP1
         VpXL5LTk8sufmQsgyJL1H9+8dMb0EK83Q2gw7kv9slrKYi5+aBCmSLFZDdrOAXjFJ6Ns
         HSqUdIp03GTUQ5JkJNgQAUGDfW3a9vtKBx86RrKjGDWl1IAbhpBTvIbG6f0FlaFDW10/
         kCtRs1u64UGrPmH4EmyZIj5Z5A8A0Acsj7/mZmKDN2zUC3Nr+Y9SzuZbKic7K+icj+8F
         GzlRkT1cSwLQDRGu+2u+CdQvs1/rDzFSYWQqCTlbqMSLotEFNVoVA5TWaF2DWPweyuH+
         TRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zq45ImM/3kfZVyZWiENMbA0c0j0oq1HjXSaMfDLcgFc=;
        b=HdPkf5xewDXzY/MKSFkKje1ftnlHr4GtredNGvupp/9W2KWXWCCSoDuoOb/xDj1LPX
         fZtXJA7XDRDTPxAKG24qpZKV2dS3ulTS4e6subJ9y4yi3Awco4A0USstnnbTxqO5r5kk
         BQqkQV7xvKOuahyQhzR2w/t1ecOcIlQu3MUN32CXpkws7I/WDsFNs308r16nCj8gjEXf
         HXA0pH7K8zkN+FpbAg5Ylfcdt21D7LF7bu7m5/+hDs8eDRQndCWL+NVlozm/I2jTgyH3
         6ehpOn0YtrOMrTj9vSrv3A31Z4X7/9fUKDamp1LwmgekVcDbAUdu4HfCtc0+oLE4llL9
         3/fw==
X-Gm-Message-State: AOUpUlGWA64NNHjIAN5zmlabt8cbyHMn0bS1iKxkQkaA/N0Gc/iUlEQE
        zzSTMb1Vlju6Qsz96EM7IVE=
X-Google-Smtp-Source: AAOMgpdMS1s+u8F2QJ6epJ1vxL7sSaFj7x+A6KXU8vawunFWwWb9BAK6IM9Ky1/jKUprxl1qyASKuw==
X-Received: by 2002:a62:5ec3:: with SMTP id s186-v6mr4085326pfb.129.1531793417487;
        Mon, 16 Jul 2018 19:10:17 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:16 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 22/32] staging: gasket: don't treat no device reset callback as an error
Date:   Mon, 16 Jul 2018 19:09:16 -0700
Message-Id: <20180717020926.176408-23-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

It is not an error for a device to not have a reset callback registered.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 7ea6551626524..131ae2462edc1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1840,11 +1840,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb) {
-		gasket_log_error(
-			gasket_dev, "No device reset callback was registered.");
-		return -EINVAL;
-	}
+	if (!driver_desc->device_reset_cb)
+		return 0;
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-- 
2.18.0.203.gfac676dfb9-goog

