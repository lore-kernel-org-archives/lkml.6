Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42467C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443A252C8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqyWI1ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E443A252C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeFXSOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 14:14:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42303 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeFXSOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 14:14:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id u202-v6so524744lff.9;
        Sun, 24 Jun 2018 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qYdXgGdymscMzna58pIG2G67+erNmrOJHfk9CjKMqYM=;
        b=JqyWI1ZE8l7haJGZV4Ca2iDyvAAqAW6sYD+5W3C969vcO+daJI5gWLY6Nj6NAnx72z
         WlEGjJzrxqdCWEz/hKxQn2RuxhbC2ANNY7mnpWsMbKgbhwK9bPuuchhiLlwngj0F6KzS
         Qoq9Mt3sX6MgVEhFKCH9jqa4+Dv3dlUdgTy2Ja5g1hEXOzNuWvg7d1WbhD0+AMMhBMQj
         xX2QUpmfm3mLcpaade+YqOvN7meSqq0r3bizYydf5ZzHVbb44N1PaKPGoVprtQSbnmM+
         AmUhluDRijHT8zWvKZqLkfduSeWeY88CRSW5Bp7/rbAYQ1BxcJEfaITdJTm6gbKuS3Ul
         qYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qYdXgGdymscMzna58pIG2G67+erNmrOJHfk9CjKMqYM=;
        b=MbUzLOBRksA4/xnJZaXS/ygxwvlZJYCm9OGOChW7x5vDQIK9vtXhmdvuRrkDL5fOv0
         DF13PIY2cxQCtEnFPhDud3Qs4U9z/mgTZwnG8i1F+4B5noFTTMu1Rys2926DAtp51W6K
         Kr9k2/xzScayH/Pqklpyu1Bo7MjL8ckflQQbJgla2sGSxmWPzuYLnelZ0SObnjihBRxk
         GG9s6DnTP0RAFy7A1NvN6BzRJMlZQVQRSqSg7G5zI5vEfumoaa3fChrBAetqFnVFVyg4
         KtBznPJ9jJebWR2es2QpDD9lVQmoFXiZBsf7G1+0sOGopuiZoB+1el59M36qmDhlINB7
         /GtA==
X-Gm-Message-State: APt69E1gJb3B0FZ1fz2zSzPsAKEQKHCMOe9dNDvmTU+F/OX1M/Rg6nVc
        RJ5yTB2yuDZ2b+l1HKcT/yQ=
X-Google-Smtp-Source: ADUXVKJP2cUntjeciG9Nz/+dHWcsuiDp6c8BGoixbz1X9HUcSfBRSFfnQzZrsJMLwATymihYG6igDQ==
X-Received: by 2002:a19:e9d7:: with SMTP id j84-v6mr3875450lfk.115.1529864073238;
        Sun, 24 Jun 2018 11:14:33 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-33-209.dynamic.gprs.plus.pl. [31.0.33.209])
        by smtp.gmail.com with ESMTPSA id h82-v6sm2761433lfg.51.2018.06.24.11.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 11:14:32 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ASoC: cx20442: Don't ignore regulator_get() errors.
Date:   Sun, 24 Jun 2018 20:14:41 +0200
Message-Id: <20180624181441.6975-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current shape, the driver just ignores errors returned by
regulator_get() at component_probe().  This doesn't hurt on Amstrad
Delta board as long as it registers the codec device at late_initcall,
when the regulator which depends on basic-mmio-gpio device (probed as
late as at dev_initcall) is already available.  Otherwise the driver
may end up trying to control a codec which is not powered up.

Remove that dependency on initialization order by handling the error.
If the regulator is not yet available and -ENODEV is returned, convert
it to -EPROBE_DEFER to get another chance.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Created and tested on linux-4.18-rc1

 sound/soc/codecs/cx20442.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 07dd33b09596..ab174b5114dc 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -362,8 +362,27 @@ static int cx20442_component_probe(struct snd_soc_component *component)
 		return -ENOMEM;
 
 	cx20442->por = regulator_get(component->dev, "POR");
-	if (IS_ERR(cx20442->por))
-		dev_warn(component->dev, "failed to get the regulator");
+	if (IS_ERR(cx20442->por)) {
+		int err = PTR_ERR(cx20442->por);
+
+		dev_warn(component->dev, "failed to get POR supply (%d)", err);
+		/*
+		 * When running on a non-dt platform and requested regulator
+		 * is not available, regulator_get() never returns
+		 * -EPROBE_DEFER as it is not able to justify if the regulator
+		 * may still appear later.  On the other hand, the board can
+		 * still set full constraints flag at late_initcall in order
+		 * to instruct regulator_get() to return a dummy one if
+		 * sufficient.  Hence, if we get -ENODEV here, let's convert
+		 * it to -EPROBE_DEFER and wait for the board to decide or
+		 * let Deferred Probe infrastructure handle this error.
+		 */
+		if (err == -ENODEV)
+			err = -EPROBE_DEFER;
+		kfree(cx20442);
+		return err;
+	}
+
 	cx20442->tty = NULL;
 
 	snd_soc_component_set_drvdata(component, cx20442);
-- 
2.16.4

