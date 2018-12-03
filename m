Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBC420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="K18T5dOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBC420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeLCN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:29:26 -0500
Received: from ni.piap.pl ([195.187.100.4]:56096 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:29:26 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 9EE4B443027;
        Mon,  3 Dec 2018 14:28:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 9EE4B443027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1543843699; bh=idciN5L8/LZtBaF+h1cUXZ28om2ERlcrF+dbGe8DA6c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K18T5dOE077ErF4/6N9thUtGKHfLoIRR1DCGjewIxS+TajkoVFA3dbQl+Lrtkyo/A
         uaGkDrqk7lS45KxAw9fSOVNcoSbEI6dJ43WduBf6QUOBjhMI9PJ7xWBUCacjwqPZsN
         jFWJ2LmTQA1dHXDF/6Sc5oBDU+n36ojVpMuj56pY=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in i2c_imx_clk_notifier_call().
References: <m3o9a2hni5.fsf@t19.piap.pl>
        <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
Date:   Mon, 03 Dec 2018 14:28:18 +0100
In-Reply-To: <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
        (Fabio Estevam's message of "Mon, 3 Dec 2018 09:21:32 -0200")
Message-ID: <m3ftvehh8t.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 132422 [Dec 03 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 214 214 dd5d82bb00ca93bd3dfb46ca097df6af04819311, {Tracking_DKIM, one}, {Tracking_ sender_matches_from}, Auth:dkim=pass header.d=piap.pl, DmarcAF: none
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/11/29 11:35:34
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2018/12/03 09:08:00 #9343794
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Please provide a commit log, giving some context to your fix.

Well, I hope Lucas could add something here. I am uncertain how it was
supposed to work, the ndata->clk (the pointer, not the clk pointed by
it) can't be at the same time a member of imx_i2c_struct, and I believe
the macro only does simple arithmetics to get to the outer struct.

@@ -510,9 +510,9 @@ static int i2c_imx_clk_notifier_call(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
 	struct clk_notifier_data *ndata = data;
-	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
+	struct imx_i2c_struct *i2c_imx = container_of(nb,
 						      struct imx_i2c_struct,
-						      clk);
+						      clk_change_nb);

> Is this a regression?

Probably (it went in between 4.16 and 4.17, commit id is
90ad2cbe88c22d0215225ab9594eeead0eb24fde). However this part may be
unused on many boards (apparently it only fires up if the "IPG" clock
rate changes), so it may not manifest itself. I only hit it when I added
a custom driver (using/requesting a special clock derived from IPG).
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
