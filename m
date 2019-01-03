Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01031C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B719121479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HNInV1pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfACCoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:44:46 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:31224 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfACCoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:44:46 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 21:44:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1546483485; x=1578019485;
  h=from:to:cc:subject:date:message-id;
  bh=42rgqTIvm3wNn/AyhXkmJiM9paV2BATOvozMQnyiUvc=;
  b=HNInV1pAG1MazTcqfAMfrp7mcu0iHWj6q7mQ57qhn3YPjAFc6ujTGdce
   3V6yOj5sYh2jeqCZ3TmxYSMniTtmKfB/VLE4+HyPpKolGpqeE1/KC5I1q
   VM9CNmcKJVINamIWqRgoW5PUBPURAbSJvHuKuFSR6UGJA/x3NX3X041Os
   M9wV0mLoLfoO92JH+fXA++ScfsZsp2+AMeR5k49v0fImeKdZEMUYlJYUm
   /aHwBtq5OhpDO0/RTiLdUAcq1zu0cUsPLkEVIB2SqRt956dLe1RDZB8lN
   mVGZ04X4epeG5U3FlQ3D2/bro8ny+KdlOsb1fdRIMEghkwpfV/VSf4cLZ
   A==;
IronPort-PHdr: =?us-ascii?q?9a23=3A9GF3Wh/sz+j0BP9uRHKM819IXTAuvvDOBiVQ1KB4?=
 =?us-ascii?q?2+gcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fDhBt/?=
 =?us-ascii?q?8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1?=
 =?us-ascii?q?Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyhzHontJf+?=
 =?us-ascii?q?RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKWE169b1uhTF?=
 =?us-ascii?q?UACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRzut86ZrSAfpiC?=
 =?us-ascii?q?gZMT457HrXgdF0gK5CvR6tuwBzz4vSbYGQNfp+ZbjdfdIcRWpOQ81fSTVPCZ6y?=
 =?us-ascii?q?b4sOEeUBOftXpJT5q1YAsReyAA+hD/7txDBVnH/7xa003fo8Hw/I3wIuGMkDvG?=
 =?us-ascii?q?jIoNjvKKsfS/y5wLXOwD7eb/1WwzD96I3Qfx8joPGNXLJwcdfWyUIyEA7EjlSR?=
 =?us-ascii?q?qYz/MDOUyugBr2aW4vF9Ve2zkW4rsR9+rSWyxso1jITCm4Ebykjc+Cln3Io4Ic?=
 =?us-ascii?q?e0RU17bNK+DpdcqiGXO5FrTs4mR2xkoDs2x7wCtJKhYiQHxpQqywTBZ/GGaYSF?=
 =?us-ascii?q?4B3uWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U5RripAjtnMrncN1wHP6sSfSv?=
 =?us-ascii?q?ty4EOh2TGX2gDW8O5EIEQ0mbPDK54u37I8j5QTvVnHEyLygkn2g6iWdkIr+uis?=
 =?us-ascii?q?9evreKnpppiZN4NsiwH+NLohmtCnDOgmLgQDW3KX9Oe82bH540H1XbVHgucrnq?=
 =?us-ascii?q?TdtJ3WPcEbqbS4Aw9R3IYj8RG/DzK+3dUYnHgHLEhKeBObg4T1NVzDO+34Auul?=
 =?us-ascii?q?g1i2jjhk2u3GMqX7AprRNnjDjKvhfbFl5k5YyQozy81f5p1NBrECPv3zQEnxu8?=
 =?us-ascii?q?LcDhIiLQy0zPjoCM9n2oMdR22PGKmZP73WsVOS4eIvOeaMN8c7ojH4fskk9f7z?=
 =?us-ascii?q?ijdtiE0ddKjxhcA/dXuiWPlqPhPKMjLXnt4dHDJS7UIFR+vwhQjHDmZe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BuAQC6dS1cgMfXVdFjHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZYQED4x4iwZPAQEBBopXGGyFU4llAQoBASyEQIF7IkoBAwEBAgEDARMBAQk?=
 =?us-ascii?q?NCQgnMYI6KYJfNlJWPwEFATVbgkcBgXQNmx48jBUziFABB4FMCQEIh2yEQYEPg?=
 =?us-ascii?q?QeMQIJDAoEqAQEBihiFHpBnAQYCAYFbgTmOSSSDIoZZh2oBLZlVAgQCBAUCBQ8?=
 =?us-ascii?q?hgzNNJYFsCoFEglCOLB4zgQeJOAE?=
