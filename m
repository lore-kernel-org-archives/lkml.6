Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F5B25F72
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKj2tmxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F5B25F72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeFZXU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:20:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43898 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbeFZXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:20:54 -0400
Received: by mail-qk0-f195.google.com with SMTP id z74-v6so72134qkb.10;
        Tue, 26 Jun 2018 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qvRe9AwcdYF7BhqLa9amMQwq21YMKKWccS+dwMY6bbs=;
        b=LKj2tmxdJvuKVS+KImkVc6wBE3lRsfk6YRt4qS9r9GMAp/VJZKFRMc2IUw7osy9r+l
         YfgFxdjCUR3/HbaXNZ/rE5UGHzSLr6przR8I8QQe98VhFJ9jS/6LI70ZH/6WODu00QAs
         UNPwNs2/o6m+tcq6KQRZh/SsgXSfjngfdhrOiWWKCKXMkoc8neBaao6OIZtAAhbey5Rh
         mq4VOuR6hyZsFSPLigc/DrBM9RbyLzjs49Cr1qjcrLPo24PqTyUNm0itZJAlwn1jzx/h
         nTtSJ5uJHpt4A3lkvN+kutDvGbgcCLVjO0mc/G3uuwrRVRy4ChM6+inkTPh+1Aj0n1Zz
         OYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qvRe9AwcdYF7BhqLa9amMQwq21YMKKWccS+dwMY6bbs=;
        b=aVVRFtCochfSfiW8z2PsXPn2tSzVN3W7f/FY5NhTK1BoOp9mUjZC9+MGqYvZHN5ovn
         n15BgqdwGeo/J10vakdLphQQzAEo4hWJZ+0Gp2j1L1FAeYJ5ZWeQeOoHudqwMFRJq7B4
         pmWLu7igvD2uatf7Kox1BLDWesS+/EZ2K560WaCwPVmvM+5wvwBhXhYSn/vk/l1WYXwx
         pvJcSB6uZWDvkxQbzRPVb3RxrU3Mg67zUNTps+2Cf8enSICMIhYnlG8SMLvbaF+bNlCS
         4EcXX0rNKxcmDt57dB1OntN0rjPx4s2wLSCB3LflSL3qurB2jPLR+y/9zwyjcL/Bwkkd
         WdRA==
X-Gm-Message-State: APt69E2j31Z+f0gliCqw/8lZ1RLsrwVKejdU7cne6UThImbQca3moSKR
        qLSsJAU5JbgJ8GYtBUpfEQrs6KBDH1w=
X-Google-Smtp-Source: AAOMgpe51WT01jTp69f0k0mBdFhmco1dS2+5JS/7tg1wrsZtZjBMOFkv6f+molZzHZ4vGu0Hw0eQ0g==
X-Received: by 2002:a37:6945:: with SMTP id e66-v6mr3143814qkc.305.1530055253650;
        Tue, 26 Jun 2018 16:20:53 -0700 (PDT)
Received: from localhost.localdomain (186-106-210-254.baf.movistar.cl. [186.106.210.254])
        by smtp.gmail.com with ESMTPSA id y15-v6sm2174877qtb.75.2018.06.26.16.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 16:20:53 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH] arm: dts: zynq: Fix memory size on the Zybo Z7 board
Date:   Tue, 26 Jun 2018 19:20:25 -0400
Message-Id: <20180626232025.14003-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the reference manual, the board has two Micron
MT41K256M16HA-125 DDR3L memory ICs, which have 512 MiB each

Tested on a ZYBO-Z7-20 board

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-zybo-z7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98..bc81ebee5 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -13,7 +13,7 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x0 0x20000000>;
+		reg = <0x0 0x40000000>;
 	};
 
 	chosen {
-- 
2.18.0

