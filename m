Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738B420862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="QxQSxx/M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lakmQwXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738B420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeKHMW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:22:57 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60813 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbeKHMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:22:57 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 70BFB2202C;
        Wed,  7 Nov 2018 21:49:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Nov 2018 21:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=7zGaLz7HQK8HBIwdkfhpaWhqIglc54Ism5j6RhMgnwA=; b=QxQSx
        x/M0F/oGSmglW3guJldinNiS/L6cZd5Ko8UZXQFxH2e4FmHJx0hXHMhizscGp4KA
        VpgoN1MzrXQIqJyCBN5qIlPNgduU6RnLZvsrImkLY+YvGAEdGzFF7HfORbXi5sVQ
        iUZcb6vQow+403EoPoTn7deL0pJTqrCQBEJVBEbrA1yeSgm8ui1vB+EY1mbJEj4F
        2wsCg+j1Ivi+bJIqpf1CbMI5aLEV5yRnYdE84rAgoDrUODb8KzbI6v0+Bg+S+Qx1
        Gti+BNEhCDW93FulX/oCQIRRJaX11YsA7KrnFe92+R8DiX0CeNAHAF95TlxlcJk5
        73PHb5wW/tXN+oHfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7zGaLz7HQK8HBIwdkfhpaWhqIglc54Ism5j6RhMgnwA=; b=lakmQwXK
        1DhoVm2JQ0NKdouf1bwDe1gSg94CMApiFTk/9Ztk1bN3/EIgjvP0g7Le/YgxoGH3
        +/XozmBQIWfbzuY3QZs05DDyjV1Y7WfR6AjqCFeXLiOOcEVuSz03rlyNmyDYjCRZ
        T5+0noNgDowEyP+dLrWszOb6CegYE2i3Wfp7XNiwhzFpJYdGRQDPCvDI4oyEz9zZ
        aqQvtC/fKpwEigEd20xz8c+0oBMMrvongmEZmLkHViSi1dCYRHmIM76QcrB12Mf2
        Jx7KxXtvK3mFdx+OG1tjllr7Wx1eVFGL2be/EbqLZJQCOqH5huuqzq4SFMsVNPl+
        clJHqzUts1Q46Q==
X-ME-Sender: <xms:RaTjW670MO7YRe9bYqmvkHvv8gkkV2-XXiiGS69js7ghZRqkFmBneQ>
X-ME-Proxy: <xmx:RaTjW3OHcbYHNIHmjvStgVdIdhn4v25Al3aYL7j8tI2laF1rLTyk2w>
    <xmx:RaTjWyL0VHpOpoC96BcpkmFN_5bED5-R69_7ix2qI270AzFm2M7xXQ>
    <xmx:RaTjW4HHtBxjHdxpStzOkQi7u8uN6qe4LZlX2WxALKm2lCfP1nkQNQ>
    <xmx:RaTjW6RV6VYo2FDiKFSgqDLG54250HPQetFJ6cSAzna4nlFq32KpqQ>
    <xmx:RaTjW0G6Em3ywLfO4-pwG_iI-Pm9vG8Tnzqw6zoxodUHcTAsSWk_ag>
    <xmx:RaTjW_GAmbaIzafudy2DJKWREsIMtp1_78U98dIetOgWZMhy2db8jg>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F007102F2;
        Wed,  7 Nov 2018 21:49:38 -0500 (EST)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v3 3/6] net/ncsi: Don't deselect package in suspend if active
Date:   Thu,  8 Nov 2018 13:49:06 +1100
Message-Id: <20181108024909.9897-4-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108024909.9897-1-sam@mendozajonas.com>
References: <20181108024909.9897-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a package is deselected all channels of that package cease
communication. If there are other channels active on the package of the
suspended channel this will disable them as well, so only send a
deselect-package command if no other channels are active.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-manage.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 02421d1a22c9..b8b4e765a04c 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -440,12 +440,14 @@ static void ncsi_request_timeout(struct timer_list *t)
 static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
-	struct ncsi_package *np = ndp->active_package;
-	struct ncsi_channel *nc = ndp->active_channel;
+	struct ncsi_package *np;
+	struct ncsi_channel *nc, *tmp;
 	struct ncsi_cmd_arg nca;
 	unsigned long flags;
 	int ret;
 
+	np = ndp->active_package;
+	nc = ndp->active_channel;
 	nca.ndp = ndp;
 	nca.req_flags = NCSI_REQ_FLAG_EVENT_DRIVEN;
 	switch (nd->state) {
@@ -521,6 +523,15 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
 		if (ret)
 			goto error;
 
+		NCSI_FOR_EACH_CHANNEL(np, tmp) {
+			/* If there is another channel active on this package
+			 * do not deselect the package.
+			 */
+			if (tmp != nc && tmp->state == NCSI_CHANNEL_ACTIVE) {
+				nd->state = ncsi_dev_state_suspend_done;
+				break;
+			}
+		}
 		break;
 	case ncsi_dev_state_suspend_deselect:
 		ndp->pending_req_num = 1;
-- 
2.19.1

