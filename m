Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E573C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C218217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="PR6M+G/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfAYSx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:53:57 -0500
Received: from mx5.ucr.edu ([138.23.62.67]:3417 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfAYSx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548442436; x=1579978436;
  h=from:to:cc:subject:date:message-id;
  bh=A6AGaJZxC7CSOYep6As6FAR1JzODsulmW2ZPRkr14ow=;
  b=PR6M+G/uLju4FfPSHsS1rJ3Xs9eUJp6SRVH05p9t2CB4aUQWDEWwxN2O
   uYqm0GYHzQEi8XHXInUT/9pAgZN5guOhIk5MxPeIdm57AkKYVEzp9yyj+
   PbsI+3SAn9jD2IkypQXCqRPHz2nt05nPr5yGFxq6aUHdr1UF7en0rwpLO
   mBSnSKFLaRoJ2y97ZkRxz//AP8A5wgUDMt8dFCo8F1OETOcKyJOijQI5z
   GfaNmuUR9Trml4Mx1VW1gJH9BiR0o7r2PSRq4YLE04AprQUuvKDSsg+Mm
   FBI+VE2vqhLEU7Htnb1rQOaqQE2U8pnezbyVCSiHPB9AR+lV5dD5BjzVw
   g==;
IronPort-PHdr: =?us-ascii?q?9a23=3AHKc2LhzqY93+4aDXCy+O+j09IxM/srCxBDY+r6Qd?=
 =?us-ascii?q?1OIUIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbDQizf?=
 =?us-ascii?q?ssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1?=
 =?us-ascii?q?JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryhvOrHtIeu?=
 =?us-ascii?q?BWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3o05MLwqxbO?=
 =?us-ascii?q?SxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RSqt4LtqSB/wiS?=
 =?us-ascii?q?cIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyVMft+frjGfdMbQ2pBUdtaWTJYDIih?=
 =?us-ascii?q?YYsPDvQOPeJFoILgo1cDoweyCQyqCejyyDFHm2X20LU63eo/DA/I0g8uEdUVvX?=
 =?us-ascii?q?jIsNn4LrseXPqpwKXUyzjIcvNY2S366IjNah0uo/CMXLNwccrMzkkkCgTIj1WR?=
 =?us-ascii?q?qIzlJTyV1/gBv3SV4ud7SOKgl3QnpxtvrTey28chk4/EjZ8WxFDc7Sh13po5KN?=
 =?us-ascii?q?miREN4YdOoCoVcuzyGO4dsX88vR2VltD4nxrAHvZO3ZjYGxZonyhLFdfCKcpKE?=
 =?us-ascii?q?7xDsWeuXPDx2nmhqeKiliBa36UWgz+r8WdSq31tStSpFl8XMtmgK1xzO9siLUv?=
 =?us-ascii?q?t98Vml2TaIzw3T7/tLIUEwlabCM54hzKM8moMdsUjeGiL7nF/6jKCRdkUj9eio?=
 =?us-ascii?q?7/robq/6qZ+bMo94kgD+MqIwlcyjGek0LBQCUmyB9em/1LDv51P1TKhWgvEsj6?=
 =?us-ascii?q?XUtJTXKdwepqGjAg9V1ogj6wy4DzejyNkZnXgGLFJfdxKGk4TlJ1/DLevlDfij?=
 =?us-ascii?q?mVSgiilkyO3bPrH5GJXCMmDDkKv9fbZ680NczAszzdZC55NbE70BI+z8WlX3tN?=
 =?us-ascii?q?PGCh80KBK0w+n5B9VnzI8eWnyAArWfMKzMtV+E/OUvI/ODZNxdliz6Lq0U5uzu?=
 =?us-ascii?q?kHhxzU4PfaCohcNMQG2zBLJrL1jPMimkucsIDWpf5ll2d+ftklDXFGELag=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C5AAAJW0tcgMfSVdFkHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBhAUPjBtfixdQAQEGinxthVeCcoUKgXsBCgEBLIRAgwwiNAkNAQM?=
 =?us-ascii?q?BAQIBAQIBEwEBCQ0JCCcxgjopgl82UoEVAQUBNVuCRwGBdA0FnyM8jBcziGABB?=
 =?us-ascii?q?4FLCQEIh26EQYEPgQeDboR/g1SCQwKBLAEBAYo5hS2RIgEGAgGBY4FBjnokgzG?=
 =?us-ascii?q?GcIgFAS2acQIEAgQFAgUPIYElgg5NJYFsCoFEglGOLB4zgQeHWoJNAQ?=
X-IPAS-Result: =?us-ascii?q?A2C5AAAJW0tcgMfSVdFkHAEBAQQBAQcEAQGBUQcBAQsBhAU?=
 =?us-ascii?q?PjBtfixdQAQEGinxthVeCcoUKgXsBCgEBLIRAgwwiNAkNAQMBAQIBAQIBEwEBC?=
 =?us-ascii?q?Q0JCCcxgjopgl82UoEVAQUBNVuCRwGBdA0FnyM8jBcziGABB4FLCQEIh26EQYE?=
 =?us-ascii?q?PgQeDboR/g1SCQwKBLAEBAYo5hS2RIgEGAgGBY4FBjnokgzGGcIgFAS2acQIEA?=
 =?us-ascii?q?gQFAgUPIYElgg5NJYFsCoFEglGOLB4zgQeHWoJNAQ?=
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="23695216"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtpmx5.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 25 Jan 2019 10:45:53 -0800
Received: by mail-pf1-f199.google.com with SMTP id p15so8232133pfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1QOsUWecV2RDcnzuAuipZco+k6f59evuap0j4RrEzQo=;
        b=DbWaqKd/QxJd3phb1/nujncOkpWb8WGZz2VWPG0xeoVQ0hth0wjXXwgM4PIkIZhZyR
         32ZHUv/XpAvsG8pN/JekWNSgQyiz67xgt4ivXdjUBgLPGed36g7EY4YH9J9vmszFolTZ
         qqrn3TdUzrQ1H955sGn05kN9oJuOCrvASNt6vuX+DCEn+1llqFjHCwauWl8pLPC0kDMY
         oK+fzqATJ3mjOEUI9ZoyonpX3krNtEnlXw+QURqlAuMXbw5shImviNuBImkNS4OOdk1D
         FrQHfXBiayJtk8tP16IRBEBDJl2iVMfEG6q85fqQoo4ViLZFAumK7C+EeG/MZTDPyoAP
         IS2g==
X-Gm-Message-State: AJcUukfkb2cfxqnOo3VbqCCl3f+ZIgmt12w26ge6mJyVDV3o1xi7hSUW
        ZezDpEGhjR8DVZSaQwMEjJ9ekqjaAPsGORMR7l3ZloeP+2xSm9+bJ3kr0VMz0DK9irUd72xXBAx
        /zkeQ34K/4vw76JQa3XR/Gxm/mQ==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr11060314pgo.378.1548441953001;
        Fri, 25 Jan 2019 10:45:53 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4eG5mL0LiUw4mtCPBegkwoliucgx9/VQjYjHOdO6c4vwIWIqknx/3RFpXQYUlNPE4aY7waMA==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr11060293pgo.378.1548441952615;
        Fri, 25 Jan 2019 10:45:52 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id t3sm26068745pgv.31.2019.01.25.10.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:45:51 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5651: Variable "ret" in function rt5651_i2c_probe() could be uninitialized
Date:   Fri, 25 Jan 2019 10:45:37 -0800
Message-Id: <20190125184537.13419-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rt5651_i2c_probe(), local variable "ret" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement. This is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt5651.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index da60b28ba3df..8d6cbc6b6ff0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1734,6 +1734,7 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	struct rt5651_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5651_priv *rt5651;
 	int ret;
+	int err;
 
 	rt5651 = devm_kzalloc(&i2c->dev, sizeof(*rt5651),
 				GFP_KERNEL);
@@ -1755,7 +1756,10 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	err = regmap_read(rt5651->regmap, RT5651_DEVICE_ID, &ret);
+	if (err)
+		return err;
+
 	if (ret != RT5651_DEVICE_ID_VALUE) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5651\n", ret);
-- 
2.17.1

