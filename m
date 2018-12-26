Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC60C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3622E21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aDC3lT5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeLZC5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:57:44 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36182 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeLZC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:57:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 78CAC9A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qm_HhI1JPXx0 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:57:42 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 48A3EB71
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:57:42 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id o22so18383839iob.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bhyNc1efrIcsohjpviRrNYPtA0fyraSlCXmX66e+qJg=;
        b=aDC3lT5NDrWmPbvmp5vcZeIvwtyNIJfW0PprDSEXRmjA9VRM7LCR54KUJ8xcSSMYo5
         E25wzBxzenUZbYohu2+3LWkOA0sonsx/sR05lLZM2VpMITMO7HZApyllgw80TnC/5jm7
         uPSKhquK7x3eJLci+QdBDSfS+ywzzl3jPHBmGSu9rHlUBhP65VZD3Cfj+vZzCbzG4sGX
         Awi1ehsV2mHEDAvbYRpUIgs6g/92+Ll2wYnqWdd1QNJcASnUkIJRLxJ0cOCpz5FiRz8i
         GPAgdaQCSpHApJwNqMlTbcZ4HB6/+/ipfYXHolNsnww8Zs73re4WDrsC/l4U6QQCHJsN
         MHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bhyNc1efrIcsohjpviRrNYPtA0fyraSlCXmX66e+qJg=;
        b=IGXUhiMef5PfiHzyv3HxdiLE29BeSN+jPzRsBhqm/KR8hiq3rfjsDp0BUMChGg16l8
         CNbkgzhk1r1NRMZcgHczcO1FpkvegBDC2k2FZfKzJUvEz03ANY1oxBsrSeg+jrP2Yh+I
         wsHegvZ/OrdXe6eoJ4pjH9jX7io2VFU+CdCnLiW9gtSRxwRD1FDJ7HrypCx8o7JixxYt
         3g954kJcxXKF/MV+FC+vAnDtKw1KR5/kvEFIHFWtL8wxXFQ/9Rv0YW8VZYwNhnP01baI
         OVGOlXQndys1ObFSCXRBcvrEEngo0aowyQ8pAk8yzABYytRHYMH6HNYk7a4JU1Agy33/
         MdGw==
X-Gm-Message-State: AA+aEWYf/RbP/Zv486T7+1bLhDjmR2D7dv+6hpuKXFLUlIwdUJt0BkXR
        cOkrAR3k7OMmjLwLcu0RFM6a//J7jypJl6GRuoM+KcMf1p3eJPBo2JgmR5DIae6gJShUaajv6Hx
        v8eGVTgncpK8MRj6bJn1HHCTpBfyR
X-Received: by 2002:a24:f909:: with SMTP id l9mr11222479ith.74.1545793061874;
        Tue, 25 Dec 2018 18:57:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN52EogG7kT/jqoSUzzUacufuuLL4phDyf0eIYVY4uj+lVuqtwCUGerGAXsaUvDaDYd2Fs58zA==
X-Received: by 2002:a24:f909:: with SMTP id l9mr11222472ith.74.1545793061683;
        Tue, 25 Dec 2018 18:57:41 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id b192sm11676951itb.12.2018.12.25.18.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:57:40 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmicro: fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:57:14 -0600
Message-Id: <20181226025714.72643-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index d07520fb969e..62ccbd47c1db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -59,7 +59,9 @@ static int sun7i_gmac_init(struct platform_device *pdev, void *priv)
 		gmac->clk_enabled = 1;
 	} else {
 		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
-		clk_prepare(gmac->tx_clk);
+		ret = clk_prepare(gmac->tx_clk);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.2 (Apple Git-113)

