Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C447C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67D921850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130521;
	bh=jqSnSB2+atjEKcucQcy7bRPfc4Q3HmgOGugg54JuQeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9A1YuT4FDqg2nS49yzzTqxxNKSAYOs7ZnPLyZ8ZOkrfbjRFZ1AzHIpEg6I6cRil/
	 8yfavFppMBL1Zd1sj4FihyCTS1xIvNZVxtLMYzUSdZ5cpZNrY0lkPhov5IYfQmFY2S
	 J/A2UPsD/040M7+HVJ7pFFxkhC79QiDmSMqSGa7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbfBYVfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbfBYVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B602184E;
        Mon, 25 Feb 2019 21:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130518;
        bh=jqSnSB2+atjEKcucQcy7bRPfc4Q3HmgOGugg54JuQeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnMozycTSj2oZnZa+ZlI30Rh4e5GF6+mi2hyo+95ccYjnlwmCAcMzWX8dvosi2VCS
         zLqXhWU4TeoYV/3oSw0grD84beyW5rA/1EFq/z9LomlBx9N9PLmh6ovTP3oMbnOLGB
         NxlK1AS0U0nvMT6EgqlgVibpJJO6oE1fawR+lh7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 098/183] net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ9031
Date:   Mon, 25 Feb 2019 22:11:11 +0100
Message-Id: <20190225195111.191415397@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

[ Upstream commit 1d16073a326891c2a964e4cb95bc18fbcafb5f74 ]

So far genphy_soft_reset was used automatically if the PHY driver
didn't implement the soft_reset callback. This changed with the
mentioned commit and broke KSZ9031. To fix this configure the
KSZ9031 PHY driver to use genphy_soft_reset.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 51611c7a23d1c..22dfbd4c6aaf4 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1076,6 +1076,7 @@ static struct phy_driver ksphy_driver[] = {
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
 	.config_init	= ksz9031_config_init,
+	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
-- 
2.19.1



