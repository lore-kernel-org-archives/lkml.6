Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F583C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flTa8Vb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6BE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeLEQKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:10:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36076 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:10:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so10289166plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M3eLsZU+Rg5gDdY238DoSbxki/UaJUCXoXFmghye3uc=;
        b=flTa8Vb8zXJKvVcp6YmWGi7F+F1VJyhdL1yv7two67f9bAEbvONNeMlOd2Zk1xxEL7
         Yppd1e82uadEsfJZtrU5o9c7cimXg0nW5MVHiutWj3qhy1eUO4931l8RpeCHTCT/xQ19
         qZuy0qC5q+IukRO3mHbMzViTm/ShO/U46On88OkHutZryKhCwaSpxFoqrRu0Z2QKWl0c
         9VZXQKV4Y4DJnNAUpZFaIDwyUDrqEC+kO/X2GYoqdRvhP+zyjLoIdE/0euSAD0fRjkJ2
         FBgVT7P2TuLjxVAI5C2QRDW8Je00VE4NCaC83T34Wwa/Mmm1QC0L5IPn5kd27rP0oM6S
         U2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M3eLsZU+Rg5gDdY238DoSbxki/UaJUCXoXFmghye3uc=;
        b=HjXorFQD5OvBreo1Nw9QONm7fYaLOhEgzqTp0wDXNdalyd7OPlwyQCp3QuUwe7+2p8
         C6uEc66oNxPR9p2ZNKvxjc597ZP6vycu6bFgHrx4xnNQh6kATa1rDU81YycNNy18iIVr
         XTGRTjG/Nb8idnVLKl1ULym7fEZv/Ns7yTt79y4/gYhdcWM34XxddlRnQIaZefW2APDZ
         bimlTCAI/4hyNBvkvj8M0MYCEmAeXdByYMYbSU7fejWhyVJ52WL3U+qGzhE++q/uabpM
         3/A4sS2Uyx3Adl1n3gXMH5WYSee5Nlnyunps+a9Tp+lzBmGIjfTCij2/xSGvb21asXk1
         7X0w==
X-Gm-Message-State: AA+aEWa0d+x5rkGgYpaHwjfBA55JlweLVsjhwv+VQ3izsvEcrhH14c+z
        uaj54EMCMLQv9emlR1fEyEY=
X-Google-Smtp-Source: AFSGD/VGsKeXO5zmWC+4+RD0Hdqcc/ODU68Zkt96wcIIyMCS4Dcvo6PVwA/cPkFuE9bXJm5mtKrGdQ==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr12622335plb.254.1544026245915;
        Wed, 05 Dec 2018 08:10:45 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w10sm21974036pgi.81.2018.12.05.08.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:10:45 -0800 (PST)
Date:   Wed, 5 Dec 2018 21:40:29 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: mt7621-mmc: Remove missed lines of the #if 0 block
 in sd.c
Message-ID: <20181205161001.GA12511@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch
https://lore.kernel.org/patchwork/patch/995533/
does not completely remove an #if 0 block in sd.c.
This causes the function msdc_select_clksrc()
which was earler not compiled, to be compiled.
That causes an error - MSDC_CLKSRC_REG is not
defined.

This patch completely removes the #if 0 block

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 7b66f9b0a094..3d918e481bd8 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -216,26 +216,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 	spin_unlock(&host->lock);
 }
 
-static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
-{
-	u32 val;
-
-	BUG_ON(clksrc > 3);
-
-	val = readl(host->base + MSDC_CLKSRC_REG);
-	if (readl(host->base + MSDC_ECO_VER) >= 4) {
-		val &= ~(0x3  << clk_src_bit[host->id]);
-		val |= clksrc << clk_src_bit[host->id];
-	} else {
-		val &= ~0x3; val |= clksrc;
-	}
-	writel(val, host->base + MSDC_CLKSRC_REG);
-
-	host->hclk = hclks[clksrc];
-	host->hw->clk_src = clksrc;
-}
-#endif /* end of --- */
-
 static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 {
 	//struct msdc_hw *hw = host->hw;
-- 
2.17.1

