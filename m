Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400CEC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39BF223B8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4LFTNjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39BF223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGGKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:10:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41692 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754098AbeGGKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:09:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id y127-v6so11672600lfc.8;
        Sat, 07 Jul 2018 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLEK8xZtvtMV86QkS7VyX9ir6Qn72Y5mJ1xdkDdSc1w=;
        b=D4LFTNjIrnbNnZcmOWnLM56fxaFksf0HYHg2PFUMhOaupN/cMATfC2IPIpVyIAQU60
         NfBRX88Mf6ftaET8KD1goICNXl09ELKM0DVbm0MmMZQBQSBKZy2NF+Hbieym/VrP4z1q
         wLeffjT2AiMgy1WZViVP2N+w0+zaO8o35TSCFYbXYMSOFZ2KDdTdD+rjiU8s8C80vLXl
         nvrsJhBQZs+nNBrJGILFuVKxgeY8/xdCwFzyfpYf3Hg2j+S0Z1ALWkTxePDnKiv/d5a2
         hnOF0BBOaULCJ3JPOnCQ9NYfd2B0EdNY0MrRxj8cbw1ibxwGXOoVhE2ABa/XxcHLX2GX
         afMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLEK8xZtvtMV86QkS7VyX9ir6Qn72Y5mJ1xdkDdSc1w=;
        b=YuF7FBOY/isRK4Egkqstp5+3mng/S7p8EjXJAf4xJGKxxtTVdZUVU3KvG18djZRQQO
         PJ9In7tWgugU/dwjvR/oEumc0emzByZ2OhxBy3XX9pLTNa0gJLjAsRekIsU2CQ6xS7Zy
         aSezp8ThfiuIv8TJBaYP9HjH+L+CdQUmftK7flCq3ViMcXm4pWsHrAs97v9P34tZy1di
         IkfAw6/T9p1ucFYW05BTB3+6wU/x47ca25s9MP3F/HozYmqoLLkc2t0UFgLMP9ii1bn2
         sE9vYzRKC4sdUPjyln3HvbYDJ/4pwAvClO4IYwvlC6CrP5obrQ5ou29018/YCd2jPYo7
         CpKw==
X-Gm-Message-State: APt69E0n+s6fs0+ByeCiUQj7Q54qOFIRtN3iUPFxqab74I9h1uxcr2x5
        IWFV38Q1uQ5xFGj19gP2FrM=
X-Google-Smtp-Source: AAOMgpevHkFBndz1wt8cYMT8xlC7SzKFgRq7nGVUJssDobUr5FLqQiKjOCxzsl8TJxb1nx0UML//uw==
X-Received: by 2002:a19:dedb:: with SMTP id i88-v6mr10159077lfl.26.1530958194824;
        Sat, 07 Jul 2018 03:09:54 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id k77-v6sm1321292lfi.46.2018.07.07.03.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 03:09:54 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v4 4/5] dt-bindings: samsung: Document bindings for Samsung aries boards
Date:   Sat,  7 Jul 2018 12:09:42 +0200
Message-Id: <1530958183-10956-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for Samsung Galaxy S (i9000) phone
and whole Samsung Aries devices family (based on S5PV210).

Also because this is first not Exynos-based devices, document this information
at beginning of file.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Squashed with patch which was documenting existence
    of non Exynos-based boards
  - Added reviewed-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..3fa287a86300 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -1,7 +1,9 @@
-* Samsung's Exynos SoC based boards
+* Samsung's Exynos and S5P SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
+	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
 	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-- 
2.7.4

