Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB00C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D334C2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="G1vv4hq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfA1W4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:56:14 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:45378 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1W4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548716174; x=1580252174;
  h=from:to:cc:subject:date:message-id;
  bh=OaIAV9dK899tF4iY8yw5mBkHgD/ZmEPNPk8JL7LWKbc=;
  b=G1vv4hq6OcjRsDQyktOZBgHlMuyoWEMFHg3fSXROkNmogFhidZ+2GYS+
   f9d0mH/hMAqixtSWxOiEK1ZbKTteEY4JMag2F6F/4Nmz1ERIfacdXERgT
   50+N9kRMZXL2zGLWjjNUK+GErpDfQFjFMOIYQaWgy5Z8rVJjXbrkk/xPq
   /G25vxXfzJQEtk2k6/YHr7QHJ33qFGHSuUkexTNzrrRSC6un7IFx/VuVV
   IEi70BLSEt1f8HpWUgJLqUINbYYEiOIEDRo7dSLkySTdkys0yyTOi80ii
   +3Rgb6Ed/IIfxKZUjMBCNa/ZSc7U1ELp00ISA5M96H3/NW7OODbj5Pwyy
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AzZIUQB0jcRTnjap/smDT+DRfVm0co7zxezQtwd8Z?=
 =?us-ascii?q?se0eKPad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndiQuro?=
 =?us-ascii?q?EopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZv?=
 =?us-ascii?q?JuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0BvJpXVIe+?=
 =?us-ascii?q?VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PGAv5c3krgfM?=
 =?us-ascii?q?QA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vyi84Kh3SR/okC?=
 =?us-ascii?q?YHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYNP9/fqPGZtMaRGxBXslMXCJfG423?=
 =?us-ascii?q?coUPD+sfMuZcsob2ul8CoBWiCQWpAu7k1z1GiWLs3aAi0+ovDxzI0gIjEdwJq3?=
 =?us-ascii?q?nYsMn5Ob0OXe2v0KXE0TPOZO5W1zfn74jIdwgsrvONXbNxccrR1E4vHB7Cg1SQ?=
 =?us-ascii?q?qI3lPyma1uURv2SH4edtTv+vhHI9qw1rvDeg29osh5DPi4kIyV7E7T10zJgpKd?=
 =?us-ascii?q?C8UkJ2Yt6pHIFOuy2HOIZ6WN4uTmVstSoi17ELuJq2cDIUxJkpxxPTceKLfomS?=
 =?us-ascii?q?7h/hW+ucJypzimh/d7KlnRmy9FCtyuj7VsapzllHtjFFktzQtnAV0BzT99SHRu?=
 =?us-ascii?q?N9/ki/3TaP0Bje6uReLkA1karXMoYhwrotmpYKv0TPAyv7lUHsgK+ZcUUk/eeo?=
 =?us-ascii?q?6+D5bbn8upCcMIp0hhn/MqQohMO/Hfw1PhYSU2Wf4+ix173u8VfnTLlXgfA6iL?=
 =?us-ascii?q?TVvZTeKMgDo662GQ5V0oIt6xalCDem1cwVnHkGLVJFYh2HjpTlN03ALf3jEPew?=
 =?us-ascii?q?n06snC11yP/bI73tGo/NIWTbkLf9YbZ97FZRyA4yzdBZ+pJVBagNIPHtVU/rst?=
 =?us-ascii?q?zXEBs5Pheqw+boFtp9zJkSWWGRDa+DNqPdr1uI6vgoI+mWa49G8BjnLP1w1v/8?=
 =?us-ascii?q?jWI+0QsMb6mg3MNPM1ilFe4gLkmENym/yuwdGHsH61JtBNfhj0ePBHsMP3s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DDAAA+iE9ch8fWVdFjHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBAYM6Sg+MHF+LGVABAQaKZRhthVeHfIF7AQoBASyEQIMhIjQJDQE?=
 =?us-ascii?q?DAQECAQECARMBAQEIDQkIKS9CAQ4BgWgpgl82UoEVAQUBNVuCRwGBdA2fFzyMF?=
 =?us-ascii?q?zOIWAEHgUsJAQiHboRBgQ+BB4NuhH+DVIJDAoEsAQEBiDWHOFaQVAEGAgGBY4F?=
 =?us-ascii?q?Cjn0kgWqBR4ZzOIdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgjUcjiweM4EHh?=
 =?us-ascii?q?laFDIJNAQ?=
