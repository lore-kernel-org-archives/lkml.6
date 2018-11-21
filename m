Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A4021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUJODMbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A4021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeKVCT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:19:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40417 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:19:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so6059272pls.7;
        Wed, 21 Nov 2018 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FRTLG/U3oR9gL/KxBILMdBAq7JTFVnu0dqr9HvDbVNg=;
        b=NUJODMbrViBLWVwsTYcqSV1ig2IIjA6aqr3Cv254mr4xQdtExDo2JUNgWid9XhIuY9
         jHZ+vdq1JoTm1q1PCDOUAvqeDsgxgEesAcTv++iewjq7VtFeTQTLMWmf+DaeII4DtxGN
         n8XZbwulog3uWLd1HqrZWgNOUsn57Nmwf+R3N50HJkJhj/9xWMYbYa5OoDmSlw2PCqQH
         BJmuW2ZL4T1oeyj1frZGVIjFzYMr7YTJ/yp7yaCJY96vdHa+7FovKOIg+eFFxfj6hbb4
         M0p3ykWaOpcaPWRC+HrAqiak+NaDNBEobwuNZXvVJVVRcp3sWz3jbJatxl2LI7fYkXvk
         YgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FRTLG/U3oR9gL/KxBILMdBAq7JTFVnu0dqr9HvDbVNg=;
        b=j9i4/K9Vr/PSEsIBBV+KPwmFIhWX3tQP/n7EweeGKTQtFgB04QpqWXm46/COk3f1Q1
         xJC8yPIgEhOXHMN9ppyVtPfaQNuIq4VKCrm6fxDD1p5pF+IvGqcVMa+uAoxf9H4rReFu
         u7p+52vnX9m3XOofHzjvSD5WnspXU12APz8k/xKKnJ+lgJzGq91ohmFzgOHKfyNoVB/C
         x72DGxYb8Xe1hYiV/mE45ihJHn5isQCtdcsHtMlvM2ea7oWI12UJ/Ljq9z7swIfiCp2D
         2JjqjM3ep00RLpU3k9vhlGYz+K0ItW1AQBun88QDMWsyxf5UuBsGcFjAp1bkSo1pxpm9
         T0Ig==
X-Gm-Message-State: AA+aEWYSfqo6xFGlp0IlaZ9rM7JYi7cB+t2ujnf2pyso6nW/kQX7rXzp
        Z3VhbCuggv+4OoZ7hXriWD8=
X-Google-Smtp-Source: AFSGD/V9WFGAVGC1jl7EWP6cFR9DH38qTBAgwaFL8G7HnBjUENlwNW8FqALT0om+yzvCDcVEbndXXQ==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr6438945pge.346.1542815098848;
        Wed, 21 Nov 2018 07:44:58 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id u19-v6sm54668918pfh.153.2018.11.21.07.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:44:57 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:44:47 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, icenowy@aosc.io
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, hao5781286@gmail.com
Subject: [PATCH v1 2/2] Documentation: ARM: sunxi: Add Allwinner SoC T3.
Message-ID: <20181121154447.GA4384@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Allwinner SoC T3 document and fix format.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..94b9c12 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -14,7 +14,8 @@ using one of the following compatible strings:
   allwinner,sun8i-a83t
   allwinner,sun8i-h2-plus
   allwinner,sun8i-h3
-  allwinner-sun8i-r40
+  allwinner,sun8i-r40
+  allwinner,sun8i-t3
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
-- 
2.7.4

