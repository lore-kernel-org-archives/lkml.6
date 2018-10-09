Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO7vlEFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJIXGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:06:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35273 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJIXGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:06:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so2390063wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwk5eL7TPZkrvQxQv1Tbf5K14a06uhubcF9tS75mwNY=;
        b=PO7vlEFMeUgCB1RY1eScGhLL9w3iJGDhtmvBFEJxFdEc6lDhEUmylZczpgwS8KFLAe
         d9J/Pbw7ZvDqHjxOww151ZGqi/KDWW0o28AA3ad9hqdT5AvvavJCl30nN0+p83HkHO7Y
         CkNYeqwno+r/nV0UVh6hccxhEzeiqptJGyC1rSXdcHg2sk3SzBD4YauoLiRMyAc9cVzg
         9WVoTr/IHOHiyHLqmgr0CtHt3CUayG4sk0olgQWgRCVSK6AY4sxwuwjyIKecQ264vLJd
         zIuqniincRc9CXBhhN/FSp5Vsx9Wtz+leIEian2b6YNaqjGlLrXamPtYbv7zw3a8Q02m
         X13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwk5eL7TPZkrvQxQv1Tbf5K14a06uhubcF9tS75mwNY=;
        b=jvViJoTeie7A0WrXn1rDTjBZ7mpINVXzvzi9dEDahjct/hd5neatz//f7nur/Wl/5Y
         aENfT4J9iZESTRhfdWjPPylK2AJ7tOZIzP0S4KuFI7/NHBa79EgkMQL0t18lEWPBV9wV
         muv5xAlRwoPXakqhn6CYw1RDx8TQHFq8j1AnDDoAe3j3GEVrzsLMu53E0TjK4qK+H/GM
         Yf97ljCSBVERwrVh4ykqmHUEBj9/Eb/c4VMaPKOk6MATIwLENg3ce9HuXD/ezxFHwbzR
         0YU5G6jAjM5gqw0eoIZBHL6mqaHleZ4jlMHZQMA8ax8V/xs8eYTVVaFz4IB3G6zB9ssH
         zdrw==
X-Gm-Message-State: ABuFfogX8BK6fBaOLt7z6XC5H9k9c5V9i2LdWi7fXgQrVyWeE9FdGhVS
        iXFBH5dSUSJJvYAvBA7xDCM=
X-Google-Smtp-Source: ACcGV63i2ZlC11FrOLX3YJKW5P8J4d3d19J/luI7JouB32Yw+9FvowA+BSbQDupic9ZQRBT9lPbctQ==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10-v6mr2127659wrw.78.1539100146876;
        Tue, 09 Oct 2018 08:49:06 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa83.dynamic.kabel-deutschland.de. [31.18.250.131])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10907338wmd.11.2018.10.09.08.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:49:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: use __func__ instead of hardcoded name - style
Date:   Tue,  9 Oct 2018 17:48:51 +0200
Message-Id: <20181009154854.9054-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181009154854.9054-1-straube.linux@gmail.com>
References: <20181009154854.9054-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded function name in rtw_xmit_entry().
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index d8ef9b5d81a8..8e250f2bf39b 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -166,7 +166,8 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
 
 	if (rtw_if_up(padapter) == false) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit_entry: rtw_if_up fail\n"));
+		RT_TRACE(_module_xmit_osdep_c_, _drv_err_,
+			 ("%s: rtw_if_up fail\n", __func__));
 		goto drop_packet;
 	}
 
@@ -187,13 +188,15 @@ int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev)
 		goto drop_packet;
 
 	pxmitpriv->tx_pkts++;
-	RT_TRACE(_module_xmit_osdep_c_, _drv_info_, ("rtw_xmit_entry: tx_pkts=%d\n", (u32)pxmitpriv->tx_pkts));
+	RT_TRACE(_module_xmit_osdep_c_, _drv_info_,
+		 ("%s: tx_pkts=%d\n", __func__, (u32)pxmitpriv->tx_pkts));
 	goto exit;
 
 drop_packet:
 	pxmitpriv->tx_drop++;
 	dev_kfree_skb_any(pkt);
-	RT_TRACE(_module_xmit_osdep_c_, _drv_notice_, ("rtw_xmit_entry: drop, tx_drop=%d\n", (u32)pxmitpriv->tx_drop));
+	RT_TRACE(_module_xmit_osdep_c_, _drv_notice_,
+		 ("%s: drop, tx_drop=%d\n", __func__, (u32)pxmitpriv->tx_drop));
 
 exit:
 	return 0;
-- 
2.19.1

