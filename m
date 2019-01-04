Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590921872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="c6YoJrhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfADUmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:42:52 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:24975 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:42:51 -0500
X-Greylist: delayed 885 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2019 15:42:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1546634571; x=1578170571;
  h=from:to:cc:subject:date:message-id;
  bh=dVeo+lqbfDbwmjZVwas2MgBddAFiC9twLCj5ra9dt9k=;
  b=c6YoJrhIsFCPFDsSoDyKbtgVKfc1cmUkOtI7/eeo1Gyuk+8Hstkhe3Nf
   PNL/CPIWtshVJpySUC5VTtW2sC3PpiLz1eZ6qzOwjoFXushSz8UbDcxnv
   9v80PiEGvqG9bstpYT8Ngpk/2+9tVmhPwdWduMb9Nhoq+98r+k8t/srT4
   xxDh4gzTZIeKJ/syH9mL1ZNFirxSLW0GjruyIBcBWIxdAff/XLcQH8ddm
   97POFHPeUtKOVdXWVZ6WjgokA0UqHkPg7DFYPI7+KoOAuDvpYp5VmM+Sj
   3rMcy+Ot1KuUVLPuH/ozZvcW/x1PELi0nNW48P+7jm4zCS1x/q+QHUFOw
   A==;
IronPort-PHdr: =?us-ascii?q?9a23=3Aw7izihIN8uc4j6eNYdmcpTZWNBhigK39O0sv0rFi?=
 =?us-ascii?q?tYgRIv7xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD4+ou?=
 =?us-ascii?q?JSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgpp?=
 =?us-ascii?q?POT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0AHJonxGe+?=
 =?us-ascii?q?RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L281/szrugLd?=
 =?us-ascii?q?QgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8ahkVB7oiD?=
 =?us-ascii?q?8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfp7f6PdZsgaRWtHXsZeSidPHJqy?=
 =?us-ascii?q?ZJYBD+oAI+lYq5TyrEYKoRawGQWgAeXiwSJKiHDrx603y+QvHx/b0gIuHNwAt2?=
 =?us-ascii?q?/ZoMnpOKoITey41rXEwSnFYvhL2Tn98o/IchU5rP6OXLJxcMrRyVQoFwjYiViR?=
 =?us-ascii?q?qY3kPzOP2eQMr2SX8+RtWPmyi2E7sQF9uCagydoxioTQgI8e11PK9T1hzYorOd?=
 =?us-ascii?q?G1TFR3bN2kHZdKqS2WKoR7Ttk/T2xsuis20qAKtJ+/cSQQ1pgqyR7SZ+aZf4WJ?=
 =?us-ascii?q?+B7uVumcLDFlj3x/Yr2/nQy98U24x+35Ucm7zUhFozJektnJqnANzxvT6tWbSv?=
 =?us-ascii?q?dl/keuxzKP1wfL5+FBO080lK7bJ4c5wr40i5YfqErDEjLylUj0lqOWeUIk+u+n?=
 =?us-ascii?q?6+TjfLrqvIOTN4hxig3mM6QunNKwAfggPwQQQ2SW/f6w2b7j8EHjXrlGk/I7nr?=
 =?us-ascii?q?PEvJ3eJ8kXvqu5DBVU0oYn5Ra/FTCm0NEAkHgHLVNFeAiIj4n1N13SLv31Fuq/?=
 =?us-ascii?q?jEi2kDtx2f/JI6DhDo3XLnffiLfhYap960lExQo3zNBf4Y9UC74YLPLwREDxrt?=
 =?us-ascii?q?rYAQE9MwGv3ebnB8ty1pkEVWKMHKCZKqXSvkGM5u41JOmMfoAV637TMf8gss/v?=
 =?us-ascii?q?n38knhdJbLup1JpPMCuQA/98ZUiVfCy/0Z86DW4Ws19mH6TRg1qYXGsWOC6/?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CvAACMwS9ch8XWVdFjHQEBBQEHBQGBU?=
 =?us-ascii?q?QgBCwGEAw+MGV+LCVABAQaKWBhshVOCb4R+gXsBCgEBLIRAggIiNAkNAQMBAQI?=
 =?us-ascii?q?BAQIBEwEBAQgNCQgpL4I6KYJfNlKBFQEFATVbgkcBgXQNm0I8jBUziFUBB4FMC?=
 =?us-ascii?q?QEIh2yEQYEPgQeDbohSgkMCgSoBAQGKG4UekHABBgIBgVyBOY5LJIMihlyHawE?=
 =?us-ascii?q?tmWECBAIEBQIFDyGBJYIOTSWBbAqBRIInDgkSjiweM4EHiWEB?=
