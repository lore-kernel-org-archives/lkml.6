Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A0C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7B20834
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="lr5yqzuv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GU5qw3iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA7B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeJXGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:17:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45327 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeJXGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:17:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 023E921C7A;
        Tue, 23 Oct 2018 17:52:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Oct 2018 17:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=0I1QQ8+X1Fm1viHEvfd4Oq27EfJa+jf4/LNmrlSqiEw=; b=lr5yq
        zuvOVbeUA+od8Qc8Rg3kqM1l+G1RLW0pz9xiN5Gb1aLXoQX8IAaAVQnZkD/kMHkC
        nV7Lj7q7i+lRGz/rRnhTnk4WxrxemDIcVAolRicCikrreFbNq4fzM5cj/3IuDtZX
        xZw2goS5heaUPWvN28fgUmyRcasjbBmMfqlROA0JIpCd0zPbJP1+TMCWnv9lmpgd
        8lsIR5+XmfQVmsZic+DiZa+AMDxu2zHKefiVtcIFUKl1xRmnNN6pSQ+iBJ5h7FaA
        8hL3e8Xx9bSFrCdctWwpYnSSoEbkgdiKt/Mded0YtQiPnJShpscK8W93XpT4tC1o
        UXB5cevrR85R+NCgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0I1QQ8+X1Fm1viHEvfd4Oq27EfJa+jf4/LNmrlSqiEw=; b=GU5qw3iP
        4eRjf8fL3N0E/2zco5OawTqIEEIOUePHqN+H3IeZWRG3JAKN/1px3hfodDd/GuQ9
        P55WGa40mCQ4Ggw5HFCscJsvA/CjqWXoVBGdKuHFRGmTsENs//uLqg1O/pN6utQ4
        2UhSY5Xk3SuhUVP4GQkOXC38lWP4WA3MYt4jjuguuxUTHyTbJUtHXBALncHm09HI
        GIJOL3i+jQ4XRY6Nhuk9lfxg6QBfciJImjxjF80vsbFcOthsBPTEZY7MQioiM+fs
        KvYHxR8CDY2KhfnwKct78RhzSqidKsXJS1reHmf+/UCh/CaKaVRfvyr7nfIXYyTR
        QCmjsOVRAjj+sw==
X-ME-Sender: <xms:IJjPW_92kr_foru8CHZ0QGo_4QYoSr0WYbZqRK8N-J7qg7vR7JaBNA>
X-ME-Proxy: <xmx:IJjPWzQRvKCvB3yOken1JzPda3maDqnl5EcVpBZW87pJJzzIoBxFpQ>
    <xmx:IJjPW3Ix6j40_DDBHSGph5JfDaRxQuiO-VCIQI81ssyF89ta6ty_zw>
    <xmx:IJjPWyF7zpymvSdUizgKmPURfpd3KHvUz9ZufYV6iSfXJAj1BWnSBA>
    <xmx:IJjPW2K-tvIGxkuGgophj5OsuGyCLoLKDh5bzFxT0XnwYkS_bnHOnA>
    <xmx:IJjPW-4kpkanvII9rpemrg1ChE-56GzlVmlRsIijezyN9mLG3y-K5Q>
    <xmx:IJjPW2gNCKE_lV0lyd4b88lTcJrFMtvweCzp4zEsL7iJFt5NCmlyIA>
Received: from v4.ibm.com (unknown [158.140.225.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30C3B102E4;
        Tue, 23 Oct 2018 17:52:29 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v2 3/6] net/ncsi: Don't deselect package in suspend if active
Date:   Wed, 24 Oct 2018 10:51:58 +1300
Message-Id: <20181023215201.27315-4-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215201.27315-1-sam@mendozajonas.com>
References: <20181023215201.27315-1-sam@mendozajonas.com>
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
index 6c62aae10205..013437b42e94 100644
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

