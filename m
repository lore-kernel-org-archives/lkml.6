Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3087EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2BC2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8R9dVfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2BC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbeGVXuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:50:19 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44337 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbeGVXuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:50:19 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so6595405ybk.11;
        Sun, 22 Jul 2018 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lbzup+j4uV+Cyvc6JSmDxolAbVH0YdeWVSBZD2fqHpg=;
        b=p8R9dVfFr6zAueVCIZa1GVXM4nSkIMW6O2rtSs2CSKvjlyTGtgyWaHP3/Wc+MvZh6m
         KpBt7U6MYQOxDkeO7c4ldf88UKvQ2KtjDw9kE5SD5YAkY5G01LJnjNGz4JcZXh5YOOp7
         CaIEbfttk1/dl8Xk54YP2NqmSBGjI1J9x2TtBY+ulhsVIWxXHdfkw/oYc6mE1Ry1bvj7
         u82qirjgGBA0C/+oYc6g+wMAtQmx12GcjYOHBprg7frr2LYhfoKBxqcKcKH5CCf38xU7
         qMu1ZGRVKy2CaoDy7eAsc/B9usHyj95GrKfdmWwRw+F8Lgwmvxb5Th/NWyAJO3/B2r2S
         ewCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lbzup+j4uV+Cyvc6JSmDxolAbVH0YdeWVSBZD2fqHpg=;
        b=TqEEW8ohTgq09PVASGHXi8IGa68Tmv+ksDwwzZfid6Qkhvn4hguivcEsMkoBU3dYBB
         +qOiEYhVeAAei+f3svRnSd0wP530vEANjHD4H3vS3SITALlGUc9liB5kRkJNz7lQ2IPc
         oRb6UPQFEVcFwvAYLnYGwm8HVajQSk91JGyA65ST2hJmPJOQkXvOSvWoUvrIJFWu6EHZ
         sUq+M8t6ltbdd+mrvVRCcdeX/Ys4i8Iiowe5Z0Y8ddwqEY5w2tDg1GD7nYRzsY5BKlSQ
         tGRymkTB+fNUm0qxdoe44Xg8SuwjZ+2W+XhjNsuJmHamU6a6DcV2K4puwHZOqeavDvpu
         48Ww==
X-Gm-Message-State: AOUpUlE9Xa7D9jCrbvM3UtThgTFXzBE4eDtsG5qxCYX41uUvB94JcMlA
        emq7eBaqOuGdL1bDx2nhcjg=
X-Google-Smtp-Source: AAOMgpcovD1823JR6zM2QMAaSaOgDGvl9IpQrvStBJ49wNtUKhlLrYMlj692I1fHSfx4ZgG3YWcuZQ==
X-Received: by 2002:a25:b28c:: with SMTP id k12-v6mr5589114ybj.161.1532299920968;
        Sun, 22 Jul 2018 15:52:00 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id r69-v6sm3922977ywh.44.2018.07.22.15.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:52:00 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 10/11] dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
Date:   Sun, 22 Jul 2018 18:51:55 -0400
Message-Id: <45406263819b9877c8aa8dca32e8f13e79957293.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
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

