Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C63C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHeTjNpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfAOIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:24:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35867 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfAOIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:24:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so2229860wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdjxCe3A3QpOWTWuXU6tNMiSaxQ//Tl5vGOVqNXoEaY=;
        b=PHeTjNpYyF5gsKS/9nCJFAj4mijX9MwOseoMHigfzn2ttOytI+8eVhjuzjxjCqht3l
         yIn/9mnl/TKhWiqzlEwgfzIKJj+M5DzkfRaMx+ihfTxfJz5XgdbhNAG0r6huYUbTPq7f
         Er3Ut7iLoXMhe+IrxggpmYvEtfNSKkJU9iRm89p2vMshQHu9eYkRDVTdGVQh5cs7WZoe
         r8wJE9H5ltwH0BlFyPoKwmUElpdMgdvOyT0heKQV+T4SrvyckX6A5oQi463wwZrkO+sm
         r0L4WavsIfP3FDFQI3HSX+hqXLBSnl+TNa0zymS6HK77M0VIYFf8zVOdurwHDRsk7NCB
         ojYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdjxCe3A3QpOWTWuXU6tNMiSaxQ//Tl5vGOVqNXoEaY=;
        b=NzGe1qYOJIQ3ymltfw53Kv0dj2Dpy5u42u0Ima/6Fl0+o5BaIABRAo2UEeVyjWSiPS
         0p3vx3Q+78bdz+CJq8LlkJU77S4DbG0T4Rv8Ki5Qstts02BB/soC7smiW0G6W8t02Ame
         iz9CSZcdi/2QhoH+6YmJgtzjW2NWXwTB2wwbHNnU323JiRtn0r5hEOhbjhXz+mnuHRtF
         n0j1RHHP0UD/xwzZqlMMPMEC9ZetpS6nQH14BsaG+B/Ss2AyCBAHWCFfRJzhKxiBqHmp
         jaXKfni1ZtmCAnn28HsSpL4Mn+gxNFx5hpZ9XILlDD2x4AP7Z1k2Vhyx+0itp4HmF3vi
         CT6A==
X-Gm-Message-State: AJcUukeyO7nlRKNMqwSZ9GCW1UTHE4mi1GU98WKS9uNxbWgtuV/57cLB
        s/0T2rSLMOgbquMICoceoqg=
X-Google-Smtp-Source: ALg8bN6ajKOuvfg5Nym7ou7BbU8O1XAyGTPj22YUv6eTIWp5ZuQqBpjrOFuC10Q/alWQETVMTXSeig==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr2170945wme.94.1547540655164;
        Tue, 15 Jan 2019 00:24:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id u10sm62556295wrr.33.2019.01.15.00.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:24:14 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: cleanup declarations in os_intfs.c
Date:   Tue, 15 Jan 2019 09:24:01 +0100
Message-Id: <20190115082402.8519-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115082402.8519-1-straube.linux@gmail.com>
References: <20190115082402.8519-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove extra spaces in declarations.
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 6681383579ee..6ed4a06a0796 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -137,7 +137,7 @@ static int netdev_close(struct net_device *pnetdev);
 
 static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 {
-	struct registry_priv  *registry_par = &padapter->registrypriv;
+	struct registry_priv *registry_par = &padapter->registrypriv;
 
 	GlobalDebugLevel = rtw_debug;
 
@@ -248,7 +248,7 @@ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev,
 			    select_queue_fallback_t fallback)
 {
-	struct adapter	*padapter = rtw_netdev_priv(dev);
+	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	skb->priority = rtw_classify8021d(skb);
@@ -263,7 +263,7 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 {
 	struct iphdr *piphdr;
 	unsigned int dscp;
-	__be16	eth_type;
+	__be16 eth_type;
 	u32 priority;
 	u8 *pdata = skb->data;
 
@@ -286,7 +286,7 @@ static const struct net_device_ops rtw_netdev_ops = {
 	.ndo_open = netdev_open,
 	.ndo_stop = netdev_close,
 	.ndo_start_xmit = rtw_xmit_entry,
-	.ndo_select_queue	= rtw_select_queue,
+	.ndo_select_queue = rtw_select_queue,
 	.ndo_set_mac_address = rtw_net_set_mac_address,
 	.ndo_get_stats = rtw_net_get_stats,
 	.ndo_do_ioctl = rtw_ioctl,
@@ -361,7 +361,7 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 static u8 rtw_init_default_value(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
@@ -431,7 +431,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
-	u8	ret8 = _SUCCESS;
+	u8 ret8 = _SUCCESS;
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
 
-- 
2.20.1

