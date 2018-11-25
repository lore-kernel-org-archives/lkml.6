Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF41C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC29F20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bed5rzPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC29F20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeKZKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:39:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42136 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:39:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so5634648pfr.9;
        Sun, 25 Nov 2018 15:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=119WCIjD/9PeWkiZt1Gu4+OimZm1Q9WqFbU+PsTKo+I=;
        b=Bed5rzPmz6eybEMdOynkJks6JWpyNI6U2AWnXQkdH7OPCA+uZMngIGdRrghphoD3r8
         VENk7PG9Wx6AQb1TH2047uFRj9RvH3woqMcOLd8ViOsy3Z7hu4GvB1JVOqvqozd2c3g5
         ZwOGOfNGUopSWxTP81uRS/thtjvKFbF5e9wtkcQbQ+4uFcDnouwO8HAnz/5GS759VkL9
         3TJ4XikgtqM1cvDyjO58qSNluSlo8vLbgz0qzvRHmqQ2Bixx09El2TCOtskHQeI7lJW2
         sjCIyMRm5fIgIK1C3GeAzGK3kcZWgLCI7bgbOl+Lbg6ogAbx6ceKaQ0mQJPINS30bjmV
         XC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=119WCIjD/9PeWkiZt1Gu4+OimZm1Q9WqFbU+PsTKo+I=;
        b=tuNHVf3y4I1j1b1WBoZovrujjH0SPIo/TBa1YlC2fLULV6RwF8o6iIAapj3egjdnAZ
         jRPEicIIrp8ATe5YzsOLS7/4t70+dsZNMIk6NvTzqvIMH5Kf+a191KqKszL1eXh0RDH7
         6RZlnOoG1694C8FUQduk5mBrW3R4n1atrTPMjpB/E+NfkdlMD6cvHr2N8Lak96yIrTIW
         uJ8dD7dHkLxXy+m2TsghP5Aa1XHYcGgTsbeXs0JfOB74RyT+Gawle6fu6BE7FQTc6HvT
         4M5I4oCoARhqGv9HnJ77iyDMXeaNEi9KaytE/5YDZ+Q72m/m/Zjs8zsR7SX3/K9U21hG
         t6KQ==
X-Gm-Message-State: AA+aEWZ/re3FdyocneVli4AUOnwsFA/LVRF20Bk+kAlbI1gQ+H6qIVJ8
        BpjsYzddCoZdb2+Coq5y6ug=
X-Google-Smtp-Source: AFSGD/WULMYGgN8Fy6knvi6ImyzOR7FdwpjnK+ACRVwvDZl9R7GnTvHQCFk2X///gbN5+myDY0Vcxg==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr21823183pgk.21.1543189632823;
        Sun, 25 Nov 2018 15:47:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm48789867pgk.18.2018.11.25.15.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 15:47:11 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.20-rc5
Date:   Sun, 25 Nov 2018 15:47:10 -0800
Message-Id: <1543189630-5306-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.20-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v4.20-rc5

Thanks,
Guenter
------

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v4.20-rc5

for you to fetch changes up to 09aaf6813cfca4c18034fda7a43e68763f34abb1:

  hwmon: (w83795) temp4_type has writable permission (2018-11-18 14:34:56 -0800)

----------------------------------------------------------------
hwmon fixes for v4.20-rc5

Fix temp4_type attribute permissions in w83795 driver
Fix tacho fault detection in mlxreg-fan driver
Fix current value calculations in ina2xx driver
Fix initial notification/warning in raspberrypi driver
Fix a NULL pointer access in ina2xx

----------------------------------------------------------------
Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Nicolin Chen (2):
      hwmon (ina2xx) Fix NULL id pointer in probe()
      hwmon: (ina2xx) Fix current value calculation

Stefan Wahren (1):
      hwmon: (raspberrypi) Fix initial notify

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Fix macros for tacho fault reading

 drivers/hwmon/ina2xx.c            | 6 +++---
 drivers/hwmon/mlxreg-fan.c        | 2 +-
 drivers/hwmon/raspberrypi-hwmon.c | 6 ------
 drivers/hwmon/w83795.c            | 2 +-
 4 files changed, 5 insertions(+), 11 deletions(-)
