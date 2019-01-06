Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F78C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD092085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 16:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ddEMDeFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfAFQb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 11:31:58 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57802 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 11:31:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 48F7B747
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 16:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u_-8VuSKjizM for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 10:31:56 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1D59994E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 10:31:56 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id f24so46316359ioh.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l4JDFm4H97lFvVtPf5saGvZZu+kiKNt8Vw3PFyZO5jo=;
        b=ddEMDeFMdOC7t9w3aaEjvZTKe/Tai/WTMF8L1uRGKZvTbY+sf9j5LvoxyuDZJ7gDB1
         uIcV79+/IH08TZ2PDlbEP1jsO3Ylh7mRBPosoUfGlUkHHiU48z5swzWfD89MaWvkKqY+
         97Vc/91YuttMGK0Rx5+YKNKwT20vKBnXy/YmQGw+VJgGU76UtQL64LNSGdwC5vQPlsAO
         8ypQ6BVGpQaWNYOC/dn2et12nnLI/1aix68bj1XKbIsNOAf0Ofhck+E6kDL2E5Kb2+Wl
         F37o50Rdj5yd3or3HK0ZXjnltxKbjNwj7z0zVaBU60zwrTjLwhWPiYvlos1BJ9Zi+KYz
         fTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l4JDFm4H97lFvVtPf5saGvZZu+kiKNt8Vw3PFyZO5jo=;
        b=gRww0w8gtGD3TgxRcNTJUozmogQ6ZepmMxOUVSiDfayx+Gurrvp56fbENqHiEu2Bhn
         Zm1KKb6R2rFpLW1is9hOuwwKmIGCLFj+uOEG+NoluCibz5V/RX7liR3MiECFjJLEqKPO
         63hZDFXh2IVYEPLuynwPHl+izQKYpNQJLRCdCb8qPG5/WUjdUXnZx+2Nn9/vg6CX2p8g
         U0zaVmhKeULo9PkhjtVpq8iWoJWmJUMfNKsIx0cyI81pwZpY798Rz/u3mx1tXdvN8BPn
         C3MPg5MCOe47CKuv8SHPEk1ydC5EoMAvWzKm5GiTZOo1vINNx+YotoFVY4PVW1DHCEu8
         RzwA==
X-Gm-Message-State: AJcUukfQXOeiHh4+PG+skWK9r+A+t6iQPYonDtRGADyPe7Hta2h3AdMv
        Ohdfj65hCCEywetr+WRdmYogY2ueBQwmjotxBijrVBRTy6zoDhBdeRUMQGLRD85bw61euRPg+9Y
        0sWJ0ubZh8f/zKXvu1e3pBprUDAUp
X-Received: by 2002:a24:7d93:: with SMTP id b141mr5304415itc.91.1546792315570;
        Sun, 06 Jan 2019 08:31:55 -0800 (PST)
X-Google-Smtp-Source: ALg8bN56Yp4WG8Sd2GuVj9Flyg4+RrCjepqh44IqLp53eg9pMbi2uqDmWy8WsdjE4nW/e95cE1YTdQ==
X-Received: by 2002:a24:7d93:: with SMTP id b141mr5304405itc.91.1546792315320;
        Sun, 06 Jan 2019 08:31:55 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id t2sm30654290iob.7.2019.01.06.08.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 08:31:54 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: ice1712: fix a missing check of snd_i2c_sendbytes
Date:   Sun,  6 Jan 2019 10:31:44 -0600
Message-Id: <20190106163146.9518-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_i2c_sendbytes could fail. The fix checks its return value: if it
fails, issues an error message and returns with its error code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/pci/ice1712/ews.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index b8af747ecb43..7646c93e8268 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -826,7 +826,12 @@ static int snd_ice1712_6fire_read_pca(struct snd_ice1712 *ice, unsigned char reg
 
 	snd_i2c_lock(ice->i2c);
 	byte = reg;
-	snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1);
+	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1)) {
+		snd_i2c_unlock(ice->i2c);
+		dev_err(ice->card->dev, "cannot send pca\n");
+		return -EIO;
+	}
+
 	byte = 0;
 	if (snd_i2c_readbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-- 
2.17.1

