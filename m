Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E0ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CCD2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPbPqCDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CCD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYEDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:03:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJYEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:03:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so2927265pfe.6;
        Wed, 24 Oct 2018 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TyAItt7B89hqOiKcSGQWElDSW87SzMYqvzXcYlna0tk=;
        b=tPbPqCDOHk0VEZh+B4xohBcmribIHioUNZbff4mWhMHFNplj12GXAK8IjJE3PoVVbN
         DUAFAcHo+TzlteT2iZn0OqelOlBT1PFHXWdIWaxlS23xFD7CJjMrbTr3Z52/36LrYoK+
         1ww6vOAfpM9eXc2Y7DHavJTYje4sZOK4OGVpr2mAxqe5uwhUpEpTqidE1Gdz71T9WEkT
         x5twxBrWxwJ2VrEcChjCfxHBe2oQe1RbCA/fxUabq71m9qXo3IQDGoZpxO60Ia2MWP4Q
         YwRLvHHeDeGmPbiXOz0lhixC7rC9UCwakh0ZamyPwhogJRNLQ9OUaCf6kmGUJcmq5iQF
         kD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TyAItt7B89hqOiKcSGQWElDSW87SzMYqvzXcYlna0tk=;
        b=E27R57J0nVR+klQ9zvmR0QLc18W5miLzfjYPp5UoFe1WAuRV3YR40h4N4a+9OPXREV
         vvQrKU35TTHLle647jDPiK7nFBbfrP02TNQa3RxFIRt5iWnx5tntY96sX6N2PUWccJ3Z
         OOguhF6Ax/gZooY72YmxmqP4KGMe7CdhKxGeaKdkG7eLHO4Bu1bliM+Ma1xP2GG/U56P
         TstwE6ccVjccSllNgBASolAwTimkZNuDXwiR6dRv/DYEpcgI35CN+trc3rl5BPzlAynO
         1mu0NSe5c0dasN3di0t/JlI7I7ictwY1pFwJ7h0JX97hWwHzcIN+yUFI2qJTgzP2LV7H
         U27g==
X-Gm-Message-State: AGRZ1gIQ+65qiRT2TDGrbWvamhkRurbrTTSA/q9NqPqYi/QGaeGXIg+R
        s4Kj79t5beRrUD7/kEeEYnvzp9cY
X-Google-Smtp-Source: AJdET5cYTZnvZWwl5lXnRLjs56uZijWsjOThd5N5spLEBl1bbELbZHN8ZPL7UT93t4/2IeLTzX8Qew==
X-Received: by 2002:a63:af18:: with SMTP id w24mr3732644pge.385.1540409655485;
        Wed, 24 Oct 2018 12:34:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r81-v6sm19921633pfa.110.2018.10.24.12.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:34:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] hwmon: (ina3221) Implement PM runtime to save power
Date:   Wed, 24 Oct 2018 12:33:57 -0700
Message-Id: <20181024193402.16698-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches implement PM runtime feature in the ina3221 hwmon
driver (PATCH-5). However, PATCH-[1:4] are required to make sure that
the PM runtime feature would be functional and safe.

Changelog
v2->v3:
 * Dropped timeout dev_err messages as it's indicated in errno (PATCH-4)
 * Improved a dev_err message and comments (PATCH-5)
v1->v2:
 * Added device pointer check (PATCH-1)
 * Returned 0 for alert flags (PATCH-2)
 * Moved CVRF polling to data read routine (PATCH-4)
 * Bypassed i2c_client->dev in suspend/resume() (PATCH-5)

Nicolin Chen (5):
  hwmon: (core) Inherit power properties to hdev
  hwmon: (ina3221) Check channel status for alarms attribute read
  hwmon: (ina3221) Serialize sysfs ABI accesses
  hwmon: (ina3221) Make sure data is ready before reading
  hwmon: (ina3221) Add PM runtime support

 drivers/hwmon/hwmon.c   |   7 +-
 drivers/hwmon/ina3221.c | 210 ++++++++++++++++++++++++++++++++++------
 2 files changed, 189 insertions(+), 28 deletions(-)

-- 
2.17.1

