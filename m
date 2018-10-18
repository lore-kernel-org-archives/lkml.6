Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5DB21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="rp3XtIA5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRn3Zyia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5DB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJRL6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:58:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47375 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbeJRL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BFED722251;
        Wed, 17 Oct 2018 23:59:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Oct 2018 23:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=Q/u9mkjEty/6SJu1ipwDBRVWcYPnroUpjbfnbMRZK5E=; b=rp3Xt
        IA5NEyFrEChpsPOeg936/euZKIUZHSqgoDhTxy59Z91KVhJ9hVGmFzoX2Xwuu1qB
        1y5lF00kS2HK9qeKXpONmz30I7oB1cUoBBMGzGjnbMSIVHnELqDfOkb747yCIXEJ
        92X10n18fWN8Vbkc1K3IbNxVuDJOA9foIgE06JvtX6W5KRRQB9VKreI4xxOFHZ3u
        MckaC7WuxSudSGDsOGfCATVikX8iqRu2u+vhFi1F2oi0tbNFTc5e7lCI7nCHDUZ0
        jO7qxlZzbsYR9vb/Dx5Eb8V9J2yBZAn9PrkPhiMXWUeVJBgeDMFsN2vCcnjbR+nG
        O1Idr8C9CiHUEcsng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Q/u9mkjEty/6SJu1ipwDBRVWcYPnroUpjbfnbMRZK5E=; b=DRn3Zyia
        tflWiM0BB1+tK3Hy2uYbGf6fkZE107jd1ZL8nphOppfHN4rEalDTFVXqDedvjCPu
        qzgfBgVBefrY1FuTnvyBAhZykTJINB6KOP5CTe7jGiNQKlqei6TnK2wDYnYIMCCG
        tS1n5d+gfQUmkaTkzV/znTQuwQaTnX/47tWe30wAy9iH6eCO6KU9ZKZ6wgU5hWI5
        OQJ2K086hxKCSrBDXrxGBoa8onDKvEAZh6IIm3j6etblp7TLe26tFSP6XBWFfsyw
        19p+4XYutYGp7a1O1iVVJ0Vzwu9sdBoUaJuRnhOwMx1k03fixtd1kAR21V5wWKhL
        kiKaEr8AqjHpuA==
X-ME-Sender: <xms:PgXIW3PfCWKOhCIX1Un6YBpmZk4I3OlHSlSwVSeMkuyyZMrOhsPAwA>
X-ME-Proxy: <xmx:PgXIW1EyoqywbAv-kP99YYyftTL5wDSjG0PJfX9QKkvTawmnKDzS1w>
    <xmx:PgXIW3ubsG68F4gfxStsUyjcIhEDhq7bHQDRJ1aRNTAyZFm7q2Ol4w>
    <xmx:PgXIWwrGuI7n-ZImOqHvyvXArnOR8tm5fVazt2uu9dP96XLzseqkkg>
    <xmx:PgXIW2UQTI2iMkjFucbGxKzDLWwND14Di5HjxvKe7U1N955hciPQSg>
    <xmx:PgXIWw0_spXTwpUiqPvnAwG0JNP3IWL1Hn2sA-QHKfLWEIwPyPwkWA>
    <xmx:PgXIW-GIEik693WFOgQA9_ukwNLvceI2FACoKe6D6WB75vMBIGW2nQ>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4A578102D7;
        Wed, 17 Oct 2018 23:59:56 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 3/6] net/ncsi: Don't deselect package in suspend if active
Date:   Thu, 18 Oct 2018 14:59:14 +1100
Message-Id: <20181018035917.19413-4-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
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
index fbbfed559f9c..602af74bee81 100644
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

