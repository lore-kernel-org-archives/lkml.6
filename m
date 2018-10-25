Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klshA9Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DA52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJZI0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:26:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45782 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeJZI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:26:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id s3-v6so4749627pga.12;
        Thu, 25 Oct 2018 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q3ME8CNrSG6RJBB/1rleEDm56ypRs2JFhCSnxNmfSUs=;
        b=klshA9ObXkjEt4gDhlgcLpTdGKfZXIMQFTMADWL5Z0h1eolFJDn03vtl9jH2MfEYxO
         /nL7emLahZgLZlbO5LM2Nt8Ip4JkQGc8WCGnZLdOvmRSPU/yYaSFzbIPYbZKt1jzd0qQ
         1UEuX5CkXqeZAMg+wwXanh3kCArXdSKpRWMD3GkNUvwjfSnSvIBCxFot/fmpHw1rFeC5
         yccXAtnPF2nUlW9TayyfAUk7z2HI8Vl/to/7QhuRfpxAcU4/vaXwxClj0T1A9vfbsHCC
         bug23lXSbUGUhthZLzoUcjm/0NRnxdNvCKUWNPreic2Gock1mABKwFhpBth5cDqvrNX4
         WGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q3ME8CNrSG6RJBB/1rleEDm56ypRs2JFhCSnxNmfSUs=;
        b=kYqA+tigqCuNCduBPBE2AM0/Mot0BUYNYrYqKwINHfs7Alei3e+i1uLjCWW/MViPV6
         pAGFRQDZRocsycZX6L8tslzEnZUjmqiBULvRE6mUEPC1SObBqFojMZ7qSqBwndcdL9Vd
         /pz+RGQROW0JYaejh92tFDo3rPa1IOYZo+GDIefpE77Oj/4Lo5vEcX628VXIETkhZphE
         4zq+qvlE1rV2WyALtR5ZC9Fvj4pbpAMjrweDnwMruSzTmC2Ot1Qj4TCKN0LN7Caw3zlj
         2srfJhlrcHBuUXSiB/vjcmkU5KwnYIdIjgquyoX/v6t4WgvOEkGVUDPRxlYGNnbRf7jS
         i57Q==
X-Gm-Message-State: AGRZ1gKB+87LpqGDe7G6gC07Q+6J42FQe2UaQ8ceoeQMLUZbPJLSu1lk
        RVPQh5Wxnm33oPzxSjFRxxw=
X-Google-Smtp-Source: AJdET5ffgtleCUInrVEqyvz3ILbs+SZrS4OyfadEd5Np1C89o/hQMjwJ59G0iscEIoakofhnkGtYmQ==
X-Received: by 2002:a62:6bc9:: with SMTP id g192-v6mr1230592pfc.232.1540511488652;
        Thu, 25 Oct 2018 16:51:28 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e189-v6sm10453806pfa.91.2018.10.25.16.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:51:27 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] hwmon: (ina3221) Implement PM runtime to save power
Date:   Thu, 25 Oct 2018 16:51:17 -0700
Message-Id: <20181025235122.3240-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches implement PM runtime feature in the ina3221 hwmon
driver (PATCH-5). However, PATCH-[1:4] are required to make sure that
the PM runtime feature would be functional and safe.

Changelog
v3->v4:
 * Added generic pm runtime functions to hwmon class (PATCH-1)
 * Updated to pass pm pointer via _with_info API (PATCH-5)
v2->v3:
 * Dropped timeout dev_err messages as it's indicated in errno (PATCH-4)
 * Improved a dev_err message and comments (PATCH-5)
v1->v2:
 * Added device pointer check (PATCH-1)
 * Returned 0 for alert flags (PATCH-2)
 * Moved CVRF polling to data read routine (PATCH-4)
 * Bypassed i2c_client->dev in suspend/resume() (PATCH-5)

Nicolin Chen (5):
  hwmon: (core) Add pm_runtime to hwmon class
  hwmon: (ina3221) Check channel status for alarms attribute read
  hwmon: (ina3221) Serialize sysfs ABI accesses
  hwmon: (ina3221) Make sure data is ready before reading
  hwmon: (ina3221) Add PM runtime support

 drivers/hwmon/hwmon.c   |  24 ++++
 drivers/hwmon/ina3221.c | 290 ++++++++++++++++++++++++++++++----------
 include/linux/hwmon.h   |   2 +
 3 files changed, 245 insertions(+), 71 deletions(-)

-- 
2.17.1

