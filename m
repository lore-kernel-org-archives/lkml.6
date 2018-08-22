Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FD92083A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="aZrhQhcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLUarz/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FD92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeHVIVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:21:22 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42869 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbeHVIVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:21:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 92CD82F5;
        Wed, 22 Aug 2018 00:58:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Aug 2018 00:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XqsnZC+aeLNUENOr5
        youAetQsJiesBumxStsV4vmDpg=; b=aZrhQhcqiserYlFHz3BbzFvBoEUfaYDrN
        lL60SxVi7R9wJK6BcxuwFgfP5yRCe9xGr1XOVZ4JRZxJuDPJzTOEe9AXlHWcd8du
        P49xCvP+O+JDvX8WEZwfDl1hqLiPCBuy7qpNJokvETQ6tYjzvMRsa2uoymaE5yIm
        88bdL4OfRFwz+tCf33V2md13Ev9f0tdIZcpyRekBJKIZFBdniB5UDDSqsrbtycvV
        lwTCwwL5xwaesfoVF2fsUIG2hUcX+Mfk3DdxCt1f1Sud+x10XT+2T7pNwvPkFM0x
        vonkf9cBV6ii2mgKQZvsq4KdrkNTd+zPJRKlXHkRW36+ztYbyU/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XqsnZC+aeLNUENOr5
        youAetQsJiesBumxStsV4vmDpg=; b=LLUarz/99moY0e5Y8XVLhpr2WgaqzW3OX
        BF+2HyiIslwg1IIqvMRXhhiIsaXoiu0+AxHbdgvp8VAPVqz+WDoDYDKdt34QMsJ8
        Gg5Bz+RbLGGm1hAwWuk5ZU3MZwzp1gHzYy3nCQe+ULPzhEW4+ClY7zaCC+9Hvs+0
        ljtB0cWcgcrR58cqhvZR/ZwPTO8GFGzG9qCwykm0+G4uC0OT3FVDD4xBOeDFYGKC
        Va84c7JQd5UTFMztyWWxIpLlmuWo2pz3FNlqiNAC7GyagXCEGs660b+65pLGQ/ck
        rXUclGaTpcOpyqpu0iD4ffTYxz9IuXz5RpYS97nGVL5UB1rUMDY+A==
X-ME-Proxy: <xmx:X-18W5H7UetTYEtBsGjtEqn-1BTcivB_aUpEMfCCdj-r2UxpDoiW9g>
    <xmx:X-18WxSBmZHIpU3vLptMmLfmh32jpjMvB2W3ggaoYvug3kVMFa8sMg>
    <xmx:X-18WzVCjJtJpnzTCB5MPyA6CVPiFkUCkQNS9SUnkt70ailMnROUKA>
    <xmx:X-18W95yCdrCzE53uLvDjSpX5rGqxFa2CmV3jTU9rcxKYZUreLQFhw>
    <xmx:X-18W-G5tNghyYipboGdJTML9KEzoO6QGUD3lY-fuNOwm-p2dBNvSw>
    <xmx:YO18W6aLpkyLcRtXRCQjVW-fOf-HfTBt_8gyN2QH6WHUeiNevp-sow>
X-ME-Sender: <xms:X-18W0kSjAU8vntNG7EO5r3JhqADjY68DiZSibpSEdMIxd6r3aCgAQ>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77725E447F;
        Wed, 22 Aug 2018 00:58:05 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net] net/ncsi: Fixup .dumpit message flags and ID check in Netlink handler
Date:   Wed, 22 Aug 2018 14:57:44 +1000
Message-Id: <20180822045744.9267-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ncsi_pkg_info_all_nl() .dumpit handler is missing the NLM_F_MULTI
flag, causing additional package information after the first to be lost.
Also fixup a sanity check in ncsi_write_package_info() to reject out of
range package IDs.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 82e6edf9c5d9..45f33d6dedf7 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -100,7 +100,7 @@ static int ncsi_write_package_info(struct sk_buff *skb,
 	bool found;
 	int rc;
 
-	if (id > ndp->package_num) {
+	if (id > ndp->package_num - 1) {
 		netdev_info(ndp->ndev.dev, "NCSI: No package with id %u\n", id);
 		return -ENODEV;
 	}
@@ -240,7 +240,7 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		return 0; /* done */
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			  &ncsi_genl_family, 0,  NCSI_CMD_PKG_INFO);
+			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		rc = -EMSGSIZE;
 		goto err;
-- 
2.18.0

