Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84E020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="cxvJQHc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeKTGU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:20:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46246 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKTGU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:20:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so50699911qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RSd0YY79CZ2ofVk0lazuSeMJcWSSybR1ELoxeT+ta+0=;
        b=cxvJQHc1Z0RO/Nq9lluPFDjUTIeDltnH6lEusRZEACIVBxeawF8cueOhz1AYtIxTR9
         WpEW4/qJ/f5uoUP+qj5N4qsQx0dwMJOkbCuaBoxfqY5yn6tjn76Z8hr5m9oXFg98Vk3q
         4v4XDPxj7DsGkqMFzP6LymdT5i+zw0Pb+L8qkXboan0jmZfcSETZwOQaempQCQ0lKlcV
         WXHGx3iGVs4urIDHaRVUoFjkmOQ+m4MZeNPAAzhxXFY8489kH40PCgx9KR7nD3zcmhTP
         8g44s/syYZntgcgNy21lYRC2i8r7SCbk8WwcfW1PjtuZV/kNeWmaVLxsJHpZBLcN+yMG
         96aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RSd0YY79CZ2ofVk0lazuSeMJcWSSybR1ELoxeT+ta+0=;
        b=DuFKLCW1JG/E0eS78hcBbNqc0bAjDAziDqf1HkughuMC1QWwXyoRdHxshq6UlhVa9x
         XdljWiWpYF2BNsWmX+HRbPxCRS6kiuPy/yKBYFVRLHEn/3EkQqaBkkwgy9rVtslb+Fjf
         ofD1qt7pY4YyIq0sivAt1/J/9tjSTScKjzFm8N0F5OIrUbsLB2RKKjfqdOVQRTnxRBKz
         hnhdSC55ArsZAt3+My/6NTnfAaYFJTcg3wtKXW3vjay/kJ7CWzU0eVZsAQoO7bCKPnGL
         C7rvmzoXmcNeJmuTN5hOmyDQMsNRwnm3ExyDlKunktAGotYwLl+l055HtUZ9zMQ3OpgN
         PeCg==
X-Gm-Message-State: AGRZ1gLlIbPM0HdJe+/5gOrXaGRDLCzeG5qr08XkpacFVut9WhYVZO80
        eVFDOzB05PS3mNxKEVh44QtVwA7UkVo=
X-Google-Smtp-Source: AJdET5dCwbvRc5rgvFihUMliFBl9M8ebiyjRkWfZArg9XXyduGTUO0LPEYBZjMUlFislmzCMc0bvhw==
X-Received: by 2002:a37:a5d1:: with SMTP id o200mr21353218qke.328.1542657345902;
        Mon, 19 Nov 2018 11:55:45 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id r24sm27409959qtr.2.2018.11.19.11.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:55:45 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     bjorn.andersson@linaro.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mfd: qcom_rpm: write fw_version to CTRL_REG
Date:   Mon, 19 Nov 2018 14:53:17 -0500
Message-Id: <20181119195317.22617-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114224201.16225-1-jonathan@marek.ca>
References: <20181114224201.16225-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required as part of the initialization sequence on certain SoCs.

If these registers are not initialized, the hardware can be unresponsive.
This fixes the driver on apq8060 (HP TouchPad device).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v2: updated the commit message to be more descriptive

I think its important to note that the downstream driver does this for
all versions, so it is safe to add this.

 drivers/mfd/qcom_rpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 52fafea06067..8d420c37b2a6 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -638,6 +638,10 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	writel(fw_version[0], RPM_CTRL_REG(rpm, 0));
+	writel(fw_version[1], RPM_CTRL_REG(rpm, 1));
+	writel(fw_version[2], RPM_CTRL_REG(rpm, 2));
+
 	dev_info(&pdev->dev, "RPM firmware %u.%u.%u\n", fw_version[0],
 							fw_version[1],
 							fw_version[2]);
-- 
2.17.1

