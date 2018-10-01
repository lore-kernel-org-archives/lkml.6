Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97991C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617CE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJmvrjkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617CE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeJBAMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:12:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:12:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so8428891wrw.12;
        Mon, 01 Oct 2018 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylSKkJex51bmkXE5d2+E0OtuYc6WVCdX84LM57m5W9A=;
        b=FJmvrjkzAY+RhnGjtkhXsUlnXRqYIr6vus9KYOzSIIon+mm/qaAcFt66rbpuDXsxSa
         SaoVa8bv4NeiS0e8A8303zIAyvaeadBX6JSVsINXPh37UAuVn19YcXM+S02Mj8NtIPIH
         5pVrwCtDieqE0Cc4rtLRnIxCDssrJcPSgzJUpbLZwIansHBx5imaqpvHcLgUhVgww4dQ
         il2wvrCNvpisz7EDRrCYlAyNw1vrVd3eo98NP2m+8P7wB/K63LZNg13aU2Ol6qSPMjcd
         fzQYpzLMrzz2tw6RiZ7TOZk1n7WN/lTBZ8gJ9jGKrQ58hgvLBdVmb5Ivc0oEhqsTd+ZF
         LjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylSKkJex51bmkXE5d2+E0OtuYc6WVCdX84LM57m5W9A=;
        b=e5RhGseuG+rvWPRbQK18cbtKmEtKWrWhN12sWVbQVUxC37ybYLDhzGOkNt+4AlkopO
         rnMVFPUeJd9NHkYlFzu4s+wOWPmbxnYa6KQ0QL+Ir21rsa79YezPVB0N9Gz0sxjcHAjD
         C+rZ2trd4SESTsN1QQFdQ2bPS9UydbrskgZRtJzCnUcmb+mgDtxx1RPVDgk6sRbzY1DC
         1MGSa5rGICkTwgbftwCEF280S1rt/X/cvDD2Ujei4OXAocfycP+l/vgL878XLeYDx4VF
         nx01yAFnJohojZ048jE+qxNF39zCtkOx1e4rNKz2pmVcKeaxFQpWh15XidFoUQig4SU0
         hjAw==
X-Gm-Message-State: ABuFfohfZkmLriZ7chs7ASQ666KIMRiff1MuUWZabxV50w/iA6Kpqq2S
        PmEWi+VtxqRAfio3kASXBJDa6yUC
X-Google-Smtp-Source: ACcGV604WwoMHlUz8zhiY8BOssKK00uMjzNnvYKLjlOGzNrcq6rWg/4yupl7MK5xFsdwX+bOC0auNA==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr8341041wrx.146.1538415196445;
        Mon, 01 Oct 2018 10:33:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7840651wru.31.2018.10.01.10.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:33:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 1/4] dt-bindings: ata: Document BCM63138 compatible string
Date:   Mon,  1 Oct 2018 10:32:59 -0700
Message-Id: <20181001173302.25398-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string "brcm,bcm63138-ahci" as a valid
compatible string for the standard Broadcom AHCI controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 0a5b3b47f217..7713a413c6a7 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -9,6 +9,7 @@ Required properties:
 			"brcm,bcm7445-ahci"
 			"brcm,bcm-nsp-ahci"
 			"brcm,sata3-ahci"
+			"brcm,bcm63138-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
-- 
2.17.1

