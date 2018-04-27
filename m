Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3786223-1524807964-5-14601904870436545588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES rosven,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='io', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524807964; b=Bpif0gaildXkzFNWrmylVGP13HHUjAOqFpLeJdlnB4yCI9qIw1
    8xkcyzmaDa4K4DkVrUMm1P8hoJxPS2hSnBIlQAdk+YvSghQNxSGyJkkIL6hzG1Ip
    Xy1gazihqX0B7MdQKmsuYYT1G16y8KkQ2xr8aCIfmO1K2da/i7IxI+lJB8Unjkxn
    5QYRaB/JET9AWtpQaCBLihHhHBILMUkuquApkPJWHf5rgpL2H2HR9dz8rPx24SXx
    Hoa2gfZ43aEU81gjohvOVRDnjuWiRy8DAs6KLQ919gjpKrQA01MOJDoomz8cew4a
    eNCpM4MBNlOe+tBn6KsyJzVj7ZHkp9XgzasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:subject:date
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524807964; bh=LbOUP
    n9Gkz7TBS60rlodhTd/t/C7dMtF+ek0aSrIPys=; b=AXK7DW/AVm5FnFUU22qQR
    GgVrMYJi47RJCf5Btru/xncR3A0X2eKXcClpKHvU0L4UgFTx0I+0pGUh3PMZdhr5
    y/pDpPP1x7AdAibZnAnBCDu6WCwEE/IwZPPhMowMrPauUIepEgQos+wJk/4nCdHK
    FoZS6TplXLaJhBrVriuks33iakzvOUkgl0z2DqR4vGWpbWQPQJ7pws7iFiNb2qEV
    8HtMYAYt8tBNgQksZZG7Te824IArWVvEj0aIq0+dLc8U8req1J0GHbnlF3sexcrq
    k3S4gORAljYNEtn0gBqT2Ot47ljvjNHXT9eN2OYJcTLCJIJIDmhsdSIcbmCTotiU
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=elg.io header.i=xtrat@elg.io header.b=Lk8xF+wg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mailjet;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elg.io;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=elg.io header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=elg.io header.i=xtrat@elg.io header.b=Lk8xF+wg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mailjet;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elg.io;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=elg.io header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBjF7XhJcEBJjNy3RUy9KHusQWTByqxX5XQ0rWX2uCg9DfKhcv8l7knSqzBu4RFWMioAyhrci+Uc88CRIbw/9ZLqCE5G9rccQdMDEuOlbvuYXzZXLoAV
    3yi7oloGPlg8Pvfm6Ml5uKlwiYbVRQo3q28n+d1UHIXHnYNBAH8QR+Ldsrm5zOVvFnpwLDEuesE5EtQfdHybxwQ1fSMjs/6X8ry0rSm0CxdKDQtjLZTgSddX
    rgpsCxJLsoENLdobY6Oi4A==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=KqOhe5OoNmIA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=rIQ2OwTckwrSlP6gn0gA:9 a=1XtaASNAG-4Yr8MH:21 a=Ij68rIorzcbNyBSs:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-Id: <958b53ef.AMIAAAYVaKUAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa4rkQ@mailjet.com>
From: Efstratios Gavas <xtrat@elg.io>
To: xtrat@elg.io
Subject: [PATCH] Staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Date: Fri, 27 Apr 2018 05:45:07 +0000
X-CSA-Complaints: whitelist-complaints@eco.de
X-MJ-Mid: AMIAAAYVaKUAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa4rkQ0Mklkv1uTM6gVI4h8f7GrAAKs_E
X-MJ-SMTPGUID: 946aed3e-7cb9-47d5-b0da-f1cb78af501e
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org,
 Thibaut SAUTEREAU <thibaut.sautereau@telecom-sudparis.eu>,
 Aviv Palivoda <palaviv@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed coding style issues.
Signed-off-by: Efstratios Gavas <xtrat@elg.io>
---
 drivers/staging/wlan-ng/prism2sta.c | 52 +++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index fed0b8ceca6f..914970249680 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -764,16 +764,16 @@ static int prism2sta_getcardinfo(struct wlandevice *wlandev)
 
 	if (hw->cap_sup_sta.id == 0x04) {
 		netdev_info(wlandev->netdev,
-		       "STA:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "STA:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	} else {
 		netdev_info(wlandev->netdev,
-		       "AP:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
-		       hw->cap_sup_sta.role, hw->cap_sup_sta.id,
-		       hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
-		       hw->cap_sup_sta.top);
+			    "AP:SUP:role=0x%02x:id=0x%02x:var=0x%02x:b/t=%d/%d\n",
+			    hw->cap_sup_sta.role, hw->cap_sup_sta.id,
+			    hw->cap_sup_sta.variant, hw->cap_sup_sta.bottom,
+			    hw->cap_sup_sta.top);
 	}
 
 	/* Compatibility range, primary f/w actor, CFI supplier */
