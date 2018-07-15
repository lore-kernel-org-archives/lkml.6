Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFFA2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flJZ46Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFFA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeGOVLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:11:36 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43398 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:11:36 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so14709420ybl.10;
        Sun, 15 Jul 2018 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lbzup+j4uV+Cyvc6JSmDxolAbVH0YdeWVSBZD2fqHpg=;
        b=flJZ46CzEjSmqgueaaSBaLA4qnjgzCfZ2ETxTBFqmRogAId+RZOIp4g87WCu8K4bl/
         8ZhkXF0Sk8VbSPAe20MUCuwnY8ax+vnL0dy0F/LOEqtnmnB/WUcT4TeCxhJ+F8QBeyJn
         pTxmz6HFgPj75N7HORwfDEmjhQHAM7+3oKJP/6bwPu6DuNslGHcKrUl2GcLQhPrsZ3Rt
         SLlM6qEdeoZE/B0BxDqe6uNMKYfG6C/NHoAixNjzVa2/vppw/lzo0SXormyG/KXpoXwh
         R2/bUFJO/aWXzdww+j5H+soyZfU1sZAt1UWQtCMSai7gjBmaMaMAXBM5pMNxwGBpo9fb
         KN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lbzup+j4uV+Cyvc6JSmDxolAbVH0YdeWVSBZD2fqHpg=;
        b=aq+yTHWN/A36k8fS7sVuVsjNDDPmve+P3CPrCGVKPbZpSznfKKRRV6chy9eoWfIs/e
         9NEBv++UHudwaPY6wxpOLQ/+C0V4RlTYsvzTV0pgWT2Qyd6g0N2Oy2FScEb9aazC7ZMd
         HGH8qcPOXMy/9Fz+3KBoN6tmILzWFmhqxG0f7LgoZV3TdVODDAt51fhw3iKiGgONu7On
         G7k6F09Ze1rw8BXzW7zbhfaVHfpa/46wwgJ+yJXZofIcCE+9/2z1nOsFr2qaPHGfgofM
         utWSmNYISxq1O1h4FzeZdliuL8marPvbRazviExac8DLNZX9N3ub10sHzodTTtFrx62L
         k55g==
X-Gm-Message-State: AOUpUlH0knMUOqDzBw/mr/jqfg90D+/owlU/J1BwZHB6fCj6TlXnwwF9
        J6uv3FNXfb+ZZdMx/uC7sgVM7Q==
X-Google-Smtp-Source: AAOMgpcKDi5Hpmu7bC6PnaUF/sUnHZ7EKAoPZWcfKYY/2cynOPE9MaO8+c+JBfs4JRZHljOSN+vmmQ==
X-Received: by 2002:a25:94c:: with SMTP id u12-v6mr7664962ybm.435.1531687645738;
        Sun, 15 Jul 2018 13:47:25 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id h145-v6sm10090199ywc.3.2018.07.15.13.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:47:25 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 10/11] dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
Date:   Sun, 15 Jul 2018 16:47:19 -0400
Message-Id: <d208e0b18c05fdbf900a2098991cf35b51bf70b5.1531685025.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

The STM32 LP Timer counter driver now resides under the Counter
subsystem. This patch adjusts dt-bindings to account for the STM32
lptimer driver move.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
-- 
2.18.0

