Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114BDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F920663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekbOv/bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfBXUdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:33:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37330 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:33:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so3473933pgq.4;
        Sun, 24 Feb 2019 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ArTrIZZhrWlHTpLnvz292rS3KEiXNeIIUmm0L6+dn1g=;
        b=ekbOv/bnpOhlcjiZTPICRyK08UveQCl9CFmhcIZH36b0QlqRVhgl0rLtexZZvi5rmI
         vCdNyWcsjujKRFFbL2V40KsICgeARBSA9I8m0Eby6XQSFU3PMwIsnCKxjmxcHYN5c5qO
         J2eEQTu0bvFO53IMsugaRK4RtIENkXOhegZfhWHxT45FYFjx0w1/nHq9Od6/qmFmsau6
         LCJGscIQqEWxYqz88K9Msoxi/88IR8jeWL5l3Pqz6R+xTU3uBwDZqnXuGtG/2SRF7Sgt
         iKA9fRKRuymfvi5tIFtUfBgurkXZ+2MVbphlGdrv1IYrYuaFqqXSi0B3IPe6soOYIcsI
         Ae1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArTrIZZhrWlHTpLnvz292rS3KEiXNeIIUmm0L6+dn1g=;
        b=JWOzueDU+QL9v3rCou0tkMz3Iv1Xe3o99TheUSg40Zcq6jXgEblghA5bhBzqnYWOJi
         H454PMd21ADJpszysYzGanv2q3SGdbkUNUNy1uScpPotaBl4CcszmNmOn3ALRuDzJyZq
         cvrPIvfY35U/U4fWOtdzozyX+tQM5G/kyLBb7clt9VLOzBFTbwyDN1jREijW0Q53T80m
         6dMawL2BKC8xSBD6+cmrPe0oLCizChj1I+z8D6uT9O9KKzfMbytOdoEaByBfVs0H1Hbc
         gKaIecvoD431Yx9KYNWHRqfNeGL5Zev1jpBxsUSHZmHQ4r2iItvO0KXQtFvbnJSXADRr
         Wmfw==
X-Gm-Message-State: AHQUAuYIhmT7lG6eyfHubPoC42eVH7br/THJr2CpVjpKYN8Tn2Jo4v+m
        1YWkb97AW/VFQUGZD3MpHKU=
X-Google-Smtp-Source: AHgI3IaZApfkg2IoUUDUWOBJ8zjB1Y5uaWvhqfkD3Ipie6IvwyD2TqFueURlJdos/sicevZxDL5mdg==
X-Received: by 2002:a62:1346:: with SMTP id b67mr16628810pfj.195.1551040400132;
        Sun, 24 Feb 2019 12:33:20 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::e774])
        by smtp.googlemail.com with ESMTPSA id j24sm11522963pgl.58.2019.02.24.12.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 12:33:19 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: vendor-prefix: add prefix for Lite-On Corp.
Date:   Sun, 24 Feb 2019 12:33:29 -0800
Message-Id: <f52fc8ffcacc8d80796bc98959b49fe9b0237da8.1551037168.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a vendor-prefix for the Lite-On Semiconductor
Corporation.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..e487a5d95ba9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -219,6 +219,7 @@ linaro	Linaro Limited
 linksys	Belkin International, Inc. (Linksys)
 linux	Linux-specific binding
 linx	Linx Technologies
+liteon  Lite-On Semiconductor Corporation
 lltc	Linear Technology Corporation
 logicpd	Logic PD, Inc.
 lsi	LSI Corp. (LSI Logic)
-- 
2.20.1

