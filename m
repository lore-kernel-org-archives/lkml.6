Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D8ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B9920867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uudXvGQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeIRNjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:39:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38941 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:39:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so1000501wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSXDNBBNhUsCnnfMOMa4ywH3AKXJc/J1kIJt7rV81QM=;
        b=uudXvGQEr7LayYH5FQbZNkdrJL5EHdyyLgtRhYJ/E3Tq3Ah5C0C19mBuid1R/R6FNv
         kNoI9pDB9dmUxpRpoDpAZdMoyaq1JzZEO5BaUQAY8/6SgB51YtvOu4MWOAQ14xntp5kj
         U7vs8EX9S4JgQSJsWAJyCsM0DmIDWD1HZG6VqA2olsLpH09EF5k3BBE5+FTpm41e7kZW
         9aw0lJ9z7Iyn9W7hR057WjRA4AWXO7CWhL08QEW/iddhiK/XhgW+1+V1GrE75DGQXYS+
         HrEd7J2LMKOYqINS8RPBJgIcVLRYSbsKXIFpGr/c0h6G9n7cDsmm+AMBk5VVuk5fNG0I
         hddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSXDNBBNhUsCnnfMOMa4ywH3AKXJc/J1kIJt7rV81QM=;
        b=FS7VYAY9FpTxzN7AP7AGE0o5ShlBCh7RLOV5LlqwUd39Bw5WsSIVdNHmzCGvAhs9zL
         PU7ZThS+HN0Iym+jCC2ebXr1Xa5Ahi6K5KBWdQ8tDoaIPCsoBVo2lUlFZ0/cHYG8J06l
         d1iLpk1oPGbGVllDp8Yqrt9ZbFWVKhY98PPmAmbldHIB4uSztC/M1bbX0KnMUwg/HqKw
         wWVrTHRWqJl5WBOAUZAslx3qvATmS2qKtJ8JCSrhYQY9EuFL7tFiePVYEzh31TWZJXVR
         qifQjvMVxKjy+/DbMnltXW/dIMpQu4AvKAuD6gG/qH31I5cgVINran9aKTrcYOXVAMiZ
         fHAg==
X-Gm-Message-State: APzg51DnHjI9k5bntqTqyXgOv4Rh05nQvvpwM31SvOJSl91bnXi0+SGF
        /898ibwUFUKX3AEYRzNS/6J0A/sx
X-Google-Smtp-Source: ANB0VdajXO8+5qi13blW7spvbnvu4Hhi+jVCOMbXGfCzgRgIV/VaXR1zJqbD8uOeyyCx8yhjfsoc0A==
X-Received: by 2002:adf:ee86:: with SMTP id b6-v6mr21697397wro.242.1537258062975;
        Tue, 18 Sep 2018 01:07:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1386869wmd.7.2018.09.18.01.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:07:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/8] staging: rtl8188eu: fix comparsions to false
Date:   Tue, 18 Sep 2018 10:07:08 +0200
Message-Id: <20180918080711.21594-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918080711.21594-1-straube.linux@gmail.com>
References: <20180918080711.21594-1-straube.linux@gmail.com>
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

