Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABDFC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUwDaKCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfAUHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43331 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfAUHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so9719702pfk.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6WlxeoSKVFFBkHDj3lScI9geCz61A1AgW89x8UulvdA=;
        b=LUwDaKCUmKjjiIyUs6G9kZ1ZpG+8kQ3ed+bCoxk63xAzuRooDWKS1hieVIrjUwSiE5
         6za1wJ1q/J9vBgmesSYwqujTLF4V1dc/g3W607ZJnd/vcboiv5g3mJYr0V1R+yZNjOuR
         ZJh5HZhEd+MnPGYtWjxzXQwLdeA/UinPzudDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6WlxeoSKVFFBkHDj3lScI9geCz61A1AgW89x8UulvdA=;
        b=QaAiK9UAdc6BxYAWAD7lyx1u6dJGKpDmZd6jg4ko+efCjRlHzF9guUSaNPyb9xv6+k
         SY9UwdoABFkpYRSs3l/hpEpy+yegXsp5E+7EvKcKuuxivrCxqtWhDJnsLXt+TUmjbzNc
         NOyuSGIok77o9pJ4fD3ffO9daq6/weeMHaBFRJXduePGT2jwHhyAi9+uzh1a9hcnZg4u
         vf5YMF5HRtk1bQe22jgrNahxn+jLuw0wfJ5kh9rTRJf+HTjQVM+cpi5sG8CLbTdHRrqg
         s0Zlwp1YPFtRERfhqA0WKTtYfWtcir0xN1b5e1S6yUUUMh8O0FkvDcNZ1EKEuBIGFIQm
         0Myg==
X-Gm-Message-State: AJcUukeJ/OfJW/jO2zh/lF7PBtMCmreQ7pBt3soKgkrW6FeomgYJP8XR
        UT72Gp/HeXJjqHmbvXF0edSwLQ==
X-Google-Smtp-Source: ALg8bN7Hu+DMTpD1RJaUxBUdZkhOmOXSV/o5AKed3WkgkLUbNpkk4mn5gU1VKuOI0UFP7D/rSZvAqw==
X-Received: by 2002:a63:d655:: with SMTP id d21mr27202902pgj.280.1548056364748;
        Sun, 20 Jan 2019 23:39:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 23:39:24 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Date:   Mon, 21 Jan 2019 15:38:27 +0800
Message-Id: <cover.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds charger and fuel gauge device nodes for Spreadtrum
SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
devices and adds nvmem cells for ADC to calibrate the ADC channel scales.

Baolin Wang (4):
  arm64: dts: sprd: Remove PMIC INTC irq trigger type
  arm64: dts: sprd: Add ADC calibration support
  arm64: dts: sprd: Add SC2731 charger device
  arm64: dts: sprd: Add SC27XX fuel gauge device

 arch/arm64/boot/dts/sprd/sc2731.dtsi      |   42 ++++++++++++++++++++++++++---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 +++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

-- 
1.7.9.5

