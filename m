Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164102AbeE1KzH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164320AbeE1Kyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 301/496] net: dsa: mt7530: fix module autoloading for OF platform drivers
Date: Mon, 28 May 2018 12:01:26 +0200
Message-Id: <20180528100332.503087576@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 3c82b372a9f44aa224b8d5106ff6f1ad516fa8a8 ]

It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
for the OF platform driver. Otherwise, module autoloading cannot work.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mt7530.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1122,6 +1122,7 @@ static const struct of_device_id mt7530_
 	{ .compatible = "mediatek,mt7530" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, mt7530_of_match);
 
 static struct mdio_driver mt7530_mdio_driver = {
 	.probe  = mt7530_probe,
