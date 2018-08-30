Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682F720839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fubLOn3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682F720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeH3XFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51557 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeH3XFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so3003338wma.1;
        Thu, 30 Aug 2018 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6iCbW8J+KgHVaSl644rAO8j84rXqhGHUryoNJ+DbzA=;
        b=fubLOn3Kg3eBkI2XnydjEzDLAle1z7QmrP+9bU5aYuE3KmiHF3pP0dvRvZdHe3w1sh
         8bpdl7fCulAbIX5DMD01i8LoWKyYmYJPXWZ/ZR+RGelz6SMps8GFfKE/eSM8php6clJl
         iBtVhBFXDqfzafEONPqgQRlzwlXARd3297VXecs4JggJMs91Xndbs5aDLTzh5GV2ajDp
         q1oyEPaCDBi1Kul5wGr8aQWRkQUPWOh8fM6ZcnHFW0gq0ayrnqk4hs27oR0sXdzV4xeH
         f+LUno5MHljvWtihgn9bAwZ/mf8E8dc9tl+58mTS202pMcC/N9+Miq10DTyOw79wP3tp
         7POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6iCbW8J+KgHVaSl644rAO8j84rXqhGHUryoNJ+DbzA=;
        b=oOkaK+Uo3EXv2mDsqlGHO84fAHdQaPtFHPxXlVductGhUOJH2yGSkTGFdad+m4Jclj
         5rP81N5I4XxAMKV7hMPHZxMYEvUlTn1HudhpPDDkA0wnUtMhf26rjn2tnP5fT/Gfgro5
         W1Svvo1OXlyTwSjvqtZUzkAC56nTvDH1z7mcQEQpkUw7dL/WGOWFAhTK5hgJo/MARUOe
         OLobczcirDBwqRcYT6o3heuMC7rVVcj69LdvBDsWPexlz44/3raRg446RKdxVlFfyqfM
         XLSAplF48Wl47Yo4WWwujCxFk4pOcoke+B2kq1NQFw4COmiFDJxGPyZZc6Kp8OvsCwWj
         x81g==
X-Gm-Message-State: APzg51Cp3shyEAArPjjouDVqLSCYOUjPS/slyg53rYj797HZ+tCA5F3B
        DKGffeC0Ntu94E40hwG8oRU=
X-Google-Smtp-Source: ANB0VdbtZTB+/Dr2RzC4ZnRmfxLvuGKtiigCJh7ajuLdogWVY1RUZp+N6dGnIXqCbcLBV8cmp7Vqmw==
X-Received: by 2002:a1c:8145:: with SMTP id c66-v6mr2749219wmd.139.1535655689957;
        Thu, 30 Aug 2018 12:01:29 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:29 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 01/13] dt-bindings: ata: ahci-platform: fix indentation of target-supply
Date:   Thu, 30 Aug 2018 21:01:08 +0200
Message-Id: <20180830190120.722-2-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the indentation of target-supply's ':'.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 5d5bd456d9d9..b88820b4c01e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -47,7 +47,7 @@ Sub-nodes required properties:
 - reg		    : the port number
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
-- target-supply    : regulator for SATA target power
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4

