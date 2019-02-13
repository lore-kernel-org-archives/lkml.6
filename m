Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B77C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2862C222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oz4kZU1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392416AbfBMPJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:09:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43724 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfBMPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:09:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so2196144eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swOxzW9vMk4pzi3UvIEu4I0VThBe9QbWma4JZoUhk5o=;
        b=oz4kZU1zvj7oAr/tvZuyugE38V7Y1AP5XsNMajS1ZIWonUiDl4HDeF4IZbUGJsot6x
         itKQBwOKUfXN2e6CJKPOvKG6Gui+HBa6mhBorBw53pA09TBkkTti6LrTmrU3za5/HoU+
         +PaMpjg/BOSphEMthFSdaIIN39t/aLmanQ/wj+DTbwWfI49+o9eKhwFCu10qjnazKLeL
         lyxbYctZGEogsFpmvp1upxzqYRVx5sNmtaJE+j7GUbUFKsy0vNW9gnzI6m+XRKx5p+Et
         +WxOyC0KUWrIlbjmaqCr27SM+lfqiSmjUFY1rgIpuVH1aX569wViOpReuKvqXd19y4iR
         v5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swOxzW9vMk4pzi3UvIEu4I0VThBe9QbWma4JZoUhk5o=;
        b=tZ7EQC7kKJ4+f0aMEtaSok2IwgTeuYmlAQtBXgPtvRAE1lXQmYIpJyi6+TTGfZQdPB
         g1LUFFR3KI89rAwRuDRDRCEpCz5uYtbVeOczIeSdBeNEIj9wW4sgkWrekeYbJc3uOjwq
         A8byAidflbHG+/+Ca2gsl1jpDLLADECnZ4TvDQ96yMRe3d3YPOEEhqWLAI4eZYTNN9Jt
         mEZtabKFXI/fQx61l9SoVJRn6ffo4AGJewMro92cIPpnoPfL4e4D6rsWO3DVFrkx6w7/
         W0XYH4i1LwfqB3bBbPuN1cAhdyROrg6BiDtdpwu+i9RhxgwGUpFKVIUjJocRvbpJDHGc
         zsTQ==
X-Gm-Message-State: AHQUAuZFgT8PAp6XzILriekOxNNn+iR2fvaIfq3l6QpMaxsemy4+Zniv
        Yj87VeOtNXmsB8TweyNeTWsaUw==
X-Google-Smtp-Source: AHgI3IYK8BjdKw5IxA6WwhOK4/YgwYQ9tO0sg+FqNKjbt184GrurwgEAufFPexUsdgvkOn0euwheRg==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr747853edq.185.1550070579497;
        Wed, 13 Feb 2019 07:09:39 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:4505])
        by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 07:09:38 -0800 (PST)
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
Subject: [PATCH v4 1/4] dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
Date:   Wed, 13 Feb 2019 16:09:26 +0100
Message-Id: <1550070569-18588-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4: No changes (Reviewed-by tag added)

v3: No changes

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

