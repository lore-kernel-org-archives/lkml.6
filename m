Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46920879
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB46920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeK2MsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:48:25 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:64526 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeK2MsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:48:25 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 489BC2B9D68559A14B65;
        Thu, 29 Nov 2018 09:44:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAT1idK5072002;
        Thu, 29 Nov 2018 09:44:39 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112909450631-13598656 ;
          Thu, 29 Nov 2018 09:45:06 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     olivier.moysan@st.com, arnaud.pouliquen@st.com, broonie@kernel.org,
        tiwai@suse.com, mcoquelin.stm32@gmail.com
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ASoC: stm32: sai: Fix invalid use of sizeof in stm32_sai_add_mclk_provider()
Date:   Thu, 29 Nov 2018 09:44:34 +0800
Message-Id: <20181129014434.51578-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-29 09:45:06,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-29 09:44:27
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAT1idK5072002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(mclk) is 4 or 8 as it is the size of a pointer,
but we want to reserve space for the pointed data.
This issue was detected by using the Coccinelle software.

v2: use subject lines matching the style for the subsystem.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Mark Brown <broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@st.com>
CC: Arnaud Pouliquen <arnaud.pouliquen@st.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@st.com>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Wen Yang <yellowriver2010@hotmail.com>
CC: linux-stm32@st-md-mailman.stormreply.com
CC: linux-kernel@vger.kernel.org
---
 sound/soc/stm/stm32=5Fsai=5Fsub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32=5Fsai=5Fsub.c b/sound/soc/stm/stm32=5Fsai=
=5Fsub.c
index ea05cc91aa05..211589b0b2ef 100644
--- a/sound/soc/stm/stm32=5Fsai=5Fsub.c
+++ b/sound/soc/stm/stm32=5Fsai=5Fsub.c
@@ -390,7 +390,7 @@ static int stm32=5Fsai=5Fadd=5Fmclk=5Fprovider(struct s=
tm32=5Fsai=5Fsub=5Fdata *sai)
 	char *mclk=5Fname, *p, *s =3D (char *)pname;
 	int ret, i =3D 0;
=20
-	mclk =3D devm=5Fkzalloc(dev, sizeof(mclk), GFP=5FKERNEL);
+	mclk =3D devm=5Fkzalloc(dev, sizeof(*mclk), GFP=5FKERNEL);
 	if (!mclk)
 		return -ENOMEM;
=20
--=20
2.19.1

