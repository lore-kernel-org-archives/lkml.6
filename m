Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AEDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DDE21A81
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR4HjSnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DDE21A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeFUTKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:10:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36403 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeFUTKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:10:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id n24-v6so5909026lfh.3;
        Thu, 21 Jun 2018 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ECNPoFO1x8otn955yhQ4w+FDQRu/jeUKuMS2Mv0BLI=;
        b=rR4HjSnFeuMR9iVXY2cVZuo6FiTD8gLorJ1F4zIq5mckf4riqAFWvNNhWJ74+NXNNA
         46Eq12/xRHgFt4ah1Vhm9YpybefA06zIev8sENl2/ZghoVOP8S/CTshnt3fUaExUCgVK
         TWouYVxuZFVqLmCkKS1IcpOPNXRKN13hjfhAYCKQLAK1HFeInreEjlUq/Blvnf14iePG
         TwLl4vXWpwyWp616f/X3jyP67DRhQiBYVmEhnHk65+tt9HQJBZ33kRdhkewIpD6y79UL
         nqpPjeo9GTTYbcN7ZyhiKsrNPeJhBw6IuUgo9D2MhXXUD2X/eI6lSUD8tJsCgb/BCaMg
         5LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ECNPoFO1x8otn955yhQ4w+FDQRu/jeUKuMS2Mv0BLI=;
        b=C6yRDvsh2pxdCNaka68xDiuop6fLLNfDG06HvsygGg0sQcP/pp0Xazrw6sHCpIY+cg
         Hzk6o1JuSvxz6Hfiu0COgCF7fKJfo87wjRtzPfso94ZRVgzl+lE5kPs1zioZQgjzlEgj
         SBJuiEKOdUUw09XEqcowgsA/7/23GIpDcplmAYUiIKKVe6y0NHjbLGbzit7xmvd6c2/n
         ZTrQIzDslvIJsymDx0Y13ikw6PNSN33j80gfnDXH3t3Hemc+JQe5MW2TMHNj4kN/eI/y
         DzTqv7ciMPjzxeh+i993yEf/TjhIDbbnHLvo+Q5r2VfpS6VfY13nUFPOBFw8m/8mIKFq
         D2Kg==
X-Gm-Message-State: APt69E3LEKLn/T93puNSE4/ZOu3ZvYYsJgM5NR89+h1GPLwKAIOhd9VE
        NLbodnOxCOltVriz9u2bqaQ=
X-Google-Smtp-Source: ADUXVKKrVSwCLLsEqlzZAyxjpzDuwfgFHHZ1jZFOySgex84Cg1cZ1wC4TEL02lqbwYQ+YQxMEuDD0w==
X-Received: by 2002:a2e:61a:: with SMTP id 26-v6mr17255318ljg.91.1529608231661;
        Thu, 21 Jun 2018 12:10:31 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id u3-v6sm988036lji.4.2018.06.21.12.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 12:10:31 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH 7/7] dt-bindings: samsung: Document binding for SGH-T959P board
Date:   Thu, 21 Jun 2018 21:09:59 +0200
Message-Id: <1529608199-5583-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index edce6602de50..8a9358336aab 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -3,6 +3,7 @@
 Required root node properties:
     - compatible = should be one or more of the following.
 	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,fascinate4g"	- for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
 	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
-- 
2.7.4

