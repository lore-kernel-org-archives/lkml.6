Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3614208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="sAjluob2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3614208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeGLKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:32:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37196 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeGLKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:32:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id v22-v6so21472629edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRwZteiui4ibJcEzwlRzOZLCu4DZY+VfqOoD+wkvc7o=;
        b=sAjluob2LUzm9X2MxmBRD75vTc0RzKV52uOIkKOclHK12MIsaStcJdMgNR7VZuvULh
         6ORUy3uJg3Jdv1Z36imrTz0RBehF/wHCRGcup1+CgXF7n+mVjp5c9bYlTYAqm36sTCBP
         WJGEc6FjH1zlyYhH/g38+37BHZrnQoSw7iLmLgM7bqub8lUau+FHY4fr+wXctn5S3PcZ
         NZUtTGunNVogKsPeTPftzt7Wr1QnVwV78U7XwBwHdryWRQXr1kwrk4jMRUDfbPWqpvSI
         5+c88aRAjU8K2yKwl2dNYrCWRwsl02Z1SqGHX+Yidb2GVa/mdmg9OlWa1XvtfWOhbVwD
         pADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRwZteiui4ibJcEzwlRzOZLCu4DZY+VfqOoD+wkvc7o=;
        b=nf0562h2OJnXRLXm+J4xEoHiYlttmxVe3HG9I34sg+8iAOvqiXIFEz/mJiVoF9MlEb
         SUpXSHE1wcHlU5zR6fhV435SYaFJ6csWk87ho8h5eOimEQxuaqfr7rc8byeqwNWJzmhg
         XXetEOXA0ZrtDPbubo4SKqYxiQGTgODD1S6aRjk7Q9HH2a82UZRJc3ASOB2doCBdQGBo
         32pDXpDv7jSrdrLfXTWov8d+HWMWDAGx5rK9Adqa6pcdMKOQb6Zq/YjBpZXDfXYDxJM5
         YXOsSrDZ5Cygmq7wUCekwQEHAPmCe/5xc2ZDu9OjYDeTwWtmVJnhQ9kprnp7uJjtM61J
         R6aQ==
X-Gm-Message-State: AOUpUlH9XLxYjZUV5tekyUMU0A914n8yXs1vTTZafKCIq8thW7NaTbR/
        zE9s1tV97BdDee//xfreCIm3ow==
X-Google-Smtp-Source: AAOMgpdv0yWEFKcvukS1eqQDITFB8IZ6jtIF1cmd3CVYRyY6jWUxCfbqzbLCPBJmViLJ6pjigtRPJA==
X-Received: by 2002:a50:f5e8:: with SMTP id x37-v6mr1897069edm.132.1531391019487;
        Thu, 12 Jul 2018 03:23:39 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id d34-v6sm560819edd.58.2018.07.12.03.23.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 03:23:38 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Thu, 12 Jul 2018 12:23:24 +0200
Message-Id: <1531391007-29552-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531391007-29552-1-git-send-email-koen@dominion.thruhere.net>
References: <1531391007-29552-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---

v3: No changes
v2: No changes
v1: Initial submission

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..c7aaa1f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
+sancloud	Sancloud Ltd
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
-- 
2.0.1

