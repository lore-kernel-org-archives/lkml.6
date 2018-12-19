Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8712C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78456214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je+P+wTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeLSQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:04:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLSQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:04:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so17859140ljc.8;
        Wed, 19 Dec 2018 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngVQAKuo8iZ2AhPYUfFDSDo8oErenzKZAMdi0+QR+xU=;
        b=Je+P+wTiSS132/OYNBJGWFuMnRcNMqVyFWYK6HkGA/dcKfF0tcaVSq+Ppt+Yyn8XMp
         sFLDoz+Ml1N9X/4/3qBnyGsF7uQmNYYqpJClJ1LO6luPJhV6TlMHlbyunVyvJfmQAkNm
         /Q3oFP6xQzsN73uAPPGe0TY3vByM2sUKE2uC+p8oVHjv9GDXJmLCY3Mqt8w6oXYmmBTo
         tgqvus6CGNGTYG6bPrxRO1UqHbh14e8SchEnY197n7b0+XQpJU499Yyoa9fTKpNOWHak
         rY+tEPSWPXfYjGYmriOY3WbK4udIuIt9o6+WpRlmEwjKu3OIPpxBgHJsnem0LEJ1YRcM
         5gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngVQAKuo8iZ2AhPYUfFDSDo8oErenzKZAMdi0+QR+xU=;
        b=tPDYoiFgThqkF2PFl6zjZE0tqZhuKHEBXS0sK8kJDdRBNJEIZ8X2HpiS4JeJxZFuQq
         7W+ZqNVJaOqUOVnC5gs5AoSqwzGy4fLJKd9P1aFb+4X+R7kI8JZ04JISiYqoAvbgCYfO
         3IVgiMhSNy/S+tFLD+n92AdFPdBRKki0veE3Jx8kZi/3qnlK/7U7DpDDxCtiiE1yLcp4
         1VODDRaMMJ4qsazPPwiwhudGb/MTVg0TrVttqvpprvsynbUGFtww0fFVHeQ8c2Wwv0uR
         wqNLL9GhBf4promiEIiHaHAw7OXqNSRNl6HcTYOwEg/ThNIxT06xFAQCnu2ZtCCGnAkf
         5JvQ==
X-Gm-Message-State: AA+aEWYhbcfvRUojumO73zAKU5kpl/TQkw4+VhtVgnGnGYI0A7aMdLBc
        Pm8AReuyFbovCK0XPRRg5E0=
X-Google-Smtp-Source: AFSGD/UiKeMYiz1n1P+y93y49ttH2Vl+kPk/qIKf8YwCLriepYxMihJFvJpC/nHEu4WzLQnGn8WSSQ==
X-Received: by 2002:a2e:2a46:: with SMTP id q67-v6mr11164912ljq.38.1545235468587;
        Wed, 19 Dec 2018 08:04:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:253f:4197:555d:bfba])
        by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 08:04:27 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210 support
Date:   Wed, 19 Dec 2018 16:57:03 +0100
Message-Id: <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit documents new compatible for s5pv210 soc,
which will be also supported by this driver.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
index 82cd1ed0be93..78658dec6941 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
@@ -5,6 +5,7 @@ Required properties:
 	(a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
 	(b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
 	(c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
+	(d) "samsung,s5pv210-rotator" for Rotator IP in S5PV210
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