@@ -1189,7 +1189,6 @@ void prism2sta_processing_defer(struct work_struct *data)
 			inf = (struct hfa384x_inf_frame *)skb->data;
 			prism2sta_inf_authreq_defer(wlandev, inf);
 		}
-
 	}
 
 	/* Now let's handle the linkstatus stuff */
@@ -1241,9 +1240,9 @@ void prism2sta_processing_defer(struct work_struct *data)
 			/* Collect the BSSID, and set state to allow tx */
 
 			result = hfa384x_drvr_getconfig(hw,
-						HFA384x_RID_CURRENTBSSID,
-						wlandev->bssid,
-						WLAN_BSSID_LEN);
+							HFA384x_RID_CURRENTBSSID,
+							wlandev->bssid,
+							WLAN_BSSID_LEN);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result = %d\n",
@@ -1260,14 +1259,13 @@ void prism2sta_processing_defer(struct work_struct *data)
 				     HFA384x_RID_CURRENTSSID, result);
 				return;
 			}
-			prism2mgmt_bytestr2pstr(
-					(struct hfa384x_bytestr *)&ssid,
-					(struct p80211pstrd *)&wlandev->ssid);
+			prism2mgmt_bytestr2pstr((struct hfa384x_bytestr *)&ssid,
+						(struct p80211pstrd *)&wlandev->ssid);
 
 			/* Collect the port status */
 			result = hfa384x_drvr_getconfig16(hw,
-							HFA384x_RID_PORTSTATUS,
-							&portstatus);
+							  HFA384x_RID_PORTSTATUS,
+							  &portstatus);
 			if (result) {
 				pr_debug
 				    ("getconfig(0x%02x) failed, result = %d\n",
@@ -1404,7 +1402,7 @@ void prism2sta_processing_defer(struct work_struct *data)
 					       &joinreq,
 					       HFA384x_RID_JOINREQUEST_LEN);
 			netdev_info(wlandev->netdev,
-			       "linkstatus=ASSOCFAIL (re-submitting join)\n");
+				    "linkstatus=ASSOCFAIL (re-submitting join)\n");
 		} else {
 			netdev_info(wlandev->netdev, "linkstatus=ASSOCFAIL (unhandled)\n");
 		}
@@ -1501,7 +1499,7 @@ static void prism2sta_inf_assocstatus(struct wlandevice *wlandev,
 	if (i >= hw->authlist.cnt) {
 		if (rec.assocstatus != HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-	"assocstatus info frame received for non-authenticated station.\n");
+				    "assocstatus info frame received for non-authenticated station.\n");
 	} else {
 		hw->authlist.assoc[i] =
 		    (rec.assocstatus == HFA384x_ASSOCSTATUS_STAASSOC ||
@@ -1509,7 +1507,7 @@ static void prism2sta_inf_assocstatus(struct wlandevice *wlandev,
 
 		if (rec.assocstatus == HFA384x_ASSOCSTATUS_AUTHFAIL)
 			netdev_warn(wlandev->netdev,
-"authfail assocstatus info frame received for authenticated station.\n");
+				    "authfail assocstatus info frame received for authenticated station.\n");
 	}
 }
 
@@ -1674,9 +1672,8 @@ static void prism2sta_inf_authreq_defer(struct wlandevice *wlandev,
 			if (hw->authlist.cnt >= WLAN_AUTH_MAX) {
 				rec.status = cpu_to_le16(P80211ENUM_status_ap_full);
 			} else {
-				ether_addr_copy(
-					hw->authlist.addr[hw->authlist.cnt],
-					rec.address);
+				ether_addr_copy(hw->authlist.addr[hw->authlist.cnt],
+						rec.address);
 				hw->authlist.cnt++;
 				added = 1;
 			}
@@ -1697,8 +1694,8 @@ static void prism2sta_inf_authreq_defer(struct wlandevice *wlandev,
 		if (added)
 			hw->authlist.cnt--;
 		netdev_err(wlandev->netdev,
-		       "setconfig(authenticatestation) failed, result=%d\n",
-		       result);
+			   "setconfig(authenticatestation) failed, result=%d\n",
+			   result);
 	}
 }
 
@@ -1937,9 +1934,8 @@ void prism2sta_commsqual_defer(struct work_struct *data)
 
 	/* It only makes sense to poll these in non-IBSS */
 	if (wlandev->macmode != WLAN_MACMODE_IBSS_STA) {
-		result = hfa384x_drvr_getconfig(
-				hw, HFA384x_RID_DBMCOMMSQUALITY,
-				&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
+		result = hfa384x_drvr_getconfig(hw, HFA384x_RID_DBMCOMMSQUALITY,
+						&hw->qual, HFA384x_RID_DBMCOMMSQUALITY_LEN);
 
 		if (result) {
 			netdev_err(wlandev->netdev, "error fetching commsqual\n");
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
