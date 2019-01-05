Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9AC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6363206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="F+RQu45z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfAENon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 08:44:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56018 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAENon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 08:44:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9E9BDC83
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 13:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YUQjNzqvVgVw for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 07:44:41 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 707717BC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 07:44:41 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id j3so3200438itf.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 05:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lLxaO63rYyD+jCJ0zBgxSgVfZ1K3zX1gcZ9xN4ObIrA=;
        b=F+RQu45zZp+KqDpCUoHpW34XjeovKX3t5cSoiOixzvBvwkijByYE+EFYwLIzZDbhHv
         kgsOQsHKFahBDMv11h7VYpDJGdw4RqhX2P3u+gfWfqzbBbIcUjnWQgBe6S2anXlMoVQT
         qE5UHpspXJp5m1gSqYWaG3MGDoclbcA6otlXu8Rb1s+SdkTU2yi/9QXrskEv8bsq+p9L
         riThdQCABP7HuoUJjtzLfQoZeKdeECTlR1xcGn3bYxdsfbnpKOqnYhWpMG6S/s/DLtdb
         O06TxZilshghHeIXa8IOTZf3q2J3P1BU18HycqiQEyQsKkMUdejDjSbSKm7A+bVfwsMc
         QMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lLxaO63rYyD+jCJ0zBgxSgVfZ1K3zX1gcZ9xN4ObIrA=;
        b=f0Qitvlgs2qYMehhjQ++n+fUHpoEKRdeWbP4mbjSueriO9RSPNKd68smeyEsv9LwkK
         QXUBAuXHlsirhdl57nBoePDylJltRAh1ierzj+IP/uBMjO0ynZrBnWWtw790A4ZFsDtO
         dvrLzU1teITn14as5dO0T7sA6mNwfGLX463Lv6whPe9CKl9xsfZtNPT9xwiI2Ev4DE2h
         b6opix7x3uZD0rJEsnPJpM3MTyJnpBGks7lWjS5F0hWfZpjd6yD/XWeGte2J8+9FsIT/
         XnwPK8CkY94dC6M34Tri/MULEnPsDtN6RqZ/h3U6pxASl54CrxHNM8Epn1OUSrpRQ5Lx
         Bvgw==
X-Gm-Message-State: AJcUukfCPrQ87cNwdfovvVwqT+c1mfrmCJoHTuDTQXmIj//AdnfOPYsc
        7/I+JGDxsncsZ1XFOdfMtMIpjXeQijkAtZASe1u5UslDehTGk0bdyoFFxwM1u8/ecjzQFpzkovF
        opb+SB/xnOD4af/LqdIgtXyjuuqeT
X-Received: by 2002:a24:784a:: with SMTP id p71mr3780721itc.158.1546695881035;
        Sat, 05 Jan 2019 05:44:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6eypdpDkog8fHNJNEm7TtBZEGAXtw5rHbUxoS80E7UXSm0Q0dZ+vc18FRwuLHKUX4kOB8k4g==
X-Received: by 2002:a24:784a:: with SMTP id p71mr3780706itc.158.1546695880805;
        Sat, 05 Jan 2019 05:44:40 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id f4sm11671124iop.70.2019.01.05.05.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 05:44:40 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5663: Fix error handling of device_property_read_u32_array
Date:   Sat,  5 Jan 2019 07:44:27 -0600
Message-Id: <20190105134427.1022-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rt5663_parse_dp, the function device_property_read_u32_array() can
return an error. This fix adds a check to the latter as well as to the
callsite of rt5663_parse_dp in rt5663_i2c_probe.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/soc/codecs/rt5663.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index da6647015708..2678842d8cd4 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3480,7 +3480,7 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		table_size = sizeof(struct impedance_mapping_table) *
 			rt5663->pdata.impedance_sensing_num;
 		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
-		device_property_read_u32_array(dev,
+		return device_property_read_u32_array(dev,
 			"realtek,impedance_sensing_table",
 			(u32 *)rt5663->imp_table, table_size);
 	}
@@ -3507,8 +3507,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata)
 		rt5663->pdata = *pdata;
-	else
-		rt5663_parse_dp(rt5663, &i2c->dev);
+	else {
+		ret = rt5663_parse_dp(rt5663, &i2c->dev);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++)
 		rt5663->supplies[i].supply = rt5663_supply_names[i];
-- 
2.17.1

