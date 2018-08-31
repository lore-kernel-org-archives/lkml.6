Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C7FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C790204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C790204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeIAAtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:49:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41318 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIAAtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:49:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so5934910pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MzwmOORP773QVZfN+zCU1aKTEQE6vSxB9vK8cSNRRqM=;
        b=Ev1trUXfA8ws6gnCjQqlhbskgPPVU3w5LqZKTMgNCCiXTvyklcGWOE+H9IZPXvU4Tl
         oMUOkYhjQwg1AHcjzQ9wZk9iJWrPxyyuAfcVHGfFTepZxR79V+4hnz8UViF7Q4F3krto
         9WlnLcjlTj4uqbty9UDMtcyf62pps/PQGXuy6y1cYPfIlxlshk8doSVIW/GHynhkw4xt
         0g3eTcfOzlHToiCZuanpOWdthn0LdvW36rZLbAcnEMqvGH4XjJSkMoEEGYsiUw2hftAH
         AmZT+kpNpbdFCNHMNYsKRKC4ux2EkjoIOSiRzX+J79kptXskskPJS+/WnfQ7Cf6ixhlb
         jzSA==
X-Gm-Message-State: APzg51B7SB5TwpBHlXWQ4Iw5tu4GhgyEhsZ0iFatZtdUe+AUbwPxEvbV
        Tr2eceOT2dw94hItXy+J26Cm2A==
X-Google-Smtp-Source: ANB0VdYscL+L3XPfH2QFSM3k0qvSEXslSjxCDCUzGKbNisEIQFWMcCVrrBWO+AGHL3sibNocFl1ghQ==
X-Received: by 2002:a63:e756:: with SMTP id j22-v6mr16068833pgk.185.1535748002984;
        Fri, 31 Aug 2018 13:40:02 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id g20-v6sm14857570pfo.94.2018.08.31.13.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:40:02 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, moritz.fischer@ettus.com,
        linux-next@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next] net: nixge: Fix Kconfig warning with OF_MDIO
Date:   Fri, 31 Aug 2018 13:30:54 -0700
Message-Id: <20180831203054.12132-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Kconfig warning with OF_MDIO where OF_MDIO was
selected unconditionally instead of only when
OF is actually enabled.

Fixes 7e8d5755be0e ("net: nixge: Add support for 64-bit platforms")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/Kconfig b/drivers/net/ethernet/ni/Kconfig
index 04e315704f71..c73978474c4b 100644
--- a/drivers/net/ethernet/ni/Kconfig
+++ b/drivers/net/ethernet/ni/Kconfig
@@ -20,7 +20,7 @@ config NI_XGE_MANAGEMENT_ENET
 	tristate "National Instruments XGE management enet support"
 	depends on HAS_IOMEM && HAS_DMA
 	select PHYLIB
-	select OF_MDIO
+	select OF_MDIO if OF
 	help
 	  Simple LAN device for debug or management purposes. Can
 	  support either 10G or 1G PHYs via SFP+ ports.
-- 
2.18.0

