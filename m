Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09738C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78B021479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fvWRIStk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfACV7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:59:49 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:12644 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfACV7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1546552787; x=1578088787;
  h=from:to:cc:subject:date:message-id;
  bh=/o+PWOz2vh0Ueg52FRsUejU5YUfBK9vRn4AgNH0aLzk=;
  b=fvWRIStkplLby2Ulk5b+Gm8ycgpVlfczASbXoyML4AcR/S81tIPYmmGB
   4R5HZ6L8lOvI7KYMVkYStKIXaz1ChUyI7Qn91FYXnGlyvMrFh5QydihNN
   ZBHXWE162H4c8kyjUDj/7IYR3ZDtlpDcPRy26/KSUHvnNW+0fkV4b4Moq
   zIGMMWHNxWYqeeS6lWBMbyxOxDEbXnRWpFuse1Fl4gMzyMGC1IM/5pY51
   vBJYzq50P0mERPPFM3yo/6mWpBPb2Nw86FYdNQ2NzYTT4z5Af/VmquJoW
   XevznlwDF5HRHGMEIBGilTAc/C1jmSxEKtsRxPJZUBXDvW/WByOsLeC8H
   A==;
IronPort-PHdr: =?us-ascii?q?9a23=3AYo0aJx9syPN0H/9uRHKM819IXTAuvvDOBiVQ1KB4?=
 =?us-ascii?q?2+gcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fDhBt/?=
 =?us-ascii?q?8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1?=
 =?us-ascii?q?Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyhzHontJf+?=
 =?us-ascii?q?RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKWE169b1uhTF?=
 =?us-ascii?q?UACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRzut86ZrSAfpiC?=
 =?us-ascii?q?gZMT457HrXgdF0gK5CvR6tuwBzz4vSbYGQNfp+ZbjdfdIcRWpOQ81fSTVPCZ6y?=
 =?us-ascii?q?b4sOEeUBOftXpJT5q1YAsReyAA+hD/7txDBVnH/7xa003fo8Hw/I3wIuGMkDvG?=
 =?us-ascii?q?jIoNjvKKsfS/y5wLXOwD7eb/1WwzD96I3Qfx8joPGNXLJwcdfWyUIyEA7EjlSR?=
 =?us-ascii?q?qYz/MDOUyugBr2aW4vF9Ve2zkW4rsR9+rSWyxso1jITCm4Ebykjc+Cln3Io4Ic?=
 =?us-ascii?q?e0RU17bNK+Dpdcqi6XO5FrTs4mQGxkoDs2x7wCtJKhYiQHxpQqywTBZ/GGaYSF?=
 =?us-ascii?q?4B3uWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U5RripAjtnMrncN1wHP6sSfSv?=
 =?us-ascii?q?ty4EOh2TGX2gDW8O5EIEQ0mbPDK54l37I8j5QTvVnHEyL1gkn2g6iWdkIr+uis?=
 =?us-ascii?q?9evreKnpppiZN4NsiwH+NLohmtCnDOgmLgQDW3KX9Oe82bH540H1XbpHgucrnq?=
 =?us-ascii?q?Tds53WPcEbqbS4Aw9R3IYj8RG/DzK+3dUYnHgHLEhKeBObg4T1NVzDO+34Auul?=
 =?us-ascii?q?g1i2jjhk2u3GMqX7AprRNnjDjKvhfbFl5k5YyQozy81f5p1NBrECPv3zQEnxu8?=
 =?us-ascii?q?LcDhIiLQy0zPjoCM9n2oMdR22PGKmZP73WsVOS4eIvOeaMN8c7ojH4fskk9f7z?=
 =?us-ascii?q?ijdtiE0ddKjxhcA/dXuiWPlqPhPKMjLXnt4dHDJS7UIFR+vwhQjHDmZe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AoAgBrhS5ch8bWVdFjHQEBBQEHBQGBZ?=
 =?us-ascii?q?YQED4x4i1oGilcYbIVTiWUBCgEBLIRAgX8iSgEDAQECAQMBEwEBAQgNCQgjAQU?=
 =?us-ascii?q?vgjopgl82UoEVAQUBNVuCRwGBdA2cAzyMFTOIVAEHgUwJAQiHbIRBgQ+BB4Nuh?=
 =?us-ascii?q?H+DU4JDAoEqAQEBihiFHpBnAQYCAYFbgTmOSSSDIoZZh2oBLZlVAgQCBAUCBQ8?=
 =?us-ascii?q?hgzNNJYFsCoFEgjWORx4zgQeGW4JNAQ?=
