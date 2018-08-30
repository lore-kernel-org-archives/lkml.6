Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DDBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA120837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PThgoGAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeH3XFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeH3XFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so9012418wrw.7;
        Thu, 30 Aug 2018 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+HNfr3I0MzGHGd7Aj3LN1rm33wfTbHxswxtDehlIDw=;
        b=PThgoGAPiljUk94JizmwB6pajpMFObk5uy970nta1s1e70QjLBSghpncln7/h8OklD
         7cFkrrNca7sHbPDLGTeA2yaALPF++Syt4fhIbxUuG8rol66lXMQ5FrBCtzjJaugUenFK
         7VdHho6Z7Nqd28SbUJY/qVafGEC5amkUfipD77lY4EUw7NZXYr4X+cyPq2pUJ0fE6wIe
         4nhl/lsQJtNEnnNgvNFvh7140iLwhKbKF0x09SM7QflYTL8dk1DPcVJYB0moE5LFDtE/
         CSKAvOQyvDreFuCGEkmNtBgVAe+pYIjKMRe6UI9nNSCn+wC72DBQ0BmguzOT5cO8IA+P
         dVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+HNfr3I0MzGHGd7Aj3LN1rm33wfTbHxswxtDehlIDw=;
        b=ihM09bPNvJDBKIVu+TZzHcd2nFTzvonvsSfgVklhTePcbdXU1DlbA+ZZjkPgr6wyI7
         s9hU/Dze3+ui+kN0rhvvORzXSGZIO4KqET+t3IIX1CMIKBAoOx0QTdhz+hqIk+m8q7ox
         16h80dgALg23ViDc12t79xWePvupumPVK6TiRPH8AZ0KVh3Hl5T4iC1odavprDxto5PY
         4RWlXYIYNrFtsQ+/BiuRi3xiHiIyhzLNMbzo+APfUQrQu6niCMKvXGab49hkJ3F2H7Us
         PjXcL8hepN2AM58CYqrLERj73TtRhkZeq/K/09GscjxHcsZTLdDR5X7HIRs+PHP7y1c6
         RXWw==
X-Gm-Message-State: APzg51B5tyexEhiqt8B6D4KKAtQdM8mN4B+M+MAvgSP4MFm9Odx4Y7sh
        H/xxxVsOTRIpRaI++5AXvhE=
X-Google-Smtp-Source: ANB0VdaalCsRbYx/Q0GUikEdPntcQpegLLgk7pWIb70v2qIy7lkr8MQIPvRy+o1VDT1E4fhFUQlZgw==
X-Received: by 2002:adf:fc44:: with SMTP id e4-v6mr8826662wrs.9.1535655693376;
        Thu, 30 Aug 2018 12:01:33 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:32 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 03/13] dt-bindings: ata: ahci-platform: document ahci-supply
Date:   Thu, 30 Aug 2018 21:01:10 +0200
Message-Id: <20180830190120.722-4-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional ahci-supply.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index b88820b4c01e..f495774c8af9 100644
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

