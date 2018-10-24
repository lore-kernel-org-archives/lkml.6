Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A334C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F75C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDGRzAcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeJXLbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:31:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:31:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so1603072pgs.11;
        Tue, 23 Oct 2018 20:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SRpE5e4gtZrq4V5FQ4g7zY8CczGppgihLevewyb5A/Y=;
        b=HDGRzAcfJl4X4WJQqKBaXJKEUhFMyRiH80AUL6fElifAOOjlFTS/vObdA3dSgsyzBW
         CkA03AJp/DMSboJvMgMNAK0GGFwEd1Bj//ObW7bh9a+c/usdpjL0ZLKlSjB3i7jXaprk
         amcUJUL2s8C0nHucMFRrvp+U3Vj9fR6fx+QBj8CH2Vj1CTWGQoKKwRZXSjWb2LMBm7vt
         0zlRkLegoG3dSYqcqCrdDmJHlhbPzQkNbAhgsyzNFHGe6PsZONPLUv+8KvhqI1+w0rs6
         NkwKjK/Ht4uwb/giNGZCdoqqJDCEhNHqxQU5fr46SuXe37IaEnno+IFse1kts9CsPpUe
         ISyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SRpE5e4gtZrq4V5FQ4g7zY8CczGppgihLevewyb5A/Y=;
        b=RaOXlxR8jn0ZgIvm31g/RBDQDSAthI9PeGqWtbxS2+hXzQkBdLBZWNjbUfU+Tw8XYN
         uu7TPko9SmGT2+eONYYvd5MC/9ctk7N7uoK/DwtCu4Uz8uLub4lyV6i4vmR8LYRKDNJD
         Hlj2wkl10hAoDlSTYuZu7I7ckC65grCi0WnneoEywxaUWt+wc+5yLdIt8o/sVyepFKQN
         aGGHtXMz50KYdvAnVBdleMIG6Ezn8+hb5c4jE9XWHb0DGd8/1XN25Ze4DDUSagcIcqo2
         62Hqu+HlHcNFE+1R0M6oPggAAWimij5HS8mNu2lKqlGvrHSveHVMBqyrSjs+KlvkChoQ
         Bw1g==
X-Gm-Message-State: AGRZ1gJOAs7p4PQHg5i4Ljn2cqBUb2lkQP1Pl99LB3NUNaOCb21n1EIK
        OQvg7NQj9ptjxT61rzONx5AQEyge
X-Google-Smtp-Source: AJdET5cYwJz3C8gHriPKnzFXYgXOdkS8faA2zO5ihyqmrpg6a+XqljjqwM8P83ErUW/Aq9zI6mG/hw==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr801826pgn.162.1540348589107;
        Tue, 23 Oct 2018 19:36:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3606625pfj.84.2018.10.23.19.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 19:36:28 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] hwmon: (ina3221) Implement PM runtime to save power
Date:   Tue, 23 Oct 2018 19:36:18 -0700
Message-Id: <20181024023623.4231-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches implement PM runtime feature in the ina3221 hwmon
driver (PATCH-5). However, PATCH-[1:4] are required to make sure that
the PM runtime feature would be functional and safe.

Changelog
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
 drivers/hwmon/ina3221.c | 213 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 192 insertions(+), 28 deletions(-)

-- 
2.17.1

