Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C007BC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129120883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1R4WoIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfAHUFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43573 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbfAHUFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so4483094lji.10;
        Tue, 08 Jan 2019 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
        b=u1R4WoItDbfO6hhHhsjLfP7o7pC7bq+5OE70Y3mc1vKCha4OdZYEpjXJbUWrFatenH
         UjWL1dq+TwAHuGoV/VfZsUS0FxaaxBF9Jd7FBdNhzHdaCW2eq5mMLIX4l6gg6Rl+Sh8n
         r3ddpAJ6TfFOgFx4b1LCe7n865Kcq+OwAkT9th8YQvGABZE5xkaele7YBs1TT7tLA4SI
         tRJFICpi6FTtvxju9xECpA9+ozkfkwf9Sa7sU/RV+ylrCeq7PeQwR5sx8g/bkvToaO9P
         8dbGPJNYtBuPgLm3bPxbvktiN9cmmod3WfQGBgmlhTUWDhOsUuLJaInMy4Q10c7shjAX
         J4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjuAmgjHlhPWg7vZv/M0TlOMAshH0WF7o8w6mNSkFXw=;
        b=W8jz+z1FU+pQmOZsPm1WhRXwNuAvK4By+5vh0O/Wtgp8GsvYTn6WAAGy6Lbf7uLgtP
         dC8erHffmXvm54fvjmhQU3gxWkjZQr/mKSuZ9F437KUa/mcVGezm8MTh8OEf4kUqbnZC
         5iNemEbtblTmC713kImbrd9yKkDWGvSENsSgUvgnQ2I6l23QRI49NzixC31sA6EruUmW
         SfzZNayuxAGnM1wLcDZVGGcLWVEqUMbnEdRlmG8hdhY0BrVqy0HChfhm3Mz1dGC6PrgH
         q+UXsrEDqLwqRu01Zfgil5LScNI5SLPHn77CvVuoSt1reTrgNY5Fd1MzDsu1nqU+2EhO
         PJPw==
X-Gm-Message-State: AJcUukfQHjmnqEXG/Rzfeo2kL8RLRByvAmCjTUMC2MxHCIo8sN3D9aPe
        I1P1pTo9xVAtGFQzJTfKyzE=
X-Google-Smtp-Source: ALg8bN5pT46pkrxZpK7o+mLATemc0Niur+ce7kuw8r+G1YGgUn7ukO1fkhqYJIVugFOyvbwxKsnDoQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr1826784lja.58.1546977927995;
        Tue, 08 Jan 2019 12:05:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id y23-v6sm14486768ljk.95.2019.01.08.12.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:05:27 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date:   Tue,  8 Jan 2019 21:05:09 +0100
Message-Id: <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
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

