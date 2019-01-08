Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAEC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiw5KuHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfAHUF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45262 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfAHUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so3870745lfa.12;
        Tue, 08 Jan 2019 12:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJBrkvQYfWOzoaWTTYjdTw7rzq10zKkZT5MK8UrU/IU=;
        b=fiw5KuHKyyeVAPm/A/5GyeW05jMOybQc/EdvDw9m69+fnmlovM8+iDvQHB9z+Z8Kqb
         ROYNY6gPBpcagApXBd8S21nHUStCJGUSaMJOUUQXx5YMXDe7C/uAy9wFaUbcwuor27og
         QzrbJqJ3WS3IoH+3ixfJL7djeO1iHD7J+o46oTrwpKLCzI4cyhrhgI+Ls/D6gwGda2km
         ni3ImA0Zj0aV65QywyGohA3FbID9T/5WEijK4roR09J81XUW6KLRWcLxbd6cDkCyr1FN
         Waw5nMb7Sal35izZZBRMJOKuUb2NYBO6IBJsFZoILfXVdwHiV969v+FQeVDmZ0/6/Fi0
         IQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJBrkvQYfWOzoaWTTYjdTw7rzq10zKkZT5MK8UrU/IU=;
        b=XGOIu8BDyZJsTdd941TLqf0ElRw4g1uKQWSBZlfiqdDQ0awuFaCnQNZ6cyzMCVWqqv
         UNSCfLDq46LwK8baT0tBnJSkEEjckyI4r+FI6Jwi4zwIrcv8sjsqox7ps8Ua6OK7iAWO
         XSdUbIucLttQl410x2mvnf+I07UlqvLz+oTW/3dgDm9atMKgzzYjmv/xQbuJmWPlvy5e
         xUEnT70n4zW5IfbyGuTrBOqvsHmH9Py5qJo7DhkLoxGqhSJj95MCCDR0tbS473yVfRfp
         z+gBkYinYVKvMoYsjgDyEEBBlWj9sD/EFm+4mOoi35JiWf5amgkqKYJix/rwAA4+kDzq
         x2ww==
X-Gm-Message-State: AJcUukdLOvEN/i07gFHKncsSicosk8Zj36KA+1NXyzO5+ctAx67bQSVX
        TOiNdo0G4LlhURTXOS/1tMQ=
X-Google-Smtp-Source: ALg8bN5syWz6qOlfHuQJsIssj/34FsoXEDQ+ynEG9KcCWM4a6yhNGwBXde77cF54JsBiC8KQYpHfbA==
X-Received: by 2002:a19:5394:: with SMTP id h20mr1909869lfl.75.1546977921665;
        Tue, 08 Jan 2019 12:05:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id y23-v6sm14486768ljk.95.2019.01.08.12.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:05:20 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date:   Tue,  8 Jan 2019 21:05:05 +0100
Message-Id: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables cpufreq support using s5pv210-cpufreq driver.

First patch adds missing dmc nodes, which are required by driver.

Second patch is cosmetic, it stops driver from flooding kernel log with
 messages, after every change of freq.

Third patch adds defer probe support for regulators, needed by driver.
It was observed, that those regulators can be no yet initialized, when
 driver is probed, so we should wait till we can get them.

Last patch enables required kernel config options.

Paweł Chmiel (4):
  ARM: dts: s5pv210: Add dmc nodes
  cpufreq: s5pv210: Don't flood kernel log after cpufreq change
  cpufreq: s5pv210: Defer probe if getting regulators fail
  ARM: defconfig: s5pv210: Add cpufreq support

 arch/arm/boot/dts/s5pv210.dtsi     | 12 ++++++++++
 arch/arm/configs/s5pv210_defconfig |  6 +++++
 drivers/cpufreq/s5pv210-cpufreq.c  | 35 ++++++++++++++++++------------
 3 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.17.1

