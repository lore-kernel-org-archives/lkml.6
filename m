Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1376A20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AvL9UiD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfA1Qii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45438 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbfA1QiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:38:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so18754673wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DwXU/DABY03ITJwoWyaouwbE8TjJuTN6E6OnLCAmCoA=;
        b=AvL9UiD3J4AerEcQE13yxgFPcrNzEyvgVO/Oed9HUx52ap7/tMpLGzKcGWXRGxciNK
         ZdRFq9lnPpRcfvosrhlsegfVAVUgGprCIx2a1cscd0T90+lG1RfGJ+pyg90BTmK4JXB1
         +ifa2QS9EZd00bpcesusSxt9OZC6c6+v2Y8TlJL+ILgy2nG3wkyeVbaJZ0uV9TjxYOXS
         DNkQCUG28w5ZJogOBquDxyApdURnAZdJpFoMcU7vt8jwxyH7Mabs6MCuA3PLNlazBkYR
         IJVCZNnSnsei5MriMsg3c4hjn9z6IKnWjDEZ0ASkG5I9PgdHeOzA3NEHWSTyOistHo9+
         0Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DwXU/DABY03ITJwoWyaouwbE8TjJuTN6E6OnLCAmCoA=;
        b=tvxQEk8VI4F2BXvaBQKtfozpkdS5HN//BJ1JqESbypQZKeLbVuUlv9zN1+cjbkoXfg
         CtcfARGsSsxpIQJ6ggrumJ1lAmzGgDNHb/Mn2ZZRfjGwZ035a/UiAD+i8WJSiyiOi+/q
         0mKvQyjHxrfZ6SVmkhHLAAWfYYG5Pd1fIeD74u+WgGidR/CSe91tMz12D2G9evJ+7+Sg
         V0er3oJMrY7T2Gj6P9d8XI9KvMC5qAF7CoW4tcpHkdTzHY6kyX4EnPS8fQBKYee6gB/N
         ZoSuDe5qsnQ2Rahm++J6rHPq1qPMwDYXjt9yAKUcNrPDno+kUZamxBrbvQcIk1/OpHnD
         M76A==
X-Gm-Message-State: AJcUukdnj3o8WCNv6QCWvIgfD2JkR25HwwB/8bv5+NDnSOpZQQcpLGeE
        u2Sz3gaM1cuVNvCRN0nzwqXaXA==
X-Google-Smtp-Source: ALg8bN5KMG1QHbxfXu8KVWN1cLvVGhJydZpy2RUk7wZ6NpeR6bHPzOsCNI6QCr0tfyobn6ULK0jr6g==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr23651374wrw.113.1548693486851;
        Mon, 28 Jan 2019 08:38:06 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:d40b])
        by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 08:38:06 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
Date:   Mon, 28 Jan 2019 17:37:58 +0100
Message-Id: <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3: No changes

v2: Alphabetical order

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..d80a70343b36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -150,6 +150,7 @@ geniatech	Geniatech, Inc.
 giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
+globaltop	GlobalTop Technology, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 goodix	Shenzhen Huiding Technology Co., Ltd.
 google	Google, Inc.
-- 
2.7.4

