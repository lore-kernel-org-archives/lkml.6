Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A452177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYpWZ6GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfBSOMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:12:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38601 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfBSOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:12:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so22124696wrw.5;
        Tue, 19 Feb 2019 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0JBM24FcnQmJde4WWzmBZkXqboeyOfFTcrQBHQ0MrE=;
        b=oYpWZ6GHIP1tReRGBO0W3DC9apYQa7+3LWHqex46G4UucbgFSyL6XVfxc7IM9oZ75s
         2Yl0R0N2QiUFjpaASb7hXdodlfMd0+/gLNw2+MoukVNQBsRC3CQy569ZjYTncmyViWuT
         EZn4q5HmZdT3BYHQx4m5RLf9TPAZG7qKSCvhmwkYniZnOGxAHQ0+i6270ELvjYVGByH1
         fsHXB2ZyFznxlsGJhNP1TT/ZFrvzYvUOD96mKU75cre2VZRaK5Ft2XBTuIGpLSxE8KTt
         f4na/ZpeKqW22CYB+FSJS7SgWEYNb4kY4eLrscFzGgXaUxZoN7zlYpPUbvycWtMwi5O/
         FvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0JBM24FcnQmJde4WWzmBZkXqboeyOfFTcrQBHQ0MrE=;
        b=QCPyk0QRPrWSVdHhm9D6nQDTPnFnFlxjh8jNgTTvIupg2uvPs15Fkeyf7ctiqcEutA
         q+Z04ffisU3Me91beAEXnzszvq1bpy/aGx624g13vpHnFRAKfrTILrm8zZoynMTGupp4
         Q8k2zeMY9dqmAWhSqsv2rK6toQ7K+Nm4ApMIw1ioGDWBJ0JnkP1NaxYbY8CABugz3qay
         5EGSfXBt/EyjSf1jxqJNU9kRjyHYwo59xz+zy6VpOhN5OtyoL3aTPYWOFo+QnI8BvMgU
         hXztqWMv/+bbpiB9+P/vB1rsKNQSBC8QkOv7BMn7DeQJUMIfXY1xReT4r8Nu2yIiT+Fs
         z7/w==
X-Gm-Message-State: AHQUAuZ1Bb5m2z1Qunfo8+yzu22rJ/r0jE5jzth82Y6qnbrZXLdjae7M
        JrFLeNqq2Qx69+CNA/3xMCk=
X-Google-Smtp-Source: AHgI3IbFeA/jEEQdX/aZ4gZJjHe3Bm8VtiS1XfpZC787xUxsokGem+pWeQLBb2Tw+4nYc5GrEgZyzA==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr22553510wrn.130.1550585570974;
        Tue, 19 Feb 2019 06:12:50 -0800 (PST)
Received: from localhost.localdomain ([5.2.196.146])
        by smtp.gmail.com with ESMTPSA id w4sm4510587wrk.85.2019.02.19.06.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:12:50 -0800 (PST)
From:   Bogdan Togorean <bogdan.togorean@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@gmail.com>
Subject: [PATCH 2/2] ASoC: adau1977: Add support for setting MICBIAS via DT
Date:   Tue, 19 Feb 2019 16:11:39 +0200
Message-Id: <20190219141139.24216-3-bogdan.togorean@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219141139.24216-1-bogdan.togorean@gmail.com>
References: <20190219141139.24216-1-bogdan.togorean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If platform_data is NULL add reading of optional adi,micbias
property from DT. If adi,micbias is not set keep the default
value for micbias.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
---
 sound/soc/codecs/adau1977.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 116af6a9ce3b..11c53bcb71dd 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -885,13 +885,15 @@ static int adau1977_setup_micbias(struct adau1977 *adau1977)
 	struct adau1977_platform_data *pdata = adau1977->dev->platform_data;
 	unsigned int micbias;
 
-	if (pdata) {
+	if (pdata)
 		micbias = pdata->micbias;
-		if (micbias > ADAU1977_MICBIAS_9V0)
-			return -EINVAL;
-
-	} else {
+	else if (device_property_read_u32(adau1977->dev, "adi,micbias",
+					  &micbias))
 		micbias = ADAU1977_MICBIAS_8V5;
+
+	if (micbias > ADAU1977_MICBIAS_9V0) {
+		dev_err(adau1977->dev, "Invalid value for 'adi,micbias'\n");
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(adau1977->regmap, ADAU1977_REG_MICBIAS,
-- 
2.20.1

