Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2132234-1518983550-2-16729516789952956150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518983549; b=U+vyLAbK9ygLDCNw5TrHjfOZ73QkLIQtyW8qrZzSKavtl9K
    shRKpJTKalL+30e/GOTnw1m20F7GQCZ5oFyeqmOe6d0Cb9xmUf3vf4RtnCir9A23
    nmPhnrYSLGB/mgZExp4Y881JkXWf0QlsKa28KcV80WaSl7f2HYSwbPjT6t4b7CaM
    Mknp5U7qvLVv4eB5WqS+uvr+xzoQzHgBTUXR1634ejXE57GsnjFuVajrBd4H/wvt
    ZwkjlqkBnc8qio+lNuggWM0kAlruors5PC3b0QX6IJK/PmjQ0TUK1TlCIzT8ZGUi
    ny+wVYEKr2duDhCtBDtrPSb8Gq4XspGyDJ21RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518983549; bh=5
    PHOc6GPP6Hb54/qpoiVi01vgsBZjT/qj5uW6wV055c=; b=MiLfhVMFKETY3LId+
    Nu9bUaqbvEXVTm7uSzstufa/79Sr5ggqkVUA4e6Fn9h8HnL6yS7Qo6b2tCrlxkiR
    OjGG9cTlr1Sc3FfYmqqVinuns1NzqJmPB9dxzf9AorWixcjvj+G5VYcwvdHEZKpo
    /Vo+EPwnSm/bz+WLKLZxEHKGU0VpkuGtw9Ysbf3sWvCCDn5oF5PNxaBn24pGBJae
    K2O0L5cs9ywiPLkLJX7b1KySvQOTO9mgptMjpAyB1H+nshEmT4O4G8fb5wgqSR3o
    mjykYSZcPA4SpIKOLSRd+HBE4u9w6bXMtgJJVqj39OH0MfVoqgH9DIBt+k/XG+wq
    TR4Ag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ng4hGk5Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E9uu+EGc;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ng4hGk5Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E9uu+EGc;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225JVwo6ewhR/XQ2lgsfBKuFqmrGWIgkbudNtcm3tOmsW8QKQ5wYMIK1RY+dTC/P1WjAkakOZw==
From: Stefano Manni <stefano.manni@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com
Subject: [PATCH v2 1/2] staging: rtl8712: make unsigned length for
 rtl8717_get{_wpa_, _wpa2_, _}ie
Date: Sun, 18 Feb 2018 20:52:12 +0100
Message-Id: <20180218195213.12755-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.9.4
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Stefano Manni <stefano.manni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixed r8712_get_ie, r8712_get_wpa_ie, r8712_get_wpa2_ie
to have a length as unsigned int pointer instead of signed.

Sparse warnings:

drivers/staging/rtl8712/rtl871x_ioctl_linux.c:173:27: warning: incorrect type in argument 3 (different signedness)
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:173:27:    expected signed int *len
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:173:27:    got unsigned int *<noident>
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:613:35: warning: incorrect type in argument 3 (different signedness)
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:613:35:    expected signed int *len
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:613:35:    got unsigned int *<noident>
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1411:67: warning: incorrect type in argument 3 (different signedness)
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1411:67:    expected signed int *len
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1411:67:    got unsigned int *<noident>
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1992:33: warning: incorrect type in argument 2 (different signedness)
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1992:33:    expected int *rsn_ie_len
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1992:33:    got unsigned int *<noident>
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1998:33: warning: incorrect type in argument 2 (different signedness)
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1998:33:    expected int *rsn_ie_len
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1998:33:    got unsigned int *<noident>
drivers/staging/rtl8712/rtl871x_mlme.c:1701:59: warning: incorrect type in argument 3 (different signedness)
drivers/staging/rtl8712/rtl871x_mlme.c:1701:59:    expected signed int *len
drivers/staging/rtl8712/rtl871x_mlme.c:1701:59:    got unsigned int *<noident>

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c    | 8 ++++----
 drivers/staging/rtl8712/ieee80211.h    | 6 +++---
 drivers/staging/rtl8712/rtl871x_mlme.c | 3 ++-
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 9872703..612ccfe 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -107,7 +107,7 @@ u8 *r8712_set_ie(u8 *pbuf, sint index, uint len, u8 *source, uint *frlen)
  * index: the information element id index, limit is the limit for search
  * ---------------------------------------------------------------------------
  */
-u8 *r8712_get_ie(u8 *pbuf, sint index, sint *len, sint limit)
+u8 *r8712_get_ie(u8 *pbuf, sint index, uint *len, sint limit)
 {
 	sint tmp, i;
 	u8 *p;
@@ -211,9 +211,9 @@ int r8712_generate_ie(struct registry_priv *pregistrypriv)
 	return sz;
 }
 
-unsigned char *r8712_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
+unsigned char *r8712_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
 {
-	int len;
+	u32 len;
 	u16 val16;
 	unsigned char wpa_oui_type[] = {0x00, 0x50, 0xf2, 0x01};
 	u8 *pbuf = pie;
@@ -245,7 +245,7 @@ unsigned char *r8712_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 	return NULL;
 }
 
-unsigned char *r8712_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit)
+unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len, int limit)
 {
 	return r8712_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
 }
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index 68fd65e..d605dfd 100644
--- a/drivers/staging/rtl8712/ieee80211.h
+++ b/drivers/staging/rtl8712/ieee80211.h
@@ -738,9 +738,9 @@ static inline int ieee80211_get_hdrlen(u16 fc)
 struct registry_priv;
 
 u8 *r8712_set_ie(u8 *pbuf, sint index, uint len, u8 *source, uint *frlen);
-u8 *r8712_get_ie(u8 *pbuf, sint index, sint *len, sint limit);
-unsigned char *r8712_get_wpa_ie(unsigned char *pie, int *rsn_ie_len, int limit);
-unsigned char *r8712_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len,
+u8 *r8712_get_ie(u8 *pbuf, sint index, uint *len, sint limit);
+unsigned char *r8712_get_wpa_ie(unsigned char *pie, uint *rsn_ie_len, int limit);
+unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len,
 				 int limit);
 int r8712_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
 		       int *pairwise_cipher);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 7824508..ac547dd 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1725,7 +1725,8 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 {
 	u8 *p, max_ampdu_sz;
-	int i, len;
+	int i;
+	uint len;
 	struct sta_info *bmc_sta, *psta;
 	struct ieee80211_ht_cap *pht_capie;
 	struct recv_reorder_ctrl *preorder_ctrl;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index eda2aee..a8ae14c 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -717,7 +717,7 @@ void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len)
 {
 	uint	protection;
 	u8	*perp;
-	sint	 erp_len;
+	uint	erp_len;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct	registry_priv *pregistrypriv = &padapter->registrypriv;
 
-- 
2.9.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
