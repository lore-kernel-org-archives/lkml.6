Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-75009-1517772462-3-8927526843137888253
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
    t=1517772461; b=djalyfo3+H/+44joNyv3L5IWAQXMqwMr4ps1wyO9nc6PVNZ
    /4ZHFf8xDb7h9hizzSb9IgRICsyPtpz8CAJqqaz335tmeMEce4vGUv/cdHQWbKtH
    SVHb3icmtwLQhlli7eKEBiXBC8rkfcR6R5jCdHdCschRBJP8SDL//XEb42IYqYXX
    8VxH0lEHfQcPC05/fKPbuXZlsGkdy/Xjjj1LpRoTGOWXg9VaDxT0FoCYAA28SWM1
    nOBaFZaGp6FJaik9ZjwFX2T7ZSgMvVjTimNWC66qgqVNtrY65qL9vKapbIN7xr20
    paihI6oo3g/2FzBFT1bmy3tG2zxHNWxQcuX/4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517772461; bh=B
    kFoO36n+mGTnmJkyxuBm0Kzhl63CqHCJ1aQFbWLdpA=; b=uU34KVmHlhtAksaYx
    zGrF+2NVRuE02IrGk1ztmpUb/I9SStlkF7x77wFr+fh0bLSDWovbo2i7KiqT2J48
    EImz7Lp9sW/uagY4vQhGLZo5q/VNMyHRpEn3DDum3Jl1RdEENnni/5qIYpXM/hHe
    Kt1lIebO1/Q5JZYGrX1wvej8LDFbqIITzWxCNSprtRtWWsm3cS9+7KDLmq05KKyc
    BQJViEFgN3O+qkqajepQfHhq0FksBJntoTxcIZLxzCcZmyAdU7s/isfsLxrpUYTS
    QTtyDuFroTq/eOP0QYZvrYiJRNB6Au+s7+/1QBA7QTh03arkliPTud+HKAUPkT6H
    aMAjA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LMT/WhSc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=shYyeicE;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LMT/WhSc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=shYyeicE;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227M59eVYjV0vMfPKM1UIbhj+ht9/uUm/rxlS87FcPuY2YsfGDDMxmh3duls6Ryz07Ogay9KPw==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] staging:r8188eu: Remove struct pkt_file from
 update_attrib()
Date: Sun,  4 Feb 2018 22:27:37 +0300
Message-Id: <20180204192739.13202-2-insafonov@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180204192739.13202-1-insafonov@gmail.com>
References: <20180204192739.13202-1-insafonov@gmail.com>
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
Do not use struct pkt_file in update_attrib().

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 76b652648d3d..eb46e34ba562 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -408,7 +408,6 @@ static void set_qos(struct sk_buff *skb, struct pkt_attrib *pattrib)
 
 static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct pkt_attrib *pattrib)
 {
-	struct pkt_file pktfile;
 	struct sta_info *psta = NULL;
 	struct ethhdr etherhdr;
 
@@ -419,9 +418,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	struct qos_priv		*pqospriv = &pmlmepriv->qospriv;
 	int res = _SUCCESS;
 
-
-	_rtw_open_pktfile(pkt, &pktfile);
-	_rtw_pktfile_read(&pktfile, (u8 *)&etherhdr, ETH_HLEN);
+	skb_copy_bits(pkt, 0, &etherhdr, ETH_HLEN);
 
 	pattrib->ether_type = ntohs(etherhdr.h_proto);
 
@@ -442,16 +439,17 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		memcpy(pattrib->ta, get_bssid(pmlmepriv), ETH_ALEN);
 	}
 
-	pattrib->pktlen = pktfile.pkt_len;
+	pattrib->pktlen = pkt->len - ETH_HLEN;
 
 	if (pattrib->ether_type == ETH_P_IP) {
 		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
 		/*  to prevent DHCP protocol fail */
 		u8 tmp[24];
 
-		_rtw_pktfile_read(&pktfile, &tmp[0], 24);
+		skb_copy_bits(pkt, ETH_HLEN, tmp, 24);
+
 		pattrib->dhcp_pkt = 0;
-		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
+		if (pkt->len > ETH_HLEN + 24 + 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
 			if (pattrib->ether_type == ETH_P_IP) {/*  IP header */
 				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
 				    ((tmp[21] == 67) && (tmp[23] == 68))) {
@@ -510,10 +508,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE|WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
 		if (psta->qos_option)
-			set_qos(pktfile.pkt, pattrib);
+			set_qos(pkt, pattrib);
 	} else {
 		if (pqospriv->qos_option) {
-			set_qos(pktfile.pkt, pattrib);
+			set_qos(pkt, pattrib);
 
 			if (pmlmepriv->acm_mask != 0)
 				pattrib->priority = qos_acm(pmlmepriv->acm_mask, pattrib->priority);
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
