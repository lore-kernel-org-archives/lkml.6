Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtl4H4b4r0/PXtR989rfJTuJ6uqY2ZytXpepPMxKUVJxqLpe/3uGPJ8G5pv0IJCqaaN7de0
ARC-Seal: i=1; a=rsa-sha256; t=1522140096; cv=none;
        d=google.com; s=arc-20160816;
        b=t2cDDj5yuuaSa+jtYOdjtf8a+9TDS36JXwwdE9e//YLngWSoO/pMZZvX7TeI0VcW31
         /8jJJ+lbaMUJICCmofg68QyOX0c//1LpMxf4CoIucVfQgDNk3PnVRrOa7Gad2LoGyn4/
         gBtIpk5Lxs23ijRMsnyVu8oAJWZdEn0Vh8lY+g5o82T3AXz1v1Q4UUFjj9CDCIf4yBz4
         OKufK/1eUEseWktNFEsuzpgzQQ/YtobbL81uWE1B9nRDLvK9n1SI/ZcVHxGkMYABw9Fc
         6Ca+rWLcrh844eI9uW5+Bmi0zv2e/VU4SsIrqBs1eXyrBRHaBA9bqCAtUdD6qUy79yeV
         YoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ie96Zx8PHiuCUACqsgI3qdZt2H+FQqB9P9OOy6aAs78=;
        b=UMNi8ss/aYPdIKFLwgykn+a8d0Z948nuNtL8fSvcNrXb9jJ+qWjXrWQdMmFbtMCAuw
         Oo/bjhyYoOi2INB1ysKnzt8JjXFTFEoz4G3jN0wb+jqytry33dW4guxOlsh4nVOR4U+x
         EJKB6ZDB1Cq0UEIZ+BefeloWxEPJDiVIJR4qClYGQ8FMXi4vyRNtxHRLDOh53MtS6M+d
         n95skLaRShNkXpjjsyJ2MU6b61OKITLeeDHdgxsmRApd+yz9NgTLdvOAjQHTWFXywkfK
         ejOSSwg3QDnJCh36GLi5Ob9m8BQRxdX/XjOzg7tRdLkcU3P5dz+pkibtJIi7bfzsYpv+
         dfww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 17/23] staging: rtl8723bs: Fix lines too long in update_recvframe_attrib().
Date: Tue, 27 Mar 2018 01:41:09 -0700
Message-Id: <20180327084115.16129-17-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:PcFXmo6SLznxFAZnmtLnvL+68UhTlG5WkshUfDrEnXFATcAqrhN
 0MQrT4aQtqyFsZUpfHtdAqhhVzn32F6qKyTKScFCB5SFGbZdAkXxukdKlOh1qN1+KQZKz25
 +K8poQMwGm9zhola2Pc2L0sfi0MyGLSUiMn7dzfdE6x1jtYxsr9KeR+Q3cvcReSziaupdRq
 IliXCwEm3JoKJJMLO0qqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7NBo0vUiRVw=:Y+l+saKJunU1NFn1tdnJhm
 UlVK4PyOVHOTz1syW6OIxOqWVXBjBtjX2HgLbkLr51AJEwDxqBCJNzab6mRww1Od/cWxoIKiY
 zJ6lFT8UcTqhRCl9G8VHe2gCBVMtvIWxQEcHDGNk3iTUrnZiq/EeRcdnjQROzLSsZQN3RVsGv
 9EkKF3cL/DzoxR6q6ZnpNWXFq9A8+VFjZlfDFj4iScd+QkYxWF2clTPD2+haD7DKdgvnqgD/u
 C1ZZXiUoI/jaZ7BfsMmMmEo9b3s3i+YVFRaJmqsEqf4RFBjoQuhweGzujjSyyKqV3aLQYokOn
 ZpBmjs1Ii0mCHz6IrgqtQm8qcxmIu1E1MTX50e4V3yWOcLvvy/pL9kL2VH2HnN1Wil4IjKbYT
 MF5kE4d61AkH2RjkUo7zsqIX4CU3zX2HLBKeY+v99ei+aE6EjGv8e4R0adwoljpVgUuMdfouH
 ZcpcGF5UmuVV1wCFz+fdXqaJEnNxpUodbKr/6n5TkmQRCotAdDUS/grqdz+Ha3SrCJeX2ziWK
 6fwPMzhzMbhnD3xHtpMjA8AYKbFjVuuO42xhxR+u+E1h0lKcSlxfTh5vkEsSOcf1kvM87hl++
 kylbkk6mLjbst5VhrUCi6rIiq22WpXdv3JyN5RCLrd67AJUm0gfWo4yTk6zEVD0+ZqjBz5n5j
 w0cmGKvKQn/VUDrAoeLnEZHyF3k6rbE7oY3Dq6YrQNOL+uvtECiAaSRk7jg3rUW+1t6Vycpxq
 vgREWa7wYWdLiXrFk8n4/cQmAtENC7xniBWUIQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079574110801227?=
