Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE19C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F72214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ+6AwXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F72214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLFP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:57:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38828 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:57:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so377089pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ktfmL44F9jS097tsKdnSUHiqKrT3vNQF/bXH3AYOCcY=;
        b=UZ+6AwXv5G2A6tJz+YqGtscZ0SmEQyBDDBomADsftBKFvm59DJnJohI7TYnnFpPW16
         w3JPoHEdSdMNvX/7irTA6D/Vry7CKXMIiuhpfzd12fG7SLJzC9BvxSFZcByrpPFjQ5Md
         isa8ESY3/RVhTss4eEIKfKjr8CnU+kmXbU3GdXAHr3vhHjULc3DjZD37Qx/+jq/GSFOS
         /4c94VAmgUiiOGlB56m5GJ+O+5STMy/n4twZvPRIvHnfWMmsp8pa64qfcnnKin0QUK8y
         K9RDo8whSCQjxxOt9jF0utx9C85zFNjc+s7+YM0xkl4KWgOK3WAsQRpJs8xG+sByv05T
         72zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ktfmL44F9jS097tsKdnSUHiqKrT3vNQF/bXH3AYOCcY=;
        b=Pz4lTg4+3oc/LBqfB4h1i+v5XDRHM9E28z2WvBRnjjBVPq4aV/rNRplnOz611zqBlc
         8dUyTQmdUGcCa9v57wlRsC1tg5+pl/VSxG6t5wJYHGLD+i+XMYYgWjmkeksoYeTDj5PH
         2PhhBrZaER2x8P+meAXXxq0CTGErL3AtNv8EbnxxquT6nUjz5ddg2rGC7jKDodBtmpFa
         A+v73FpgIkbINeDu41hnfd7JO+p7F6jGj5VHTeFqa9l3tc/7sOhoXu6iuz6FFZzRZzFJ
         jlKDogW5N3XkX4bvvVG+olr3yopQs7Vbb4kxRaMUaTf6y0vCSL72F961vfk3jonogcSl
         439g==
X-Gm-Message-State: AA+aEWapZrzyufA1Wv79jOFylteRrYdXz93pQHJoyEIyGIfJd67+9OAN
        /vAhedHY+luP4YdWGEkyDRM=
X-Google-Smtp-Source: AFSGD/WLGZod9+cR/0KIRa/3PEr1r2FEh5dnsHBRf9eKTow+zXotLIQ6yAlA4qo6DRStTHVB6ZFqDw==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr29294760pfi.172.1544111837337;
        Thu, 06 Dec 2018 07:57:17 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g5sm1812156pgu.57.2018.12.06.07.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:57:16 -0800 (PST)
Date:   Thu, 6 Dec 2018 21:27:06 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: mt7621-mmc: Fix incompletely removed #if 0 block
 in sd.c
Message-ID: <20181206155659.GA15420@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
does not completely remove an #if 0 block in sd.c. This causes the function
msdc_select_clksrc() which was eariler not compiled, to be compiled.
That causes an error - MSDC_CLKSRC_REG is not defined.

This patch completely removes the #if 0 block

Reported-by: NeilBrown <neil@brown.name>
Fixes: 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
 - Modify commit message
 - Include Fixes: and Reported-by: tags
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

