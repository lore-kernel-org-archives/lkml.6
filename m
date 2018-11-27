Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D383C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4D21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOs7mb9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA4D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbeK1DFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:05:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40414 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeK1DFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:05:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so22710414wmf.5;
        Tue, 27 Nov 2018 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aMIj/Q4ZGhEQ80o3lPWygUgt+NmhvvS1EeJN+XmZJ4=;
        b=aOs7mb9vtWTKj/MiyL7700eVFTAM5PI3YJh5NDWz5ZOPgpq2KZbdXKuoP17m4HduWb
         Jj5Cqk8L+PuP7pPwUr0oXA9yIODyApx6T3N+AljPH1/KEyiQLa526uV8KPySYbna6wsb
         SEQtXJYVFMzVPwaMeRbwK4IXddHXtzJFPZy2+vpe0DiHq2DDTVJSM/hmhydPIygL2JjX
         37p9Hmse1t9lkVh/7ZwXHxLBIYyD4TCL7T3yHsBAF10WlcGqSbCOjhvphPMzu4fOoMyk
         ZJYMooGekf9fVw5ACTDZtsEu6nJhvDIU0XeZQa6g9fvqvobbbxs2IPN3mhJM8yslJ+dB
         sXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aMIj/Q4ZGhEQ80o3lPWygUgt+NmhvvS1EeJN+XmZJ4=;
        b=VFabFRGO3D96Yph2+7WcM7NiKFJXxPLsB2rfiDR9T6UldtL37zzzldYoGMtfmnBFm3
         QvvVdxYrgM1R5XGsxEIl/Vq2bYKlYkZLOD0y7A105aroKQNyQYRqTG973HviSAhJSJ0K
         uHsNYTeTF8mvLf9vkEfNHF8Zpq4p3XcPgRYw+VXsRklSGLx6aBVK6D0h8+E0WypGdnho
         BbMXTS0IHkLa0rrErGJvlHlD6eu9HPNsRkuAnpNczIhbY0HnIwiZWBrKexDhNdRRm9Dn
         qf675W8IL89A/0l3C/KU9vTFe5RIRmp9xx8FUvOq4PDZMGwOdeNMiZ1ckYImrBfwDXN2
         qGIw==
X-Gm-Message-State: AA+aEWaNC+ibuAkCJWC97AeGgYprnXFGFjtId/yJmDyED9JU/enXlAqD
        ZhtG8OI/0NXNzZbXgmVePuQ=
X-Google-Smtp-Source: AFSGD/XZ18KWxcQaGfVtJlAORnHTsWdXEq6Vhmnn9zJnEhHWCwh7qQgyimTxBr3B2V2lGqB7caYd5A==
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr26448805wml.102.1543334834780;
        Tue, 27 Nov 2018 08:07:14 -0800 (PST)
Received: from localhost ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id x136sm5724249wme.0.2018.11.27.08.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:07:13 -0800 (PST)
From:   Richard Genoud <richard.genoud@gmail.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mario Forner <m.forner@be4energy.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date:   Tue, 27 Nov 2018 17:06:34 +0100
Message-Id: <20181127160635.11836-1-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leak was found when opening/closing a serial port a great number of
time, increasing kmalloc-32 in slabinfo.

Each time the port was opened, dma_request_slave_channel() was called.
Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
never freed. (Well, it was free at module unload, but that's not what we
want).
So, here, kzalloc is more suited for the job since it has to be freed in
atc_free_chan_resources().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Reported-by: Mario Forner <m.forner@be4energy.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/dma/at_hdmac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 7cbac6e8c113..1b7f0ca0d5cd 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1641,6 +1641,12 @@ static void atc_free_chan_resources(struct dma_chan *chan)
 	atchan->descs_allocated = 0;
 	atchan->status = 0;
 
+	/*
+	 * Free atslave allocated in at_dma_xlate()
+	 */
+	kfree(chan->private);
+	chan->private = NULL;
+
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }
 
@@ -1675,7 +1681,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
+	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
 	if (!atslave)
 		return NULL;
 
