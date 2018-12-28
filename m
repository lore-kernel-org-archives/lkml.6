Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1C820855
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yZdVqtTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbeL1KvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbeL1KvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id a20so10459504edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7MS0Uj6TV3IGRKuWXxgSYM6zp8WuEpgDa+p4giEhME=;
        b=yZdVqtTY4hdZe8hkiWJ/OnLpqWTsMeOY81l02Veg7pb8pTkRRNxSllQmrLi27gS29v
         KS1pa+U4IuZK3PlGmOrms/cxlyJuEXrEI0wQX5Zz5Rk9pkKP1HLIerb/2HphlYATFHeb
         TxpehEIX06Ki39IRnOiHgWkeMnldKz69VDYjv0xKUdi9yJyRjf+dXAu9catVnVOZbWVW
         zUmulG9Pc2/9WSqSNTKfMfBMoZoFZoWCCDbInX4g4ArbP/7ErQ8i6jLt3ZKtkdlUkXD9
         BmgwGYWS/ZP8FKkSEKxM2bRI7OQmJdvC1jlYuWirVrjn5i5s1jMEknMshiICXb2gES02
         b37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R7MS0Uj6TV3IGRKuWXxgSYM6zp8WuEpgDa+p4giEhME=;
        b=izaVmeugeVNNnSbKNVuj2GX00ljv8xhto/LorozqW7Fh263tQhkbzT3gZw+mDWp8h6
         b7CvGSlxZUQT4zJKzzKo1ks5AuHWqurpDDeujM3JYMDWCKOJjw3luPXfN/qn1jgXC/LM
         +4v3yhfVxkQk9PLEHh7JpegSmt/5Qq1jjr0U4SUajmejoIMcs4acP6HAXLzjupfYfgAZ
         uPJPQmD+InRktGUPLpVk9lH5NEMh9RtZaP5mMtIIAVEM26I0/QzOUH6rM8JDqZ0ZbsSk
         Nd6yyRnGDL8gXcDo48IcfvhEWBrklUtkr6cWSiJ71SEyuxWzVChKrPm/543UP3uEKkMS
         eU5w==
X-Gm-Message-State: AA+aEWabMGuqH96O4OiRYOLOAokzKkL8Wt8CIXEsutQDNezgnxV/OjNH
        XZj9mUC9Og6KZ8YhmaY9eLAjsQ==
X-Google-Smtp-Source: AFSGD/WkcjQjw5oTUruL7JeZA3mZvu0230sCi2ShPckzaEfx8suGNY1wnf1tdaDpB7CBxiFGzh4alA==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20-v6mr18411872ejk.184.1545994276866;
        Fri, 28 Dec 2018 02:51:16 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.home (anice-157-1-157-17.w83-201.abo.wanadoo.fr. [83.201.132.17])
        by smtp.googlemail.com with ESMTPSA id b45sm12919494eda.34.2018.12.28.02.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 02:51:16 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
Date:   Fri, 28 Dec 2018 11:50:32 +0100
Message-Id: <1545994235-8309-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..a9214767afa8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -153,6 +153,7 @@ goodix	Shenzhen Huiding Technology Co., Ltd.
 google	Google, Inc.
 grinn	Grinn
 grmn	Garmin Limited
+globaltop	GlobalTop Technology, Inc.
 gumstix	Gumstix, Inc.
 gw	Gateworks Corporation
 hannstar	HannStar Display Corporation
-- 
2.7.4

