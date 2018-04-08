Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1780087-1523176382-2-7617221218855550541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='me',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523176381; b=C11y4Tp/yJryoBXkUmgaJdojBzlTH6R62vNsErO5298zNDMz6z
    50BnnEdutUYvslnQc9SwtPoinKJb7Dsw5TXG3gy7sOJmhBPd9hISJIMMA66aTVLN
    12AvDrHW9EDzVBP6iVfvb/ZOUbO+jxH7X7v+bBspd6M68JVG1SlNE8nc5PPCUkIF
    kpmdFZBHZKVN1j3hLitgb683whP3ImoRyJ71Hh/Pk0PiqGdwmoEMfhY7dobNm3GT
    tzLPxo/P62yHrfREnVv1MhDQN5xTax3bEbP6rTG3h/uLgh6cN1OP289ttNclfZvd
    YxnbiPp03HxHYxcWIC88mItTutpWtOH5zR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523176381; bh=VG06D/NsZWXo1xNHQMwheLQf5Yuz3N
    VXtyT8KQuDlGI=; b=Gz0VcMLQE4m4rftX7WTPQVNJAaWATl/WlANIfG3uopANGe
    P8+7E6uXsPpW85/oRjt0HXvzKu3VoiSX2Nob+qNqipU1tGsvsut9Dq8a9r1KMdpv
    xlCcP7X4Oiw4W88uvKspX25/qY9n1H+u3gEv3ZvKN9xIOuek+9cZxIrVX0oym5kM
    0aXm3pFKdD4NMSjajQqV0lT9w5R/wTcTy9PfkVGS2AuHTAq816Cgipjh/GVF8Y+s
    rlVSizm4PcXoR0X6VOvK+1EfbFQofxZSYjAY3r+h3hioJ+9Fs8Lin1sRMnyH27XQ
    AZKKiVVPJqvdI7fGI/msQcDBv1hQo7FoxujbGy2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b=KV/or28b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kresin.me;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NQEggHkF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kresin.me header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b=KV/or28b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kresin.me;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NQEggHkF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kresin.me header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNEr1k/TvOV5DY42yUgzwZihzb9d69hmuNnzr5ffief1PCsre+MxXP64tkOg5hMYN8kdbByO26V40HhWSxNCJNDXY92P6bqRd3ES3ExsBPJGNBvQR1zO
    EnPsqTOF0VfnBTHWOl9kzAxDKts7eiJqWALsqz8usS2w5RZuEhO1H3XkiWJ2SeTJEiZ9hxGoDwnpE2+ZjGjStIZKmCsA07obc8zmYTLc1r2z94RzDbTzve4d
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=HT84mVL4G48A:10 a=ZZnuYtJkoWoA:10
    a=VwQbUJbxAAAA:8 a=7tp3yMfCmjX2PYPYcJIA:9 a=74GVLRNJkQHWq88_:21
    a=OmR0XSuFe3782xWj:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeDHIcs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 04:32:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39146 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeDHIcr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 04:32:47 -0400
X-Google-Smtp-Source: AIpwx4+PpHmh33bsHFSHu38EylOQ3J4Fok+cpJnChFWZpNyTZWq2B2anDZYf67mB5imTD+3gnMK+bA==
From: Mathias Kresin <dev@kresin.me>
To: john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Date: Sun,  8 Apr 2018 10:30:03 +0200
Message-Id: <1523176203-18926-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While doing a global software reset, these bits are not cleared and let
some bootloader fail to initialise the GPHYs. The bootloader don't
expect the GPHYs in reset, as they aren't during power on.

The asserts were a workaround for a wrong syscon-reboot mask. With a
mask set which includes the GPHY resets, these resets aren't required
any more.

Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/soc/lantiq/gphy.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
index 8d86594..8c31ae7 100644
--- a/drivers/soc/lantiq/gphy.c
+++ b/drivers/soc/lantiq/gphy.c
@@ -30,7 +30,6 @@ struct xway_gphy_priv {
 	struct clk *gphy_clk_gate;
 	struct reset_control *gphy_reset;
 	struct reset_control *gphy_reset2;
-	struct notifier_block gphy_reboot_nb;
 	void __iomem *membase;
 	char *fw_name;
 };
@@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
 };
 MODULE_DEVICE_TABLE(of, xway_gphy_match);
 
-static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
-{
-	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
-}
-
-static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
-				   unsigned long code, void *unused)
-{
-	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
-
-	if (priv) {
-		reset_control_assert(priv->gphy_reset);
-		reset_control_assert(priv->gphy_reset2);
-	}
-
-	return NOTIFY_DONE;
-}
-
 static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
 			  dma_addr_t *dev_addr)
 {
@@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
 	reset_control_deassert(priv->gphy_reset);
 	reset_control_deassert(priv->gphy_reset2);
 
-	/* assert the gphy reset because it can hang after a reboot: */
-	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
-	priv->gphy_reboot_nb.priority = -1;
-
-	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to register reboot notifier\n");
-
 	platform_set_drvdata(pdev, priv);
 
 	return ret;
@@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
 	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
 	int ret;
 
-	reset_control_assert(priv->gphy_reset);
-	reset_control_assert(priv->gphy_reset2);
-
 	iowrite32be(0, priv->membase);
 
 	clk_disable_unprepare(priv->gphy_clk_gate);
 
-	ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
-	if (ret)
-		dev_warn(dev, "Failed to unregister reboot notifier\n");
-
 	return 0;
 }
 
-- 
2.7.4
