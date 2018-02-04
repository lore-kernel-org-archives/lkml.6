Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-75009-1517772458-2-8277841729162186622
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
    t=1517772457; b=wINDrcae4+zLIlfak4OMfckzj6b3//P9tEzvpsCyexrs21k
    5WTeUQWkK7objykuh82XjYHGPhCBEiGASYBdLQmoPhc/duvobtVJxyzOOJtbOH9i
    Df7RxHJr00bZzeDNtNXxTBlt/gicNkec31UXx+T9AU3mnOuNXLZApHeQdeSFGimR
    3p/RYmNcTtKqXkGpcqAbGpPtbvlxnpgdnpM97yAp5TntLSsiAOCTGPnWKfeLg/2m
    vsqayfaAP+o6uaCiGvihTiRHNmt/OkEGVaCaJ2bIdj4Cn4Km59OHny4oQopl0H7d
    j03KYyGR1LSaHkfxNBzuURwGYGOteBIJ53gu55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517772457; bh=o
    jHg4zX63ag5Sug1SGT/AP7DjzwWTGTl6o8qjX3zfqw=; b=l0qpgKnbKy3oribtQ
    OwVp899KUZVEUMLFSInu5bJuyrk1UsTRYmtcLcy11j01srOsjK3BNn3Q6STkLms/
    60Pzion++Pnjv9MT/aSXd8QH7OIBHYknQ4gVtDfA8Nagxaf5AH8lZj9Q8DwAuMxk
    mVtvl+2dutiMqcOY6x5wbhQpPSa5V3XGbGpnnByKeH6t9sD2caTjc3MEnrRf/Wl5
    mFlymCdx7TGzuoaD4SK2vvsrQkKhMWno7IzmOVr7YeYCmM09tvMOiwjLZr+zI8a7
    MWZCkZFpuJ78gdFlayjPwZBXaUFBKbXRdQt3tX+ArEDJSKtc2GxQ2l1SREoRQsBK
    m8Drg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nYD8PX7o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BPDYWqfr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nYD8PX7o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BPDYWqfr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227A9GTQHL/EbtSqtT0EIjgikbe3Hv0UO0QLH78hmgT7FOQugrsks7RR4niZXpaiyrt3pKENAQ==
From: Ivan Safonov <insafonov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] staging:r8188eu: Remove unused struct pkt_file
Date: Sun,  4 Feb 2018 22:27:39 +0300
Message-Id: <20180204192739.13202-4-insafonov@gmail.com>
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

Struct pkt_file is unused now, so remove it and correponding functions.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/include/xmit_osdep.h | 13 ---------
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c  | 37 --------------------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/xmit_osdep.h b/drivers/staging/rtl8188eu/include/xmit_osdep.h
index 959ef4b3066c..00ebad88f0d1 100644
--- a/drivers/staging/rtl8188eu/include/xmit_osdep.h
+++ b/drivers/staging/rtl8188eu/include/xmit_osdep.h
@@ -18,15 +18,6 @@
 #include <osdep_service.h>
 #include <drv_types.h>
 
-struct pkt_file {
-	struct sk_buff *pkt;
-	size_t pkt_len;	 /* the remainder length of the open_file */
-	unsigned char *cur_buffer;
-	u8 *buf_start;
-	u8 *cur_addr;
-	size_t buf_len;
-};
-
 #define NR_XMITFRAME	256
 
 struct xmit_priv;
@@ -43,10 +34,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 alloc_sz);
 void rtw_os_xmit_resource_free(struct xmit_buf *pxmitbuf);
 
-uint rtw_remainder_len(struct pkt_file *pfile);
-void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
-uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
-
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
 void rtw_os_xmit_complete(struct adapter *padapter,
 			  struct xmit_frame *pxframe);
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 8bf8248e4ac7..8ac9567c954d 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -22,43 +22,6 @@
 #include <xmit_osdep.h>
 #include <osdep_intf.h>
 
-uint rtw_remainder_len(struct pkt_file *pfile)
-{
-	return pfile->buf_len - ((size_t)(pfile->cur_addr) -
-	       (size_t)(pfile->buf_start));
-}
-
-void _rtw_open_pktfile(struct sk_buff *pktptr, struct pkt_file *pfile)
-{
-
-	pfile->pkt = pktptr;
-	pfile->cur_addr = pktptr->data;
-	pfile->buf_start = pktptr->data;
-	pfile->pkt_len = pktptr->len;
-	pfile->buf_len = pktptr->len;
-
-	pfile->cur_buffer = pfile->buf_start;
-
-}
-
-uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
-{
-	uint	len = 0;
-
-
-	len =  rtw_remainder_len(pfile);
-	len = min(rlen, len);
-
-	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len-pfile->pkt_len, rmem, len);
-
-	pfile->cur_addr += len;
-	pfile->pkt_len -= len;
-
-
-	return len;
-}
-
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
 	int i;
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
