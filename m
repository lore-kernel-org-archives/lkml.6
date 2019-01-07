Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADCD20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865718;
	bh=j7mV8G4m1HXyUsdTHABauTZYfqWueeZ6TZwSdgKqEn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tT3yVwQnRrbW3NW3Tu1Klva6WkK3pFdYWhncCxZumanfNpQWdZ+X3IaK5HpZLJLqJ
	 Nv8EH9mT5ZB3azdiDiPEA/npf/y2owboK2612UnPOwHLvFm3D6fqZXktr4Y6Ko6kuz
	 G1jK27pFt/8+aQh2Io1puYnTFtmbHnVaJqNgNU/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfAGMsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbfAGMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B889F2089F;
        Mon,  7 Jan 2019 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865299;
        bh=j7mV8G4m1HXyUsdTHABauTZYfqWueeZ6TZwSdgKqEn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQA/tWyhptrMGTzTCGBe4NZ/oaVBSnrf6k0LIm/rkCAK+YzSYvwnHGCemWILnE889
         h0UT9KGlhMjtEpANUfr84/02lvGdjXd+bF1NawChj9M67cOdCBiw2KxRsTifSVNK0y
         hRURY9ngSTfep/br5EQwNtaAPUNaIgU1pkr7Y4sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 048/170] mscc: Configured MAC entries should be locked.
Date:   Mon,  7 Jan 2019 13:31:15 +0100
Message-Id: <20190107104458.839565009@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: "Allan W. Nielsen" <allan.nielsen@microchip.com>

[ Upstream commit 8fd1a4affbdafda592f80cd01bf7a382a5ff2fe8 ]

The MAC table in Ocelot supports auto aging (normal) and static entries.
MAC entries that is manually configured should be static and not subject
to aging.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Allan Nielsen <allan.nielsen@microchip.com>
Reviewed-by: Steen Hegelund <steen.hegelund@microchip.com>
Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mscc/ocelot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -733,7 +733,7 @@ static int ocelot_fdb_add(struct ndmsg *
 	}
 
 	return ocelot_mact_learn(ocelot, port->chip_port, addr, vid,
-				 ENTRYTYPE_NORMAL);
+				 ENTRYTYPE_LOCKED);
 }
 
 static int ocelot_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],


