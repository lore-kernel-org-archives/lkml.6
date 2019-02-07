Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F0C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EEE2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tFvSjWEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGRq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:46:59 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:18734 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGRq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1549561615; x=1581097615;
  h=from:to:cc:subject:date:message-id;
  bh=wImntgiBJtk3wwGZmT6fv88DkNLi+LVBqQWMeTeg6K4=;
  b=tFvSjWEMv5doygeYrIZA47vnhv/Q58aPFpuk0aSwOZdl+CMhlK8JhIfT
   mNs7yuvFUUsZ+Y4XEtbMFa/D7cUXD/Pd/jewnKiSD1c/o4EkAmEKPuj5r
   nnbfBXgPsY6QOV6Kx3NxUKt8atbVRwpNhDHfXjPcWQR57Yy71K7S2W5wT
   X7oGoKAWzjnwvWWDCYkiQzit6Nt/czqLcbbiM3g+oWXahVoYcnh4Csnll
   3SXjcKYgrvCGE0b8tbvWSfHq8Ate+Y8HCiaI8gG+UCNkDM1+t8M8Sbsma
   udUwLQ8oqGQ36skHQBlN9KgwwA83qnhRuDfFC+6E3rJd/xFT03DmFZs45
   Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3AB1OKWxA8HpbGAlKaArEZUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSPvzpcbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzfqbcfdMBXmpBX8BRVyNcCY2i?=
 =?us-ascii?q?doUEEuQBPedGoIn5ulQFsB+yCAewCO/qzDJDm3340rAg0+k5EQ/IwhEuEdwNvn?=
 =?us-ascii?q?rTt9j5KLseXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBUrBxccvQyUkvCgTFhUiX?=
 =?us-ascii?q?pI3lPjKV1v4Cs2mH4+Z8W++ikHMnpB1rojS12Mgjl5TJi5sTx1vZ9it52J44Kc?=
 =?us-ascii?q?OkREN/e9KpE5tduzuEO4drQs4uWX9ktDomxrEepJK2fSwHxI45yxPRa/GLaZaE?=
 =?us-ascii?q?7xP5WOuTLjp1gm9udqiliBao60egz/XxVsyz0FlXsCVIisLMtnUR1xzL7ciHV+?=
 =?us-ascii?q?d98l+h2TmR0wDT7flJIUUumqraL54t26YwlpUOvUjaEC/6hln6gLOMekUr/eio?=
 =?us-ascii?q?7OvnYrH4qZOGK4B0jQT+Prwvmsy5H+s4LhADU3aH9em4zrHu/k30TK9UgvErkq?=
 =?us-ascii?q?TVqo7WKdgHqqKhBg9ayIcj6xKxDze819QYmGEKLVJEeRKHlYfpOk3CLOz2APqk?=
 =?us-ascii?q?nlSjjC1ry+rYMbL8H5XBNmLDn6v5fbZh905czxI+zdRe55JSF7EAL+v/Wkzvu9?=
 =?us-ascii?q?zCCB82LQi0zv35CNVyyIweQ3iDAqyHP6PIt1+H+OYvL/OLZI8PtzauY9Y/4Pu7?=
 =?us-ascii?q?vH4rmUIaNf24z5seaSjgRdx7KF/fbHbx1IRSWVwWtxYzGbS5wGaJViReMjPtB6?=
 =?us-ascii?q?8=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CmAwCnblxcgMjXVdFkHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZYM8Sg+MfIsQUgaKfm2FWYJzhwoBCgEBLIRAgyoiSgEDAQECAQMBEwEBCQ0?=
 =?us-ascii?q?JCBsMMYI6KYJfNlKBFQEFATVbgkkBgXQNoVg8jBcziFkBB4FLCQEIh3CEQYEPg?=
 =?us-ascii?q?QeDboR/g1SCQwKBLAEBAYpQhTyRVAEGAgGBZYFDjxElgW2BSocBOIdkAS2bTwI?=
 =?us-ascii?q?EAgQFAgUPIYMzTSWBbAqBRIJSjiweM4EHiyaCTQE?=
X-IPAS-Result: =?us-ascii?q?A2CmAwCnblxcgMjXVdFkHAEBAQQBAQcEAQGBZYM8Sg+MfIs?=
 =?us-ascii?q?QUgaKfm2FWYJzhwoBCgEBLIRAgyoiSgEDAQECAQMBEwEBCQ0JCBsMMYI6KYJfN?=
 =?us-ascii?q?lKBFQEFATVbgkkBgXQNoVg8jBcziFkBB4FLCQEIh3CEQYEPgQeDboR/g1SCQwK?=
 =?us-ascii?q?BLAEBAYpQhTyRVAEGAgGBZYFDjxElgW2BSocBOIdkAS2bTwIEAgQFAgUPIYMzT?=
 =?us-ascii?q?SWBbAqBRIJSjiweM4EHiyaCTQE?=
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="1055034899"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 07 Feb 2019 09:46:38 -0800
Received: by mail-pg1-f200.google.com with SMTP id i11so403913pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2tzpVyPYpfdzliPB1oyDkazyBfCrViS9BIM/UOQo4PI=;
        b=E0bp8owJtdY7WXhvQFuFBCuLn0R0qqtqLPRZL3x2Sre8VFvgZCY7yUaux3OMsTgcU4
         CUhFrpMKW7kNfHuitvWLkqQaUx0z0T13JspzmzbjQm6JGxO+ta8FHg59cbIhltXtKszL
         MBC65uhzlFf6wq6KsGlp4t97eDFRWMnkRGvYFStTKb6SB0sIsSRL2saXNMtF/w3scCN5
         abVKigAmARFYIoVlof6YCLTchWOUpJJ+96qkYeiBtF8gmOYHEj56a/Ygxo0W5H/J4EP5
         BaiKHiqxDFFsw+iSrv0dxLar/glATX7A5W3zLMtJ/2XoxXfs6DbHQ854AGWthWIE8yqX
         96Jw==
X-Gm-Message-State: AHQUAuZ1MyyuvrF+0ny6e8pgNB29cR5jiwQDe8JXJ2ExOnuxqCXGIfzV
        b/nM0EDt0PItuBDGbLNs9CspWGGk8Trh4MavmrUX+7C8w4Bl7bxz7dl0eI7ZhoudMmjnO2/Z9iU
        YP22E4kgKeu6wZ4T0+5XwgDza9Q==
X-Received: by 2002:a63:da14:: with SMTP id c20mr15338846pgh.233.1549561597764;
        Thu, 07 Feb 2019 09:46:37 -0800 (PST)
X-Google-Smtp-Source: AHgI3IayrGVGwQ3ZjOg/wOj9tm31uHR4CdpsjffL6HoAIgRqtFTZ12maLg7c1SCwb6lANot4erlZ3A==
X-Received: by 2002:a63:da14:: with SMTP id c20mr15338773pgh.233.1549561597020;
        Thu, 07 Feb 2019 09:46:37 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id m67sm14007791pfm.73.2019.02.07.09.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:46:36 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Variable "val" in function sun8i_dwmac_set_syscon() could be uninitialized
Date:   Thu,  7 Feb 2019 09:46:23 -0800
Message-Id: <20190207174623.16712-1-yzhai003@ucr.edu>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 39c2122a4f26..50cfd6d83052 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -641,7 +641,12 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	int ret;
 	u32 reg, val;
 
-	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	if (ret) {
+		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
+		return ret;
+	}
+
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
-- 
2.17.1

