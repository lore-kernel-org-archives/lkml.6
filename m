Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1015056-1520111537-2-1660672297414145556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520111536; b=Jx9B+/5Kxs4Rz/GNQLIJvzxUBojoUQ6JTPZcLUSG+p4cnqp
    T44V7IdhVjk3oguKt9oLnVQx3/8wVMtRdtMdELjXKC0bOJA0/4r6v9VVp8A18Cqi
    1qtLkW5GNRQa4neRFDzoLncezzEbOVMTUrnlb05LN2iQBDWAWIaDzXN0xcZJP4+e
    epD9v44VBbbe+1r/wqwxnkP7BiIp58Xe08Ms9kevQXQb5eiHE6RFcU3LwWDEviku
    CztG7twsCzamjF0ei0ALpppVI+hRCZTGlJluYEgOJHuFu7pWBfFQVLWXSUdVwf3z
    EHfi1qoQANAzIlV/QFtchZb7NRMuscOavSOFNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520111536; bh=J
    9UEpMTY6h3/7fTxf13IYkX2cinb/RtdyCW/gZA7Z8M=; b=WO+Js+rQsj5h9y24M
    011JyoCQ//IgHk6U1JEXlxQh3Bdz6ZJX8PgGyQB3kw+43nFZoZUr0sByUVuCyfsL
    GJDxILsv2OLrHBCeNSqRrBvtkcpVnuCDwiXfiRJOIpPRpa8NIHxugVQhpqaYDUMA
    UFTl7INIokq6NIoWUy4Miqk3CVwvVpsOZa8C8rH3lPZmw7K7L4olr7hVanr5B/YS
    LtCoxz2xTE8evdapQJ7FdLm+dtHA6GXVPJntw3KH/P1ItZM+SCAuxu/tDd3RAHzO
    pRfsZOmpiLEtSJfl3v3qV30m4KV+Nnzhy+A/vUZweT9SE8Bj0pEzVDe4dApyMlNb
    xJa/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tMiWR76U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h5xvSaVd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tMiWR76U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h5xvSaVd;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt8D4Egpkoin5udmzBXRfHUF4cfMuxgPFDniZEdpfFwBN0zwiRilNDwBDa4HnyATQsd5mZhZQ==
Date: Sun, 4 Mar 2018 02:41:42 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: rtl8723bs: Replace memset with eth_zero_addr
Message-ID: <20180303211142.GA10078@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use eth_zero_addr to assign zero address to the given address array
instead of memset when the second argument in memset is address
of zero. Coccinelle was used to do the replacement and add the
header file linux/etherdevice.h if not already present.

The Coccinelle semantic patch that makes this change is as follows:
@header@
@@
#include <linux/etherdevice.h>

@r1@
expression e;
@@

-memset(e,0x00,ETH_ALEN);
+eth_zero_addr(e);

@includeheader depends on r1 && !header@
@@
+ #include <linux/etherdevice.h>
#include <...> 

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c         | 3 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 3 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 9 +++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fe739eb..c13e514 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -14,6 +14,7 @@
  ******************************************************************************/
 #define _RTW_MLME_C_
 
+#include <linux/etherdevice.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
@@ -2109,7 +2110,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 		mlme->roam_network = candidate;
 
 		if (!memcmp(candidate->network.MacAddress, mlme->roam_tgt_addr, ETH_ALEN))
-			memset(mlme->roam_tgt_addr, 0, ETH_ALEN);
+			eth_zero_addr(mlme->roam_tgt_addr);
 	}
 
 	ret = _SUCCESS;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1e6c587..75a4b23 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -14,6 +14,7 @@
  ******************************************************************************/
 #define  _IOCTL_CFG80211_C_
 
+#include <linux/etherdevice.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
@@ -2391,7 +2392,7 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 	{
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN))
 		{ /*  BSSID is matched, the same AP => Remove this PMKID information and reset it. */
-			memset(psecuritypriv->PMKIDList[index].Bssid, 0x00, ETH_ALEN);
+			eth_zero_addr(psecuritypriv->PMKIDList[index].Bssid);
 			memset(psecuritypriv->PMKIDList[index].PMKID, 0x00, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = false;
 			bMatched = true;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index cc18d0a..bf437c8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -14,6 +14,7 @@
  ******************************************************************************/
 #define _IOCTL_LINUX_C_
 
+#include <linux/etherdevice.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtw_mp.h>
@@ -124,7 +125,7 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
 	memset(&wrqu, 0, sizeof(union iwreq_data));
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	memset(wrqu.ap_addr.sa_data, 0, ETH_ALEN);
+	eth_zero_addr(wrqu.ap_addr.sa_data);
 }
 
 /*
@@ -1080,7 +1081,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		for (j = 0 ; j<NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => Remove this PMKID information and reset it. */
-                                memset(psecuritypriv->PMKIDList[ j ].Bssid, 0x00, ETH_ALEN);
+                                eth_zero_addr(psecuritypriv->PMKIDList[j].Bssid);
                                 psecuritypriv->PMKIDList[ j ].bUsed = false;
 				break;
 			}
@@ -1294,7 +1295,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 
 	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
 
-	memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
+	eth_zero_addr(wrqu->ap_addr.sa_data);
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_wap\n"));
 
@@ -1303,7 +1304,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 			((check_fwstate(pmlmepriv, WIFI_AP_STATE)) == true)) {
 		memcpy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress, ETH_ALEN);
 	} else {
-		memset(wrqu->ap_addr.sa_data, 0, ETH_ALEN);
+		eth_zero_addr(wrqu->ap_addr.sa_data);
 	}
 
 	return 0;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
