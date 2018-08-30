Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D21C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661E82082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/K1kD6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661E82082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3XIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:08:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36418 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH3XIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:08:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so8147792ljj.3;
        Thu, 30 Aug 2018 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qMQExZ5pfFvwXY1fBHkgqK5Xngk1uYqfFb/4tnV8mgw=;
        b=T/K1kD6hn7cwXC+cjj8j2DdyjEEKfV44E+HkhnisG3O3C5R6hYA0vh5jGz4A/MZ2Mb
         oMONE5o4kDLVksCyGbSwoPUlGhES5j5fqgKJmraaRD4N5R8HXOWu4BJ+oLfpnXbi0Z9K
         YXX5sxGKJUjYa+DxStKUtlXL5uY2v1epVmx98ZV3rKiO0kepY3LfX630Qv1f2pJJJuR/
         rFMdhrk1euU6C9LwmAiM4mHUViJ1TXrv/Eu6IVK+eESfHiFc2S+bPmfQU0OKlPaLw362
         m2IVkgY2gyyOs07lrkQglyplmcKyYJAeeM/V+VXSzigtzsZA37gfSy2U8AEWMmLv+N+O
         bB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qMQExZ5pfFvwXY1fBHkgqK5Xngk1uYqfFb/4tnV8mgw=;
        b=WzERgVMkyHuE1nhLo+SW9OCOa9+z4numJES697a+IVbHyKn8/14Z7yq99fByEBlC0J
         tDmKzwb0ojQd3xD3VfKpyLlvnhk4MLa5mZssSZLRoVV4+wrgwIqIqGH6B6QcBThxsBa1
         7S7WpbFDsclO2AbluD8228MLEKNmXCmxm1H3WgYtJhBlNyGK99zA47KTheeni0d6uRBm
         Sm/7318NIH4WkvkprKbIvSYVtTU1Eq3cowFSQQ25UnYUumFU2qwnqVhkD1HDjQuPhb2W
         XQc7isUp25L52gZGofLgc+3oiXgt9mkHIunDnxl5HnOw9aBR1gpsklX9PzCblGPNKNlj
         7JTg==
X-Gm-Message-State: APzg51CZB0ZoPKp15R50wGM63dP407YDlA9LUCiupDfL8sGzwAcE5Iv6
        hZF+GjSFcyDygCaHBlWb/4Y=
X-Google-Smtp-Source: ANB0VdbmbWqTqem7gDIbT2LS9shwpdYmIermIPQEj31QoN4tAON8wsYsRUzLY1FCCkbczdI5zitlqA==
X-Received: by 2002:a2e:8513:: with SMTP id j19-v6mr8054172lji.10.1535655907333;
        Thu, 30 Aug 2018 12:05:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q128-v6sm1373081ljq.72.2018.08.30.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] LP1/LP2 suspend-resume CPU clock fixes for Tegra30
Date:   Thu, 30 Aug 2018 22:04:52 +0300
Message-Id: <20180830190454.8729-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-series fixes CPU hanging after suspend-resume / LP2 cpuidle
on Tegra30. The bug really appears during stress-testing, like frequent
suspending under variable load + the upcoming Tegra30 CPUFREQ driver.

Dmitry Osipenko (2):
  ARM: tegra: Switch CPU to PLLP before powergating on Tegra30
  ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30

 arch/arm/mach-tegra/sleep-tegra30.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.18.0

