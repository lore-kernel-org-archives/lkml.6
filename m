Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26A820856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZsMi8eVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfAQQyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:54:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50291 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfAQQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:54:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so1826649wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6qRpn5S966nXnLaFTqmom3s0zt1yyX1JZ9+R2qhF3s=;
        b=ZsMi8eVmRGd4IWVBPniDrEC7YdNqZLV0NYZSr9mBYO6P7SwP4JnFSZP40bQnr3LNjv
         qp5mK0/2bkTXUYsbWsHBM1jhjsLIAyadx9LR1PROcwYFH/15/6zJdF1uTDJWt9RjIJbs
         P9329vyBke1U09hUibrv8TFkxPOa9MJFkzMOpREa3UJc8WC+XXi7i24diVOwgG9bFHz8
         sV4FzY3ejSL5zmTlMXqbbvtfWzAeuaw/ShTXPygNIe9tiARM3c+iMIbaTvRp+q1EdTP7
         bxE018wj9PWzfavYvT76dqoBfDOL+Dstt7t7J9Ny+hD9KcGqrXn2OfEjv5O0n3iscrW7
         OA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6qRpn5S966nXnLaFTqmom3s0zt1yyX1JZ9+R2qhF3s=;
        b=JzkZH4qMkGNK0u7UW4ftFw8c1Dj4ij8gR3n4FRq3yt3AjpPVrsv3W8/ho2pFDUgQ+m
         eAGFZc5UVnsgix5z2oaNYy0mAKpvR9adU7N43XGwPW3RE4VSP2/fzv3OJ9SVQpygXRwG
         8CsJbbkZJVw9+I9sE8do5OKAXCfWyAng53lp+174x6HCfoLiF/kEWDjw0fFTj3ii22WH
         fkhRvPmTTAEFHAfCsQj/QjWRjHM4Zr05kvb/0IQ8x9a2Hg8YNE302BaBkXkLlDoCbRmS
         HAQU8tB7dNg0/5CqbV499n+ta6tGkJvusl+7/FSJKdXFKxWP9Ria48Me1otLPIlHH7Uc
         +zGQ==
X-Gm-Message-State: AJcUukdsHg8SURhzFcs7i1Oe9mzRft7l1iI+PzrjeIuNeqwTKE3rW+Gi
        2pUunmkLBL8CFQ2bvXPkYmB/rg==
X-Google-Smtp-Source: ALg8bN6qTZ9AA5J1u/MzzOt4IZ/Gr4gZIYrLCp/2l3abY71IkSvX7wWxwwXRKtDYUij85Y1K+sMo/A==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr12737066wmh.118.1547744081818;
        Thu, 17 Jan 2019 08:54:41 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:54:41 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
Date:   Thu, 17 Jan 2019 17:54:31 +0100
Message-Id: <1547744074-28308-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: Alphabetical order

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..d80a70343b36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -150,6 +150,7 @@ geniatech	Geniatech, Inc.
 giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
+globaltop	GlobalTop Technology, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 goodix	Shenzhen Huiding Technology Co., Ltd.
 google	Google, Inc.
-- 
2.7.4

