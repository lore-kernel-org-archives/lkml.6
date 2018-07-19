Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdz9QgJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B995120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeGSF41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:56:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35782 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeGSF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:56:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so3297159pff.2;
        Wed, 18 Jul 2018 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t9RFX8F+egnav+HpCTEPx2pTL02J48Fy55VH79Jnvdg=;
        b=Gdz9QgJTUc+2RZL02q3t8YGrr3XWd1LByqwtMYeKCxOQlAmgPfImOPHUO0Sb0ou7Y+
         R7JT8cyK98x9oyLQS5xOgv2xirIevI8cFUCuf+aPRNwfYDHz+4kODLSsH8Tn1xNBecQ6
         adUqdxgNW+hVo/A07PmQyfcbNsbB5040wmfm2IjXwErveKb2GZwGa8d9uHQ998wX0CYX
         /nWpJ/1ZA7MY4hy+vs2c6mgqcaGt0mq8IDE/JkftG7cMUaVyFVfJJZEm2UO2btDIxC1N
         tmN3Sphzwekvsg8DyIAXXlLChm6LQOdaiM2bDHjt8Q7Amq4e6OoNPtblh0FzIn56biIA
         lqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t9RFX8F+egnav+HpCTEPx2pTL02J48Fy55VH79Jnvdg=;
        b=SZab2jr6SZ53g+nGL/PFJnXJdW3KCqh/914wWeljfdDNP/M4L2OG1app1hCTq97UzS
         Ci92Tqt18DYNbH8rn2c4AkP77u+5KfHy/OkFl06wB1sQfS/FUgkPVXpWRrwYeAazoMP5
         BHTvcm1SRz2ejmOKVneuc1FLZUWZyYNaClhNbdk3U8zMoyapEVWtG8t0qn2Kg6gETYbC
         P4dZBWf94CKvvx/48xn+flmcQZ0O05ao95F4fI7mJE+yhDmL/yOH9dT+ObyBBZKiraUj
         mMzI/Jt/3h0iARu0kor/FqzHCv+evsR1ijcxo4o7ufsbbl7vo/ZH7JslLR5r2ytb6y1m
         XQIQ==
X-Gm-Message-State: AOUpUlGuJxpIhTl6q9xy4bWyp06Fjkjuq3I6LGQqSIoB6ix5GM5hT5RY
        Qe7oBjzvppanswDr7BZ92wo/
X-Google-Smtp-Source: AAOMgpcnuSXRhzoCqtsGZjdegjjCsIcPpdskHrEGMH8mNb4bSBQunIOtxI8/vrojjDwzFKp/aFnpeA==
X-Received: by 2002:a62:5bc3:: with SMTP id p186-v6mr8098557pfb.42.1531977310672;
        Wed, 18 Jul 2018 22:15:10 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s20-v6sm6701328pga.37.2018.07.18.22.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 22:15:09 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers/base: stop new probing during shutdown
Date:   Thu, 19 Jul 2018 13:14:58 +0800
Message-Id: <1531977298-21465-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race window in device_shutdown(), which may cause
-1. parent device shut down before child or
-2. no shutdown on a new probing device.

For 1st, taking the following scenario:
         device_shutdown                        new plugin device
  list_del_init(parent_dev);
  spin_unlock(list_lock);
                                                  device_add(child)
                                                  probe child
  shutdown parent_dev
       --> now child is on the tail of devices_kset

For 2nd, taking the following scenario:
         device_shutdown                        new plugin device
                                                  device_add(dev)
  device_lock(dev);
  ...
  device_unlock(dev);
                                                  probe dev
       --> now, the new occurred dev has no opportunity to shutdown

To fix this race issue, just prevent the new probing request. With this
logic, device_shutdown() is more similar to dpm_prepare().

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a4..3aba4ad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2809,6 +2809,9 @@ void device_shutdown(void)
 {
 	struct device *dev, *parent;
 
+	wait_for_device_probe();
+	device_block_probing();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
-- 
2.7.4

