Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4268C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05EE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deoJ9Bx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfBULvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:51:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40694 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfBULvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so9490606wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMnF/ZR1+W37CuRkf80c+T3BI7KnPXSLVpAkjcBAFTY=;
        b=deoJ9Bx0+y/dAFIhzbt+rybytuLydl3/MOYMEpio43iRFoP7HZxiWZVJBIta1mhb+n
         MJvECXNIO3FoVx3gahEEzZPmCtyH+1bpNG1gA0TPjm/GCYNikag4j6bdkmI+GDinO3JD
         kL/U2mDm36+nISQjbq+dv48s6+8OuKD/8OTYHC7KCmGKMWTFhayprzHsrpfW5td3OXGe
         B82axxPPHI+JT/Vbec8+R/N6pDAOb9UX5y22OyS8HljDfdlBwFFtEdIJKsFMSK80YwMH
         px6mGW3cS1jd2Y3UCWqbgD2XtO5lnI5JfZ0qr6orKTlZ6Slm6aBKqdHwOc/0hsJxIUCK
         NCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMnF/ZR1+W37CuRkf80c+T3BI7KnPXSLVpAkjcBAFTY=;
        b=ngvN01vzoJioZh1KzBgUZXJq4oUIlxJOmXVvtlbZH/KhRPbfGLVRTFujrQC0VDeaUJ
         GfVMJiEqr/mStcIGED5vhaAWIF7KuEg+V7aB5vPMA+SaunAAdOr0110wErWW7zwy/ZUb
         qh9SwLfa6ZiRfBpDDLs1u+z4NICu6bP8lAwbWwx+KzL1WY318gXb0M60L9sB2bVMBmEk
         ds8ma7r6vrNB6gxTcNPf70HZAb2ON6KWDQVQ7kTfO6wbmiFOMYCwFeiuhRm30Wb50x37
         +k9xfWMAOsnE2qFRT+JN8X8dTmSl/ZYyKGk24lIXtfpSbdK4I02kFoYXUDVPivq6i4gr
         I48A==
X-Gm-Message-State: AHQUAubxPK5drYqMW0KzFA2IjvNCg2qAo3U+NiICiqPcfevLtAw82Grh
        lAyKFGg8sLPsqJUIFesK2nw=
X-Google-Smtp-Source: AHgI3IYTDKRx+T5HA4Sb7f7xHWKMWYpQGC5wYu8FpjMlwdXLBbp7Hdv3o6PIgkQ8kKojN4z4AcMLww==
X-Received: by 2002:a1c:c5cb:: with SMTP id v194mr5145647wmf.150.1550749901510;
        Thu, 21 Feb 2019 03:51:41 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8188eu: cleanup comparsions to NULL in rtl8188eu_xmit.c
Date:   Thu, 21 Feb 2019 12:50:57 +0100
Message-Id: <20190221115057.31207-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115057.31207-1-straube.linux@gmail.com>
References: <20190221115057.31207-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use !x instead of x == NULL. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index a72e069269b8..9e5f23392d58 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -440,14 +440,14 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 	RT_TRACE(_module_rtl8192c_xmit_c_, _drv_info_, ("+xmitframe_complete\n"));
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-	if (pxmitbuf == NULL)
+	if (!pxmitbuf)
 		return false;
 
 	/* 3 1. pick up first frame */
 	rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 	pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
-	if (pxmitframe == NULL) {
+	if (!pxmitframe) {
 		/*  no more xmit frame, release xmit buffer */
 		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
 		return false;
-- 
2.20.1

