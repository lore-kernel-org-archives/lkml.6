Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D926B20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlZeiZmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D926B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeGUO20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44660 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeGUO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so6350170pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBF2y/mExi53CF1QzH4dbyiJJYz/W7TnC0dgpxncxrU=;
        b=DlZeiZmQnRIskF2bgZ2HlIqQRSZe6VlIALRKNxvRn+Zw8b/tDtZoG0CRSZRcTixRte
         PHyFA0TqBmf4RWhP1gV6NYY7G4U/mm9oL/ictccvpENqyVNwVOVE3rWV4hZdn9oQJpBD
         19tSIbDVEI+CGNTaafnVt02kArDP3ZU2zxbyjbpv+P92aWo+4n2zjEZCmCbICVpV56rb
         4UrJ8X6yXttOJAZu4iHh8deoS1+fyxzGcNWy6qEa527MAJ18dAjSAePfCWk11MjC1ZCJ
         DCZjK6Olj1S0KownLt21kq/0gKt5Wt69U8rJdZ4RZRQ7SoJhlES7EmvhtF+SEiDSeUVZ
         mcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBF2y/mExi53CF1QzH4dbyiJJYz/W7TnC0dgpxncxrU=;
        b=E6Ew4Jycb4ENYM9/c0Rb2KhYZn/uoKp9cLtsDPh7jrvju9RiCnbp3OH50xwlcp6DH9
         yIA35MX0dltGL0cvGrES7YaxeGpTj0jYEsufZQaWAy6CgxzpNr84PbHdYhVcCqnYqN2R
         vX2dQh5WWcRGf27hTXnZpJXPIJva7QqUlvsdbuFSIJ0ys1uIlKFdHLUBf0/9N/uPd1AI
         egTU4jkXQWknCv+b9HVH4QY1s4rifV+RmG5nDUcDr3gra2EMGa00aU/S+IkFlH9dXCCN
         TYcCv12qh6x5A8AGQbrnnKwM5srsdHhNGt1CQ/Kz9HZIKu1hUhn6WUgOZSpDKoHi+NDJ
         sXLA==
X-Gm-Message-State: AOUpUlEzx1R4pe11yqJzbrEEo7t1YhOmEa3EjkuWNp4KK/NGamNM+qQk
        FuH57DNceU4KWxDMVkOnjrM=
X-Google-Smtp-Source: AAOMgpd4ID7eYLRobMtnBf8dptEMPPg2JdV6sd3DD1cLha2WL3m7hP962Cl/+aFPGw12m3dwMUfepw==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr5831228plc.221.1532180133545;
        Sat, 21 Jul 2018 06:35:33 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:32 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/14] staging: gasket: apex: convert various logs to debug level
Date:   Sat, 21 Jul 2018 06:35:07 -0700
Message-Id: <20180721133507.95599-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 1c6f73b5a2a9e..6396b18b246a5 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -420,7 +420,7 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 		gasket_dev, APEX_BAR_INDEX,
 		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
 
-	gasket_log_info(
+	gasket_log_debug(
 		gasket_dev,
 		"%s 0x%p hib_error 0x%llx scalar_error "
 		"0x%llx.",
@@ -589,7 +589,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Disallow HW clock gating 0x%x -> 0x%x",
 			val0, val1);
 	} else {
@@ -602,7 +602,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Allow HW clock gating 0x%x -> 0x%x", val0,
 			val1);
 	}
@@ -668,7 +668,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(ibuf)))
 		return -EFAULT;
 
-	gasket_log_error(gasket_dev, "%s %llu", __func__, ibuf.enable);
+	gasket_log_debug(gasket_dev, "%s %llu", __func__, ibuf.enable);
 
 	if (ibuf.enable) {
 		/* Quiesce AXI, gate GCB clock. */
@@ -738,7 +738,7 @@ static ssize_t sysfs_show(
 					gasket_dev->page_table[0]));
 		break;
 	default:
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Unknown attribute: %s", attr->attr.name);
 		ret = 0;
 		break;
-- 
2.18.0.233.g985f88cf7e-goog

