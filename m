Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF5620685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syQrfQTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfAJUxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33575 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbfAJUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so9320610lfc.0;
        Thu, 10 Jan 2019 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eSlKha60Px6UNpdnXSUR6EysfM1BrF6z25Bgwx9Baw=;
        b=syQrfQTQs9KEuxcdxHKh/J8TQDTXYNQXWajawLtDCuKIr8Xs+EQIyINcpDDD4iV39u
         SzHmgdPFUB4u1PNUNNxzgu5aVsa9395Kmnu0LzHLYmnLrXqSBoAAYr219egJf9U5B2gT
         +IQ3lMp7mV3A2A/MpPNNQ3N41WI0k6YWe4nUK7yMiz46ZlnUG/HHCo94+5LQoximT5t7
         h2PcR4B1LETbvc0kKeZ9PHd+7hNqkQPLG4if8pE0yyFjcLHGRGkud8+rH+/Xt5SgszEp
         CcHaa9PIMdWehX18NEhjyqdX2m8ZbSOC0I1DP4U+vm0eCIahbw4/nHPecZCNvi5z/G/n
         +XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eSlKha60Px6UNpdnXSUR6EysfM1BrF6z25Bgwx9Baw=;
        b=Rf3xn7cIAqntXeGTWoXheh+FNTdOyT7hOwhjnWHjjgiTm3rZjG+KbBQnRwLgwmE3iM
         ZszpoFD4zNLlJwUyqMEMTVaoHv9dAwRsvNvZY1qfFmPFkI3XQeeTDoKiHp7CPJbAn+Bp
         N1iTieJHm8FTaP6tIWvSPdvAiNANRl4bEykY15PXXw227cqlay8k3HLPevf7Ayfbf22m
         GhNz62xWf2bHFoSEhamYZipemGeqgbLI7wmy6DYvwVXFyx2Yys4Sw58ON3Oy0Zqcp2pf
         tC4CyyZSnpANMXN+Nk9l5Pq1Jbvl3qoXxcH4ZzQbjl7DKAGeiLEmc1q4lPA6BI1OE1rM
         GP3A==
X-Gm-Message-State: AJcUukdnUvvD6cIf/ib35bmMV09q7+R8yQXkxqdrjNPtC3YggmUrBq7L
        CUAxF7Y4Hso+VEWfGnn5CMY=
X-Google-Smtp-Source: ALg8bN5yVCtk0zO/TczaR04e9HTgOfd/c5nRqiqJXlWlxRa65MMcLq2etLGQG3et7RgZkQjlwp1lIw==
X-Received: by 2002:a19:ef15:: with SMTP id n21mr7162146lfh.21.1547153591755;
        Thu, 10 Jan 2019 12:53:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm15389690lji.42.2019.01.10.12.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:53:10 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/4] ARM: dts: s5pv210: Enable cpufreq support
Date:   Thu, 10 Jan 2019 21:52:11 +0100
Message-Id: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
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

Changes from v1:
  - Added Acked-by to one of patches
  - Fix compilation error after changes in driver
  - Reorganize code (so it's smaller), inside patch which logs information
    about defered probe of regulators

Paweł Chmiel (4):
  ARM: dts: s5pv210: Add dmc nodes
  cpufreq: s5pv210: Don't flood kernel log after cpufreq change
  cpufreq: s5pv210: Defer probe if getting regulators fail
  ARM: defconfig: s5pv210: Add cpufreq support

 arch/arm/boot/dts/s5pv210.dtsi     | 12 +++++++++++
 arch/arm/configs/s5pv210_defconfig |  6 ++++++
 drivers/cpufreq/s5pv210-cpufreq.c  | 34 ++++++++++++++++++------------
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.17.1

