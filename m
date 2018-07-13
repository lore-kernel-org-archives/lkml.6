Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E775A208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="xfqq0hJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E775A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeGMQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:09:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41282 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeGMQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:09:26 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so31738917ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uaT4Ou8Ds511lDR3q+LHM8xEK42mLmUsgMTWDyjAL88=;
        b=xfqq0hJbg5s5tdeKim71D8uKhfhzc09FTQt+tdE0hhqtik2qd4avHowTsAKfm1jdXb
         nviksUsrLfwS3OijTMuMpjfO3ql1Q/l7MKnKEJf1usGz+6ibFZeq/9dRXM7XC+MSs/hX
         IvMjzjotnpx8TbhxZog8Hw7H+rTC2DO66Ypk5yLaIs1OS6N+edDhm1kumfF6ors/a0RA
         pab4I6cNV4X51skkqEOkADe9/FvHEZNwYfdNzf/yrsMQvQ8IUZnFNPuaJmiR9JhtL/Yf
         /fK4lUUUTioxhCNPn0ZyTe4sgcu+OZ17EE8EP3UuA8wcA85nNtb3npfDVw5KnlJAjVBc
         rYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uaT4Ou8Ds511lDR3q+LHM8xEK42mLmUsgMTWDyjAL88=;
        b=ptEXjA9FMD8NschziwXJBiOxOrum2zbTWKbEFOaPf3PunPDKDgEzSZwFf/7bQK/1CK
         WVCkuy03a9LQF24CbS5JjcFNFWrEuQ4ep99FiyKD4VioyxPp0LobQ+2rBUBjdk+CyhCq
         Qmrd04ocC03iMCBXS1XZaV06+wHFkmgs4euO3JheKwj17VZXEuN9e6fGN7GPtnhHaDc7
         Esz2mCphOSfeE7pJkX4PHR5JQMhiY2a/mo98fPNjRaVOwif661Iv5OxJeeezzBeHEAGB
         X1PY/yr9iLXavSQFkU6vSIhkMOpoHtz+NH9JMU98SQJEMWyHVD2ldX1AKzkTPrsG740t
         DqcQ==
X-Gm-Message-State: APt69E2zekIayXQTpJt4kkih+4aoWniF1pUq76z2luwYglSmt9260UXk
        ktmZxHVpoLqhhSEyCGjRHG2I9S9pceE=
X-Google-Smtp-Source: AAOMgpdUej8clNa6mynviESM+SHIr2zBGQwtAFl8YV67lsUf0PEia2EUrbk42aJpVq8L9vazSPirxQ==
X-Received: by 2002:a5e:950d:: with SMTP id r13-v6mr29737567ioj.224.1531497252952;
        Fri, 13 Jul 2018 08:54:12 -0700 (PDT)
Received: from debian.hanksspec.com (ip-98-240-239-173.midwest.us.northamericancoax.com. [173.239.240.98])
        by smtp.googlemail.com with ESMTPSA id r20-v6sm7781066iog.85.2018.07.13.08.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 08:54:11 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     john.stultz@linaro.org, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey960: Remove keep-power-in-suspend property
Date:   Fri, 13 Jul 2018 10:53:48 -0500
Message-Id: <20180713155348.24343-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the keep-power-in-suspend property because it keeps wifi power
on during suspend. This property is only required when enabling WoWLAN
and should only be enabled based on need. Also remove dupplicate property

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 68c5a6c819ae..a927ce4ec40b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -586,7 +586,6 @@
 	ti,non-removable;
 	non-removable;
 	cap-power-off-card;
-	keep-power-in-suspend;
 	#address-cells = <0x1>;
 	#size-cells = <0x0>;
 	status = "ok";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8d477dcbfa58..4588fe4e00a8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1050,7 +1050,6 @@
 			reset-names = "reset";
 			card-detect-delay = <200>;
 			supports-highspeed;
-			keep-power-in-suspend;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio_pmx_func
 				     &sdio_clk_cfg_func
-- 
2.11.0

