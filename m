Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B4ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB472083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4UDViX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB472083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIOBU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:20:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36032 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeIOBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:20:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id x207-v6so8895553lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlTQg9fsytfPzq/qZPTHJTgOY6GoYyuL3sGfWFlpG34=;
        b=a4UDViX089mqEg8h+DWDEPpaYKGlNYm0wWN2zE6XaRrr98N3x/WyND/jHDpAgjMoi4
         i9hVFUQEErIN1MfTyyk5kArnX9NcmMdfTqnBEKtimCDraog/vhe2AYhgbBCxNnmqArOt
         VxOguAyj3RxabVgxAFghiYg2RoIsMSQQDj04lzSkFQxCHEa5ghSXys2TrWdhHHM9+Upj
         OuWYcVdRWUUBaHCw2S5wXLOvD+KAdXishGiduwfJKSePwBz4vcetVV0cvQDB24cp12+y
         kC7PhBK+Nmu7qhPR3ny1D7nJU7r+0op6enduLe9omufwioPIQjKuiurjJs42kvWRwAg+
         5J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlTQg9fsytfPzq/qZPTHJTgOY6GoYyuL3sGfWFlpG34=;
        b=LhMb4TJFGA0HbodmayVCTxt5ekrQ1eewGsWotjq+fkQzU+qBkhaAhxIx6T5zXpwsoX
         cJ1MfoDRKPEBJs0aFy+iuOCJUtez21FO3iFMy6U/2DTAUQZXgLp9cKznBuXeXqH5Bz5y
         FipB+r1qPleZp9kr51JVKcCeq46qXRcOgobjzDRDPbCOIA1UJ/5jz2UGww+cBvmhaI10
         hAOPQVlLlWld6Hwb2Sb/t0sWrjrZ+omk5R5+lkxbh7AFaYL71axPyjjlBIwzeV74x11X
         SX51z/O1B0ufk8fNn/blFgIkrfCBcEsCtZtpFciQzyH/9uVOSIijgnvrOj/x62RD9OBM
         5wMw==
X-Gm-Message-State: APzg51A4/DWKSlzPkLPSBNX6tv2rP8hh/ZmhZsRaTf85eP9cSc4uIN+p
        d6dMqG4g8ZEbpOSr+BpDcjU=
X-Google-Smtp-Source: ANB0VdbYWnhtZA8Egqk8zuFeeoajgylfqsoQEL+4yUeBeQmP0yBdOgVz8c/G16zSJAh78U6uAN5R5Q==
X-Received: by 2002:a19:501a:: with SMTP id e26-v6mr2631058lfb.71.1536955465628;
        Fri, 14 Sep 2018 13:04:25 -0700 (PDT)
Received: from localhost.localdomain (staticline22297.toya.net.pl. [217.113.232.143])
        by smtp.googlemail.com with ESMTPSA id n129-v6sm1458695lfb.3.2018.09.14.13.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 13:04:24 -0700 (PDT)
From:   =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com,
        =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
        Aishwarya Pant <aishpant@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Mihaela Muraru <mihaela.muraru21@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: remove code that is valid only for 5 GHz
Date:   Fri, 14 Sep 2018 22:04:05 +0200
Message-Id: <20180914200411.19059-1-r.weclawski@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that is used only for 5 GHz.
This addresses the below TODO item:

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Signed-off-by: Robert Węcławski <r.weclawski@gmail.com>
---
Changes in v2:
- set pdev_network->NetworkTypeInUse to Ndis802_110FDM24 in default case

 drivers/staging/rtl8188eu/core/rtw_ap.c       | 23 ++++++-----------
 drivers/staging/rtl8188eu/core/rtw_debug.c    | 25 +------------------
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 12 +--------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 13 +---------
 4 files changed, 10 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index e611eda11b5f..1c319c2ca86d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -337,8 +337,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	unsigned char sta_band = 0, raid, shortGIrate = false;
 	unsigned int tx_ra_bitmap = 0;
 	struct ht_priv	*psta_ht = NULL;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex *pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 
 	if (psta)
 		psta_ht = &psta->htpriv;
@@ -363,20 +361,13 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		shortGIrate = psta_ht->sgi;
 	}
 
