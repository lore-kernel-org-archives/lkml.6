Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC86C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE021734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129334;
	bh=xegPGkM+QXX6eZAYP+D9DiFhTyqVBml3CJh8rVNNyz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gspNFwPS657XGfqY19VNvYmoDEmAxxiUisfhxrZ3tnHw9GwEoxgHkg7h8537Rb/yl
	 TIvPa0z80zKftUrLVFx5VuW0+jDDH+WJolkP51rSbUNvvl6Bu388nCGpsDdn0r+tsH
	 8sCtznDQbru2OQOBIiUYdPioXW8PuQaOFLJDXtvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfBYVPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfBYVPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B2F2147C;
        Mon, 25 Feb 2019 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129330;
        bh=xegPGkM+QXX6eZAYP+D9DiFhTyqVBml3CJh8rVNNyz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9DFddfm8Fnh7cuLJ5kyK33K4DLKT/m3rc3Q97PaMBp3wXcyynOryTS6K0jRZZcsA
         qm68o7rmmDi8avmrcLgdv079Xb10X/xQvtCp23bTZzQ5rHCTdCUrTnywgrKuurfVDi
         JUqTkVRqWPgqOwwlM1VFPMw3NUfg0Cv3lAe7+OlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 61/63] phy: tegra: remove redundant self assignment of map
Date:   Mon, 25 Feb 2019 22:12:01 +0100
Message-Id: <20190225195040.487223945@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

commit a0dd6773038f3fd2bd1b4f7ec193887cffc49046 upstream.

The assignment of map to itself is redundant and can be removed.
Detected with Coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/tegra/xusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -418,7 +418,7 @@ tegra_xusb_port_find_lane(struct tegra_x
 {
 	struct tegra_xusb_lane *lane, *match = ERR_PTR(-ENODEV);
 
-	for (map = map; map->type; map++) {
+	for (; map->type; map++) {
 		if (port->index != map->port)
 			continue;
 


