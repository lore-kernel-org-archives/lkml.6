Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E89ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363BD208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfxqxdGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363BD208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeGNGQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44479 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeGNGQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so5658819pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Y0Eor/8QT/wLbu75TJa8qgXzgMPAt14BJ4HIE9yb3Q=;
        b=GfxqxdGOtVe21S/DMA/OPmgpAnvromQAtN0mqZtuhFIYy//OQxuohDmUCiXhWKHoSd
         eKkf1sAdl/aK0pB1TFIWHLn+bL7Eic55FmuxCLhEWmfF8reA7t5Kbdt3kYlUMh3Rde4B
         7Xb1rIkiuOmq5ZvygT2RnvlAiNlhwbg9v8QzUiZChiqT9YnBdUeyRkutfmVt97eVd39K
         N21vd2GYykWgGYYiojg4d6Et0bmaAHoPwOqJZTWb0nlSxbN4yWnBro5sn+D0KqI+SMJT
         8k5utvJufyZedfHztukgmOJ5ZsTbSjKvpTTogNGKAP1nI4GhDefCoIUzcWR9pksBYr5j
         LfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Y0Eor/8QT/wLbu75TJa8qgXzgMPAt14BJ4HIE9yb3Q=;
        b=OYi3GJripnEyivH8uKTsja5oNrPVXj6cI2FXbh8nUuCljid1/oILzi3Tbd7Uid5+E0
         4POh0SqxwE7QOW7Dq8dMBwIImPzmjOwWkt0bcl+8gsYYuTsyCxWb3JofaVHHgxdG0nBT
         TELNd4sWvI9QJUo7CR+lV1nFuCaCXxcakQMe4KnE51YQ0Y0kWcFLi2ubWcCkc6YtPmaA
         Cw5Mgoi7AUEHElRUVKAT67SWboYs2CLQpGr4Y/OHaNi5+QrMXXGPDhKSEIvTyjyU8ZD2
         wtEaT+h9NmtDyVr4EHiKTpVjvbG92gQK2Bkd2gmBnlai1IM1p32BR1DqmhTvSAQxMRrB
         n+Kw==
X-Gm-Message-State: AOUpUlH3Yfk3weposLd9FaUMuMgxIwpJEe8SyU9nqx7n9D1D/vYTl9Dt
        mcVsX2KYa8rqpwyDA2IWeV8=
X-Google-Smtp-Source: AAOMgpcSbklLZXVr+HidUN88Bam3FU4bSGjqNp1OsO17CZVbCfNR67JKdD1CGMq+LyPP8aS8MS1b2Q==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr8529740pgb.452.1531547924690;
        Fri, 13 Jul 2018 22:58:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:44 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/18] staging: gasket: sundry fixes and fixups
Date:   Fri, 13 Jul 2018 22:57:58 -0700
Message-Id: <20180714055816.223754-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixes mainly from the chromium review of the gasket and apex
drivers.  More to come.

Various (18):
  staging: gasket: remove X86 Kconfig restriction
  MAINTAINERS: Add maintainer for drivers/staging/gasket
  staging: gasket: typo and whitespace cleanups
  staging: gasket: device registration error and unregister fixups
  staging: gasket: sysfs mapping creation fixups
  staging: gasket: fix deadlock in pci driver unregister path
  staging: gasket: convert gasket_mmap_has_permissions to bool return
  staging: gasket: gasket_wait_with_reschedule fixups
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: gasket_open use container_of()
  staging: gasket: always allow root open for write
  staging: gasket: annotate ioctl arg with __user
  staging: gasket: gasket_enable_dev fixups
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: gasket core error handling fixups
  staging: gasket: don't release coherent mappings
  staging: gasket: various cleanups

 MAINTAINERS                                |   1 +
 drivers/staging/gasket/Kconfig             |   2 +-
 drivers/staging/gasket/apex.h              |   7 +-
 drivers/staging/gasket/apex_driver.c       |  79 +++++++--------
 drivers/staging/gasket/gasket_core.c       | 107 ++++++++++-----------
 drivers/staging/gasket/gasket_core.h       |  11 ++-
 drivers/staging/gasket/gasket_ioctl.c      | 100 ++++++++++---------
 drivers/staging/gasket/gasket_ioctl.h      |   4 +-
 drivers/staging/gasket/gasket_page_table.c |  69 +++++++------
 drivers/staging/gasket/gasket_page_table.h |   8 +-
 drivers/staging/gasket/gasket_sysfs.c      |   4 +-
 11 files changed, 198 insertions(+), 194 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

