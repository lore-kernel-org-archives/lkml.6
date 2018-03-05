Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1041060-1520235217-2-14919579481268522647
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520235216; b=opHFVSHkJpvbNW7ieUjAVXbVjMFgLAguhITH1HPtvq448Bh
    /vn5PX2YHsKPVXdm4YvQ7jWPEdrWWFfc+hCdhUd2hkgIumyrBJ0y6HITEgkjr1pv
    PAsrqXm6RyLD/gxG839OerUbN+of3I5uBXz4lVwP3VBQvR4gO7GcXuM2/uj22M4X
    xrw/vcEw/qSE0zD282BapWEMCD7b7NgJKivmw7cpKK6OAo+Im0ZZ+4j40MjCXq1R
    rckDrAdKaHGJjkIPScp+R+0rLm+7X7ricJ+OK7y3Jf0FpkmSkiuLJxZUsRSSsj1E
    1ihxX/IXFn0O4QYrUbOcIMLBoLGkLYoY50gWH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520235216; bh=i
    rApBYG7XRId8T3UMjA+t2q8RXYGNamukEkoEk7ClyU=; b=M0WfQpmOZUAnp3bW7
    ALLZ7MTzgitqk4K/VK/+QbhKsMnyo0qKVl4oZaHHWy1zCRvXsBDX9x81TNn/0iTd
    0qlz2cuBfPAaJng60BKE1nTHmtnbe/WMumTZVAuEhlhTOG+6/Ui5SrO1qxBEJCZ/
    M05rRBwgIXcTPUC/gaq3BOlIl2wQEOHoI1yu1EYp5b3W8wtBDEc/bpHRSdwfK5A1
    zxWtXzcAqxzHSvtKLpcGy9O2kar1w6JDkQNXlOcqpql0fIWysW2K+DlYh8/gXalh
    9LmZEX4vKtlqNATqkLo5/GktEQLtiMiFPF7Y+znrtxBm8q4/UAupvYWu2AQosTiH
    hsEZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T+75hort x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lzgy0qiH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T+75hort x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lzgy0qiH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELukFEHaHNWEU4PzP64rGE2hFD2noDmnwQ1HzVKkOaRXiD95595e7H2ZZfINhDufJ/EQg4cFVw==
Date: Mon, 5 Mar 2018 13:02:56 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2] staging: rtl8192u: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180305073256.GA4347@seema-Inspiron-15-3567>
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
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace printk having a log level with the appropriate
net_*macro_ratelimited.
It's better to use actual device name as a prefix in error messages.
Indentation is also changed, to fix the  checkpatch issue if line is not
exceding 80 characters.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
*change the subject line, in v1 driver name was wrong.

 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index e6648f7..200fe5f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
 
 	priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(priv->tfm)) {
-		printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
+		net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
 		priv->tfm = NULL;
 		goto fail;
 	}
@@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	keyidx = pos[3];
 	if (!(keyidx & (1 << 5))) {
 		if (net_ratelimit()) {
-			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
-				hdr->addr2);
+			net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
+					    hdr->addr2);
 		}
 		key->dot11RSNAStatsCCMPFormatErrors++;
 		return -2;
 	}
 	keyidx >>= 6;
 	if (key->key_idx != keyidx) {
-		printk(KERN_DEBUG "CCMP: RX tkey->key_idx=%d frame keyidx=%d priv=%p\n",
-			key->key_idx, keyidx, priv);
+		net_dbg_ratelimited("CCMP: RX tkey->key_idx=%d frame keyidx=%d priv=%p\n",
+				    key->key_idx, keyidx, priv);
 		return -6;
 	}
 	if (!key->key_set) {
 		if (net_ratelimit()) {
-			printk(KERN_DEBUG "CCMP: received packet from %pM with keyid=%d that does not have a configured key\n",
-				hdr->addr2, keyidx);
+			net_dbg_ratelimited("CCMP: received packet from %pM with keyid=%d that does not have a configured key\n",
+					    hdr->addr2, keyidx);
 		}
 		return -3;
 	}
@@ -306,8 +306,8 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	if (memcmp(pn, key->rx_pn, CCMP_PN_LEN) <= 0) {
 		if (net_ratelimit()) {
-			printk(KERN_DEBUG "CCMP: replay detected: STA=%pM previous PN %pm received PN %pm\n",
-			       hdr->addr2, key->rx_pn, pn);
+			net_dbg_ratelimited("CCMP: replay detected: STA=%pM previous PN %pm received PN %pm\n",
+					    hdr->addr2, key->rx_pn, pn);
 		}
 		key->dot11RSNAStatsCCMPReplays++;
 		return -4;
@@ -341,8 +341,8 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 		if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
 			if (net_ratelimit()) {
-				printk(KERN_DEBUG "CCMP: decrypt failed: STA=%pM\n",
-					hdr->addr2);
+				net_dbg_ratelimited("CCMP: decrypt failed: STA=%pM\n",
+						    hdr->addr2);
 			}
 			key->dot11RSNAStatsCCMPDecryptErrors++;
 			return -5;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
