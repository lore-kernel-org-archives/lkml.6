Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A327C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F90217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="nxIMgNPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBFCSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:18:25 -0500
Received: from mx4.ucr.edu ([138.23.248.66]:2922 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfBFCSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549419505; x=1580955505;
  h=from:to:cc:subject:date:message-id;
  bh=D0JGImJ9qrSJZ/loF6Jscsoui2BmjSV1/GLZh7cocuo=;
  b=nxIMgNPODPByb3BgoYNwUJCfbRaNmYf5PkPis1iGoW3paQM3nCacPphC
   OBJncYnb8DRK1U5kP/p3WkaVdJbAwwhJuJciTEW+uE7+39s02gTaTkmA5
   zEGycwR92L005jvGk9YNNtTqBkx64f/4Um54z/ur/Fh+6HDMEWbH2/E/6
   PAvpwa7ow9gyodxTBCN6+yIQgRk0cpjQJPVZBM6T9M6yfiI+E1fbgwPI1
   d59hhvT9NqGLpRDXSSfbEtNOERzvRO5XByc+penMpp9t+WVwz4oTpu0KG
   oe+VuUes/sjAsIEqJjc3w4zjmGJtu9t8hh4ESQ0nvVt1bCFkGaCUVyFls
   w==;
IronPort-PHdr: =?us-ascii?q?9a23=3ADzjFRhU3D3RBsN7WB/+JfHRDhffV8LGtZVwlr6E/?=
 =?us-ascii?q?grcLSJyIuqrYYxyFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUBEEjc?=
 =?us-ascii?q?hE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRo?=
 =?us-ascii?q?LerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21hbHuGZDdf?=
 =?us-ascii?q?5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2Ao/8LrrgXM?=
 =?us-ascii?q?TRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5KpwVhTmlD?=
 =?us-ascii?q?kIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94aQGtBXt1KVyxABIO8?=
 =?us-ascii?q?YJYEAfQYM+1FoYn9pkUBrR+jCgKxAO/ixCNEinrw0KYn0eouDBvG0RQgEdwQrX?=
 =?us-ascii?q?raotb7OqAJXOyp0KXF1ynPYulK1Tvh7oXDbxAvoeuLXbJ1acfey0gvFgLFjlWN?=
 =?us-ascii?q?rozuIjSY1+QMsmib9eVgVP6jh3Ippgxqvzig2t0shpPXiY0I11DJ7CN0y5s2K9?=
 =?us-ascii?q?2gUEN3f8KoHZ9KuyyZN4Z6WN0uT3x0tCog17ELvZy2cDAXxJkmwxPTceKLfoaI?=
 =?us-ascii?q?7x75SuqcIC10iXBqdb+5mh2861KvyvfmWcmxyFtKqy1FncTSuX0VzBzT79SHSu?=
 =?us-ascii?q?N6/ke8xTaDzwDT5f9AIUAzjafbLoQuwr80lpYKqUTDEDL6lFz4jKOLckgp+PKk?=
 =?us-ascii?q?6+vgYrXhqZ+cM5F7hhviPaQpn8yzGeU4Mg4QUGiH4emwyqHv8EnjTLhJjvA6iL?=
 =?us-ascii?q?fVvI3GKcgBu6K0Bw1Y3p4m6xmlDjem1NoYnWMALFJAYB+Gj4noO1HUL/D5Efuz?=
 =?us-ascii?q?n1qhnSx2x//aJL3tGIvCIWXekLv5Z7Zy91ZcyBYvzdBY/59UDrABIPTuWk7+rd?=
 =?us-ascii?q?DYDQE2Mxayw+n5DNVwzZ0eWW2RDa+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq562m?=
 =?us-ascii?q?o2U+nAosfLupwJxfPGGqHv1nex3CSWfnmJEMHXpc7Vl2d/DjlFDXCW0bXH21Ra?=
 =?us-ascii?q?9po25jBQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BsAACjQ1pcgMXSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUwUBAQsBgztKD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI2Bw0?=
 =?us-ascii?q?BAwEBAgEBAgETAQEJDQkIGwwxgjopgl82UlY/AQUBNVuCRwGBdA0FoQw8jBczi?=
 =?us-ascii?q?GMBB4FLCQEIh3CEQYEPgQeDboR/g1SCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM?=
 =?us-ascii?q?2hwCIFAEtmz0CBAIEBQIFDyGBLAaCAU0lgWwKgUSCUo4sHjOBB4smgk0B?=
X-IPAS-Result: =?us-ascii?q?A2BsAACjQ1pcgMXSVdFlHAEBAQQBAQcEAQGBUwUBAQsBgzt?=
 =?us-ascii?q?KD4x8ixZPAQEBBoplGG2FWIJzhQ+BewEKAQEshECDFCI2Bw0BAwEBAgEBAgETA?=
 =?us-ascii?q?QEJDQkIGwwxgjopgl82UlY/AQUBNVuCRwGBdA0FoQw8jBcziGMBB4FLCQEIh3C?=
 =?us-ascii?q?EQYEPgQeDboR/g1SCQwKBLAEBAZAIkUgBBgIBgWWBQ48MJYM2hwCIFAEtmz0CB?=
 =?us-ascii?q?AIEBQIFDyGBLAaCAU0lgWwKgUSCUo4sHjOBB4smgk0B?=
X-IronPort-AV: E=Sophos;i="5.58,338,1544515200"; 
   d="scan'208";a="27130857"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtpmx4.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 18:18:24 -0800
Received: by mail-pf1-f197.google.com with SMTP id r9so4103322pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 18:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vKCJp8IORvIsHrDyUZajuZHeMiJCJviDrMcOZ6kuFfg=;
        b=sK+/OPM304wMdn1TDJRt8LMaQPsN/tPSp96EKeG6MkDR1XRw/rq2KEhEy74SQZRH2i
         4p1Hnn+bYOzRRnoCC3F3RbacLJ8UJmo2+sx8XCctg+QcVdIkR1jqgwj5NFm7SHY8ynh9
         +azZtTyd2YH5Kafg69w6W4KjYkQxbHalSYkmLkP2hi+42kVBu7fcYJHWCCIC3d/T91+U
         Mzvi5gMwt9GE/4qKzpY94akdf78whvKoeYw5nhL/GE+a+GQwbIf1fv/e6BTKlMVxZwRM
         VX82zQKzyWKEBtecnfGbJXOZZHpeLRrD9O7NHYMnN6sAQnwCOjR6Z8vZJZUCvU+i3M8t
         5STQ==
X-Gm-Message-State: AHQUAubOGqME5XV2gsba4RK1vraZwV5OyWvio2i56OuLmBjpBzm36DnM
        2m4g8+NjKmO/zbig+cYf0IQssvuaNKZFlmGNm+YrHbMInqPTV/bAbD452cL5aBvAZzYPXl8DRNU
        sMQ9PK254bDqPyWmOuS47XgEK8Q==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr8215639pfv.216.1549419502693;
        Tue, 05 Feb 2019 18:18:22 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZX1CcpPLb8Db6nC9eW9nN5ZiP7BmEjOoo6MOm0zKDcy9yHAdu7iX0RDp7j7avOaFBbWl3AZw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr8215626pfv.216.1549419502430;
        Tue, 05 Feb 2019 18:18:22 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id a13sm4893878pgq.65.2019.02.05.18.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 18:18:21 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: rockchip-typec: Variable "val" of function rockchip_usb3_phy_power_on() could be uninitialized
Date:   Tue,  5 Feb 2019 18:18:10 -0800
Message-Id: <20190206021810.21596-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rockchip_usb3_phy_power_on(), local variable
"val" could be uninitialized if function regmap_read()
returns -EINVAL. However, this value is directly used in
later context. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index a958c9bced01..b1e24418cb2d 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -716,7 +716,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
 
 	/* wait TCPHY for pipe ready */
 	for (timeout = 0; timeout < 100; timeout++) {
-		regmap_read(tcphy->grf_regs, reg->offset, &val);
+		ret = regmap_read(tcphy->grf_regs, reg->offset, &val);
+		if (ret)
+			goto unlock_ret;
+
 		if (!(val & BIT(reg->enable_bit))) {
 			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
 			goto unlock_ret;
-- 
2.17.1

