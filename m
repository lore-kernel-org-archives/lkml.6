Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D8A20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NQaMvYDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfBEWQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:16:17 -0500
Received: from mx3.ucr.edu ([138.23.248.64]:51639 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfBEWQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549404975; x=1580940975;
  h=from:to:cc:subject:date:message-id;
  bh=cNkg2Xb4v6zj8LUbrGCNxIBVY9mdRdd173BdKbDCchw=;
  b=NQaMvYDFpdbgzFxFJy5Qvj7J0lu+hciFKdAVIZTmWDzwzXsNGPrZYXQW
   n3wTjIT8wyruLLntH+fu+ebllJeV18qlyJqGkTsOrNWawKS9j/qodfXge
   D1KR2DL9yoW4NE/xQ+K7HcVeapPKlQxPLWxO8bOG6xLr3RNBYGkDTrkMt
   Be1wahtxgjOsy+dp6MsTBZ86qkcWN3nLC8KxRYcEQnpbMRxmZvsJ0qC2h
   eiY1GT5CMHG7OyFxXeYbuc5q+lnFMxpDc8m3RUvgz58RKR2z9YZSIq5fT
   hNMaFhb6+Va6j4LQ3cO7GJ3Q/kyF0OuNrnMV9aHy7Jdx2RrCNoLsZBPvM
   w==;
IronPort-PHdr: =?us-ascii?q?9a23=3A6IbbyhWruDEetPtcXv8+lx7RySvV8LGtZVwlr6E/?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A1AADKClpcgMXSVdFlHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBUQcBAQsBgztKD4wdX4sXUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQM?=
 =?us-ascii?q?BAQIBAQIBEwEBCQ0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNoQs8jBcziGIBB?=
 =?us-ascii?q?4FLCQEIh3CEQYEPgQeDbohTgkMCgSwBAQGKTYU7kUYBBgIBgWWBQ48LJYFsgUq?=
 =?us-ascii?q?GfjiHWgEtmzkCBAIEBQIFDyGBJYIOTSWBbAqBRIJSjiweM4EHjXMB?=
X-IPAS-Result: =?us-ascii?q?A2A1AADKClpcgMXSVdFlHAEBAQQBAQcEAQGBUQcBAQsBgzt?=
 =?us-ascii?q?KD4wdX4sXUgaKZRhthVmCc4UPgXsBCgEBLIRAgxQiNAkNAQMBAQIBAQIBEwEBC?=
 =?us-ascii?q?Q0JCBsMMYI6KYJfNlKBFQEFATVbgkcBgXQNoQs8jBcziGIBB4FLCQEIh3CEQYE?=
 =?us-ascii?q?PgQeDbohTgkMCgSwBAQGKTYU7kUYBBgIBgWWBQ48LJYFsgUqGfjiHWgEtmzkCB?=
 =?us-ascii?q?AIEBQIFDyGBJYIOTSWBbAqBRIJSjiweM4EHjXMB?=
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="29197040"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtp3.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 05 Feb 2019 14:16:14 -0800
Received: by mail-pf1-f197.google.com with SMTP id q63so3636245pfi.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 14:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pRKoSfdwVwNdyz3mDpwMRoy9Lm16c1WzLiKmYaYvmpE=;
        b=eH7PVPdHMBur+lu3AnhrA4wcT/a54uP2tpt7ZGhHhT2gErII7yb5Rm+Che/u5gcayn
         AzJhBTxv0y1hwoQQYYuQy45y3WltWeHVpMPj2XVsEFzqDE+lBq1AbBv9kcwlZhQVINB8
         KEckXjM8n2gXwuhzFZ8g9xY43mEO5puR1KJYBqDh0sEGozwUzMbS/ATCUbDI9UgAGyJa
         MJhdr6uLhglJZ4RYOV6M7VlhRcDAVl3rB0u15apuY/d3Wnezhiy44JkEBZsnj1g+iIBS
         KAChSzJdUi6E0rHQQuRk28WBsKNxzaqThzmE1Ms2jK6uksh165V+mnSK62e7Uo5OdbhB
         O0Tw==
X-Gm-Message-State: AHQUAuaLAwQpuMdCvxx5RG5AQ/WLoKTThYWqLShfUaAqqctOIdwy7KLP
        mprCpV3xQWebUg9RW/eer8HsInmrs3/l9WyR7KQGeUqdDFeVUFAUVNKiuK3rM65+NEIpRJBGcFa
        M0Qk1MVcvg9flIPZTjSLVNB44RQ==
X-Received: by 2002:a63:571f:: with SMTP id l31mr3789824pgb.91.1549404974102;
        Tue, 05 Feb 2019 14:16:14 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZCsiMpsIK6rGFrgQ8DS7SKjLCGYc9FvgfZmMIbuVkDRAGCjMCY6cD2q1+TJ8D5jJk+fQPLNQ==
X-Received: by 2002:a63:571f:: with SMTP id l31mr3789795pgb.91.1549404973698;
        Tue, 05 Feb 2019 14:16:13 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id d13sm8942729pfd.58.2019.02.05.14.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:16:12 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Variable "val" in function sun8i_dwmac_set_syscon() could be uninitialized
Date:   Tue,  5 Feb 2019 14:15:59 -0800
Message-Id: <20190205221559.17545-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sun8i_dwmac_set_syscon(), local variable "val" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the if statement, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 39c2122a4f26..11d481c9e7ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
 	struct device_node *node = priv->device->of_node;
 	int ret;
-	u32 reg, val;
+	u32 reg, val = 0;
+
+	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	if (ret) {
+		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
+		return ret;
+	}
 
-	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
-- 
2.17.1

