Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F639C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C9320684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC3KqBtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C9320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437115AbeKWAcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437090AbeKWAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so9371862wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pb1zocv9SRJlU1CADsPF+SDuCcKAqhhnx2N6ZCcRbBo=;
        b=aC3KqBtvM1TmYyaTaPFwcSRi3WYFYAAdmOUtQmpE5Oq2kskW4EhcPqa05dL/sz2a59
         FrhnPlp4v4ccULlT/R69xI0le9crH1zRy60buXmpHyFT7BgT1FUYXK9hN7k6FjQdVUys
         9lPVnUiVrb5zNwDeSwz+W/wfYx28OGW2esDfwig/sYXXsuSbH7UbToumNabPWiCy0v4s
         7m4tU1e1xkPP1jqAjlvXPkdB18CiaHCpKAeCjmHh0WGPWx1XI4obv+qALqx8faT39YWm
         iz6zYAf49bq2pZcKS74RPZ9F3u9GKc6oxsefspr57vGGCNcy99K7L1c4T3rxgYnMVFUq
         olog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pb1zocv9SRJlU1CADsPF+SDuCcKAqhhnx2N6ZCcRbBo=;
        b=oJYX70QtJXyPr4XRu43h3roGtHKkCOkacUQtpQrDk2gObCs0uQnMY3OLrYtfcwOMN3
         OdkwXJwq4QCgMPJ9jeIy7NhbgaJIX0qRD4+PSN51Er4qJRUJDEH5XRMAjGs0XrBOmwoH
         oWhyCcODdj57LkBYzOmZ0QkR8HJYvM2R8qWPYSLm7rm7rW8YLep+vxiqLMnKDVuu43hu
         UWYZSaJJnWGrzaICOJVr90+pKlFFdW00MplvSWSYAC6h3qq00wVI2RXfXAuDYDZ0vnUi
         XPAIyvN0c6yURgnq1hz3vSHQE/6Xs4OCBbvvPNlxBgNg+sd/cPOffPhGpI+zZPoBXUZM
         7y8w==
X-Gm-Message-State: AA+aEWZFHsHVFv7DEN7768sf/DDGTcehb1YFhBien6axbfcz6N1w9aJ6
        jIybBWz7zLh2rvCpsEsCraY=
X-Google-Smtp-Source: AFSGD/ViHr+qdIvyGptlACWrqobPvrQQVlUVoVRvQ0sAsJU9V0v0786P9o5cfxRUrMrLDOTOdCxkyA==
X-Received: by 2002:adf:e707:: with SMTP id c7mr9293597wrm.196.1542894759125;
        Thu, 22 Nov 2018 05:52:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: remove variable from rtl8188eu_xmit_tasklet()
Date:   Thu, 22 Nov 2018 14:52:18 +0100
Message-Id: <20181122135218.1703-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable ret is only used to test the return value of the
call to rtl8188eu_xmitframe_complete(). Use the function directly in
the if test and remove the variable ret.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 9a732adbf1b1..7dc7028c1cd5 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -796,7 +796,6 @@ void rtl8188eu_recv_tasklet(void *priv)
 
 void rtl8188eu_xmit_tasklet(void *priv)
 {
-	int ret = false;
 	struct adapter *adapt = priv;
 	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
 
@@ -811,9 +810,7 @@ void rtl8188eu_xmit_tasklet(void *priv)
 			break;
 		}
 
-		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv);
-
-		if (!ret)
+		if (!rtl8188eu_xmitframe_complete(adapt, pxmitpriv))
 			break;
 	}
 }
-- 
2.19.1

