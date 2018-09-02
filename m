Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBF9C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797ED20857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="CTcORR0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797ED20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deutnet.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeIBR1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:27:40 -0400
Received: from vps.deutnet.info ([92.222.219.9]:50136 "EHLO vps.deutnet.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeIBR1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:27:40 -0400
X-Greylist: delayed 2114 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Sep 2018 13:27:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6TqfxUgw7DJGnkejUQL04NZu8Nj3gvfJ+V9JHrBoDWw=; b=CTcORR0ahZkLdBSROi9UsXSy6N
        BMyTancwCTk+cp3ndaFyR8ZHehtv8gVh5irNqE8qnKcbvmfZe84qJbQHF+56BlkwFRpbX42aSKHK9
        pve379ezFlz/y+NyoTE1CJBVeAetL5mUvcXi5J+U9emO0iSsmI29EISqfalBHqu6aZFm5l+nA+9co
        VkKhXL5QMgSutS9mgLDQVMhzYD/ZwcJeiqBSP2yTDaWKpQNpU6Zzwx4vcyuTuwLxLgswUTEba6Hsw
        ujvZ9Pcc1Df5kn3ULYdbAsyQIJPvhAj9tMfcV9LLyoh2crBbtpYGs3jRt0N2IDMaZxX0LBuCMEFTE
        Dxk/QlOS8fBDhVz2e59fTRqZlzVdLU817JmzqrLxTCVQb8n1Fxx35vI/3uQ7bKN34vG0dVzLlrebB
        mpuRa8x36pf3OIw3O+taJqgqGzvB2AXrLypWPaWi93B5Fy47cHj9LTBHWqDeCRKKgzUjRnK4m3yGa
        yt0DIs8DMyCw5o8pFcrjHO/ZykkFyN2XKAeTA+q0ww3TXhKb09hoUp1mGzMHQj36SLk1DGaSO4hUl
        lQC+TJdMz986Mz5uWd9+eE+AbbsZpy/HNkq18giZFGtdGtQeu2fX/N07USdTUDPid1Gk5fYI/INTw
        YxvZOM1xMkmW7BtQFWh4KcQY79uJHTIXAGr5e+3Ps=;
Received: from [80.214.146.141] (helo=sonata)
        by vps.deutnet.info with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <agriveaux@deutnet.info>)
        id 1fwRcR-000281-81; Sun, 02 Sep 2018 14:36:43 +0200
Received: from agriveaux by sonata with local (Exim 4.89)
        (envelope-from <agriveaux@localhost.localdomain>)
        id 1fwRcO-00027Z-Lg; Sun, 02 Sep 2018 14:36:40 +0200
Date:   Sun, 2 Sep 2018 14:36:40 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        agriveaux@deutnet.info
Subject: [PATCH] [media] saa7134: add P7131_4871 analog inputs
Message-ID: <20180902123640.4xiyc66rdazzubvo@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The saa7134 Tiger board has a front panel connector at the back (labeled
panel 2 on the PCB), with S-VIDEO, composite and audio.

This patch adds those inputs.

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 drivers/media/pci/saa7134/saa7134-cards.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/pci/saa7134/saa7134-cards.c b/drivers/media/pci/saa7134/saa7134-cards.c
index 9d6688a82b50..40ce033cb884 100644
--- a/drivers/media/pci/saa7134/saa7134-cards.c
+++ b/drivers/media/pci/saa7134/saa7134-cards.c
@@ -3628,6 +3628,21 @@ struct saa7134_board saa7134_boards[] = {
 			.vmux   = 1,
 			.amux   = TV,
 			.gpio   = 0x0200000,
+		},{
+			.type = SAA7134_INPUT_COMPOSITE1,
+			.vmux = 3,
+			.amux = LINE2,
+			.gpio = 0x0200000,
+		},{
+			.type = SAA7134_INPUT_COMPOSITE2,
+			.vmux = 0,
+			.amux = LINE2,
+			.gpio = 0x0200000,
+		},{
+			.type = SAA7134_INPUT_SVIDEO,
+			.vmux = 8,
+			.amux = LINE2,
+			.gpio = 0x0200000,
 		}},
 	},
 	[SAA7134_BOARD_ASUSTeK_P7131_HYBRID_LNA] = {
-- 
2.11.0