X-IPAS-Result: =?us-ascii?q?A2BuAQC6dS1cgMfXVdFjHAEBAQQBAQcEAQGBZYQED4x4iwZ?=
 =?us-ascii?q?PAQEBBopXGGyFU4llAQoBASyEQIF7IkoBAwEBAgEDARMBAQkNCQgnMYI6KYJfN?=
 =?us-ascii?q?lJWPwEFATVbgkcBgXQNmx48jBUziFABB4FMCQEIh2yEQYEPgQeMQIJDAoEqAQE?=
 =?us-ascii?q?BihiFHpBnAQYCAYFbgTmOSSSDIoZZh2oBLZlVAgQCBAUCBQ8hgzNNJYFsCoFEg?=
 =?us-ascii?q?lCOLB4zgQeJOAE?=
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="1052977723"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 02 Jan 2019 18:39:02 -0800
Received: by mail-pg1-f199.google.com with SMTP id o17so28118477pgi.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 18:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+vSYyjIjTQDu3l0m0Df8bdp0mqwMjzx8LaeThqnQexk=;
        b=NbIjztR93DhUCTxWs/RCo4vN1n8VoaNAvwOo3luKH/hSVhqb1e1QFXgBmt3i+eaJ7V
         zRHZP8zb8QjjSUnrJHKOC5wc8c5LUSEu+TpcbBb1n2w8EJAUXwJXAjIsZR51ElrRHp3V
         SCgV3Ke1+w15Tkfp5bLk+U6aF5orBHSbDUO08FkLDSLUJaXYA6e8Es3zXvujkc0MicJv
         rVpPBz0YkhJNig0hb+VT6wxC+4sc6avcG63LCocmmuUvMLOyDw0QHZrLL1ktLFyGGmDe
         aainXalAa+nnAqP/CBCWCix36BgLRhls3anS0Sbrbh+dZUQzkSt9bg5TWCEmPEMqSufp
         5cqg==
X-Gm-Message-State: AJcUukf8VogZF9MXlKtfsumRRQXcvGolip/E6Q942a4xGH6LhqKBAaSc
        eyTvmP2fSFLWDephWEVC0fhrSeHLIFY+Xx6rOTFSrJ/SsVgJmVO+gbc1FWYxcjHVR5JK3CURgEl
        SMGdbRx4GDNXBq1knMo6Le3I3SA==
X-Received: by 2002:a63:6442:: with SMTP id y63mr15470578pgb.450.1546483141794;
        Wed, 02 Jan 2019 18:39:01 -0800 (PST)
X-Google-Smtp-Source: ALg8bN72VjhVA9pj9Tcv+KAivqBblD6HokQyorIzTGn02q0Bkc7L7iUGV0EJB/1obXiO7SV8o1pT9Q==
X-Received: by 2002:a63:6442:: with SMTP id y63mr15470566pgb.450.1546483141432;
        Wed, 02 Jan 2019 18:39:01 -0800 (PST)
Received: from Yizhuo.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id c9sm100995328pfc.92.2019.01.02.18.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 18:39:00 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] In function rt274_i2c_probe(), if the regmap_read fails. The variable "val" could leave uninitialized but used in if statement.
Date:   Wed,  2 Jan 2019 18:38:39 -0800
Message-Id: <20190103023839.15314-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 8f92e5c4dd9d..940658cac063 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1113,7 +1113,7 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 	struct rt274_priv *rt274;
 
 	int ret;
-	unsigned int val;
+	unsigned int val = ~0;
 
 	rt274 = devm_kzalloc(&i2c->dev,	sizeof(*rt274),
 				GFP_KERNEL);
@@ -1128,9 +1128,9 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
-	if (val != RT274_VENDOR_ID) {
+	if (ret || val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
 		return -ENODEV;
-- 
2.17.1

