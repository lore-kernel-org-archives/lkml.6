Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CACB2571D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj9OW6jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CACB2571D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934823AbeF0RO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:14:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966012AbeF0RMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id i125-v6so2244920lji.2;
        Wed, 27 Jun 2018 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LT9uyAE7uonXwqaiYQx/nOeq+dE4Od7RjXxVJASk9Bo=;
        b=cj9OW6jwx3zirwWdH9YqX+g5YX50RJ2W2CqNVdeHBMPjNarW9UOEFt4yZQjarPNiPx
         TnL2ZCg178R2/sTUz12m1MwgWL2o9zaC06MrFQTaf/NRlBML7rRIr1uAja0LSt7FsjAy
         NCslIsa+1X9MGoR4eqTItEvSubAUV7kbeDWBxgU3xkysacdJuMjFfKjjNrnMsXCVMwMW
         XsrXzVGPm4AOSPGD/bT2Y3jsOgy5Bw7G90YrGJF/1ncxjaqql+luRUTui4Yt4hFOLqd7
         CVgSHzvEnBemulZMxGbcYr4FuSMVt4hx082qNqRlPMvBeIyZ6eU0YNgvAH/6BbjhZ/qO
         tCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LT9uyAE7uonXwqaiYQx/nOeq+dE4Od7RjXxVJASk9Bo=;
        b=kGktJEnWoEO37pvv7GY4Qp8RgjYZ5il6FT0l6P/jQ/LFUFJ5uhR1SyvOvKDTWOm1AX
         q6Roi88sOfmVxsQ5XdogaPoul9cpsl9kMdzJGvQ+LfRLcEK3Gefr8GUbcB9Nwuj+hH6k
         TBn/1T0MhYu1vUrUB//VrYfSk6aC57O1tkwzbMtMFGuYYSPZ1x+lrdoIrmlXWv6Gs0ys
         GuYQA8E15JF9VxCOsIkGqnb6CPqvBZ1YwQI4a0wOmHKDxyjdrwWIrpausDoe/868KNlD
         ZJ8a/Xbld9loFIll5fYLIj74rg/AIrs5npYoTBXT9wq9pVswBOhfD+w8qicSEyKGcNZ3
         fs2w==
X-Gm-Message-State: APt69E0hRchEPwlhRuE6zzmJCvs2NI6H9oH9wxeHSkusxzBUWDh//hCp
        cCa+vH5jN2f334b7v0EcKe4=
X-Google-Smtp-Source: AAOMgpfS1BoZycJSyVwIurNLlwMfHaq3chgpzLyEF/bu0Qt1+T0bZ2XXJFjlV3AgNtRDuS4nVNPZzw==
X-Received: by 2002:a2e:7e08:: with SMTP id z8-v6mr4644830ljc.45.1530119564236;
        Wed, 27 Jun 2018 10:12:44 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:43 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 05/10] dt-bindings: samsung: Add S5PV210 as possible soc in Samsung boards
Date:   Wed, 27 Jun 2018 19:12:19 +0200
Message-Id: <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are Samsung devices, which are not Exynos-based boards,
like it's in case of S5PV210. Document this information at beginning
of file.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..175f669d9bb6 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -1,4 +1,4 @@
-* Samsung's Exynos SoC based boards
+* Samsung's Exynos and S5P SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
-- 
2.7.4

