Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFD6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0C223BB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qztNK0Iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB0C223BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbeGGKKF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:10:05 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39614 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754107AbeGGKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:09:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id a134-v6so11696284lfe.6;
        Sat, 07 Jul 2018 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXEVhtVTb8SribB7mXS/puyWjY6YBc4dZdD7/tqgO5U=;
        b=qztNK0IyMV9uU4eblOKqE2GfYCAgdJ4ZCxtQu2h16j0Jw6gDmDCF43jLGbRtyydPSP
         HcbIoXVx7ePzUp0ipAy8YeldUlYOliwIufG298P5+UkFdViRJzYN/FJtZfn/W2zw+w5w
         C3W1PcwWgScS8tNTUwEKfN+oPa+y4aQbGy4g5x5NkjONgMeWurlt1o7GjBpjW3hg7JC5
         9PJuzpMGMpXHD+p7c59PbB8PeEjyvw102AgL9FdNQ6YapT6I1Wks5Har8wyu/1qh8Tsi
         Yv2VwthSTM+373OFaR9cCo43h/IKVos62wanSnJ5CFwllnmVPJuuoqZ+oDHbDzVj5R5V
         YuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXEVhtVTb8SribB7mXS/puyWjY6YBc4dZdD7/tqgO5U=;
        b=PvGRegcxycQv11tlFHqQeyZkbMx+vP87wIXSagqH7frxY/3d750Y0m7QeTqo+qDD5W
         hOpLr1xlyC/uBYeJjdbVH2KKnYD6qNdF7/m5XcpqkqzXnBmFN2VQU61JFV/FkrBClkTy
         6N9LnIMzXBWdVfRSjXzpao5pcGCUrl+836vN9pYnrpM6NL7dTuF0je9vvesZcTWKHn1q
         BREpan10uD38btAqXmOTda0TqFbEN7/ZDKStec7ZniLU4tnjWmEP3icpetBO+I+0Jyzj
         6yEtiYxWZEHIzXlcP/3oBgEXxCLr5ACZrm56KGFSHVwjSUSTWwGvtTyxj7RAf9KQBreq
         XZIA==
X-Gm-Message-State: APt69E3prldXcHdgKtZ+JPbz9f9M/TnjSKO5+sdViJAO2aNgt/L5w4+Z
        gAE/GUc02psoKwfWX4HSJ/g=
X-Google-Smtp-Source: AAOMgpdS2nQLFqU2dAplHeXjGETztjb2u29eMEyFBGk9+YuuNyE/WFZ6WSvmTEux55yT4frKajXe+Q==
X-Received: by 2002:a19:5f11:: with SMTP id t17-v6mr9731373lfb.64.1530958196166;
        Sat, 07 Jul 2018 03:09:56 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id k77-v6sm1321292lfi.46.2018.07.07.03.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 03:09:55 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v4 5/5] dt-bindings: samsung: Document bindings for SGH-T959P board
Date:   Sat,  7 Jul 2018 12:09:43 +0200
Message-Id: <1530958183-10956-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Added Acked-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 3fa287a86300..37e96e48c48c 100644
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

