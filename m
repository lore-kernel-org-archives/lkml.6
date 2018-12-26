Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43602C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF51214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="g4J/6rGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLZFMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:12:36 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:32988 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLZFMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:12:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 50AE2B00
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zyQ6zjg7ctQJ for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 23:12:34 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1CD4671A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:12:34 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id t13so12893263ioi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d5DmxqqpoSNk7vYOnf8JTcrxl8NKPjtTJeIvIQdbAsI=;
        b=g4J/6rGAI5Z0yS/YasqEHdwczHlYxdoYYXIDrXJeVZEl3SPsogH3XG58hhDJ+XRbu3
         ZoyyzCsZBK+gkuBSLmqLs8VT+shJrCy8cXfBNJ+nDs84UUa27r5HNTkAy/ZSy5iId+NZ
         vk+1A4zesHLgtePL3awGcQ+5+qoYFMdUSgKBckhIADUDJOFROk05ouAi1TmYQOaEgVMv
         mktVSuqx9GVLucq01OkdUn/izqMk7LkI2ldKRdizxGHMbNvFcPySLFkG5RLhJl7FQ60a
         1qTy8qmx31suic4zna6Kq9g/Zvz6VRVAT1KRIVJIlgtrYU7RxG9VRBpZ3NFzgY42SyFe
         /WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d5DmxqqpoSNk7vYOnf8JTcrxl8NKPjtTJeIvIQdbAsI=;
        b=mYPo0q/oy7VlP2Vi9PdPYTpqBPfr56+Zi9EgT6s0ughoyt6k1GdZgFEJE/AGz5Zxnb
         nVq4QEhUogKK0Ep/fCGHfjxVrO1Bx19RIEjZ6Td3c9zDiUx2euqEPbZDyP80AIxprMrY
         OGG8nkcGhkesQCuk0lGLN2AJR1WbSYrPcqqxKKOy0jISXzpCGi7mmKCFGzejyxTxiIXa
         VQrAFkukMTpQU54t09VV9P2LHEJIOw+61PSqCY8BCACrhzWBlmMVXP7Llg7ZdKuUuIa7
         o1sMNzx+tFVkOlRPT5SyH2SDMWQtP+wB82mlkdgPR/g4EcZc4klgg1fziuzcX/SIRPIY
         G39Q==
X-Gm-Message-State: AA+aEWa1M94VC5RCrtZGNI40wX3+DmBabPxFlVW7HnOxmX0Ns4X6GwSm
        xLpCc6aVPqVo35CUqlOuMAttGb+jnk8WRl21/5tlAeMBfN1AlMEG95RRqNgYnLcZz7WIVqv//jd
        xBlJFHJAmS0/ouF8N9+m+QCbpG12k
X-Received: by 2002:a24:b003:: with SMTP id d3mr13117649itf.55.1545801153718;
        Tue, 25 Dec 2018 21:12:33 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5bbyAmVbn2epV1eCiCCPISyvZMvoHyxlcLJ6rK7R+Kr1Exwp47uih+uDMXasjtnvg+e/bRwQ==
X-Received: by 2002:a24:b003:: with SMTP id d3mr13117642itf.55.1545801153471;
        Tue, 25 Dec 2018 21:12:33 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id w129sm13245021ita.0.2018.12.25.21.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 21:12:32 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: fix a missing check of snd_i2c_sendbytes
Date:   Tue, 25 Dec 2018 23:12:04 -0600
Message-Id: <20181226051206.74467-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_i2c_sendbytes could fail. The fix checks its return value: if it
fails, issues an error message and returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/pci/ice1712/ews.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index b8af747ecb43..b978cdb0fc20 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -826,7 +826,10 @@ static int snd_ice1712_6fire_read_pca(struct snd_ice1712 *ice, unsigned char reg
 
 	snd_i2c_lock(ice->i2c);
 	byte = reg;
-	snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1);
+	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1)) {
+		dev_err(ice->card->dev, "cannot send pca\n");
+		return -EIO;
+	}
 	byte = 0;
 	if (snd_i2c_readbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-- 
2.17.2 (Apple Git-113)

