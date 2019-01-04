Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4362087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NYEVQPvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfADVxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:53:39 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:48270 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfADVxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1546638817; x=1578174817;
  h=from:to:cc:subject:date:message-id;
  bh=KE6zIxIVEmfezihalNrix5h31w4wTlnYRw+A9IV+RzA=;
  b=NYEVQPvU3UxmnKtcuwu8OKKHRmdjt4I/WoxvktFPNPEuiWJGdcafVCDD
   fIy7/qTn8SHrryX4DOlu4uhwJX7t1sYDL7GQgDqYVZeqrtx4ts8z5pcUG
   /zIwVAd2omweqS8ZTgO7BXBgc4CKVTv19f8ABVxhUCaBrYH+eEa6esCLU
   Qr3g7ZDMP/iWJ4I/PJ0d4n3t3JP2ev4u2tBsN+DC6SON7z8Atpkyb+64y
   IelyTaVqOgeebbpdXjBhJqsA0/MdlrobOFVFYk44fM6TR2+nDyWVjnU5D
   S2ZKhgrBpLQyqouP9B5Fw7z3+OnbbeN293HfPFSjRFA9k2WnfOppoMi10
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AsDl4/RwCy+W1MrzXCy+O+j09IxM/srCxBDY+r6Qd?=
 =?us-ascii?q?1OIUIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbDQizf?=
 =?us-ascii?q?ssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1?=
 =?us-ascii?q?JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryhvOrHtIeu?=
 =?us-ascii?q?BWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3o05MLwqxbO?=
 =?us-ascii?q?SxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RSqt4LtqSB/wiS?=
 =?us-ascii?q?cIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyVMft+frjGfdMbQ2pBUdtaWTJYDIih?=
 =?us-ascii?q?YYsPDvQOPeJFoILgo1cDoweyCQyqCejyyDFHm2X20LU63eo/DA/I0g8uEdUVvX?=
 =?us-ascii?q?jIsNn4LrseXPqpwKXUyzjIcvNY2S366IjNah0uo/CMXLNwccrMzkkkCgTIj1WR?=
 =?us-ascii?q?qIzlJTyV1/gBv3SV4ud7SOKgl3QnpxtvrTey28chk4/EjZ8WxFDc7Sh13po5KN?=
 =?us-ascii?q?miREN4YdOoCoVcuzyaOodsX88vR2NltD4nxrAHvZO3ZjYGxZonyhLFdfCKcpKE?=
 =?us-ascii?q?7xDsWeuXPDx2nmhqeKiliBa36UWgz+r8WdSq31tStSpFl8XMtmgK1xzO9siLUv?=
 =?us-ascii?q?t98Vml2TaIzw3T7/tLIUEwlabCM54hzaM8moMdsUjeGiL7ml/6jKCRdkUj9eio?=
 =?us-ascii?q?7/robq/6qZ+bMo94kgD+MqIwlcyjGek0LBQCUmyB9em/1LDv51P1TKhKg/Esj6?=
 =?us-ascii?q?XUtJLXKdwepqGjAg9V1ogj6wy4DzejyNkZnXgGLFJfdxKGk4TlJ1/DLevlDfij?=
 =?us-ascii?q?mVSgiilkyO3bPrH5GJXCMmDDkKv9fbZ680NczAszzdZC55NbE70BI+z8WlX3tN?=
 =?us-ascii?q?PGCh80KBK0w+n5B9VnzI8eWnyAArWfMKzMtV+E/OUvI/ODZNxdliz6Lq0U5uzu?=
 =?us-ascii?q?kHhxzU4PfaCohcNMQG2zBLJrL1jPMimkucsIDWpf5ll2d+ftklDXFGELag=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DUAACF1S9ch8XXVdFjHQEBBQEHBQGBU?=
 =?us-ascii?q?QgBCwGEAw+MGV+LCVABAQaKWBhshVOCb4R+gXsBCgEBLIRAggIiNAkNAQMBAQI?=
 =?us-ascii?q?BAQIBEwEBAQgNCQgpL4I6KYJfNlKBFQEFATVbgkcBgXQNm0g8jBUziFcBB4FMC?=
 =?us-ascii?q?QEIh2yEQYEPgQeDbohSgkMCgSoBAQGKG4UekHABBgIBgVyBOY5LJIFggUKGXId?=
 =?us-ascii?q?rAS2KOo8nAgQCBAUCBQ8hgSWCDk0lgWwKgUSCNRuOLB4zgQeJYAE?=
