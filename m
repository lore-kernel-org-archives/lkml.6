Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtDzxodoES3DVYA75VBHwQGLcGK00SDvUX0SJWOBq2kDK8As4NmQXjhXTMWVuIbM03ggdhS
ARC-Seal: i=1; a=rsa-sha256; t=1522140089; cv=none;
        d=google.com; s=arc-20160816;
        b=pxDuw43grBEMtSbxiBodRxIbteWoMTNuQelena/Ykc9xitMVy4wWlCgbQJtU47cYyB
         bsJHf7aSWTMOwq+9qlytVWvBhDXshHNsNO5KIPBjdpx8LDsKJB2ItiNpWZoaA+tjHpMW
         0hXd/0KUfnCpn2gRhMUqQ6XiXPyZro6E9EFT6YRAFA8My2QAuanrMsg2ESNED+zRtN+J
         y699urG6Lp7sKpmg3vWsLfqKteer5t/xbcGPMgGygnsLF1I+QTCAWvCWSPOLEi9//qJN
         +qMcJs+el0PmWaTSOqvoOjmc9TDdpZPSPycSFy/vXuCZAJm/uSy+G25C8mtX0vaVcH3U
         XB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=yep0+AqQdcuI9089aCkD/7PYHi3zyhLb5npvsKZVo00=;
        b=JlJcY1YTjIm9ARenKZ/yDQZtP3GlhGPNCjiffDDqH/gWRT7dxloCNgoS/MKHRzH14U
         njXNapRu6zlfR+9OuldfjI4qdM0J7an4n4DGdedGJiYs0q31pRw4qlD2LDNM2m/mfaUt
         +MkAKK/J3cn+4mjuFZFPLmm/wiUfG7B5/MJ6JOnhTSqgQZGI4VjDTxmTsF0H3Mdj+E44
         rCJZVx98yWKS1KHRXARxnUR0JS6Nu7ySC/+0SGYoZHxLF07BQ1nXEncNQxLSWiXjblyX
         duChwNVLXd/kYy6UiuXsfFNlDgbQwg2meIn2FJRHjc9RERxewHmdFH9G9/rSlgjKSyXi
         B7rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 06/23] staging: rtl8723bs: Fix newlines in rtw_wx_set_auth().
Date: Tue, 27 Mar 2018 01:40:58 -0700
Message-Id: <20180327084115.16129-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:c7Ubac/LopRjIIzcn0QyJhWwU5mnic8oqvqnDw6+owVVb3qvIU7
 xXTuJmvVCiKIk1wTUWMvRgsS29kTX9Lq2IMXmGnrMMlBS4mW+GaOpZjEWryN8o/VBBhY41k
 FjaBRg9f0u0qkRr8/mnzBdI3oS0UTbWMZ89Fan63QkspsEonqER18nF/bxfVlXmmDvYWfv5
 agqScJhajl4AaN1kLwyGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OooL7in832A=:VAbJPaUPGoOb9B5Aoxp7ao
 rpG/EB3paT2RAAEgDZBW0o0oY2HgaIg9FQgkF2x0gerb1zC/4tYBYm4doVy6bnihgqintYRg0
 reUbiR9D2qTNiI2PfH2dsKXUc8dVNar3sPCbJOvqR7vjQ/34nwOFqHqlnQ1fkaJ4FZZXnuuvJ
 9XxZLRYHFHJIj0SYs+AVBO9zWs8B0dXS1XukUQ/cwCLg9w7jwxxCVxL5uuiZVTrOFd0Sj2s1d
 2umtBEAQOtA06Y6cwahsgDwfJKwCmPLtM+xkePh1RA1gcOjxJv7JEqu5Tqi06RB9uDn896Bl5
 npuKqNcgNA7OamhPbg4h6SV7xcY835uWm+KPP4Dd0tkzkBmaetXOPLfuPRLRtDlA/EdEOsQKB
 34VJcTjqEp1L4t0lwPILY7PWEpq5lsHqf/ZEuXGgvS2bc4ugRg+JpAPHcYaJENpJWUiX9zGfp
 qqDs5m12WU24njPUJ1NalPIrO43OIuEZheOOgVIlWp0jl5nYMYTBYMKUc5E1LclabgCioRmKn
 cFDmjZpqTBHQMs3ZEyBseSzDdwHoaiEcarsTWby+m0tBgxLgP7CwfjwSmQRpcFIO2mtS2JW2k
 gRuV9/w9gM1LVsrZV7UBieggVPXoTuUsqTJ3n3P99MzzYV2Jn385mtJ+Bo6OuFrnjh5S3uJm5
 ovwViBmyMhNv88arqRDIsu5xDoA2xJvr3Trs2nCSyUkWjZbB2YFBq1U5NzMrtXpvgqFeGotlx
 /uigdtTz4CnGaIRj4+6Y4EUlk1f4UPoOkv3XeQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079567066113604?=
X-GMAIL-MSGID: =?utf-8?q?1596079567066113604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are a lot of extra newlines in this function that waste space.
Remove those newlines, but add one newline before the return statement.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index bf437c825733..1b458074b7f9 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2139,21 +2139,17 @@ static int rtw_wx_set_auth(struct net_device *dev,
 	int ret = 0;
 
 	switch (param->flags & IW_AUTH_INDEX) {
-
 	case IW_AUTH_WPA_VERSION:
 		break;
 	case IW_AUTH_CIPHER_PAIRWISE:
-
 		break;
 	case IW_AUTH_CIPHER_GROUP:
-
 		break;
 	case IW_AUTH_KEY_MGMT:
 		/*
 		 *  ??? does not use these parameters
 		 */
 		break;
-
 	case IW_AUTH_TKIP_COUNTERMEASURES:
         {
 		if (param->value) {
@@ -2194,9 +2190,7 @@ static int rtw_wx_set_auth(struct net_device *dev,
 
 			break;
 		}
-
 	case IW_AUTH_80211_AUTH_ALG:
-
 		/*
 		 *  It's the starting point of a link layer connection using wpa_supplicant
 		*/
@@ -2208,11 +2202,8 @@ static int rtw_wx_set_auth(struct net_device *dev,
 			rtw_free_assoc_resources(padapter, 1);
 		}
 
-
 		ret = wpa_set_auth_algs(dev, (u32)param->value);
-
 		break;
-
 	case IW_AUTH_WPA_ENABLED:
 		break;
 	case IW_AUTH_RX_UNENCRYPTED_EAPOL:
@@ -2222,6 +2213,7 @@ static int rtw_wx_set_auth(struct net_device *dev,
 	default:
 		return -EOPNOTSUPP;
 	}
+
 	return ret;
 }
 
-- 
2.16.3
