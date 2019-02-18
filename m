Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DFD2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500234;
	bh=2Pgh6vhbD4FGpVCtzU5k7mKI0wJ8XYl+9yE5JLJUpg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j5bJT0lP3Rcgf0IBMbx6orbSUJxZP9xZxIIZqy5M8uzWaH580DTB821zppP/yLJWi
	 DIgaZEdK249eNwj6J/qxV2s2fdWsTnIkmhddONVCWc52ty9fpU+waE/XzwH4kRwNta
	 KjK0hiwRO1NX1Td9jNJN/+UhUbl0wny8chdtAoNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfBROaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbfBRN6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FABA2077B;
        Mon, 18 Feb 2019 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498314;
        bh=2Pgh6vhbD4FGpVCtzU5k7mKI0wJ8XYl+9yE5JLJUpg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=woofpXghNUjRcMV/67GVh3zRUS8aXj8xpBfMCXEKnSKmrAaK2IBDZ82pUsM8TNjPl
         iHpMgU8XI7mwWnEEFhUbIq+2DxVXS4KBOjNCsBjhrgU5OMa1xcU7P/r+zbQUHtRoRK
         XXnOk5CmyVCr3q3QzDtwekohYlu631SilWfJhHJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/58] ARM: dts: da850-evm: Correct the sound card name
Date:   Mon, 18 Feb 2019 14:43:50 +0100
Message-Id: <20190218133510.862155185@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7fca69d4e43fa1ae9cb4f652772c132dc5a659c6 ]

To avoid  the following error:
asoc-simple-card sound: ASoC: Failed to create card debugfs directory

Which is because the card name contains '/' character, which can not be
used in file or directory names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/da850-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 78492a0bbbab..3c58ec707ea9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -156,7 +156,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850/OMAP-L138 EVM";
+		simple-audio-card,name = "DA850-OMAPL138 EVM";
 		simple-audio-card,widgets =
 			"Line", "Line In",
 			"Line", "Line Out";
-- 
2.19.1