X-IPAS-Result: =?us-ascii?q?A2CvAACMwS9ch8XWVdFjHQEBBQEHBQGBUQgBCwGEAw+MGV+?=
 =?us-ascii?q?LCVABAQaKWBhshVOCb4R+gXsBCgEBLIRAggIiNAkNAQMBAQIBAQIBEwEBAQgNC?=
 =?us-ascii?q?QgpL4I6KYJfNlKBFQEFATVbgkcBgXQNm0I8jBUziFUBB4FMCQEIh2yEQYEPgQe?=
 =?us-ascii?q?DbohSgkMCgSoBAQGKG4UekHABBgIBgVyBOY5LJIMihlyHawEtmWECBAIEBQIFD?=
 =?us-ascii?q?yGBJYIOTSWBbAqBRIInDgkSjiweM4EHiWEB?=
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="1051515945"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 04 Jan 2019 12:27:33 -0800
Received: by mail-pl1-f197.google.com with SMTP id t10so27824049plo.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KIRoQOlFmlmxA8eKEGFEBWnDpcFgN9v4YUYbB67RaLE=;
        b=ltDS/dYvwJoSdaHEKZtTneEKMYIxHPRZuBdjEauHYv5c1rmiTMSirO0hBdJdA27pLU
         fG3nPFJPxpYVqfErIU/EvP4xJT7GoYpCI9uPBhl4YN08la8vBzKOmHF55zOw4oeByqE+
         L2/eGt4gQDxGNko2apN0ouLvQ+XvFyfzbOGBRrsrK65xDDkH6sGBj6HhYvyPUQUMi6lM
         SD2O/HWn9A0JQdQ0vLv8tHVos074bL+lKyuGehYBZcmdNquRauT35MfzZpsOMKn1VtRz
         PGx6vsqp3uO/BdjrcrDkelSnrPx024QbPeucm0E9/rATHdjxhtHzaOXP2pgrCWMaD9jy
         98Ow==
X-Gm-Message-State: AA+aEWa76XMcof0cHXnCgpK3FvpZrTWS1QhRkBVHVFzSWsAJDmgAGyxC
        26MI59/rt6EqpPyIi4O8fpNoukfjAAlpEo0KlcYGod3SxayrJl2/GQFG99GTULNcfQF4cMc+do4
        DaKu1cfxa5cnlhhOVIoZ0gZL/lw==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr53236006pfm.62.1546633652826;
        Fri, 04 Jan 2019 12:27:32 -0800 (PST)
X-Google-Smtp-Source: AFSGD/W03SynDHQ7y9cEWoVQUJakgQvJ8HKSIcPJakWCKASa8I69A1aWyyaXh3EHx3P+oMn518anoA==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr53235987pfm.62.1546633652339;
        Fri, 04 Jan 2019 12:27:32 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id t3sm70447440pgv.31.2019.01.04.12.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 12:27:31 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt274: Variable "buf" in function rt274_jack_detect() could be uninitialized
Date:   Fri,  4 Jan 2019 12:27:08 -0800
Message-Id: <20190104202708.14759-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rt274_jack_detect(), local variable "buf" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used to calculate "hp" and "mic" and
make their value unpredictable while those value are used
in the caller. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cd048df76232..a2c1a6df8df6 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -353,6 +353,7 @@ static void rt274_index_sync(struct snd_soc_codec *codec)
 static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 {
 	unsigned int buf;
+	int ret = 0;
 
 	*hp = false;
 	*mic = false;
@@ -360,9 +361,15 @@ static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 	if (!rt274->codec)
 		return -EINVAL;
 
-	regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*hp = buf & 0x80000000;
-	regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*mic = buf & 0x80000000;
 
 	pr_debug("*hp = %d *mic = %d\n", *hp, *mic);
-- 
2.17.1

