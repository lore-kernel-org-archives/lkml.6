Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D7BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B0420685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjrkIM7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfAJUxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40469 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfAJUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so9302703lfe.7;
        Thu, 10 Jan 2019 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
        b=CjrkIM7BBTZSRBJobpknJiZPTJU+pWStblRgDCGvIVSFYmeF8Dnz0JCLPNXYGFBJ2c
         5o+YvOuESHL8dY4RS8c0o1kAfJBaNzYdocDRTiLa/ADvs14oRcmd0AGMp2qJpf0bW0ZE
         trmGj2gXokwcGmxiik/0Y20U1LZIkXI0EvzltO+MVeXJSPKRaeptRxqJ21ZlpWH99ZUv
         f+hRpNmVObSMIbaQHg7ehKLsqrndLkWJSTIPk9n3oNLEx41eZj3qBohamSs6bb5Pi4mL
         ulTRXpuIQ/fJBwFMyutuCklpBALlN3FbTiUwRPH92EX0T6WTNAWuYzLtrJoTL/EPYC5M
         xP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
        b=RoZd1W1Q94T8AckG9rhR7HNtINi199VbRKRT/h0jjH5TV6sxmPiaeWUapJwkb/mafP
         ds009RiX2Halj3Hi9EtWAq0tA3CXejFr7L1qwLtNRE/6KVAILe1PIqm7Ri2IRU/AqOeS
         Nd4HTh2KHRMT8pJimlviqn0fLC6L2FMWtxR9Lfn5KI/6qaAKmlIthbQt2TmSdje9Vz3F
         R22SodNVW0ZhSpT87rP67VqjsGmuUMP89WE0n4i4oFdvVCTx06D+wEmHw0pKHBYf88cc
         e0sNYtDmfq3eq0d6Rko4PwTf1zToOaJmOXdYB5a4P+N86j+p1uPFFww4tm8LNpFiKsvw
         18IA==
X-Gm-Message-State: AJcUukdvKJ1O70YHG8IRwVXO2rjh93yqN0g2kT/5ICAohCCSadtvdVZf
        bSGJDt42C9o8/4pTqA28fTw=
X-Google-Smtp-Source: ALg8bN7adZ008RPmP0J1BWFEJu9/vRj31EhA6mkS1SlBCjLbIJYaMRKGnl7f69G+9tJtXMhStxu3Mw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr6402487lfe.154.1547153598199;
        Thu, 10 Jan 2019 12:53:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm15389690lji.42.2019.01.10.12.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:53:17 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date:   Thu, 10 Jan 2019 21:52:15 +0100
Message-Id: <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables cpufreq support for all s5pv210 devices.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 951196bdf008..fd4f28aabda6 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -11,6 +11,12 @@ CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=m
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_MODULES=y
-- 
2.17.1

