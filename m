Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94309C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEAB21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKK62NFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEAB21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbeHBTKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45435 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbeHBTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so2865750wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCb5F1FcydG4XRwhuoUj4EZSfDf+C/OcZkcj5fTdYPA=;
        b=cKK62NFSe5Gj88kEYLCV83VhoJty/BcKnEyUqaIhshPxur4RFnGQWB12ISUakEJXe2
         KUitay/e2kN017+aHabjS3gNHCFKMVQCVYpUMmzbAs3HwvU+ZWbGrfudOJdGjFpUz/U7
         1BS7LHDCbN/PlMJkHbbspKNypchEbAc1Lr6duRi8Li9bvbPqUGI4ajXYKuDUyF3DgYi9
         DSNxWK10hiNSmUXBKcgMwjzXd16nETaT6EjCK1gkYRjvstRmsuxs2OWUQDKmwFFrHf5Q
         MVhXdRXN53ogKyjcG9dBypJi+twQjI2IEys0u2tz1wXU72lexOVkwpW6Cbq8VxrNsmxv
         Lejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCb5F1FcydG4XRwhuoUj4EZSfDf+C/OcZkcj5fTdYPA=;
        b=t1LqmtY4l63Bt7d6V9f03BnrmmnwrjBiiDgLJKdh9u6l5/7VUW/Sx7Ru5mS7hRkFIa
         L+jywsAbte2O3Sa6JF1JKThNIrgTGVq/5q+q2R6FyFFO2aG8Iq3jAMmdSMx0E/i6KhDr
         adZ4lMhMkb1kLfPjO5J5vnDLbkRb8qqoD2l4IBTfzYTOir3gd5gD22ZcSpRQs060yX5t
         HbowZdFTrPzgtk3ltonyuLUVh622i+nykrqPlgzhPgpOn/TzEfRCXRNjApHxj1kvLBgh
         1IvFE4O+CTnNMNA+ZYrte1FZyU9EfSNUYRKtER8SKxGJacVAxGw+n4/iNwHY564VI7pV
         vZYg==
X-Gm-Message-State: AOUpUlHucMY5xFbHeLSVfUkJK1VCFwPY7ZweT6xs9AW5ZZ/bCViVg5o9
        Zixqt55Vj2B/1xfZKszvcGw=
X-Google-Smtp-Source: AAOMgpdbOuOMNn5HMm4gpDNgUUomRoA3efaVtngdqLlEgCdSDipzZz8bMe6HmodS24zYP3mRX4OMAQ==
X-Received: by 2002:adf:80c9:: with SMTP id 67-v6mr226583wrl.95.1533230328999;
        Thu, 02 Aug 2018 10:18:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8188eu: use is_multicast_ether_addr
Date:   Thu,  2 Aug 2018 19:18:22 +0200
Message-Id: <20180802171823.1571-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802171823.1571-1-straube.linux@gmail.com>
References: <20180802171823.1571-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
core/rtw_sta_mgt.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 53e518148ae5..34c3e2af63c1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -414,7 +414,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	if (!hwaddr)
 		return NULL;
 
-	if (IS_MCAST(hwaddr))
+	if (is_multicast_ether_addr(hwaddr))
 		addr = bc_addr;
 	else
 		addr = hwaddr;
-- 
2.18.0

