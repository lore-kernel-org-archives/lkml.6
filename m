Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D5ECDE4A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2020881
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mdk8YADz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C2020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeKEUEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:04:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53471 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:04:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id v24-v6so7800258wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKLLvWWerHEA8gEOK4LIPCxH8mV2pQQNbPRbXsJkDBo=;
        b=Mdk8YADzsEYy0/qb5s3o0OfDAD9k719F/IpFxBeWgLMV3Le2MmY2t2Z6K4pLWBMKRM
         M8kl7C2oueL0CmjtzONFpIZGXNNUFgMRahIxU4xTCDaWTixPsA6kwoCr4x5sC9YIlOHM
         f4XunweBCCUU2jazKhUDT1EOFrGUftDkYvYwxMrCKxnlBM0qOQAT3TWq0pjQ+FW9sZIG
         kzLV35Oe7KpmTHORWAHTmh31NS4CcLRMYtId8UvKNsjwvtkgSgoZlzhbOgdHsHW5xrZ/
         VqAQSFaipWqNPyTdEfwevtgqziZx07yqqhBg9aWyj931vlo823WCDtXa4guoy4oEFndN
         5gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKLLvWWerHEA8gEOK4LIPCxH8mV2pQQNbPRbXsJkDBo=;
        b=koh3DXqscxgegzRjp60EbMgIkyspab0hCUPKEXj819jTUOzUtF8l1e/9/n9SyPfYld
         26AEpsYaiwqQQ2vmt1rGIZgoEH/L4+WMaSZb97mhyvdlR96LA4YgPdf7l8OqnGDnKGKj
         iNYd+t5Wf5vFq1WJ9nT5/pTZuMwvDzPlJ5nG51oBwXz3McQ0UZhcrgX/kxzZJVQM9C0V
         ru2KAwUmD1X5CLQ82Bq3E86PhlK7afV8ImJ1yxhkSfQz7L0R3SYpSZNJuFUP2uTawnTq
         lCwtvvVGV1tS0Lxgyd2CoOBmDSlcAWTB1NJfFVogi4w/JZYhVus6VsSxE9sCPsgcjvGR
         C15A==
X-Gm-Message-State: AGRZ1gJoq0cIHlfHW7E9+N3gWjDYreUVzQ6QQxGIBQB6YNZLIhEKRT3V
        dmvCFF3OekB0+VEvEbjTjMPlpQ==
X-Google-Smtp-Source: AJdET5cYQF9CdzXKWyLDSYw7/iD+eX8aCH6yOAPFbEcWqC2b9qv5FM/kh3ZCO6a7uE/wsfOp2xnmUA==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr6026875wma.121.1541414713396;
        Mon, 05 Nov 2018 02:45:13 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id p125-v6sm8033114wmp.2.2018.11.05.02.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:45:11 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider node
Date:   Mon,  5 Nov 2018 11:45:07 +0100
Message-Id: <20181105104508.23090-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105104508.23090-1-mjourdan@baylibre.com>
References: <20181105104508.23090-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows using the new canvas provider module if present.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index 057b81335775..c65fd7a7467c 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -67,6 +67,8 @@ Required properties:
 Optional properties:
 - power-domains: Optional phandle to associated power domain as described in
 	the file ../power/power_domain.txt
+- amlogic,canvas: phandle to canvas provider node as described in the file
+	../soc/amlogic/amlogic,canvas.txt
 
 Required nodes:
 
-- 
2.19.1

