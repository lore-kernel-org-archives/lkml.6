Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A630C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FDB20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078414;
	bh=lj7l85dW7pfXF206a/rmvf7mdR6+H26o93/gPvc92tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+82c6zIS5u+y76NIe8NNhSg5ogBkqSMoAuRZD+MQobBP0knrAgjtv0NehQa6FS4K
	 qM2ga4D/XkOCD8udASz0Zx2ufOUh3P3d728BydTbIUbkpjpjH2I+Tr1p86LIJkQrMp
	 dy/6XuXupVnXxmglmjp7Ig83i73SA/lBHaFc8SjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAUNqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfAUNqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC1C20861;
        Mon, 21 Jan 2019 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078408;
        bh=lj7l85dW7pfXF206a/rmvf7mdR6+H26o93/gPvc92tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQmo+rg6k5BlTceREkVqnj4QiFp6QJGznVdkcZ1pwjCqsJPVlbxVLy0xQlDcWqHGJ
         mPou7yY7+cxpYj0EV+vJU+L+WLO+fWIpuZnzD/EcAL7QJNjyF7WLLBDOw3TU5j8DTj
         BHI2N8iVkWtglrPYgxNa5kTa3PJIS1pePv8M0+iY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Camelia Groza <camelia.groza@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 022/111] net: phy: add missing phy driver features
Date:   Mon, 21 Jan 2019 14:42:16 +0100
Message-Id: <20190121122458.228230218@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Camelia Groza <camelia.groza@nxp.com>

[ Upstream commit 40f89ebfbd73fc9439ae8d4950f60226ad176690 ]

The phy drivers for CS4340 and TN2020 are missing their
features attributes. Add them.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/cortina.c    |    1 +
 drivers/net/phy/teranetics.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -88,6 +88,7 @@ static struct phy_driver cortina_driver[
 	.phy_id		= PHY_ID_CS4340,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Cortina CS4340",
+	.features       = PHY_10GBIT_FEATURES,
 	.config_init	= gen10g_config_init,
 	.config_aneg	= gen10g_config_aneg,
 	.read_status	= cortina_read_status,
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -80,6 +80,7 @@ static struct phy_driver teranetics_driv
 	.phy_id		= PHY_ID_TN2020,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Teranetics TN2020",
+	.features       = PHY_10GBIT_FEATURES,
 	.soft_reset	= gen10g_no_soft_reset,
 	.aneg_done	= teranetics_aneg_done,
 	.config_init    = gen10g_config_init,


