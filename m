Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B81AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F88E2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863944;
	bh=qO/RUNQ7eGBmwfQbmtmUsDtXKuV1qsGThvv/vyH4Y3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s8+yRO4LCSt2FwAt1Jldm17j+t+MUkLSUT2cNfjlXlmKqqoXtJLYj9qVt8UpCOQaa
	 Pt5nRKyGxJYXzTgj6NyX5zzGH7GJNHbOu9Ku34Qv/lIePoN2kiFnFOo6VWgVtbFdEI
	 sSvN3Lh7vWKvip90G6S12wN2/6x7p5i255sSNlVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeLZWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbeLZWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CB920651;
        Wed, 26 Dec 2018 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863910;
        bh=qO/RUNQ7eGBmwfQbmtmUsDtXKuV1qsGThvv/vyH4Y3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RD2hFaOwuXOJIHZknXmjvYVqHSeD/qOeafyjUqtNjWHURA8ryVtEsoPMbT9SKEMDO
         l4qZEOXLMo5682w3Lwud5P+YVF416NdN26jMuZxqNi/7oHkinyGIy8Q4UfDUEGVXMm
         08mCZ9FziMfXx5SHOB5FlBjbdl3xILVwNpCrd/JA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Allan W. Nielsen" <allan.nielsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 90/97] mscc: Configured MAC entries should be locked.
Date:   Wed, 26 Dec 2018 17:35:50 -0500
Message-Id: <20181226223557.149329-90-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index ed4e298cd823..0bdd3c400c92 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -733,7 +733,7 @@ static int ocelot_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	}
 
 	return ocelot_mact_learn(ocelot, port->chip_port, addr, vid,
-				 ENTRYTYPE_NORMAL);
+				 ENTRYTYPE_LOCKED);
 }
 
 static int ocelot_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
-- 
2.19.1

