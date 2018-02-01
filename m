Return-Path: <stefano.manni@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517512501; cv=none;
        d=google.com; s=arc-20160816;
        b=t7e6uTeXPA6S44sAFm+i84de5ozw+kUXb4mU365MPWO5qh3rXZG8Waee16OiHdJIc4
         Qkgl40I7JgHYCTY6/aM94dkfiyK/yyaGH/Kz4pUL34UBAONsiM0tSlCLOwEGVKU7xRkx
         usaS0KxBTs4mga4pp5SyY5hTE8KQ+btlkXq7GKvCNRyJCStTnvk02wpGV2quDYYBNYjJ
         SRs/ENyL1XlIzpJISYG93U7qUQWWBCMgCu/x+Xf85gpsCmoupcJAu0hMql7zUjR8NWcC
         XOzmY+I9K+A7ka7KBTUMGIO/sfWqeMywR5uX2DiwtNL+x25lR4Do8tKklAxJwjqrbebM
         ousQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=z+tzD0hKFUQz3KfcIOZgY/KMQ94UPTZ4Qj+XC7e8Svs=;
        b=d+lKMyOBwSrRRYyYPTTQk+jb12ZTMazRNHncHd4rNrZ7VpuRZhNvwUIq8fBVH8a5Pz
         7w9wI6LCpk75FaL55v0SyWXfHIxgJ0BxdNLPyAn3TV6tl2wWSc1TvL9sq5jh1afKN2Pp
         6WSb04nMJ3cg59LHCmzw3bb/9fc/aGYhjC6iEuqXW0XQFT4lvIjBoB1GUv+n4PIDKZG8
         Y99Y3Ujo/79cKxl16d2asOdHZwcomc5xsM7CNy9E4xJNuQh4PMmsGlm97+OHTfha4YuH
         LjXKuGQhunivCQgi3xPVkBdYto6RUoZJ1H+3CLdRtW+n+m84nhUFHozeomrza4o7cJtT
         ycmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dbGvuh5L;
       spf=pass (google.com: domain of stefano.manni@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stefano.manni@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dbGvuh5L;
       spf=pass (google.com: domain of stefano.manni@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=stefano.manni@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224QBOtrL7C7EVW60duR/hEqJCSzVgPcxLCp7crQ/P/FZr/baNHmQ9TGZsy+DQJ5BU5TnVrthw==
From: Stefano Manni <stefano.manni@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 1/2] staging: rtl8712: make unsigned length for rtl8717_get{_wpa_,_wpa2_,_}ie
Date: Thu,  1 Feb 2018 20:14:52 +0100
Message-Id: <20180201191453.4611-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.9.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591227189556789119?=
X-GMAIL-MSGID: =?utf-8?q?1591227189556789119?=
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
index 33e82a9dd462..35e29112006b 100644
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
@@ -210,9 +210,9 @@ int r8712_generate_ie(struct registry_priv *pregistrypriv)
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
@@ -243,7 +243,7 @@ unsigned char *r8712_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 	return NULL;
 }
 
-unsigned char *r8712_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit)
+unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len, int limit)
 {
 	return r8712_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
 }
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index 68fd65e80906..d605dfd02200 100644
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
index 111c809afc51..215fa8999a80 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1728,7 +1728,8 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
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
index eda2aee02ff8..a8ae14ce6613 100644
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
2.14.3
