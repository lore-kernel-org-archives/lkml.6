Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B980C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E374C2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKJPlsth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E374C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFLDXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:23:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41259 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeFLDXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:23:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so11318117pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wgt99BBDLEadzYsL5zlvdtmQ4Mh8C5eXQQDuvAoOC90=;
        b=tKJPlsthKsrfvtzdacETpWWUF6j7ckosY5diXTeOqyaZ5457xcKyApXuYlIqVylAX7
         QnDdtLEbzlvaWR/yz9CLtFprCJK+Dkg76xXV5UNruJyiJRRVZZfHW+T1J4hHdo6mXHdT
         w8oHgdqZaK9KCMaWiUg3fX3lMdwpvbkQecLVzp3s7GQPFyZPHWHFIkDfVqXmbUIc9LCO
         cG1BuAxZE6JOCaMyQnmLH6yqoB/NsGHz7nl6SfKo1ti+bopPUYxaWtEO8J+0e0JFUX4s
         u8cs1qqlV0mNfh/ZGU01yXeX0UcZ7SKZZovdMciVhwCJb3T+IkuLjx8V3HkusorMtKUT
         /8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wgt99BBDLEadzYsL5zlvdtmQ4Mh8C5eXQQDuvAoOC90=;
        b=LSZSw3vLP3kvT1u4ZaXD3rCrzpWg/5i7mR0EiX/7eg9Ir7txA2Jq1uqcSm3FIL8Whp
         C6cMuIQVHX6bUtZdw5bVaxzGX0IGtJMbJU5D+Y7/jsVTnE+cPEqDNGVsFPzuOEDTZMMD
         fHrPvD1SlcF/lvNCfrZ7YA24EuoWf2PcF5QUUohrZ8bAOb2xnsAVQ0FM0AoLckCTXudj
         TBNvncx2ECqvxednJUBitTaoAGqsvAEc6DIS9NJXtsK54+ASbQM5YrsMbnvA4M2AFVFY
         BLQRgOoIGY3LAIy6yZW28CebugF47vVXVN1viHXxAtwgsJ+6VjEx0L/41SxxsU8IdB3Q
         akEQ==
X-Gm-Message-State: APt69E2X03GA58/vjwYvcTHuAqMsjwqRlOLdPQnHGR/IFVtZYl1F3rVX
        LVXeel5NHzV3U4EgXVNW8wY=
X-Google-Smtp-Source: ADUXVKKMTSfvw6Sg+BSnq0EC0gV3sWrlpvVPktxEZvhR1U5CX0lzL3TR6ezejAU9V3AcKhNjNcPMAg==
X-Received: by 2002:a65:6690:: with SMTP id b16-v6mr1603904pgw.326.1528773801816;
        Mon, 11 Jun 2018 20:23:21 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id j11-v6sm108823013pff.64.2018.06.11.20.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:23:21 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: lx6464es: add error handling for pci_ioremap_bar
Date:   Tue, 12 Jun 2018 11:23:14 +0800
Message-Id: <1528773796-37922-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pci_ioremap_bar fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_ioremap_bar.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 9655b08..6157b6d 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1016,6 +1016,10 @@ static int snd_lx6464es_create(struct snd_card *card,
 
 	/* dsp port */
 	chip->port_dsp_bar = pci_ioremap_bar(pci, 2);
+	if (!chip->port_dsp_bar) {
+		dev_err(card->dev, "cannot remap PCI memory region\n");
+		goto request_irq_failed;
+	}
 
 	err = request_threaded_irq(pci->irq, lx_interrupt, lx_threaded_irq,
 				   IRQF_SHARED, KBUILD_MODNAME, chip);
-- 
2.7.4

