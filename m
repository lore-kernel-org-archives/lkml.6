Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-75009-1517772454-5-11274311555446503146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517772453; b=oR9njEg+CHM6qG77lp9QHHcgqsOPj0etcwLIDjAkxIHPEcW
    rf9MF0gckAvFhmkPe6cLuNDHHjF2eD4Y+7TBb1qrk7QvHHBBYydM2iwY6bkSfTGF
    JoZKQjwHT+FISNbQA//GNW22YdY2yxDnXFUYm9QrGwJcfHTPkd3UtKVL5GYBDi1L
    vyrjU/CH1a+YusxzO1K5fD5LLEmRNLRyKQMWE5a3r6wdp285EQ+4LS/M0La28ffs
    fO61883fYJWR5chCUhpMb6/5aYiwso/0ScQdf8embSHN2TIjrbzVQWaHPqSdgOL1
    ElpOXYOqgWLgQD1BMo5aSTUogpmupA2oFpX8xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517772453; bh=R
    b9+Pz2C62pirXEfjrWIFHuIea9+Jgiu0YGaqqlMLiI=; b=DCv7cljOHmqQnqQS1
    0rZmydUVJE51QC6Yfmy08besvwXyMYQz/j0mXNYlEcYqu0pM3BfH+BGWfWldRO1c
    4P1KmQiszLWynw88phvB0U+VhhL7KGZdnbsYimdaTNHF+kO10/O091ENUHvgcvR3
    q364FLsjQcWdX+M2XE7qYmsYTwD0F4dEADKrRZPRHM0KMI7/aauY6SpV08rCLd8m
    BTRa8l1zCBhM/22YcG0I79xwtn6MkI6BXjmqNZd5FR9xgIW2oZR9sqyVP3I8DwZf
    mda5M89/FPVardTUqMpZTo9g7XoS/ddRZnYeIB773bBJL4F2FElB9NJbI1uzJtbF
    UFJFQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mxOXsmek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JuGT1LbZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mxOXsmek x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JuGT1LbZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2278nJMMeaAbluKb3A5XYnSzzrqGQpGbAqCb7lsDX9m7kD2Z/wUP+5qhvscmUZn9IPDiozqLUQ==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] staging:r8188eu: Remove struct pkt_file from set_qos()
Date: Sun,  4 Feb 2018 22:27:36 +0300
Message-Id: <20180204192739.13202-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.13.6
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
Cc: devel@driverdev.osuosl.org, Ivan Safonov <insafonov@gmail.com>,
 linux-kernel@vger.kernel.org, Gargi Sharma <gs051095@gmail.com>,
 Julia Lawall <julia.lawall@lip6.fr>, Janani Sankara Babu <jananis37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Struct pkt_file is a base to simple wrapper for skb_copy_bits().
Use skb_copy_bits() without wrappers.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index e8d9858f2942..76b652648d3d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -387,27 +387,21 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 	return change_priority;
 }
 
-static void set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
+static void set_qos(struct sk_buff *skb, struct pkt_attrib *pattrib)
 {
-	struct ethhdr etherhdr;
-	struct iphdr ip_hdr;
-	s32 user_prio = 0;
-
-	_rtw_open_pktfile(ppktfile->pkt, ppktfile);
-	_rtw_pktfile_read(ppktfile, (unsigned char *)&etherhdr, ETH_HLEN);
-
-	/*  get user_prio from IP hdr */
 	if (pattrib->ether_type == 0x0800) {
-		_rtw_pktfile_read(ppktfile, (u8 *)&ip_hdr, sizeof(ip_hdr));
-/* 		user_prio = (ntohs(ip_hdr.tos) >> 5) & 0x3; */
-		user_prio = ip_hdr.tos >> 5;
+		struct iphdr ip_hdr;
+
+		skb_copy_bits(skb, ETH_HLEN, &ip_hdr, sizeof(ip_hdr));
+		pattrib->priority = ip_hdr.tos >> 5;
 	} else if (pattrib->ether_type == ETH_P_PAE) {
 		/*  "When priority processing of data frames is supported, */
 		/*  a STA's SME should send EAPOL-Key frames at the highest priority." */
-		user_prio = 7;
+		pattrib->priority = 7;
+	} else {
+		pattrib->priority = 0;
 	}
 
-	pattrib->priority = user_prio;
 	pattrib->hdrlen = WLAN_HDR_A3_QOS_LEN;
 	pattrib->subtype = WIFI_QOS_DATA_TYPE;
 }
@@ -516,10 +510,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE|WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
 		if (psta->qos_option)
-			set_qos(&pktfile, pattrib);
+			set_qos(pktfile.pkt, pattrib);
 	} else {
 		if (pqospriv->qos_option) {
-			set_qos(&pktfile, pattrib);
+			set_qos(pktfile.pkt, pattrib);
 
 			if (pmlmepriv->acm_mask != 0)
 				pattrib->priority = qos_acm(pmlmepriv->acm_mask, pattrib->priority);
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
