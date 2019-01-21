Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1904C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B924220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078423;
	bh=w0y6iVNnqG8dvFbope+PyfHmutH6HUEgmpCn2F/1Xis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/QBQS+vTIE2SfGa7X3kdzPd/RbEcMLOqKjyDpzdNHKRcMEoteFCUwZlt9iN2msy1
	 ul1kiiZUwUa6LyJAkaveAQ3RSnthCJ1kU+eoI1hOgJpdAwsvvUD08G+C1hxuDT9ql9
	 XG3/ZnOAVbSHNMLKc+apqXEbc+dDET3reWBHDO3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfAUNrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfAUNqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE4220861;
        Mon, 21 Jan 2019 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078414;
        bh=w0y6iVNnqG8dvFbope+PyfHmutH6HUEgmpCn2F/1Xis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0h6sRviy12AqO3YBl16mKzBH5fkyL3sGTirSf3HPymcLxy+i3NmzBdwHKA9YHZjmW
         SVWuz1h6NEPRwABgchouxqpJ3siSJuLr90ju/jRrbbGyUlw9l+HpbQYnC1sq7G0K/c
         0pXBw1C9qXzc+ImsxWk8tFwUplM5JK2IxrBywxKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timotej Lazar <timotej.lazar@araneo.si>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 024/111] net: phy: meson-gxl: Use the genphy_soft_reset callback
Date:   Mon, 21 Jan 2019 14:42:18 +0100
Message-Id: <20190121122458.431356230@linuxfoundation.org>
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

From: Timotej Lazar <timotej.lazar@araneo.si>

[ Upstream commit f2f98c1d7fa81e25a5cf910edc9db4d3c6f36c1b ]

Since the referenced commit, Ethernet fails to come up at boot on the
board meson-gxl-s905x-libretech-cc. Fix this by re-enabling the
genphy_soft_reset callback for the Amlogic Meson GXL PHY driver.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Timotej Lazar <timotej.lazar@araneo.si>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/meson-gxl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -233,6 +233,7 @@ static struct phy_driver meson_gxl_phy[]
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_IS_INTERNAL | PHY_HAS_INTERRUPT,
+		.soft_reset     = genphy_soft_reset,
 		.config_init	= meson_gxl_config_init,
 		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,


