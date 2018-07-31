Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED2208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwZunTRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CED2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGaNOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGaNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so16290829wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zSw1xf5OMwLxLFJuNjhlSiE1nSS03gHVUG4OZhqcLBc=;
        b=dwZunTRWWeQ7VgSyIArDKMQy7Tm4TyeR+aJggIQr3YZMTyS05+8prCLSpZ2n1OzKi6
         AYdTwDtelijEs3BsS/lrmNSVFMkw2NpHB35zi6jUQqCi0XhVhsotMES7x4coByGmcQmf
         mQoZS0Po11jlI4rcpoVutD3zpJ4qmBg9xGZz+FBeUMeex9M+aDQL+/vi/A9y1n87b2l/
         Q/Q7SvVFdGpWwlVB1FFANkzFBo7LAlrkvgKN6O2JXrkZzs/u4gqes9aj557vMbuvLPYs
         uahb5uXJVvV9kkuamokqL7V8LQ3MEHj1qOzUNe8SzMbRUhlVpVakwXV2DocpEK9PFrfg
         BPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zSw1xf5OMwLxLFJuNjhlSiE1nSS03gHVUG4OZhqcLBc=;
        b=JvPQ7575QlshXwKnfqOFCteEaaWW0FoxoO14MGbR9h0l/Erbd7GrV6f6pgr89/qb0v
         j4sh3Ici2qIsp3NwKb25CB7HljTDSpqLm0KReCIPfmr5ZOm8tS27rlPLYXmvQZICBf6x
         o0YdGsSO+mGCiExKk68psbEvDILFjs8H9qp7BhNf4xUYHVGSvi73sun47tME8VSNfpU5
         NOLB4h9bF6L73OoSzaiN6nmSfNvd42MVcoLoVmMC7TNM8TH54biiBKUS+/e2PU+UIE1L
         W7Ji9GDPGDWGxx6UGRzuBn46qlxk898OSkJhPsEdBS4fkjp6C++Tp22ZZUqGWKfy9QZU
         5Cmw==
X-Gm-Message-State: AOUpUlHw/5m0Z2dpE1Q9DQ5jeFazJdXvc8c2EjmCIVtaP7IPIF0lJL1/
        /jACiA7GUFOO82l/M7c1KQcHFzbi
X-Google-Smtp-Source: AAOMgpc00DzcdNwKASN3DaDHIwdhwxZgWcQ/zD+dT2bWD/JXh7oyt71t3pNVyBJ9oqoKyJlarecF3A==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr21317071wrw.209.1533036867049;
        Tue, 31 Jul 2018 04:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: rtl8188eu: use is_broadcast_ether_addr
Date:   Tue, 31 Jul 2018 13:34:09 +0200
Message-Id: <20180731113415.1500-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_broadcast_ether_addr instead of checking each byte of the
address array for 0xff. Shortens the code and improves readability.

As required by is_broadcast_ether_addr, the address array sta_addr
is properly aligned in all uses. Thanks to Joe Perches.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 34 ++++++-------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 221fae22bab6..4a8124570e6e 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -361,9 +361,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		goto exit;
 	}
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
+	if (is_broadcast_ether_addr(param->sta_addr)) {
 		if (param->u.crypt.idx >= WEP_KEYS) {
 			ret = -EINVAL;
 			goto exit;
@@ -2208,9 +2206,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		ret =  -EINVAL;
 		goto exit;
 	}
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
+	if (is_broadcast_ether_addr(param->sta_addr)) {
 		if (param->u.crypt.idx >= WEP_KEYS) {
 			ret = -EINVAL;
 			goto exit;
@@ -2471,9 +2467,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	if (!check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)))
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2528,9 +2522,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2566,9 +2558,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param_ex->sta_addr[0] == 0xff && param_ex->sta_addr[1] == 0xff &&
-	    param_ex->sta_addr[2] == 0xff && param_ex->sta_addr[3] == 0xff &&
-	    param_ex->sta_addr[4] == 0xff && param_ex->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param_ex->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param_ex->sta_addr);
@@ -2622,9 +2612,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2779,10 +2767,9 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
+
 	return rtw_acl_remove_sta(padapter, param->sta_addr);
 }
 
@@ -2794,10 +2781,9 @@ static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *para
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
+
 	return rtw_acl_add_sta(padapter, param->sta_addr);
 }
 
-- 
2.18.0

