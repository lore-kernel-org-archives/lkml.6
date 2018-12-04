Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76C32146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="08V/3eWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76C32146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLDKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDKzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E36C82146D;
        Tue,  4 Dec 2018 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920924;
        bh=jXUTERnY2tceFqicq0ziEg34xm8fPQoLcYpTfL7ezjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08V/3eWURJV2IsRsN1DPRKd+ZO3wruBfBpzl27F++JE2I3/PNqiNiTaCemjtSSgSO
         3klxFicOXhVOxCrL1L+kdxFOnB5868YmijHdINTjBoLgHc2PjFsmuYcr2Jefj8oimD
         NRrALqXiZztQRQvhtLIJNngSqdxkeNcdv1xLsQwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Fiedler <andreas.fiedler@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 013/139] net: gemini: Fix copy/paste error
Date:   Tue,  4 Dec 2018 11:48:14 +0100
Message-Id: <20181204103650.532332859@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Fiedler <andreas.fiedler@gmx.net>

[ Upstream commit 07093b76476903f820d83d56c3040e656fb4d9e3 ]

The TX stats should be started with the tx_stats_syncp,
there seems to be a copy/paste error in the driver.

Signed-off-by: Andreas Fiedler <andreas.fiedler@gmx.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cortina/gemini.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -661,7 +661,7 @@ static void gmac_clean_txq(struct net_de
 
 			u64_stats_update_begin(&port->tx_stats_syncp);
 			port->tx_frag_stats[nfrags]++;
-			u64_stats_update_end(&port->ir_stats_syncp);
+			u64_stats_update_end(&port->tx_stats_syncp);
 		}
 	}
 