X-IPAS-Result: =?us-ascii?q?A2DUAACF1S9ch8XXVdFjHQEBBQEHBQGBUQgBCwGEAw+MGV+?=
 =?us-ascii?q?LCVABAQaKWBhshVOCb4R+gXsBCgEBLIRAggIiNAkNAQMBAQIBAQIBEwEBAQgNC?=
 =?us-ascii?q?QgpL4I6KYJfNlKBFQEFATVbgkcBgXQNm0g8jBUziFcBB4FMCQEIh2yEQYEPgQe?=
 =?us-ascii?q?DbohSgkMCgSoBAQGKG4UekHABBgIBgVyBOY5LJIFggUKGXIdrAS2KOo8nAgQCB?=
 =?us-ascii?q?AUCBQ8hgSWCDk0lgWwKgUSCNRuOLB4zgQeJYAE?=
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="1051518124"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 04 Jan 2019 13:53:15 -0800
Received: by mail-pg1-f197.google.com with SMTP id o17so31238672pgi.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bcRpBh4xAw+MYqTUT9pUoObzqTgSOzqrk5i6PSdJQ1U=;
        b=AQsscnuWdocLaz7ZdBstxv5/z4v3lA1MuFffm58MdYrdgqojJYQRbc0YenpIW46oDY
         VK+Gl5XmlW69N1uLdx3rVtdKoTy2vs685Eb5jmcd4q2RLxDujd2CT5/YYgMawc2zBNXo
         tCvuNp4rLbWHcVlqhKsN9wSbJjg3yCh5jJBguqSAmL0a5p/C8W3BYKN0WczA1hUVkaC/
         uBDEo28PHUJIqhoYVz2x73ReIah5q7/AyaV3gGGzUw8PHWprDqDjhIS42IUjjPbYgpkE
         Nrn59WRUuODnZlevm2AtNeP4Kjyd9wGXG1euF9YD0RwCaYRRgzSpZAbVoKVbBaQyfpVL
         ehrQ==
X-Gm-Message-State: AJcUuke05UfNa7m6bKRm6VTdB+Mgwr4d6smAWoBNwwK8D8s8clh3bn3J
        CUuiwRLZ+56MZecw9DaNXHv8Zv34vKCBwMMuyYqh6vnYR+ejBqpvGNaMTlcB4fGrJkbiIgjTXpA
        YUwzmFwYuHA+8/G4sY5S+qnR7bw==
X-Received: by 2002:a63:d846:: with SMTP id k6mr3080470pgj.251.1546638795416;
        Fri, 04 Jan 2019 13:53:15 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5swTgGXISJ+vGT9ltDwNeGss8juMTdHAkURLQsR7b8FeKi18ieZS3LPwnvrVWgKQf6CKQfQQ==
X-Received: by 2002:a63:d846:: with SMTP id k6mr3080448pgj.251.1546638794871;
        Fri, 04 Jan 2019 13:53:14 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id h79sm118115071pfj.186.2019.01.04.13.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:53:13 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt298: Variable "val" and "buf" in rt298_jack_detect() could be uninitialized
Date:   Fri,  4 Jan 2019 13:52:53 -0800
Message-Id: <20190104215253.16278-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rt298_jack_detect(), local variable "val" and "buf"
are supposed to get initialized by regmap_read(). However, they
 could be leave uninitialized if regmap_read() returns -EINVAL.
Those two variables are used in control flow or update the argument,
which could lead to undefined behavior and thus unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ce963768449f..7f74349c17f3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -223,6 +223,7 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 {
 	struct snd_soc_dapm_context *dapm;
 	unsigned int val, buf;
+	int ret = 0;
 
 	*hp = false;
 	*mic = false;
@@ -233,7 +234,10 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 	dapm = snd_soc_codec_get_dapm(rt298->codec);
 
 	if (rt298->pdata.cbj_en) {
-		regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		if (ret)
+			return ret;
+
 		*hp = buf & 0x80000000;
 		if (*hp == rt298->is_hp_in)
 			return -1;
@@ -260,16 +264,19 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 			regmap_update_bits(rt298->regmap,
 				RT298_CBJ_CTRL1, 0xfcc0, 0xd400);
 			msleep(300);
-			regmap_read(rt298->regmap, RT298_CBJ_CTRL2, &val);
-
+			ret = regmap_read(rt298->regmap, RT298_CBJ_CTRL2, &val);
+			if (ret)
+				return ret;
 			if (0x0070 == (val & 0x0070)) {
 				*mic = true;
 			} else {
 				regmap_update_bits(rt298->regmap,
 					RT298_CBJ_CTRL1, 0xfcc0, 0xe400);
 				msleep(300);
-				regmap_read(rt298->regmap,
+				ret = regmap_read(rt298->regmap,
 					RT298_CBJ_CTRL2, &val);
+				if (ret)
+					return ret;
 				if (0x0070 == (val & 0x0070))
 					*mic = true;
 				else
@@ -285,9 +292,14 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 				RT298_CBJ_CTRL1, 0x0400, 0x0000);
 		}
 	} else {
-		regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		if (ret)
+			return ret;
+
 		*hp = buf & 0x80000000;
-		regmap_read(rt298->regmap, RT298_GET_MIC1_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_MIC1_SENSE, &buf);
+		if (ret)
+			return ret;
 		*mic = buf & 0x80000000;
 	}
 
-- 
2.17.1

