Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857F820645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857F820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH1Fp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:45:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38010 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbeH1FoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:19 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so21258oix.5;
        Mon, 27 Aug 2018 18:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ssVMKn9XbmAgrX5MzFOLI7YD7OCtO06/Qj2Ucr7S/Q=;
        b=a6iuJ476o5wT1VQeXXybek3GOzOI5JOUHT3NmXfVHvNVtQ1tMCwCNPnfDdMUjgiH5l
         g3jnxNOnsKIP5txU4RRmxS+/Cd5Bg1SgtI3msBGz1XEP9gGDklCR7Yzs247j/jSpIBDa
         UqI4K7sVI4B8yeGmOR8AG4Oex2wlTdQ+n860cSMAxN003Qs+2xsHek/Fa2aQE9kuI9s3
         /NCo+xWxqBF++hWgmDQIntVIUuAddzOjMWAiRNnKAwzJ4az8GyTqufp/zJCMa0pTdQte
         n+ZLMENgnA4o9CL3nF/DBwfxfl+hJxLfNScVK+6JhR1xdIh+JS7dTrgfByy5PLwzwkmm
         bf0Q==
X-Gm-Message-State: APzg51Dsk0G0OgbLpMYFAIj988MWYSmEW1oaY/c8xvT6r71ovI1HMPNn
        QFx1SmiO+rwIeKqjUnK2yxOUWIA=
X-Google-Smtp-Source: ANB0VdZwGx9VGI9A0UBwrbtYDTsUdy5AmdQMn8gKGvNJ20HejtT3CNHKdURy7gCG0Cp1MGHLccFFhw==
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr1143761oib.320.1535421303064;
        Mon, 27 Aug 2018 18:55:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: wireless: ath: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:37 -0500
Message-Id: <20180828015252.28511-36-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 58fb227a849f..54132af70094 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -710,8 +710,8 @@ static bool check_device_tree(struct ath6kl *ar)
 	for_each_compatible_node(node, NULL, "atheros,ath6kl") {
 		board_id = of_get_property(node, board_id_prop, NULL);
 		if (board_id == NULL) {
-			ath6kl_warn("No \"%s\" property on %s node.\n",
-				    board_id_prop, node->name);
+			ath6kl_warn("No \"%s\" property on %pOFn node.\n",
+				    board_id_prop, node);
 			continue;
 		}
 		snprintf(board_filename, sizeof(board_filename),
-- 
2.17.1