-	if (pcur_network->Configuration.DSConfig > 14) {
-		/*  5G band */
-		if (tx_ra_bitmap & 0xffff000)
-			sta_band |= WIRELESS_11_5N | WIRELESS_11A;
-		else
-			sta_band |= WIRELESS_11A;
-	} else {
-		if (tx_ra_bitmap & 0xffff000)
-			sta_band |= WIRELESS_11_24N | WIRELESS_11G | WIRELESS_11B;
-		else if (tx_ra_bitmap & 0xff0)
-			sta_band |= WIRELESS_11G | WIRELESS_11B;
-		else
-			sta_band |= WIRELESS_11B;
-	}
+	if (tx_ra_bitmap & 0xffff000)
+		sta_band |= WIRELESS_11_24N | WIRELESS_11G | WIRELESS_11B;
+	else if (tx_ra_bitmap & 0xff0)
+		sta_band |= WIRELESS_11G | WIRELESS_11B;
+	else
+		sta_band |= WIRELESS_11B;
+
 
 	psta->wireless_mode = sta_band;
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_debug.c b/drivers/staging/rtl8188eu/core/rtw_debug.c
index 67461fdf315c..6c2fe1a112ac 100644
--- a/drivers/staging/rtl8188eu/core/rtw_debug.c
+++ b/drivers/staging/rtl8188eu/core/rtw_debug.c
@@ -153,13 +153,11 @@ int proc_get_best_channel(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int len = 0;
-	u32 i, best_channel_24G = 1, best_channel_5G = 36, index_24G = 0, index_5G = 0;
+	u32 i, best_channel_24G = 1, index_24G = 0;
 
 	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
 		if (pmlmeext->channel_set[i].ChannelNum == 1)
 			index_24G = i;
-		if (pmlmeext->channel_set[i].ChannelNum == 36)
-			index_5G = i;
 	}
 
 	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
@@ -171,32 +169,11 @@ int proc_get_best_channel(char *page, char **start,
 			}
 		}
 
-		/*  5G */
-		if (pmlmeext->channel_set[i].ChannelNum >= 36 &&
-		    pmlmeext->channel_set[i].ChannelNum < 140) {
-			/*  Find primary channel */
-			if (((pmlmeext->channel_set[i].ChannelNum - 36) % 8 == 0) &&
-			    (pmlmeext->channel_set[i].rx_count < pmlmeext->channel_set[index_5G].rx_count)) {
-				index_5G = i;
-				best_channel_5G = pmlmeext->channel_set[i].ChannelNum;
-			}
-		}
-
-		if (pmlmeext->channel_set[i].ChannelNum >= 149 &&
-		    pmlmeext->channel_set[i].ChannelNum < 165) {
-			/*  find primary channel */
-			if (((pmlmeext->channel_set[i].ChannelNum - 149) % 8 == 0) &&
-			    (pmlmeext->channel_set[i].rx_count < pmlmeext->channel_set[index_5G].rx_count)) {
-				index_5G = i;
-				best_channel_5G = pmlmeext->channel_set[i].ChannelNum;
-			}
-		}
 		/*  debug */
 		len += snprintf(page + len, count - len, "The rx cnt of channel %3d = %d\n",
 					pmlmeext->channel_set[i].ChannelNum, pmlmeext->channel_set[i].rx_count);
 	}
 
-	len += snprintf(page + len, count - len, "best_channel_5G = %d\n", best_channel_5G);
 	len += snprintf(page + len, count - len, "best_channel_24G = %d\n", best_channel_24G);
 
 	*eof = 1;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index eca06f05c0c4..ef8a7dc4bd34 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1819,18 +1819,8 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	case WIRELESS_11BG_24N:
 		pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
 		break;
-	case WIRELESS_11A:
-	case WIRELESS_11A_5N:
-		pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
-		break;
-	case WIRELESS_11ABGN:
-		if (pregistrypriv->channel > 14)
-			pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
-		else
-			pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
-		break;
 	default:
-		/*  TODO */
+		pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
 		break;
 	}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 1115050077e4..213c8d670591 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2401,10 +2401,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 			p++;
 
 			for (j = 0; j < noc; j++) {
-				if (fcn <= 14)
-					channel = fcn + j; /*  2.4 GHz */
-				else
-					channel = fcn + j*4; /*  5 GHz */
+				channel = fcn + j;
 
 				chplan_ap.Channel[i++] = channel;
 			}
@@ -2481,14 +2478,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 				j++;
 		}
 
-		/*  keep original STA 5G channel plan */
-		while ((i < MAX_CHANNEL_NUM) && (chplan_sta[i].ChannelNum != 0)) {
-			chplan_new[k].ChannelNum = chplan_sta[i].ChannelNum;
-			chplan_new[k].ScanType = chplan_sta[i].ScanType;
-			i++;
-			k++;
-		}
-
 		pmlmeext->update_channel_plan_by_ap_done = 1;
 	}
 
-- 
2.17.1

