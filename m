Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A85C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDDB2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Q7V5Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDDB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeKZDMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:12:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45984 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:12:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so12658018plm.12;
        Sun, 25 Nov 2018 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oTvQBmsSo+R04V9KH1Sk1+fvcPd9GR80N+lSsbfwtyk=;
        b=n9Q7V5Ox3Q2J0CmyE35bnOEJqHNc1uau7R+lVBNJdPuNztF7+GOqPXRBQTmvzv/f9e
         lePL4IpoBLirt4Vk6fIsi0beX3to/IeBlTY9oaceRR7zfr7O7O9nD9E9wM4OFo15XSp9
         2kWXp2auG0u/JIid67hgqpNDxLrpo3pgGCTBKRnlK54JueLdrygWdCJHGUcC1LxTMFyY
         WUyRXX92Z2eRsz6D1/lBzm2clio2tEG3+hAE3fGilyB98qNdelkMdJeN9WdN3lTYgcbk
         2M+oKpqRfc4819l3xZYJCpiiMFMYbhAqEyOoXkuZKr6rNjlx4N/i52v5T2iPj0oKnvsn
         e+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oTvQBmsSo+R04V9KH1Sk1+fvcPd9GR80N+lSsbfwtyk=;
        b=H5Qyd6WqFnff8cHpPj4xjJ+caQ2pQrXIDugx9Ha2oMGhKYdablLNKd88TqABXytP0p
         MCbGi3AmtToIM9HjxaOquZo4hpXzTs9Lw4CJhZhOrgZs7BBwaTpPRMmO2djjCQil0MlM
         vu4pwQTRHIQZ+X76UFrFQeORJfOjDDnphgUUO9EBYwzvz7ffeXH7puSSFGv7/s4s40Hk
         iiswsk45scUEi70qJbRbf2srr9xOpNrrV5Uv3iI3AK4AIQJCJVjk6s2i9KNnjtVoNTpt
         3efs7deHevTTg7oY9R1D9vslip00JR962Gt/jCEpOQy6olFoZPUCYSEmSV2BQ1fiuVkF
         6/gQ==
X-Gm-Message-State: AA+aEWZoPraYznD1TlfhMzjWQ7qUeNxxmulJGQTGcSrL6a9MKkfgGAfI
        JcBr/FoLXeGGVdPcH4nLDxA=
X-Google-Smtp-Source: AFSGD/WmtbVxHcMPsLlItabkNJtYW1DfGfo8Pp3pGEL7ulzJVu0SQUUHENVTil/dY9oXbNhDpi36uw==
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr13014732pls.246.1543162847996;
        Sun, 25 Nov 2018 08:20:47 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id p15-v6sm101187605pfj.72.2018.11.25.08.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:20:47 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:20:40 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 3/6] ARM: dts: add PWM for Bananapi M2 Ultrar board.
Message-ID: <20181125162040.GA5333@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pwm status for Bananapi M2 Ultrar board and the status
also used as LCD-PWM status.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 438b7b4..d785c9b 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -272,6 +272,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_ch0_pin>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.7.4

