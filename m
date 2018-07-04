Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56BF208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hk1SE6+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56BF208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeGDPJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:09:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38154 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeGDPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6218933wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7yQuQmvGAlbR4zcfDmJZAnreypXNnkd4KjoHxuswAM=;
        b=Hk1SE6+AEWgMR74AgU3FG5j2JMCOiNbKlY/JFR5GmwkE5MGMRbUEihHTbVmAa0LWXd
         j+/UChVbohhikqUboTQHM8U/X+LwJp2SyBzZtn9CssyMy/o0w/ANrwzPSAH4Bdt2tDSo
         l2ncX9k4K6MrkkpP1wiNYqiBw6n47DAJKtS44AViMtH11vcIHq6J5zQZC4L1lUR1OErr
         3ALFdO3QxwNQw4zBL94rt4qlJrLbivJlsAbHyiWuBgZvwug2gNwO5vIP56Eb775pk928
         aEwXkw2/vnj/nmpikH/OA0Yj0aVqKkQXCHHLp61Nvnl5yLoqzVWVFfPw0ewzDqDfG6Ul
         nU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7yQuQmvGAlbR4zcfDmJZAnreypXNnkd4KjoHxuswAM=;
        b=tSOBBvMEul7jrVr1n8j/F3H0GLEG8nG2Q36FW7gip/sfTfEO6FREHhdfJ15qIf+nRk
         A/No/eq5GCb8ydI1Wf7J/aNl7Xnf6ndCjUtwCoJe/qG307chJ/uW0VOEFd/qZ2FAghuP
         B/uQsDAEw6W+wUJLhzTgud7iKbbMgvdYPqzfeODmlethPRLR6cIq2HsPY2yMAXsVF3ef
         gzHulNy5na7VnMER3yZSbAOcgB/RuPOaSpeCp7wNVipJwB+hChZ8XmXaCfOjl7wNMgVb
         3SZ5v42k64koIc3dudQQTcSas3bc/gB2aOmlorEBm69q683QvD/zuqsmGK2Y8HrOUzZP
         EI9A==
X-Gm-Message-State: APt69E0og0ZzVXdFTv5UpIbiGQxQBXZywN3kHqljtj1kTWkTehKQ10M2
        TV8RF/QpKkTwpxrVa3x6CtfsuQ==
X-Google-Smtp-Source: AAOMgpc6GhL/llorRjRgLJndJx1uMgwpayF3tbJ2BroKWzzk+K/wEJI3hnPLfSJCLJrDQeufMKbcRQ==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr1955233wrd.272.1530716911082;
        Wed, 04 Jul 2018 08:08:31 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: [PATCH v8 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
Date:   Wed,  4 Jul 2018 17:08:20 +0200
Message-Id: <1530716901-30164-6-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
when the CEC feature bit is present.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 306e1fd..1e2049f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -377,6 +377,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static const struct mfd_cell cros_ec_cec_cells[] = {
+	{ .name = "cros-ec-cec" }
+};
+
 static const struct mfd_cell cros_ec_rtc_cells[] = {
 	{ .name = "cros-ec-rtc" }
 };
@@ -419,6 +423,18 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
+	/* Check whether this EC instance has CEC host command support */
+	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
+		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+					 cros_ec_cec_cells,
+					 ARRAY_SIZE(cros_ec_cec_cells),
+					 NULL, 0, NULL);
+		if (retval)
+			dev_err(ec->dev,
+				"failed to add cros-ec-cec device: %d\n",
+				retval);
+	}
+
 	/* Check whether this EC instance has RTC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
 		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-- 
2.7.4

