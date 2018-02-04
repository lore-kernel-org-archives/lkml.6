Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-75009-1517772462-6-15098412981773631545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517772462; b=GTRLet/hp9uhpS39YsP1viyO76AzRDJGc5WW/bNM54dv5I4
    ndZC8lVx47Tzn12essr7eJusXpnvUb4XyBBQMx3aIzb3RO6YdFI+MZ8cmuzXRvBy
    veggvQeRte+Jkfyybf9H7ctcvwaHc4QruqcZLCedF5570+BSbYcQGEJm5jiJwJDp
    9Ose3GHJUZtf41/F2dF2hca8cMmcZ9lgKh5h1jBSoO6dMB5UBI/cZ06YbBZkXGJm
    2QtlouSnhQhDXiwG3AbijfRKkL1Iuc6xB92Z8+cC+VLTgqHDt8/5+MD0RX8TW6vv
    TP52bpQ3220Ccrpc0y/ZHOZlav7Rac/nEdAIi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517772462; bh=L
    11C6akBcX6yqm04E2rXAIGzxe1I8/iKm3gEN8JN68o=; b=Z0U6VKHaq+ThyYCmS
    T/Vf25FRKjxY41Ch+xbCbGj8ibQmlhmwW1k/25zoysHLruXp1kydMqV7ukIjmR7w
    dmhdsdijHdrBJWXWJT+9FnWJ7MY0pfCzdjY428KwNehM7YTOUS71vFse5EAnvhyb
    3oSM7804Tz3kULBNNyKqh8b9xpQvw6/PsktxVSRaMwXVx+/kEklHFjG7+VhAOmKW
    svme1VN9hmBl/VNzOqWsDG3tjVKWLj0ubZmAmxRM25emhxpA8ERQ1LB6g3iXq+cR
    mOUz9ywaFFKC5DKa0cySS4U0y4c1qs6F6BPaWDfsieCtmu8NNMhS31AYv/VvIiyp
    LOHrA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IndGyXeJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p4yhcDeZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IndGyXeJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p4yhcDeZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226kBToetR0T3gNYpmJhd/1gvhvIfWYCP0A7lvqs/SJryN1nFUE4uP0GLU1n4UVuOxAYm180zA==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] staging:r8188eu: Remove struct pkt_file from
 rtw_xmitframe_coalesce()
Date: Sun,  4 Feb 2018 22:27:38 +0300
Message-Id: <20180204192739.13202-3-insafonov@gmail.com>
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
Eliminate struct pkt_file usage in rtw_xmitframe_coalesce().

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index eb46e34ba562..6b32c142fdcc 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -943,7 +943,6 @@ This sub-routine will perform all the following:
 */
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct xmit_frame *pxmitframe)
 {
-	struct pkt_file pktfile;
 	s32 frg_inx, frg_len, mpdu_len, llc_sz, mem_sz;
 	size_t addr;
 	u8 *pframe, *mem_start;
@@ -954,7 +953,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	u8 *pbuf_start;
 	s32 bmcst = IS_MCAST(pattrib->ra);
 	s32 res = _SUCCESS;
-
+	size_t remainder = pkt->len - ETH_HLEN;
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
@@ -979,9 +978,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		goto exit;
 	}
 
-	_rtw_open_pktfile(pkt, &pktfile);
-	_rtw_pktfile_read(&pktfile, NULL, ETH_HLEN);
-
 	frg_inx = 0;
 	frg_len = pxmitpriv->frag_len - 4;/* 2346-4 = 2342 */
 
@@ -1038,12 +1034,9 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
 			mpdu_len -= pattrib->icv_len;
 
-		if (bmcst) {
-			/*  don't do fragment to broadcat/multicast packets */
-			mem_sz = _rtw_pktfile_read(&pktfile, pframe, pattrib->pktlen);
-		} else {
-			mem_sz = _rtw_pktfile_read(&pktfile, pframe, mpdu_len);
-		}
+		mem_sz = min_t(size_t, bmcst ? pattrib->pktlen : mpdu_len, remainder);
+		skb_copy_bits(pkt, pkt->len - remainder, pframe, mem_sz);
+		remainder -= mem_sz;
 
 		pframe += mem_sz;
 
@@ -1054,7 +1047,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		frg_inx++;
 
-		if (bmcst || pktfile.pkt_len == 0) {
+		if (bmcst || remainder == 0) {
 			pattrib->nr_frags = frg_inx;
 
 			pattrib->last_txcmdsz = pattrib->hdrlen + pattrib->iv_len + ((pattrib->nr_frags == 1) ? llc_sz : 0) +
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
