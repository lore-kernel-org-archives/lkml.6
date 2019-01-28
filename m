Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B482221736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5STJEwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfA1JwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:52:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56094 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfA1JwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:52:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so13118029wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s43tTjyxkWpxO+Giy0VUG+GEE9ai7Obfora8y1gOzao=;
        b=O5STJEwWRBNvyFElD9th8LRfpwEr1Mgpq4XaNQwYPusSwwr+bYoWT0bu63UuvjNi8p
         i+kpsZuXFweWPN9CY667N4rjoYFRmvx8/Nyt/AhDxo6NkvUSwsG2ISbtwqKj/+Uy++2P
         vNAbt1efpOPS6ErVO7SxqTEwbNfjOtBGt51v4W0lE5TSoJ/trSknDR7JDBWSO05X/VCh
         p26A8qhXCPjgfcaGP8OMVjr/pHjyjb3IclLzhypFHQ0UqQEIWV87CUX3cva0wMPOJ0D8
         kBqA8x6e7e+Gn19Jj5yDfRTEwxQS2WYMcq/vsGbnnZfPPTfr/zDxY8ZlwldfS1kpaKOW
         Ykwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s43tTjyxkWpxO+Giy0VUG+GEE9ai7Obfora8y1gOzao=;
        b=OlSFR0BpfKGQ2VbXiVkjrGnkiyBQcD7Uj60m9ngAcgZt94Eoxx1qW1z8EMOSJ34yhq
         uSFKkqTYpM27Eq15OmrrsUyF08z24oTb7qj3CYCsDunVgKZNv+HsvmL4ubPAPPYK0Gfv
         cckB0KTgm9QKnMa83h09sS2lDygoHa4bKJwXxJUow5+IAPT2InBzfSZjMILb/e+9Ean3
         EPLbfG0fNJ4N5cJz6Jy11xOV1x6wVOkqnFcFqVCJ68fr7a61X9G1CuKxJlQ7SKF3kHlC
         Mh6V4Zp7/c6+m5+acMQyMPd7OwyHeUdQRdpJeJPEXvnfonVBCw3nTrpkVg5E5/94PIXA
         opjg==
X-Gm-Message-State: AHQUAuYSfagUiBlNH0cMufyNXTi8aBQIQwzQ4jzAKVBftxkurmCZ9TKZ
        u1HbT8WsMuGwI/pmxCbdA1I=
X-Google-Smtp-Source: AHgI3IYPh150hrSaV4Cpw04+e4ffOuDLxJoP30Miwku9MvywkM31hE7Iy8jS2jn14fDwJqLjv61rxQ==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr4191873wmd.65.1548669121179;
        Mon, 28 Jan 2019 01:52:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id a18sm139023711wrp.13.2019.01.28.01.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:52:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: rtl8188eu: cleanup declarations in mlme_linux.c
Date:   Mon, 28 Jan 2019 10:51:34 +0100
Message-Id: <20190128095137.26815-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128095137.26815-1-straube.linux@gmail.com>
References: <20190128095137.26815-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in declarations to cleanup whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index cd6298e4920d..142f8f9f6b1a 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -13,7 +13,7 @@
 
 void rtw_init_mlme_timer(struct adapter *padapter)
 {
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	timer_setup(&pmlmepriv->assoc_timer, _rtw_join_timeout_handler, 0);
 	timer_setup(&pmlmepriv->scan_to_timer, rtw_scan_timeout_handler, 0);
@@ -87,8 +87,8 @@ void rtw_os_indicate_disconnect(struct adapter *adapter)
 
 void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 {
-	uint	len;
-	u8	*buff, *p, i;
+	uint len;
+	u8 *buff, *p, i;
 	union iwreq_data wrqu;
 
 	RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
@@ -123,7 +123,7 @@ void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
 
 void init_mlme_ext_timer(struct adapter *padapter)
 {
-	struct	mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	timer_setup(&pmlmeext->survey_timer, survey_timer_hdl, 0);
 	timer_setup(&pmlmeext->link_timer, link_timer_hdl, 0);
-- 
2.20.1