X-IPAS-Result: =?us-ascii?q?A2AoAgBrhS5ch8bWVdFjHQEBBQEHBQGBZYQED4x4i1oGilc?=
 =?us-ascii?q?YbIVTiWUBCgEBLIRAgX8iSgEDAQECAQMBEwEBAQgNCQgjAQUvgjopgl82UoEVA?=
 =?us-ascii?q?QUBNVuCRwGBdA2cAzyMFTOIVAEHgUwJAQiHbIRBgQ+BB4NuhH+DU4JDAoEqAQE?=
 =?us-ascii?q?BihiFHpBnAQYCAYFbgTmOSSSDIoZZh2oBLZlVAgQCBAUCBQ8hgzNNJYFsCoFEg?=
 =?us-ascii?q?jWORx4zgQeGW4JNAQ?=
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="1053039895"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 03 Jan 2019 13:59:37 -0800
Received: by mail-pl1-f198.google.com with SMTP id o23so26277287pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OLe2NbdQFZsavojLT1j4Z7BY4V9trH7FhUjP2yJHNPw=;
        b=pWGSxOZ9DFnlnlO531TLzDj9uoT5Tym6a8l7T7QKfZFy1YuFUdSCwyBzoH9c76UZtQ
         pfDOoPrFLf03qZs6PLpP6fTtXP5VSkw4H0P0HW/upw2eZFhaUUmQ1iYRYqL2n5sZBK1n
         /F+X8dpW96ATiqWsEXAx/3o2S3mvo0gZ45xnCN7Hh8HLXWo+S5wnxfjroD/vMeENLsJ6
         2ggOSAYnmg0zl8c6m10jSE27SKCCPIiKJv1uTab1acbxUg3exJRy3q2zNujAQ2H6g63S
         05jEeQgpvtysvxbGZ+QEn5eQ2iQerrJFQg1JuUX+vWq9c1xeuPEvjBNGogUV1mSPFgLj
         QEVQ==
X-Gm-Message-State: AJcUukdUpz9IC+qFw+/HeXZACg4ideel8URhZj0VJi1bbdAtEyxo98xB
        CBmgws7G+AgYS//p0AYuPwi9IsgEm4MrfymwW8DZeIII1foluPLxdaNqx+OJM5iEiPsaKsDA7rJ
        uNeH5gVNs2onel+G0Sew1GArBcg==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr45707112pla.1.1546552777438;
        Thu, 03 Jan 2019 13:59:37 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5juxUEdJkBeUTM7honNcfUdRS9AqdNMVwzMPoWrUdgYXHp6IGG3KnIIBzDjhtOHlZRKr2Dvg==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr45707097pla.1.1546552777118;
        Thu, 03 Jan 2019 13:59:37 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id e65sm103581308pfc.74.2019.01.03.13.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 13:59:36 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Variable "val" in function rt274_i2c_probe() could be uninitialized
Date:   Thu,  3 Jan 2019 13:59:12 -0800
Message-Id: <20190103215912.6071-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function rt274_i2c_probe(), if regmap_read() function
returns -EINVAL, then local variable "val" leaves uninitialized
but used in if statement. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 8f92e5c4dd9d..cd048df76232 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1128,8 +1128,11 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+	if (ret)
+		return ret;
+
 	if (val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
-- 
2.17.1

