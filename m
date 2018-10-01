Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D87A2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGJdXDig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D87A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeJBAMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:12:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37105 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:12:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so4135213wmt.2;
        Mon, 01 Oct 2018 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EcNfXB9HM/JmAp+yBkpNmpznB04YKl8oq+1iYiX497E=;
        b=RGJdXDigiIFC8sES9plEoDUXp8Efm8MfnMufdL1VOUxMeJnTTS7vsYgawj1Eopmfij
         6nvXtFX7qXCYTzpbzGIjdummw0LcZ6pZnrVs0wJQPNNvbJ2bI+JEa3La1v7L19p1Ov9T
         ko5Bz5rVrOoA/9GUAlSSvHR13Qo6RnFtRlWYa245ndDk/J8y6MRYFPrsKyupGZaLO83X
         es3+oJiWrljk6UonOQlQNAkvLFbJqaQxC7pQ6OMt/EYFOfZn6337W8fqoKthI2nQNY3c
         6XRF2HJvUf/tq/EpaqGeyQsDjzYChRsKqgRw32ppYPmz5Tiwvl4blKa8K94oQrjTBYK1
         GsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EcNfXB9HM/JmAp+yBkpNmpznB04YKl8oq+1iYiX497E=;
        b=OcezZbB/pVYZg9dzvH/nzToX/VRhPX4uy4JbfLerwvbJ27toXMBE5l60+2FhFCCRkf
         OBMpZ+2wkorU/etqVdtRVKPkL+1lMtdOe6yQL7FJWZp3JJLlnxAlScJplwBAHd8ZFe4r
         IC6cRgOOjz7cmx0Qd8x6/ny3wKoQFpyqJtzhHmIg6zidVHJO41sPQyF0Vb3cf0dnrOth
         f7Z9iNTF2nYkfc7LCHC/h/t62nyKk6bC+4SsnQLzaKbSK3WGXC0wnryMRkYWny7MDVxm
         yL9ZGf6LP0VH+dRt8ebPUXbyW7qFuD82eR2LnaODuJ7ij08u6jCezcU8tozcg89qjwmi
         zDzw==
X-Gm-Message-State: ABuFfohaflpIynn7zdZz5ELGZ83L/T2Vp8H7CjZ+Zth4bO/K+AR75b72
        gNdknrctS8DR89qTutlSDqIhBUqC
X-Google-Smtp-Source: ACcGV63cZWAqz0gnDdSAg2uuAkwCc4T6/7UlPfM23MiAqAuqscfd2dIN4ukN1YfWh/nzzJKN3qD/zA==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr10377664wmf.43.1538415202150;
        Mon, 01 Oct 2018 10:33:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v16-v6sm7840651wru.31.2018.10.01.10.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 10:33:21 -0700 (PDT)
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
Subject: [PATCH v2 3/4] ata: ahci_brcm: Match BCM63138 compatible strings
Date:   Mon,  1 Oct 2018 10:33:01 -0700
Message-Id: <20181001173302.25398-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the "brcm,bcm63138-ahci" compatible string in order to allow this
driver to probe on such platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 0e401b7c0856..fba5a3044c8a 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -383,6 +383,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7425-ahci", .data = (void *)BRCM_SATA_BCM7425},
 	{.compatible = "brcm,bcm7445-ahci", .data = (void *)BRCM_SATA_BCM7445},
+	{.compatible = "brcm,bcm63138-ahci", .data = (void *)BRCM_SATA_BCM7445},
 	{.compatible = "brcm,bcm-nsp-ahci", .data = (void *)BRCM_SATA_NSP},
 	{},
 };
-- 
2.17.1

