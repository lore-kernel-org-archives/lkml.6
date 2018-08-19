Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9EBC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94E220C0F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeTdNok2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E220C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHSUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:39:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38192 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeHSUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:39:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so5609001pfh.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=itTLgrlxaHS7L4oav1bxoBTpoj8HoeqYhEATqdjUksk=;
        b=eeTdNok2E09lP2zFukM5jYsjnmNmJHZS4rY/XAo5no48ov1Jk/YWAF9T+mSymFPo96
         mxnVsiNzCmoINt6uSt0PnNPQQOzNm4kkEKVnthE3xwovtYCSxemn2nxSm0oKuHnIRxav
         VE3JDWtkN/2IxdfsOtI+JHpatDkWu3r9Nc4uk/HaG/bi1Se1x3vYwsueV4RYiFzpiT78
         fNYayRM6IPaeHtBfp9DdzjLsXCo8XKW20LDVl6tI58gUHrQxnlXj5PWe2bgh3KFK95pA
         oFizJMyiqhOp9aQUs5wwjPJOPnXMmB30swD4QgMLergyRu9pbF/kPmUMAtGdjxb4eUAq
         AN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=itTLgrlxaHS7L4oav1bxoBTpoj8HoeqYhEATqdjUksk=;
        b=nT025HjFAzTCOG327Wev3pTFAUEkaA7gEhIoZMGQcq9D54YxWW+KKhJfkjA/qRGs44
         sX1LFo4/hA8wGzjpAK7qnFhD3Bm9IMC4drb2DGDMbKGb4zCR0IWS1CS3/oLl8MQ1X5L+
         5GaVKAxc6GFsiqkdw3qKSuf+ajeTWuyjV5VG06kYz6tIWFXuHZHD3ORC0dVIeb0bekjP
         uQCBe8Xdf//AiWIU3QYWY9DL84CnqJ+5Fg1C0lwheYMQlSKp1WpSmn2y+FxHNdSC1m1D
         ytdlYL7KXA5Lx72NaGZ4s9QAH9Cg6xNZdlfQdRMRuxtQN+lPkP3lcvEV4t8stj4Tf1uc
         6rGA==
X-Gm-Message-State: AOUpUlGUWuhwdsjg3LlMpgLLwNnKWp6BkNtZYlV2LFcCagOn7W8D9O1F
        U2Y5AU0IrRF3m0YJtscuJZEiwwSI
X-Google-Smtp-Source: AA+uWPxfI8hfBJp4JX6jjpfQH7PurVGJonmrwSTjT6RshxQJCVdHtriCEIbezYSSHUizh3ZEZYALBw==
X-Received: by 2002:a63:c50c:: with SMTP id f12-v6mr39263515pgd.88.1534699624866;
        Sun, 19 Aug 2018 10:27:04 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id k23-v6sm8634458pgl.42.2018.08.19.10.27.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 10:27:04 -0700 (PDT)
Date:   Sun, 19 Aug 2018 22:57:05 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Removed unneeded variable
Message-ID: <20180819172204.GA8852@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed unneeded variable named ret because this variable is
used only to return 0.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index bee3c3a7a7a9..4801345a2b57 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1370,7 +1370,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 			      struct iw_request_info *a,
 			      union iwreq_data *wrqu, char *extra)
 {
-	u32 len, ret = 0;
+	u32 len;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
@@ -1388,7 +1388,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 	wrqu->essid.length = len;
 	wrqu->essid.flags = 1;
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_set_rate(struct net_device *dev,
-- 
2.16.4

