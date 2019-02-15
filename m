Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB97CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB5B21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="KnQSPs4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436807AbfBOLyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:54:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42602 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436791AbfBOLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:54:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so4714171pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IP2ayeMTXzwtnF6W0mknXowsCXTPovKKTcL3wAxl0Xo=;
        b=KnQSPs4Yf0xAStHN+9X7/ZXRXaUvDPGeWt2zKaPjje7rktLdkU5MHOg0wSEpNnyee4
         HtNjlhPnlBav3uXolmjReliDxb6g+cJFqvTTTEV6LaJAHjuwMKUeB1oHUDmRbT2HnpzZ
         a44RiPWFgHferScnjxsJwLzXBjOkaHQT6kkoiHwaEXx02MkKROjOnOIthOgw5Cio8viD
         N6REU0QwUHaBPJnBBkuD6HNZoOQJ1PeDAxQBESXjU0ZX4h7gtQz4y1W7AXH5mcVf0Zeh
         bhEVCBG5fnkvT4E1vGlGxia8y9q32ggM9o5VHXilX6s1gryOxgmjkvFmOkgtepe96Ysw
         KGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IP2ayeMTXzwtnF6W0mknXowsCXTPovKKTcL3wAxl0Xo=;
        b=UYGhsRQwmyr8xIyf21+0NrPrNJdvQ6TZGSrsJx+x4GI/HxtP/sQ3rKvGFYuu1s5nFS
         1yaJwtnF9zIbHkvK+frWuXV1BXsOEUkRtF8KQcjSvfpg4OJWp2/bjPChWrlJ5cse2Hxr
         OHbvQpZ8MnTa/CoN8G1rWuWZ59h94rNJq1DPp6no+v1xdOOObDJPtk/I6V2J2vNV8K6k
         ltTnO35Rx0OBvQuSMrGwtJbavygeFnHClnwyxp1MDcolxKBCK//WcRKv4g1cP+MDkIWn
         B6Dg4Z+ZJ5KROzFtlL3MZQO4WhYghwVEU/D9vzbyVOkJLmA0ULPbEMMMzQqEXztx6TVK
         hmbg==
X-Gm-Message-State: AHQUAuarANdb4aN/C/SQqCMIhw49dxluZKy//zd78gsOhTp9akMA9BMF
        FC8HtZ6EMHCVPl2isQhBgQxGjbJryzc=
X-Google-Smtp-Source: AHgI3IbjzVrpakKQKbwY9Ov/qCpWYl+m7+neC2iyW8h9UlKoytmz2cZWQiJmW2+B5uOphNJcCTE79A==
X-Received: by 2002:a63:f412:: with SMTP id g18mr5072803pgi.262.1550231685429;
        Fri, 15 Feb 2019 03:54:45 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id y6sm8495434pfd.104.2019.02.15.03.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 03:54:44 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: ltc3676: Fix module description
Date:   Fri, 15 Feb 2019 19:54:21 +0800
Message-Id: <20190215115421.4811-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115421.4811-1-axel.lin@ingics.com>
References: <20190215115421.4811-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for LTC3676 rather than LTC1376.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3676.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 549a1a243870..e6d66e492b85 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -389,5 +389,5 @@ static struct i2c_driver ltc3676_driver = {
 module_i2c_driver(ltc3676_driver);
 
 MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
-MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC1376");
+MODULE_DESCRIPTION("Regulator driver for Linear Technology LTC3676");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