X-IPAS-Result: =?us-ascii?q?A2DDAAA+iE9ch8fWVdFjHAEBAQQBAQcEAQGBUQcBAQsBAYM?=
 =?us-ascii?q?6Sg+MHF+LGVABAQaKZRhthVeHfIF7AQoBASyEQIMhIjQJDQEDAQECAQECARMBA?=
 =?us-ascii?q?QEIDQkIKS9CAQ4BgWgpgl82UoEVAQUBNVuCRwGBdA2fFzyMFzOIWAEHgUsJAQi?=
 =?us-ascii?q?HboRBgQ+BB4NuhH+DVIJDAoEsAQEBiDWHOFaQVAEGAgGBY4FCjn0kgWqBR4ZzO?=
 =?us-ascii?q?IdPAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEgjUcjiweM4EHhlaFDIJNAQ?=
X-IronPort-AV: E=Sophos;i="5.56,535,1539673200"; 
   d="scan'208";a="1052502781"
Received: from mail-pl1-f199.google.com ([209.85.214.199])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 28 Jan 2019 14:55:39 -0800
Received: by mail-pl1-f199.google.com with SMTP id b24so12808539pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gx3tQSojz4/53X9fnzyFA/0Ap/nsznJr6yTAcPijyVI=;
        b=AyMi0b4pREhNtcRSAzJY75RrkZty0m4y/LyVEUdM3mo91r06YdlyaP2L1Ch4KYyENy
         FWACJlQiMsy5v9IKmXGCWEszXKjBBAmnPrwdET5BLujq25HIJ/Fdxxcawq0f7dAW7vGM
         CMMTlYTKfvaCncFNbQ/SRhpl1hjwTU67UW7pD/if36FM/ib8DfRAUsH3mc7FesVwl4n8
         Cl8ZtHnQljcYWYB/i15hTPh+1OmZiZvToaxDiWHOvw8v9dlO31cN9r6efs6it+5Pw3O4
         TmwhUOrdXZ2u7rfOoR36TpR781lUilB1zvN1bvsZyl3RWPpmbd1w1lvTg7yB9IIqXKjR
         +dBw==
X-Gm-Message-State: AJcUukcpfKuPJt4xg+a6lEORg4MzshLZZwltxyoZgvtNbZ+EOQlJA6uy
        iUa6L2vb9g1vg7ZgUhosx9l0xz6XkRb1LXyLbfGjWqhpACTJeeyOBsN68mSXouKX7WVOm0R66U0
        6liH9FOqn8Q7O+Lew51xdtjQ0eA==
X-Received: by 2002:a17:902:b83:: with SMTP id 3mr22521798plr.42.1548716139187;
        Mon, 28 Jan 2019 14:55:39 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6DZCvL6Jqx3i/jgLdbkVmAaUkYFD9zOL7yGEVc28d4/YUtnIqInnikgEY250tNRdv9FCWGiQ==
X-Received: by 2002:a17:902:b83:: with SMTP id 3mr22521780plr.42.1548716138759;
        Mon, 28 Jan 2019 14:55:38 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id r8sm51458140pgu.38.2019.01.28.14.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 14:55:37 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: Variable "val" in function ipu_prg_get_pre() could be uninitialized
Date:   Mon, 28 Jan 2019 14:55:24 -0800
Message-Id: <20190128225524.14865-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ipu_prg_get_pre(), local variable "val" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement. This is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 0013ca9f72c8..df12777d9be7 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -210,6 +210,7 @@ static int ipu_prg_get_pre(struct ipu_prg *prg, int prg_chan)
 		if (!ret) {
 			u32 val, mux;
 			int shift;
+			int err;
 
 			prg->chan[prg_chan].used_pre = i;
 
@@ -221,7 +222,12 @@ static int ipu_prg_get_pre(struct ipu_prg *prg, int prg_chan)
 
 			/* check other mux, must not point to same channel */
 			shift = (i == 1) ? 14 : 12;
-			regmap_read(prg->iomuxc_gpr, IOMUXC_GPR5, &val);
+			err = regmap_read(prg->iomuxc_gpr, IOMUXC_GPR5, &val);
+			if (err < 0) {
+				dev_err(prg->dev, "read IOMUXC_GPRS failed\n");
+				return err;
+			}
+
 			if (((val >> shift) & 0x3) == mux) {
 				regmap_update_bits(prg->iomuxc_gpr, IOMUXC_GPR5,
 						   0x3 << shift,
-- 
2.17.1

