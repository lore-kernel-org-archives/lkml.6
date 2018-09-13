Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155FFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioFUxx+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0B420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeINBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:46:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37775 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeINBqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:46:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so5731209ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wLFFsBXKELJOYFVehhphbHc46k/2cpM176KUG7r4HQ=;
        b=ioFUxx+m06FkiM+SyHQYZ5Nz/hKvrQObGuZ3fwEhCHIqyRuIZxh7WRwYxzGUo9Cjmn
         HddQQUBT+LqgeBrc8D7mq1ltDOM0JcC+eB1NCRdn95jYNi2ytGG4GWJhIjDt4aDzf7W5
         GLkiaG4bazQ57VtF+/npCdP0l97LoxuGY5Oy1Y/FL2hOGo0oA+ZwnzITO3ZUIk00OhP4
         c16iYcfkYb7IQsPCVQ8tNWl/ULoJpmXbPeJWTPfqiXVe4mlecn0RtU67OR/oDrV1Uce7
         f+E+4GkD1ZskTcp3/9aqRoJwbQnCNM0PuAPrY3X1agMhxYgUGwCGrVFX5O8cNN8I4XCw
         7w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wLFFsBXKELJOYFVehhphbHc46k/2cpM176KUG7r4HQ=;
        b=qq3POn32N+mafL3EXmdMYa0CSl5WBDlUxSQP0KkSRZsNAAZFn7lVVDY7SJkPJrW5ij
         BOIeH0kEB6URPVIbGOwFrHbTHKEci0Hz2Vkm49j/0LpOj2UbCVVR4Ro4DFB/wV2IfZqt
         CLAgTg1cpoHD+Jghf/SxxfHXtYxWUkIRKN6XM6zRAUXq+KNby3uPvlP7e1VN3l1TW4QZ
         z84JOjb54+kR5zjcj7Zh8IQtBEWD1LGrW8zRb1MR3NcEeMYQr3jURuFBVQwPl6i2C5UD
         fblE6OQyWZ2pQ2e/48YpuJcNohd/mYVGZYPH0+O2fak7lXvhz1cGf9YXmzHGDQAE5jYW
         F4lA==
X-Gm-Message-State: APzg51BkkvnSlUvDceHhefOgVvYWwz873xnRsKOeGc2RiKrx7Eyt18aX
        lwefWr50p6MK5RhnicU0jz4=
X-Google-Smtp-Source: ANB0Vda28wbCX8cCjBYhjTMQe6JeKEtcKCZb3zox4WnEp8GGRKyKI83jizYcv8YMwIUJa2B45snCXg==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr3966459lja.47.1536870931113;
        Thu, 13 Sep 2018 13:35:31 -0700 (PDT)
Received: from localhost.localdomain (staticline22297.toya.net.pl. [217.113.232.143])
        by smtp.googlemail.com with ESMTPSA id d13-v6sm886897lfi.74.2018.09.13.13.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 13:35:30 -0700 (PDT)
From:   =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Robert=20W=C4=99c=C5=82awski?= <r.weclawski@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Bhaskar Singh <bhaskar.kernel@gmail.com>,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Aishwarya Pant <aishpant@gmail.com>,
        Mihaela Muraru <mihaela.muraru21@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove code that is valid only for 5 GHz
Date:   Thu, 13 Sep 2018 22:32:39 +0200
Message-Id: <20180913203246.4376-1-r.weclawski@gmail.com>
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
 drivers/staging/rtl8188eu/core/rtw_ap.c       | 23 ++++++-----------
 drivers/staging/rtl8188eu/core/rtw_debug.c    | 25 +------------------
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 10 --------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 13 +---------
 4 files changed, 9 insertions(+), 62 deletions(-)

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
index eca06f05c0c4..b610443f2ac6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1819,16 +1819,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
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
 		/*  TODO */
 		break;
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

