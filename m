Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C6DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0952081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co8Z6i0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0952081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeKFGKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:10:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:10:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id n11-v6so4994515pfb.6;
        Mon, 05 Nov 2018 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2hAN83NtA82k3ZKtyQ/6UV5vP7+Qs2sTSY0JdZixZco=;
        b=Co8Z6i0D2scjAfvwjle27v+R1cJBL/zno/OT2VkgrvdEwUisxySO4iW6Jg4aOzREaV
         yrwuwiOWH+S7t3RK0HrKrMZQMcLgrhiv7p8r3Tb5Q5t56saCMJkp8ew2bGSgeYnX7VAC
         KqAEqk+l+2XSl4HGlsL5qd3MNOjRMl9k15UIefvueZG+0WWZgT+qxpQekgMsH/R2J82I
         cYv/XPjG1K7eOc2uYqVsKLW3sDg6oJ9PCp3vxe1oOWiQRjW/kK1VF9xfz4sDWgRq3bXZ
         rF7GJgndUZiwjoICi0nxKmmRCPhb76mvitzJouVLRnos4botJ6QMQ53g8wWl1N1Wj7U0
         dGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2hAN83NtA82k3ZKtyQ/6UV5vP7+Qs2sTSY0JdZixZco=;
        b=g3q5RP9Q9Uk3bHlDV7kSlDy1IhMXxobP0buyw4HSPbfNkTIuogh2m1Hvh9AjelQuhS
         8QIttfODygR66L/yI810MDdC/rkKeXJlhJJz/qbkww+dst4qSE9N9ubyR8kYYm+0j2oZ
         9bJ5pqNriLaZznJaAgzxtDW/W3ss/ddtAhLoUCClky3Iz1jSOgPRQNb0vjKFhxfs5ykv
         vuAXMA8oEUML6708AHIhktMaCRsiu0i1b7y6hnQ6647endfnj+ri2FCDbF4X+AOUvAC6
         GmhaY961b0IUfoXbU0XvxMoWNYFoddbVFOmpGhr6PXL6cZB050iTPSPYeBE2sCLYjth3
         kNjw==
X-Gm-Message-State: AGRZ1gJHIxvbhdulqoLIPJd+oBXeixApa93VkwhaMbU3Uo6bpllmfUlH
        p+cKo7den4x8f6YUzGDYiOY=
X-Google-Smtp-Source: AJdET5eMtqgg5oRwLza/7Lb1HWt+vnQWzxbEKT9ixI0cEA/tqhDTL1hw++u+MYn5AVCMGp5XqH0ZgQ==
X-Received: by 2002:a63:d757:: with SMTP id w23-v6mr21074400pgi.415.1541450930346;
        Mon, 05 Nov 2018 12:48:50 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q1sm25569257pgs.14.2018.11.05.12.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:48:49 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] hwmon: (ina3221) Implement PM runtime to save power
Date:   Mon,  5 Nov 2018 12:48:39 -0800
Message-Id: <20181105204843.4081-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches implement PM runtime feature in the ina3221 hwmon
driver (PATCH-4). However, PATCH-[1:3] are required to make sure that
the PM runtime feature would be functional and safe.

Changelog
v4->v5:
 * Dropped the change for hwmon core; Shifted all the patch indexes
 * Used i2c_client dev pointer for pm runtime callbacks (PATCH-4)
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

Nicolin Chen (4):
  hwmon: (ina3221) Check channel status for alarms attribute read
  hwmon: (ina3221) Serialize sysfs ABI accesses
  hwmon: (ina3221) Make sure data is ready before reading
  hwmon: (ina3221) Add PM runtime support

 drivers/hwmon/ina3221.c | 190 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 166 insertions(+), 24 deletions(-)

-- 
2.17.1

