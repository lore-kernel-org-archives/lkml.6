Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB1C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4786A20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGWx384f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4786A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeG2Sko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38776 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeG2Sk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so11001297wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngYOJ0Tn2jKhxi9AO1x9qWlpQzm35rcPdJLaex2Ijzc=;
        b=rGWx384f45kpVDhBH29CXT/ReCXDNpG0XsxfN2SHFfGs15wFRuJig9LHPrObLh37Ld
         VXPU49PW9EN8GXm6tp+LYPf5SnhV0jA6aO0DPkKwuzwK7obj/kveyCickDFsC5K8aZ2S
         Sr7U1gdTQUSEHu4vop/Fw2zFqnbXciwy14xzRDSVZqXFo0/o9v4iWc8goXAg3Xs380zy
         l9vEFs0iM9CZYWqw9odSMqq0y49riOJdNnmloXS64591jbbRNa8N0bBcAcqDOF1lD6rM
         rFzJXS5JRWKm+U0efqnH2HzqbMsjPeOR6HOaBjlMUGDTtUunK6kMvv8k5zDcHnvjSbpu
         hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngYOJ0Tn2jKhxi9AO1x9qWlpQzm35rcPdJLaex2Ijzc=;
        b=ALYvPr+fKysWy8txTx1fNNHo4NC6IHDjvN8vt4V4I5rjCqX1zw3Y25Kv0Z90cxKkG2
         Qj0E3fzZ9qAmBbw+doayFnyLngsv9zJZGIOfFMCjUIqsUOjXec/G+11vzEDAZQ5iPhWq
         +cv31U5y798oJ/QSNu/f2268DDXmtYVPPfH4wZKG94ZWZR/RgURU/n6Bl7aEC/j6CPi9
         o0fuRGulXhue0WuT87HnVW4cinpE6YU9BD3Wh8bdLqXWPjZ5rc/eZAilMo8OhgtJn5mq
         gurFRGZKaVwjCtQq3ybao64bDZjrzRy8cLSa8gJk2fd0QpEWkbfEF95R/9IokaR7ERr8
         nR3g==
X-Gm-Message-State: AOUpUlE7h+mMk9O5yPrm6ftGp3tqgUnMNFFv1+Oc1xao4Ud1rYUXAFef
        0LC/aoTPHIwNjFgrt2eOu+UzaMlf
X-Google-Smtp-Source: AAOMgpdUJquWaLxMKY6JFd8suxJ4nFpgTdC4H70qiHny+eJe+SVrPP3RSGvNYDRmf48eoNjLOqecrA==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr12394078wmb.16.1532884162948;
        Sun, 29 Jul 2018 10:09:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: fix comparsion to true
Date:   Sun, 29 Jul 2018 19:08:49 +0200
Message-Id: <20180729170851.2581-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(x) instead of if(x == true).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index c43e7b438058..b21ba01abc57 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -50,7 +50,7 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
-- 
2.18.0

