Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-841013-1524864965-2-12938324428667748052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  MISSING_HEADERS 1.021, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES roensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='io', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524864964; b=JY5xkPAzy/cwzSd2PwQ9/CXaljV9AP9zilRyTXKpuL+jh+dqGs
    /8XWMpJzOLbhSKb+8mopx/kbn6klkpqd9uAawyweKdDctg5rxKg/ALkubPMDATkv
    FwvQCucmAF9rH6jLNLc4RmCsyCBzdkUjEg9ycX8qmr8e0myLReRzsWhEgX9FJoVa
    StYnBcOcfLfObS4/BNGyq2ibaLj5K3t3zMbq51k/tl7Gq47PF4aNiaLS2Dnywf/C
    8nZoCnkGX5Afvc9unI05a5ijAjblY25LYl5/2tsuj44FjNBtnz4IOWCIrV+AB2Vu
    BMpzh4uTpvnZjQ6xC5uxbFMiiK7wN/OoHjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:subject:date:in-reply-to
    :references:mime-version:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524864964; bh=+8AfF
    6EJmDHeHEa9J4bW9KxkImIHKqLR5PM4yoDRfrw=; b=fUTFO3X0/EL5eJtXRQ1kg
    W+vAO5elTnJ4GT99Xay5fZgXsKHqykaIRMeni47tDKqLxUG7fVivCm3sWb7esXkx
    SeQA4ZIuL4XlMQNoB4SuHDdqMqpGoV7WzvwupHAzMhJrdki27rQmnwLs/6BXKQ27
    5dglK+HGTzxjwiSNTJh+/RoOPIdcCVRt9A6IYn9lX65RbkLXzR9GY4BlUnTuPEB/
    JCBy1j4nBP4Zq8aHOIFNXLqjy3/0xBVN9Bo53nbbjjyk7k4TeEn7NmCmgryYRzFn
    d+C5XNMB1PxQuvCHpu4b3yUthUMGitKHBNtB16+j2hreg4x9sPkXkKIngAvgNCu5
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=elg.io header.i=xtrat@elg.io header.b=FAmPb3Re x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mailjet;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elg.io;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=elg.io header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-70 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=elg.io header.i=xtrat@elg.io header.b=FAmPb3Re x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mailjet;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elg.io;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=elg.io header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-70 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBRMb8+sisCaHiaQJmXZhi7VpGEZjThCfeOlDNKiTZvj7JPE10L6WS+sX7RvXiG9aZDBK7BeLElJ3CeVQpBafSWBaVgfQVX2Z7tVU85KB+klMNLvrxVR
    ekhTFEtkpoi7Wzciv5zbFGLcUDYhHwYByD747RY/DWAzxKkDd5RLbbIPl5DzOKOlTyDxILYjUjdBhEa+5F8hnwDy7bahSC7TidhMLGLwQAmkCSIRHyQKgqZo
    v9JZ5GKmaawaIhOKA4LCYA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=9cW_t1CCXrUA:10 a=kj9zAlcOel0A:10
    a=KqOhe5OoNmIA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=rIQ2OwTckwrSlP6gn0gA:9 a=5VaGLcz0iRVLOl0S:21
    a=M-emtaHh1vsXqJwo:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Message-Id: <2ac130bd.AMIAAAY8Aw8AAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa45e6@mailjet.com>
From: Efstratios Gavas <xtrat@elg.io>
Subject: [PATCHv3] staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Date: Fri, 27 Apr 2018 21:33:34 +0000
In-Reply-To: <20180427065801.GC4361@kroah.com>
References: <20180427065801.GC4361@kroah.com>
X-CSA-Complaints: whitelist-complaints@eco.de
X-MJ-Mid: AMIAAAY8Aw8AAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa45e6iwzYbqKbSeiyab7gc-i_0wAKs_E
X-MJ-SMTPGUID: c9be303c-cf30-48bc-b10b-5fee9da674da
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
 Christopher H Pezley <chris@pezley.net>, Efstratios Gavas <xtrat@elg.io>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>,
 Aviya Erenfeld <aviyae42@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Aviv Palivoda <palaviv@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed format/style issues found with checkpatch. No code changes.
Corrected alignment of variables after open parenthesis and line breaks.
Checkpatch now returns clean except for line over 80 char warnings.

Signed-off-by: Efstratios Gavas <xtrat@elg.io>
---
v2(unlabled): changed title info
v3: improved changlog description
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
