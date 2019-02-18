Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4FD21900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497607;
	bh=Ymcc3PWY1H3H/Czbxnzb/M6sWojtCiLqcQQnaOFtEdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fVUM5dikcI8cnKIPpmaj0+Pw4LYwLmbemihbE90MBDtdGZZ5C2+fnDGmm4pkw4Tse
	 +7+vbaJwhK8Tpsy0/UH3HhY+Xq488f5LclYfTlOPdOELJj+UgpTPHc2SBmN6aHpAAz
	 oMe11DIPT9YYAN0WEhS0NdxNokv8QWxdRxJUJcnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfBRNqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfBRNqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 788EA21900;
        Mon, 18 Feb 2019 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497602;
        bh=Ymcc3PWY1H3H/Czbxnzb/M6sWojtCiLqcQQnaOFtEdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRqYIBXFMkXm+roan5lqB4BkWfyRuwx3mddR/0Uy1b73kU3Bif4B6VpjqXycWVVQ5
         6APoqmIfQ4Rd+x5yvdW2dpK5RszaHIy+E2h4L/XWnLTSwaEoe/ZUTx2FSRTe7+CD78
         Zf3MZQAWDc5rs1/Ow4XHGdzZBhl0m1wggqT7kV5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 35/92] ARM: dts: da850-lcdk: Correct the sound card name
Date:   Mon, 18 Feb 2019 14:42:38 +0100
Message-Id: <20190218133458.022382953@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c25748acc5c20786ecb7518bfeae8fcef93472d6 ]

To avoid  the following error:
asoc-simple-card sound: ASoC: Failed to create card debugfs directory

Which is because the card name contains '/' character, which can not be
used in file or directory names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-lcdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index c196e37606c4..3a2fa6e035a3 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -71,7 +71,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
+		simple-audio-card,name = "DA850-OMAPL138 LCDK";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1



