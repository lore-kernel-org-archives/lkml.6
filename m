Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F96C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqzenBJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF6620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJBOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41846 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJBOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id q39-v6so659059lfi.8;
        Tue, 02 Oct 2018 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6P9OV16u273ERMZhfXC/W1SWJA4ZlFPo/FqG3IUDd0=;
        b=LqzenBJsz/apfQwMh7oswDXJ8Df/89aOitLdhaQW2rg9RxVx05zoDMXyK+RNLUEXG2
         Yb7SBE0tPwCBUZ3+A8BOKDYU6FvlPH66k/GxT4XbX5w6kvbmvbMxsss185y+R6sr21pV
         ONebSgnw5xM9oD3gkKYsX0qMGPe+O/tiZQRfb5sQvIkjvaLojtzWGiwBc1jV3RK7je5i
         lVaDNQp4KYAYuU8sHwNuXlUZ3iO6rdyRqxayR/9lxLGc9Iw7beFvCqa9cmGV3nvLlUHl
         lySJo6eremN1BKhI7FgIIrm9w7bysWqmqJVAhdd38zgpHXPTiiVJqoVsSu1et/KuIhZK
         9Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6P9OV16u273ERMZhfXC/W1SWJA4ZlFPo/FqG3IUDd0=;
        b=lEOmEVUZn4jy+NW96b72aYnegAv6dM2ffq6nj39dr0WTl2s1liaHUjHfmMTqCHzum/
         dxxTX06/mthyTsI42LvwEDsaK8pcdBQm567qEHqz9vOeURUhNY7k9OnfhxeMMbtub0XJ
         DeFYGiWEJNy1ZuwTxzkY18A319Dh7YWH6BbsBoUYY+OuS1KwbrJbmkcB9hrvaFpvBpKj
         4tXNPgx2bTeQK74zYU5zucfxuWDOpdr3Xs/QExewANVG7JqgBh2EKEvuQAW818np+l8v
         r273bTmR3M+toCL0fYwvMAvF5bEhl5rnTf3czMPNYrB64b72hAReQ0mwZTc7rG69h9L5
         v9mw==
X-Gm-Message-State: ABuFfojlXw8KQm09yfK+7wkZSCYwJ4XQqKIk0hpfKT4zaBWU1RoPj3GX
        jGSCklMjPNsgbyyR5sV4Nx4=
X-Google-Smtp-Source: ACcGV62BM2cUdAevimPMiig87M3Py4xwiNUEHjkolGnhz65FILKO0FYL9r8mYbtUOG+FQLNO5nGP7A==
X-Received: by 2002:a19:6381:: with SMTP id v1-v6mr7401300lfi.136.1538465551979;
        Tue, 02 Oct 2018 00:32:31 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1242246lfj.9.2018.10.02.00.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:32:30 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 5/6] [media] ad5820: DT new compatible devices
Date:   Tue,  2 Oct 2018 09:32:21 +0200
Message-Id: <20181002073222.11368-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new compatible devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 9ccd96d3d5f0..cc7b10fe0368 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -2,7 +2,10 @@
 
 Required Properties:
 
-  - compatible: Must contain "adi,ad5820"
+  - compatible: Must contain one of:
+		- "adi,ad5820"
+		- "adi,ad5821"
+		- "adi,ad5823"
 
   - reg: I2C slave address
 
-- 
2.19.0

