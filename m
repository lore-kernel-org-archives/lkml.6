Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812ACC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE0C218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="mUnn8s7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAZGdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:33:02 -0500
Received: from mx1.ucr.edu ([138.23.248.2]:14082 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfAZGdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548484381; x=1580020381;
  h=from:to:cc:subject:date:message-id;
  bh=spBmDIiF5jHQhSNgngoPo9qlEpmTF8uUh2cGxlBjoKg=;
  b=mUnn8s7xNSkwvgpFWhAWF9+rcXhTxknF2i02ASK8kq9fGQlUKIukIlop
   JVG3t8xecp4/9Yj1BxeWb00MvKyW1t1OSzjycRwvz21PNkv/zBdddv374
   3rBq3Id7ZW6RqezSJei0ISBnUUT3Xdxm8/E8qFQiQLBCC0HYckHpRQATB
   yXrt6/rBwHhMMJYpUSshPEwzk5wC1irAPSdQ1S6sz9L3N0bfsYr7Wmgsj
   HgpKfrr6/c9pWbkqq+NMc/EK1iwo9takt9JbzemKSZdZlN+omtJ7MSsm/
   0FPVPBUJJqnh2GMBts7uNRIbwV08Xpbb6+ypk+dXVxqb9o3mSllVLedQn
   g==;
IronPort-PHdr: =?us-ascii?q?9a23=3ApGyrYxXL7R72lg8HMWL2I5Gi0jLV8LGtZVwlr6E/?=
 =?us-ascii?q?grcLSJyIuqrYYxyFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUBEEjc?=
 =?us-ascii?q?hE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRo?=
 =?us-ascii?q?LerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21hbHuGZDdf?=
 =?us-ascii?q?5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2Ao/8LrrgXM?=
 =?us-ascii?q?TRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5KpwVhTmlD?=
 =?us-ascii?q?kIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94aQGtBXt1KVyxABIO8?=
 =?us-ascii?q?YJYEAfQYM+1FoYn9pkUBrR+jCgKxAO/ixCNEinrw0KYn0eouDBvG0RQgEdwQrX?=
 =?us-ascii?q?raotb7OqAJXOyp0KXF1ynPYulK1Tvh7oXDbxAvoeuLXbJ1acfey0gvFgLFjlWN?=
 =?us-ascii?q?rozuIjSY1+QMsmib9eVgVP6jh3Ippgxqvzig2t0shpPXiY0I11DJ7CN0y5s2K9?=
 =?us-ascii?q?2gUEN3f8KoHZ9KuyyZN4Z6WN0uT3xotSog17ELvZ22cDAXxJkmwxPTceKLfoaI?=
 =?us-ascii?q?7x75SuqcIC10iXBqdb+5mh2861KvyvfmWcmxyFtKqy1FncTSuX0VzBzT79SHSu?=
 =?us-ascii?q?N6/ke8xTaDzwDT5f9AIUAzjafbLoQuwr80lpYKqUTDETL6lFz4jKOLckgp+fKk?=
 =?us-ascii?q?6+vgYrXhqZ+cM5F7hhviPaQpn8yzGeU4Mg4QUGiH4emwyqHv8EnjTLhJjvA6iL?=
 =?us-ascii?q?fVvI3aKMgBu6K0BwxY3p4m6xmlDjem1NoYnWMALFJAYB+Gj4noO1HUL/D5Efuz?=
 =?us-ascii?q?n1qhnSx2x//aJL3tGIvCIWXekLv5Z7Zy91ZcyBYvzdBY/59UDrABIPTuWk7+rd?=
 =?us-ascii?q?DYDQE2Mxayw+n5DNVwzZ0eWW2RDa+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq562m?=
 =?us-ascii?q?o2U+nAosfLupwJxfPGGqHv1nex3CSWfnmJEMHXpc7Vl2d/DjlFDXCW0bXH21Ra?=
 =?us-ascii?q?9po25jBQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C7AQDC/ktcgMbXVdFjHAECBAEIBAGBU?=
 =?us-ascii?q?gcBDAGEBQ+MG1+LFk8BAQEGimQYbYVXgnKFCoF7AQoBASyEQIMMIjQJDQEDAQE?=
 =?us-ascii?q?CAQECARMBAQkNCQgbDDGCOimCX4EIgRUBBQE1W4JHAYF0DZ1aPIxKiFcBB4FLC?=
 =?us-ascii?q?QEIh26EQYEPgQeDboR/g1SCQwKBLAEBAY9skSQBBgIBgWOBQo57JIMxhnCIBwE?=
 =?us-ascii?q?tmnQCBAIEBQIFDyGBJYIOTSWBbAqBRIJRjiweM4EHh1qCTQE?=
X-IPAS-Result: =?us-ascii?q?A2C7AQDC/ktcgMbXVdFjHAECBAEIBAGBUgcBDAGEBQ+MG1+?=
 =?us-ascii?q?LFk8BAQEGimQYbYVXgnKFCoF7AQoBASyEQIMMIjQJDQEDAQECAQECARMBAQkNC?=
 =?us-ascii?q?QgbDDGCOimCX4EIgRUBBQE1W4JHAYF0DZ1aPIxKiFcBB4FLCQEIh26EQYEPgQe?=
 =?us-ascii?q?DboR/g1SCQwKBLAEBAY9skSQBBgIBgWOBQo57JIMxhnCIBwEtmnQCBAIEBQIFD?=
 =?us-ascii?q?yGBJYIOTSWBbAqBRIJRjiweM4EHh1qCTQE?=
X-IronPort-AV: E=Sophos;i="5.56,525,1539673200"; 
   d="scan'208";a="1052417701"
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtp1.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 25 Jan 2019 22:32:35 -0800
Received: by mail-pg1-f198.google.com with SMTP id m16so7767145pgd.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 22:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yaf63aLCqjFpTNHGLnD1DlppPDZbRyd+ngLiTc70LIY=;
        b=bmjXgY0DDN4KRazjqadSY4M3wJx7mYMQA9jLaKgQQmS91vRH1psZ5t5zhxBhDTHwUI
         vt/lzAvzdSJGd3AhhGLl0q5lDmmMkz8BCSYJIhme1Eq4Dx6oYLayGZvBeIDD3MEIsgxD
         j273TfD25+t8514DhkAOVTMpLefyOG+UyAjAEj/lLnJckypDha2z8ix7BaMYbW3bmZIr
         Q96Ofu7WKrhabSbbdHOD6hgByTwyceNo/oK5yyluOTXGjUB2hKp3Zq+SrAQSY73/UqSz
         tuVFKuMOLYQhQY0HQ6Be/24MLU3t/+cuNSuMscy1WFsESUNTewEEZm7VlAS8+5NPqkhs
         QWbQ==
X-Gm-Message-State: AJcUuke9NVglJDkRH5z5oPnWzn14CvHYPYUjcufKaxd3pJ1FqB1wLqnS
        Snh07FP253ManoLBBHIUzOjuiqLTCj0q3krhLz19TRdOnCRAlYzZD5exttfJX9JkP5WV91VhVhv
        fHQviykK/lCfnGN7C4pfEgXJP6A==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr14442970plp.9.1548484354983;
        Fri, 25 Jan 2019 22:32:34 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5YsCv7XKtB9I5a/bKPNYO+58A8UnKPAsilEc7mFrGw0e/Em5uRbQoHdzn94g45XXnYFhWVVA==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr14442948plp.9.1548484354611;
        Fri, 25 Jan 2019 22:32:34 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id c9sm51998403pfc.92.2019.01.25.22.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 22:32:33 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized
Date:   Fri, 25 Jan 2019 22:32:20 -0800
Message-Id: <20190126063221.8257-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function omap4_dsi_mux_pads(), local variable "reg" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.
Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 arch/arm/mach-omap2/display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index b3f6eb5d04a2..6e7440ef503a 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -84,6 +84,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
 	u32 reg;
+	int ret;
 
 	if (dsi_id == 0) {
 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
@@ -99,7 +100,11 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 		return -ENODEV;
 	}
 
-	regmap_read(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, &reg);
+	ret = regmap_read(omap4_dsi_mux_syscon,
+					  OMAP4_DSIPHY_SYSCON_OFFSET,
+					  &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~enable_mask;
 	reg &= ~pipd_mask;
-- 
2.17.1

