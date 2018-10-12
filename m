Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF594C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FEB20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FEB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJMD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:26:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeJMD0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:26:55 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBmDy-1gN7Fe2ipo-00CBLi; Fri, 12 Oct 2018 21:52:34 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBmDy-1gN7Fe2ipo-00CBLi; Fri, 12 Oct 2018 21:52:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        Nithya Mani <nmani@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] octeontx2-af: remove unused cgx_fwi_link_change
Date:   Fri, 12 Oct 2018 21:52:22 +0200
Message-Id: <20181012195232.4024123-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:L13HEqzyhNyByUk8O3uyLFXoaePJwV39to0xAel/zs4OZBUKbVT
 7ql3N/BjpSoKr9rB+ysVsVSQ1IXa0reYbvJz0LapRofu9B4XCbFR2d5/+MiT9dXZYJlLdjz
 H4mMNKg3Y4ANmswroFC1HhCxAC4guOGCGDmfhI9o6r7oyhNdhtRYmY/QMEIh+pXmN/MwE4y
 FN+Db/BqoRLKaixTeQRUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fjkqDAfI1uA=:HDIlaabvYnl1b64sb5BXrc
 n90JWf7kww5B63VpJVJZNdAUBZ58TL3UaigPMAijB1kLfopRt9Zl8R9bheUPXI1jFHePhcdeR
 nR7MWSlcjyjP4WYwIZpD33CNg0lpFcppsZ56owGXAgcWiaGvH31sMZVgZlttlzvP4hOz1Mp4d
 x61vMSqc67AiEMqwKa6rGqOSykAdBAAllDRw15PNibkgjKwLCzdk1ddrlb54idL0YIr42mRQh
 W7oO2fxmUaPaqPunbGYOWxvXVIAF/MZaUg3iISBdzlRWmfs/mb1pcTgWcfsbErSCJW4M/XGUj
 JzHGmy1svUnETg6BtzQ8FBN/ro99nU9B0XVszbhuBZ7OoAPoL82CseohQxNiYmyW8YMZ4eE7n
 ofISJqGpnpognmLgaXn2vRdfOJ1o8adIgBg3hebkHS6O/oNoTBhsPX+EjSVxCzyF6r5HJQy95
 wSKSRPyFqlypMM7IhJoN2eoEVFgUeezYBGWHfbqIJ9Pj+hvbS8pIKDzK+PcX+NW2sRuX+CgQO
 Hjxb5OjX4Hz5ZUpj5Ui3josy/3FoJ6+nih7G7mNyLkRnmvENEDlBiHY8SSFqINtE5mXyheG0Z
 c9mc+hrV67n5MhVLgGoKLhI3V4UNK0+FKe44+NBiYF3qHmUfrJvjGeDPgy92mvJM2EZRj+wvL
 Vt8vqRCTJ5WskezJWEbn4GH8+jK1wxb1nl23Vh/3vbFh7M+d7NQUrF9kGV4Q6ixKXDq0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added driver causes a warning about a function that is
not used anywhere:

drivers/net/ethernet/marvell/octeontx2/af/cgx.c:320:12: error: 'cgx_fwi_link_change' defined but not used [-Werror=unused-function]

Remove it for now, until a user gets added. If we want to use this
function from another module, we also need a declaration in a header
file, which is currently missing, so it would have to change anyway.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2cf8e402c31e..5328ecc8cea2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -58,9 +58,6 @@ struct cgx {
 
 static LIST_HEAD(cgx_list);
 
-/* CGX PHY management internal APIs */
-static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool en);
-
 /* Supported devices */
 static const struct pci_device_id cgx_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
@@ -317,20 +314,6 @@ int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id)
 }
 EXPORT_SYMBOL(cgx_lmac_evh_register);
 
-static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool enable)
-{
-	u64 req = 0;
-	u64 resp;
-
-	if (enable)
-		req = FIELD_SET(CMDREG_ID, CGX_CMD_LINK_BRING_UP, req);
-	else
-		req = FIELD_SET(CMDREG_ID, CGX_CMD_LINK_BRING_DOWN, req);
-
-	return cgx_fwi_cmd_generic(req, &resp, cgx, lmac_id);
-}
-EXPORT_SYMBOL(cgx_fwi_link_change);
-
 static inline int cgx_fwi_read_version(u64 *resp, struct cgx *cgx)
 {
 	u64 req = 0;
-- 
2.18.0

