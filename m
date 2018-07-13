Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C420871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ObC8GisN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26C420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeGMLR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45949 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeGMLR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so12030095wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zby2oxpqjdl2IsjJXB5XJlchuSNpsA+IJMjXdYoKb54=;
        b=ObC8GisNjAGhcMKlJ2JRT2eki6LZIOjsqMcMRze0q6YgkPSz0wuFqU8wB8o6ykSMkC
         5DA0S+KH6o/12WxS0YCDKHLZO8ab3ojf1QPXssDNLSSkZRSYjK6tUtEWTjkNFWvBCbsW
         FHhjZydclaTY7VdqHIuuhU4xRoh9khRRV3BO+WPWxfX2cNp0u/u2WvWBXxYumSWQwoI9
         OQn3rphlRDOjZ8hyDvaoIDYNt99DQxENpgsi3LmggFRfzPuMXXoEPdzWNTBohYA5Bmzg
         VXxVsKQMv5TGc+gbuquYp4yHAxOOFNenKwJJXsQXsrThGW33wWq1bWbsVg/Nwye5YWr+
         gyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zby2oxpqjdl2IsjJXB5XJlchuSNpsA+IJMjXdYoKb54=;
        b=rlkiHudlpDlWDEDKvVDMEqrdRl7w46t+wMBsmS+b8cA2IfTxt2/oLmdd5z6hwnEHv2
         PLAEl1v/lNhrsupyaDCMVlVbbrxm7zlc2ZqYkVyBVfxTmhUhhMS3wg/WydX0P75rMYBS
         ZW5PwqWypJx7O1c63RP696fEhSlr/6L/WMJq388Ca6xRrx1Dx4hD4ErI+TPZXdGlRuO1
         yf6fmQi0wIttpaajIjiGMG+6/Vv9Wc92U5XPE5NUhvcHCQ2eu2+GfYm/TGFZAKl/2ILS
         AAMZ3PNKue22PiuxzAhmqrRpTBGIwlHHUwfRMZRkO1tb6r2kMGSgzI96RwjqYj0tEv3u
         xGAg==
X-Gm-Message-State: AOUpUlFNKZbciUxp1FY5C/H3ULomVH6f332XKmqjI0zULGUwfntKL0kk
        hgzRRjqmS6NFg8W0QHGZpSYQjA==
X-Google-Smtp-Source: AAOMgpewWO3PsG+F4nVriU0xSH43HoBXO0gdEokqd2fS6Kx+eMe9U3ewpJAEhF3nPkMXBAiXyTiPbw==
X-Received: by 2002:adf:ee4e:: with SMTP id w14-v6mr4787975wro.63.1531479795918;
        Fri, 13 Jul 2018 04:03:15 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 2/9] dt-bindings: ata: ahci-platform: document ahci-supply
Date:   Fri, 13 Jul 2018 11:02:59 +0000
Message-Id: <1531479786-4911-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional ahci-supply.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb81381..5f362af2724c 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -33,6 +33,7 @@ Optional properties:
 - target-supply     : regulator for SATA target power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
+- ahci-supply       : regulator for AHCI controller
 - ports-implemented : Mask that indicates which ports that the HBA supports
 		      are available for software to use. Useful if PORTS_IMPL
 		      is not programmed by the BIOS, which is true with
-- 
2.16.4

