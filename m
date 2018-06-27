Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441B1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E771C26201
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUuoDSJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771C26201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965274AbeF0NQf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:16:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45059 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964874AbeF0NQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id x22-v6so3068696edq.12;
        Wed, 27 Jun 2018 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=opEZhWYgdV8vKWKCZXEtIJ0lNHQLztq6YcVZh5ybcpg=;
        b=WUuoDSJMAqiIUI8ppfiy+wPlrbmd/qUp3uWdCX3fgNxbwKZQ4aFe/xBgymeFbafaOq
         r/jOP+qGIokOZ4Rfxj0maF05Hfn/rkfl+haELss1pClDpkU9G4lugZHsX1uGlgsUDriv
         7FhQeJhOs5GF2OSdUQ0XIsI+CHiYZqoOi6rHHCfyefaGEVXVwi8mhZjl5DSzhJVWiNwH
         zhaF98s80t88riHSYbOhgkD4lM2nKn6QGIVYWxkzRIKC3qSEBobmBZaQWaIpUZm/vCjl
         sgPa1NRTfCgQodus5SMyaoZeCqV4bcjvXhVrXYWEb0xx21HVdltyQU3ciiDgvbU8ZFpE
         59ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=opEZhWYgdV8vKWKCZXEtIJ0lNHQLztq6YcVZh5ybcpg=;
        b=hdsYJ5EeZ2nDJ6CXXipUmUZlhse2nJ8bV2OJw9E+/RpmgK2B8AWXMISvoRY0nhfG78
         zwiMMwUKN+4OREA1qQ33Qk2/0a6zs4i6AbaWf6f+PwBmrFW6leQ1g75LXv50IA211EbD
         pafGR382Wk2D3KHTQ1sZ7GYvLexTG5G0erA74iIwMI5ihokbcgaWrXW2OJ6rzvKq/JGA
         qTKXRg3Q9tUCmKExIrreqOrRohtWY1qIyra2s0vCYlata9zYuM7H3oYcmtTm4ObzEY/j
         lHBhsQF2CG+k68cmE2PLnhdHPhfcci0mqh5BYr7wd+xK5VA/52SEbPDNcs7vaJGazWls
         7cZg==
X-Gm-Message-State: APt69E3dUHsuEKMfku5XrdiFPYk/k/OXwaMrHt6H6/i+jSzxDfP6e6K+
        3z7w+H0tcZNViZi1Qc25DA==
X-Google-Smtp-Source: AAOMgpc+xhxAILYMZ0PfR5kky2sKIABD2bbZFIw5KU7JmfFHnmJYokMVUD7Qo9IzRLNvPoUIBjHIrw==
X-Received: by 2002:a50:c313:: with SMTP id a19-v6mr3390643edb.177.1530105387011;
        Wed, 27 Jun 2018 06:16:27 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:26 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH v2 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
Date:   Wed, 27 Jun 2018 15:16:09 +0200
Message-Id: <20180627131609.13681-7-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
this change is just moving DT-binding documentation.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
---
 Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
-- 
2.11.0

