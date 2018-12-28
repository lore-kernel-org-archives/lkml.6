Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD307C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA7A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3g+b1zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbeL1PTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:19:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35285 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbeL1PTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:19:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so14763571lfc.2;
        Fri, 28 Dec 2018 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tl+fPCGKybsyERJ7fDUtUUMflSNz3puUm0HFiy6tknk=;
        b=o3g+b1zR4yXudKtvdOkeGyXSFEmW6vKH+L0u+xNaCjGtTYjiA10eqAsQwgWXE2ywwT
         vsijve+DBDyu6lX1Lo6SNuKcSIdjnbk1rPO3x7GlpvQxEfQLFoGhfwTBVcACbWQWBmn/
         MsNMrNnfxnVSmcezb306xvPpueMVSVDm7dNg/uBEfs6dPaBahTq0PUGT8C179AMA1Ggz
         PGGwtmNKxZYNLQQnI/4eMs7Q4Irs46qQ2kvUuFM3zdUYaP2deduuo2v/tgz15/Neb7gz
         RHrkKXFOvaOg2LgRqNGox9kSI+e9D+JRM+VCiE97xQEIR6A7YOZEHx3bF/CZv8/eWuv2
         WTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tl+fPCGKybsyERJ7fDUtUUMflSNz3puUm0HFiy6tknk=;
        b=IXTj6n3+MenkO/tWac2pvEo8FbNS18t2zpCPQIv5/4SbXn65Xy7EbgZbOt0JDCmhYk
         RYGmec5Hrbp0CnhgBKSCbgF9x7JA3gT5ngHlh+07D1A5PDO3a06yzJOqSBAJXEXJ1uD4
         70CKo7xccdGdT0lDeYINPVWJBH1Q9x2cCCpnyRTK4tBVqsk5P0TuLRmy64wHmzWsMWeb
         C/XYyE//bJ2sAlOJsTl20arPMUYX0jFaDkCDvAtQnszKpAR1yJwyqiRaUdLFtXbBfv11
         hlJ0l0mHnjninWeovPRkULJ8pRejWQwDbN/gadaxZq9TCf0u95+qMeBLdn7FMrbLimCk
         vF6w==
X-Gm-Message-State: AA+aEWYdtiandrEQ1bmtTUMTh1jbTOghunCDLdNGcFmJK2zL0+3mpAI2
        nrTLfUdEjq1INjeYi0M0HEU=
X-Google-Smtp-Source: AFSGD/WNijqlJG0IW6U3isW5JUkQDEUW6xM/8F6rqKt7QQmqv60+DZ3rvcSvOjn6p7ve6WJgMVHg5Q==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr13714028lfb.76.1546010374134;
        Fri, 28 Dec 2018 07:19:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:19:33 -0800 (PST)
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
Subject: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210 support
Date:   Fri, 28 Dec 2018 16:19:03 +0100
Message-Id: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
  - Removed list enumeration
  - Placed s5pv210 at beginning of list (it's the oldest chipset)
---
 Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
index 82cd1ed0be93..3aca2578da0b 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
@@ -2,9 +2,10 @@
 
 Required properties:
   - compatible : value should be one of the following:
-	(a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
-	(b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
-	(c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
+	* "samsung,s5pv210-rotator" for Rotator IP in S5PV210
+	* "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
+	* "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
+	* "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
-- 
2.17.1