X-GMAIL-MSGID: =?utf-8?q?1596079574110801227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix lines over the 80 character limit in update_recvframe_attrib().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 30 +++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 3a2c14f53a1f..a00d4e7ed70c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -93,6 +93,11 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	PODM_PHY_INFO_T p_phy_info = (PODM_PHY_INFO_T)(&pattrib->phy_info);
 
 	u8 *wlanhdr;
+	u8 *my_bssid;
+	u8 *rx_bssid;
+	u8 *rx_ra;
+	u8 *my_hwaddr;
+
 	ODM_PACKET_INFO_T pkt_info;
 	u8 *sa = NULL;
 	/* _irqL		irqL; */
@@ -104,14 +109,20 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	pkt_info.bPacketBeacon = false;
 
 	wlanhdr = get_recvframe_data(precvframe);
-
+	my_bssid = get_bssid(&padapter->mlmepriv);
+	rx_bssid = get_hdr_bssid(wlanhdr);
 	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
-		!pattrib->icv_err && !pattrib->crc_err &&
-		!memcmp(get_hdr_bssid(wlanhdr), get_bssid(&padapter->mlmepriv), ETH_ALEN));
+				      !pattrib->icv_err && !pattrib->crc_err &&
+				      !ether_addr_equal(rx_bssid, my_bssid));
+
+	rx_ra = get_ra(wlanhdr);
+	my_hwaddr = myid(&padapter->eeprompriv);
+	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
+		!ether_addr_equal(rx_ra, my_hwaddr);
 
-	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID && (!memcmp(get_ra(wlanhdr), myid(&padapter->eeprompriv), ETH_ALEN));
 
-	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID && (GetFrameSubType(wlanhdr) == WIFI_BEACON);
+	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
+		(GetFrameSubType(wlanhdr) == WIFI_BEACON);
 
 	sa = get_ta(wlanhdr);
 
@@ -121,13 +132,15 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	psta = rtw_get_stainfo(pstapriv, sa);
 	if (psta) {
 		pkt_info.StationID = psta->mac_id;
-		/* DBG_8192C("%s ==> StationID(%d)\n", __func__, pkt_info.StationID); */
+		/* DBG_8192C("%s ==> StationID(%d)\n",
+		 * 	  __func__, pkt_info.StationID); */
 	}
 	pkt_info.DataRate = pattrib->data_rate;
 
 	/* rtl8723b_query_rx_phy_status(precvframe, pphy_status); */
 	/* spin_lock_bh(&p_hal_data->odm_stainfo_lock); */
-	ODM_PhyStatusQuery(&p_hal_data->odmpriv, p_phy_info, (u8 *)pphy_status, &(pkt_info));
+	ODM_PhyStatusQuery(&p_hal_data->odmpriv, p_phy_info,
+			   (u8 *)pphy_status, &(pkt_info));
 	if (psta)
 		psta->rssi = pattrib->phy_info.RecvSignalPower;
 	/* spin_unlock_bh(&p_hal_data->odm_stainfo_lock); */
@@ -141,7 +154,8 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 			rtl8723b_process_phy_info(padapter, precvframe);
 		}
 	} else if (pkt_info.bPacketToSelf || pkt_info.bPacketBeacon) {
-		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE) == true)
+		u32 adhoc_state = WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE;
+		if (check_fwstate(&padapter->mlmepriv, adhoc_state))
 			if (psta)
 				precvframe->u.hdr.psta = psta;
 		rtl8723b_process_phy_info(padapter, precvframe);
-- 
2.16.3
