Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E73C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF521A88
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXvBlJQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FF521A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeFUTLa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:11:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41307 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeFUTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so5876560lfa.8;
        Thu, 21 Jun 2018 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=VXvBlJQDYgnY+WHdNqnfhDFETYA0DaNcqkbhKb6ZKmnOBA6bpvy2uD26XUheORMItL
         oNtoI1i7PDAc+7dV6DTgwtrueBXdtkfRRbkkCKJD9/HMhZugHBuFgLIsJnQ3f0IMgCgO
         aqKXFAMqdpy+K9Bwnah7hBX1jGfBz92U5vl1TVv+8FvRtPeiurDuJNh37EgiUYyLU3RO
         rpqjEwg4YnILiOn0iwsRerO+gLL7tfmA4EFHtXBV4/je1h+JBCETNFgM/wKKiFR14t6d
         hPNioE0hzuK6Slw3UQWM6ez1aj/zs345JKjpQQ1eTk1xO+n7NNGOve7ysn6TF5yS0Ijc
         vpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfkN2BRmaFMo/wJvnoikyZaoLnqmd1IN7BL7KjnftSU=;
        b=gxqmgl2o6Qd+HTItmS6MYYW6X9J/I5YZ+BQfZk9/4XVETy8H/mj1TgtszeQ3d4Rdb3
         yAPT5AycCZ+5QOcw1uID1QM0/rzAlGbLTXmHIGtlPm9NK6DHB0U4uWCzYl+Z/TUahHtJ
         vv8NBnWVJSeGTxzMvTgGGIyN4lI6DQwuQtGEdY4cxBpRNbxZZFXwkd0HXRDS4UpR5tLv
         CA2pf5fXluAIP8YnBNKg1dQJrA6FV7tmrZRvPMZ/kNSk/X21GlUvDZV4FeBPdruDta3/
         c46h2FBD5IzOHvuHKMuA3TKrRdjqd3MgZE70350a6y4q5f9NIdVSJ5Axzp2wCfMHjU74
         KQWg==
X-Gm-Message-State: APt69E2/C5jlHTU/vwHQ9KGYqtleA2VIEBt6wjbEcChl/xuFZlgAGBzM
        8VksExS/DviRO0LJrWM0nTE=
X-Google-Smtp-Source: ADUXVKKGntEk5riyMMq2IRj5MLrL3M9058LrCC/NYJXxnKpcRBcKF1r0WSaVwNGEGM/DyHPLiBi6xQ==
X-Received: by 2002:a2e:8151:: with SMTP id t17-v6mr17521656ljg.32.1529608222546;
        Thu, 21 Jun 2018 12:10:22 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:21 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 1/7] ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
Date:   Thu, 21 Jun 2018 21:09:53 +0200
Message-Id: <1529608199-5583-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing interrupt-controller property to gph2 block,
to silence following warnings during build
  /soc/pinctrl@e0200000/gph2: Missing interrupt-controller or interrupt-map property

It's reguired by Samsung aries boards, an S5PV210 based
Samsung Galaxy S (i9000) and Galaxy S 4G phones, which are added in next patches.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 3a79feab11c3..7f0c9d447871 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -258,6 +258,8 @@
 	gph2: gph2 {
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.7.4

