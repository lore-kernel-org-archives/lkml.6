Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AACECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420C420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6auWS0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420C420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeINU1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:27:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeINU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:26:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21-v6so2295880wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSXDNBBNhUsCnnfMOMa4ywH3AKXJc/J1kIJt7rV81QM=;
        b=C6auWS0o5kL5DzNUhFq4tiNBbHY92x3vQKZe0+Qi1yaH1EAk15nIcv6/Ox0vH8Vj/d
         mj2uSA2OHmHQ4BrTjz7p3t+hi1E8z4rLapcIK6i/vB8vJnNuBXYxwTEyd93+J7p/JAp+
         Nc2+IhhxPY50ZvAVVZzabzskeeNDEVao8FZknIqw/upBYC1zdvOMnmG/Zzq/hHHSa5cx
         dqiNBKTb4CwyQflOX2U86GQ743kJ7H+k4L4Ow5VxJcxF2Q4MSOkFL7l3B6SsSBSWooeQ
         +5KbuYaDPfdYdS1buKnR5gPOM+HKjrRdPn/hf+KEVXQF6oANzeeqFWGgRE7E1JguxCMj
         rBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSXDNBBNhUsCnnfMOMa4ywH3AKXJc/J1kIJt7rV81QM=;
        b=uMgQeJmlU2v0p6DomNhZ4+dFOivlUkG9hZmMX8G2qvM80nmMO43upqgA9UlCuv7BUa
         OfOX48CxMDwQ1wJdecWIMsW8QusXRxlV7l9jBnRVc40JBhfifOHmm5NpXTbvXljmaLhf
         3EYvPdUkHVM4fYAI6JEXtMJbyvVPd0bIt12d+p1xugC4tdovmtBIufnIa4hMUp4/849T
         lx/+3aU5n7r8XxXM5kV2tZvdBmNOPP0v5ugyWH8oo0oDP7tJUreNCqDAz8f7rqd1kyGk
         ZWid7zNp1TiMGal5juO7EsYKKe9UXKzDsPjcp54ClBP/1IpBnPcdbrghaEK5YQERb3or
         hlow==
X-Gm-Message-State: APzg51CU6G9xHc1wxgSc1la1P6Qr8wmDXnYkMu8t2BucMaVieO18nvsM
        if40UC1MOp73g1CtKzoGnwE=
X-Google-Smtp-Source: ANB0VdbAOR1dwHLaKfML7ydghWyjEegYnrzH3MAvDc6RekyCYVUU5/clKAopHWCg31kE0IgAwk4OtA==
X-Received: by 2002:a1c:9f41:: with SMTP id i62-v6mr2617490wme.87.1536937920898;
        Fri, 14 Sep 2018 08:12:00 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:12:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: fix comparsions to false
Date:   Fri, 14 Sep 2018 17:11:39 +0200
Message-Id: <20180914151142.1179-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914151142.1179-1-straube.linux@gmail.com>
References: <20180914151142.1179-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if(!x) instead of if(x == false).

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index bd82de044bba..db983f15ddd6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -145,7 +145,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_bssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
+			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
 		} else {
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set BSSID not the same bssid\n"));
@@ -231,7 +231,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 		if (pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength &&
 		    !memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength)) {
-			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
+			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
 					  get_fwstate(pmlmepriv)));
-- 
2.19.0

