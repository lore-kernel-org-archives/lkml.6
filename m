Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70904C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EA120869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLn/H9se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBBPSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44533 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfBBPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so7218474lfe.11;
        Sat, 02 Feb 2019 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zU6qJbQ1yRRs4N6oEV/GuuNWZd0xvEPR+ZR61MkeGc=;
        b=pLn/H9sepD7Rty6f2nCcGW0ZuCfVINA4b5HrA2bYOesHKg2j5VA0FM4g9MrVil/YHk
         SF037+4dR/OixMkERC2MhxGOmXJ5n6c77g6mIVAIqMZFWT44aRAq9xFgyvQWOdPKhxQo
         GlWtqFw7d6TsMHy35TYOrxWEBOuXKs0wKaMBNTmcfR6DuT6OaqhDyYyqFJ+V5SJ5XujM
         UuDWT9aFLr3sol+ivsjDcTVAKj0fyqq+5ET+asXH9rQFZ2Sl4w5M3AkO7c/w8uTrBkDk
         G46E2juV/oV8JBek17EKKL6Tx6CNC1CPXrjGn2MrmZdqsABFr2xLPUz22Q/5eO48qbgJ
         MVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zU6qJbQ1yRRs4N6oEV/GuuNWZd0xvEPR+ZR61MkeGc=;
        b=M+5ebzuOjk3Jxocs0VnfdCaESyIAaEPWbQdRZD8lNqU4VMQ1io2vCXFOddIM5K1CNM
         ovcTMd/na0ZHwH6A2nwud0DH80ZExjiusRqQo0FrsKUWYqs70VGW9Uih1tItqIBI8XgV
         Zu8WW9mRjpj7KHvvN57QNSHzbvbx1FDhKs1EnK4oh1JWfd+ghS09pEGGw/NkSSpQUTKX
         5ynN5ymjVGELySRkJhJvtYTL9WVp5yjfppqF/a60eeS4pFLAIqAf0oNE50vklH4Ji8l7
         e+YxWUylGKMv5lXS+aCPYqlwo6jmAXyMv72fvEVS2i32rWpFGla4lmYCtCmxD+njVD+b
         nFpg==
X-Gm-Message-State: AJcUukfuOz3x1OYeTCORccrzkVwdcwvShqofZIWHSDKke+xBht0Wz7l3
        cf2DOr3SmLJ9+CB4Qc6g1CCQ9uUT
X-Google-Smtp-Source: ALg8bN67lzKODoI/C1kBTjEx/nxuVwwLWcuundteCk2niMnJQNRf0/AaCPNgMjsjJ+Lm/VDHEeqjUQ==
X-Received: by 2002:a19:c954:: with SMTP id z81mr34691012lff.150.1549120690251;
        Sat, 02 Feb 2019 07:18:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:09 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] input: misc: bma150: Add support for device tree
Date:   Sat,  2 Feb 2019 16:18:01 +0100
Message-Id: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset adds support for device tree to Bosch BMA150 Accelerometer
Sensor driver.

It was tested on s5pv210-galaxys and s5pv210-fascinate4g.

Changes from v1:
  - Correct devm input unregistering
  - Correct IRQ type in DT documentation
  - Add DT properties for bma150_cfg and document
  - Add patch removing pdata
  - Fix race condition in input device registering

Jonathan Bakker (5):
  dt-bindings: input: Add binding for bma150 sensor
  input: misc: bma150: Use managed resources helpers
  input: misc: bma150: Add support for device tree
  input: misc: bma150: Drop platform data
  input: misc: bma150: Register input device after setting private data

 .../bindings/input/bosch,bma150.txt           |  38 ++++++
 drivers/input/misc/bma150.c                   | 128 ++++++++++--------
 include/dt-bindings/input/bma150.h            |  22 +++
 include/linux/bma150.h                        |  38 ++----
 4 files changed, 144 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
 create mode 100644 include/dt-bindings/input/bma150.h

-- 
2.17.1

