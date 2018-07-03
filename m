Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E7AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE124267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM5hkCXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABE124267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933758AbeGCJ0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:26:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51250 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeGCJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:26:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1540015wmc.1;
        Tue, 03 Jul 2018 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/41JSxo3vgcy+i8pC9vJj5EVAo+12ysbQBpqOmMaouE=;
        b=UM5hkCXoPRmhI0j61uCqe3hZbXmB/M/0efxp7E7wrQIc3vyQUkFzNLRDZQZgQlNZ0Q
         G/2MgJee60RDMHkw3v9XZv555lpI/sk/YVMrPCkvdC5qb8h0m+N48RTmioSQ0cRLRNgk
         zKJFObLMDGBF1ACeTBsMZmYzblz+d3WfatAu84qHF0uoZoUcF4Grq53RjHb6pOdtLhis
         HDEbKIRXK+MU/iNYznIa6RNLpo21RU9n4rS8AHv+Mf0qmSc6WqMzCK/hI1/CzKfjjpLx
         9n5ZMbiUb7h4624uANE5vEE2KntCE6fDRJDlLjWwYanZRwrIehWAq4mAinP3Q0POYk6A
         dbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/41JSxo3vgcy+i8pC9vJj5EVAo+12ysbQBpqOmMaouE=;
        b=iSyq9RAQiZSM/jrik92wENqOpTQ6fkqJEtyZwfDV9G6u3ony+A9VM/QJAyvt2oFnzr
         8RMFrd9IHFiS5AGUhfveZ76VXChC07Qxn2mr50pxmjpVZz/fnHMHK0jnTStj53Xo/jZ9
         dkVc+3H9PGFyDj984WZxIyI9zkQjSDswQVaWXefF5b5TpOsE/OH/dKjXjhMsrf7vglus
         CmtvSoKfehPFPYunjVhcdXBIBausmDBLKXgPX0UNA+bsmpFM5cNtC1DIxC39r2M+O7E2
         W8gC7oVe+N78ZgfCLbudC66CIiarzkh0NPq5Ppi9YgXxKbhrwQxlunvCctyR6TyjaD+a
         gBZg==
X-Gm-Message-State: APt69E0Pw2uBGCK2fmvspWMl2GWvZOFaqiFlnFwcacAj+A8yYjmx2eBV
        UaZJSiTv/I6UKQLL3sXApxI=
X-Google-Smtp-Source: AAOMgpeqsF9oM6ivAPshLjMbZE286u2dbSF/fMlRrvVJSlrn6XKT+yJZ8DoYXbeBYc/VNt63aPDEVA==
X-Received: by 2002:a1c:3584:: with SMTP id c126-v6mr6948939wma.45.1530609959978;
        Tue, 03 Jul 2018 02:25:59 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id r194-v6sm1819280wmd.36.2018.07.03.02.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:25:59 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        support@cubietech.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, linux@cubietech.com,
        darren@cubietech.com, mp-cs@actions-semi.com, pn@denx.de,
        sravanhome@gmail.com
Subject: [PATCH v3 5/5] arm64: dts: actions: Set UART clock reference from CMU
Date:   Tue,  3 Jul 2018 11:25:24 +0200
Message-Id: <20180703092524.1697111-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703092524.1697111-1-sravanhome@gmail.com>
References: <20180703092524.1697111-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index ef79d7905f44..388a5d8bb48d 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -28,12 +28,6 @@
 		device_type = "memory";
 		reg = <0x1 0xe0000000 0x0 0x0>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -42,5 +36,5 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
+	clocks = <&clock CLK_UART3>;
 };
-- 
2.14.4

