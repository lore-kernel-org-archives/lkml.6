Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA29C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCB421479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqChbCHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCB421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJJLxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:53:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44368 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:53:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so1946611pff.11;
        Tue, 09 Oct 2018 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=snD28BbkByNFnW0KdqZsSClGURsxVpf7mNclPUrbBX0=;
        b=WqChbCHk5cgCSV61ir/DFTzrFhKvokAiOhCt2cpkUmAnrZK3+RjUrNFynOntKvx+96
         x7KRm5+3DPFs3kJF1TPUUCFH+FJNeFnRG5lVFDH70QhcWqmawcDl2PXrTfXrifB8It6K
         YuaQhMoYtVqpx898hvqwg2SHK2os/0TB7BYubAJhUOTEtLKzrv8CAEVY1Y5h36PLc8t7
         Uj3zIBO1dY38xPo40awTXSc3uiCGMwnl+RkyUPgFUwQ9h8wAR6yDdbD/JzhLz2Ynsyi3
         4vj4gyAHVGVHfwmXfwu0w7mGyKsMtIoOAHR+8y8ErWbmA7l19EO87VWiLZ915Bjrtmoj
         alUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=snD28BbkByNFnW0KdqZsSClGURsxVpf7mNclPUrbBX0=;
        b=hxLJsq1ExO7xH0vSA+/UgCz/kSLv3SQOM/MUWgJg7yrYn6UK6S3h+4WxyJCCjgGJE9
         8gYAYc5jV0fdYnhl+GQhAki/ZRn0bS9ehn94JFar5V7XWcRgASibU8s3bf7zKH70ItxZ
         pENenW1SYAO0V3iWnro3r7sNy3DlAOTEZr9g6HNT4dML4fDWVizmMf1NJb1vquhixpnY
         s0ERP9l/NTlYZnrRSnW653sTRFwqyq/zbVBn/ppD1FmhE2xWuEjJ8OC+CvWACJk8hkxk
         /Ci4A1Ts5EyPtBbWsjL5LiqR53MzSAdcjJN5WsZE9rbjERvGxyjBwhPrEQFUmMj/1tsd
         4diw==
X-Gm-Message-State: ABuFfoi8eepH8meXcuuFslhH2EWzDVSwdb8lZFzYKjUeJ5yY0iWRaCTs
        h90vPB3XIsK5DDs8JVsOMbw=
X-Google-Smtp-Source: ACcGV60Mvg/DFYtA7Ryy88y7Snyqfn8dpdaK4WVSbcVP5J1Gu4yBiX7YfhvkZMcU71otHL7kWqMB7Q==
X-Received: by 2002:a63:2c8a:: with SMTP id s132-v6mr27549215pgs.73.1539145997298;
        Tue, 09 Oct 2018 21:33:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n63-v6sm21171025pfn.9.2018.10.09.21.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:33:16 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] hwmon: Add operating mode support for core and ina3221
Date:   Tue,  9 Oct 2018 21:33:08 -0700
Message-Id: <20181010043310.30873-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add operating mode support in the core and ina3221.

Nicolin Chen (2):
  hwmon: (core) Add hwmon_mode structure and mode sysfs node
  hwmon: (ina3221) Add operating mode support

 Documentation/hwmon/sysfs-interface | 15 +++++
 drivers/hwmon/hwmon.c               | 87 ++++++++++++++++++++++++++---
 drivers/hwmon/ina3221.c             | 64 +++++++++++++++++++++
 include/linux/hwmon.h               | 24 ++++++++
 4 files changed, 183 insertions(+), 7 deletions(-)

-- 
2.17.1

