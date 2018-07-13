Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31CF208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s3njyCqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31CF208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeGMMDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:03:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45923 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeGMMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:03:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so12157668wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=B2Bhy9NOZrFUvsZXtDtHNlLEOdUNrylO0yWqsdOIMXA=;
        b=s3njyCqQLS6L/Qw+qZsk/6mof0GuUb3HLOWyenD7UfRMspzsFla6lxQm71FAUXXyi/
         SII3yOfRsqQpR2zDqlLkVU12XLUXUaKTZwIl5dTUOp52vjQUKKy3LwtILL/eJtf8mz7w
         jO04fGlG8BxK2bEA9gQgWAhohxLn3iG40+ipTnbJFJ57JfCTCy0FtOFkj8d9ENY5n8Jy
         zaNR8i2m27qaO3Hi9TRpGSybNCdSrpVbF+kP4aQbPP9fCyXLF/xtITXhXu2du+KOZJDY
         tgJ7d7PgIumAPZCS8jDxJ+uq9mvn1eKhDaM3J11v2LTiA6eymElWs/VU0DtMOcYGuJA6
         6GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2Bhy9NOZrFUvsZXtDtHNlLEOdUNrylO0yWqsdOIMXA=;
        b=qq6keoYYAPK8/Zqaa9QdSYkVynPO29gt2pjXB8U0E5IrupSSDYhthcbH+Bv4PRqf2G
         I+n2AcDZ+iBAvh4u1gBnwp6AK3+n5AiyA5upzPH1TDo6C4nuCPu1yLgXJzK5HI7aovaA
         2w7V3IlkzHxbZf2VeIb+SJhekNAbRg4+87VyuJnEjL2tx07GeUwlmMkN5tTW2cS1Tblu
         +17l2J1dJhUj8ZzA6R6IZc6ndtJiRbZYzgnHUvkxGXmMdZsKYKBlpfSIJLAmIol0hqJ0
         gzLoJVyFXVzXlEohRTSc0kneRzfEUe2WSw+ZluYwoh+0r35IuveuoLkKzR8JzhIoqZYA
         ycSw==
X-Gm-Message-State: AOUpUlGwfjBxw8d2r5aF3Na2nCxc6H+YobS1MX6m5E6f+wsfX0/za/JO
        kDX+6ZNjMnlC1GktS+CQJydSRA==
X-Google-Smtp-Source: AAOMgpclUdeYdp4ANV7VicUYkMaMetImSXf/JuHm2wB2UIIEG8Tys5peJ4MN9QYXXE8auQjMzdvQeA==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr4780969wrq.58.1531482538643;
        Fri, 13 Jul 2018 04:48:58 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id j11-v6sm30508873wrr.37.2018.07.13.04.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:48:58 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.torgue@st.com, maxime.ripard@free-electrons.com,
        peppe.cavallaro@st.com, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix typo descrive => describe
Date:   Fri, 13 Jul 2018 11:48:42 +0000
Message-Id: <1531482522-10824-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a typo in the word Describe
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2e6e2a96b4f2..f9a61f90cfbc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -37,7 +37,7 @@
  *		is done in the "stmmac files"
  */
 
-/* struct emac_variant - Descrive dwmac-sun8i hardware variant
+/* struct emac_variant - Describe dwmac-sun8i hardware variant
  * @default_syscon_value:	The default value of the EMAC register in syscon
  *				This value is used for disabling properly EMAC
  *				and used as a good starting value in case of the
-- 
2.16.4

