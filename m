Return-Path: <macfij7@wp.pl>
X-Google-Smtp-Source: AH8x225WUtd0wbifCDbMqM9JtIRLIAxtz5lyEM6L6nzU/H+F2ReK21w+Mt3kt3ge6DTA5x4y3qND
ARC-Seal: i=1; a=rsa-sha256; t=1518480199; cv=none;
        d=google.com; s=arc-20160816;
        b=XmYZWh4Z/qDI09wlNERLYnpewP9dXGCV9JqO6BXUAqrrrQFHoXRpZ47dDaxdyR2d8g
         EpZkCqH7/K+BDXyUIcYT/ZTvLR6JRgVA20w/pvnRncwA9kyQBpAqr1+Ab5icrTtSK7n9
         hsckkMe8xmk476OkfTzP55mZPGB5dr7/7tFffRNkwKFb0bb0fVzj1XwLylX1yabG/SfK
         1eGd2ggBowXqxm0371VC8dssd42yttMGJuU9AavUszZQzWa0Nmbt7f9Bn/8fQO9LWlat
         4xL58H3RVBrdfbn14sar1+OBwMCqLdp8+GcoLmc3NQZ+CTaRS2OlrPrAEoeRCekCGCrG
         TAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=vZ/TQn+ZP5+wDZ3o26f1BGMEU09eVjH9mM5AzIE6uhM=;
        b=sgckHHdXuU4uBk1kSMwz536Cv0zxA9yUi2bpJ8fQ7JqVz+E0L7FDoJtXQ35mpW+Mbn
         oHQthC8iWC6YeY78VMyA95Q1kAQPtDhSH21LEWGbJElNIZ20KO9mGXMeWfqQl8mCXKPP
         Y+xEjocAkSeo3P7O34BCXzq+E9BBV0OUJb22yCYLaeUWDN94Y9JNWHugapK+JuOBFxw2
         8m2gr9WkBLKbZCgDozMxCxmrHLEvDlNEy5TQ8o44pAMF/DE3qyCJEj3bVU9eXftyjJd+
         ZZ/4O5gSHVhgirBL9FuJKzmBE7Nwwok+CurBL28Jy+4s2zsabnF0hFCQjYcxGTjx+C4E
         YX8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@wp.pl header.s=1024a header.b=kaFxOpXt;
       spf=pass (google.com: domain of macfij7@wp.pl designates 212.77.101.10 as permitted sender) smtp.mailfrom=macfij7@wp.pl
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@wp.pl header.s=1024a header.b=kaFxOpXt;
       spf=pass (google.com: domain of macfij7@wp.pl designates 212.77.101.10 as permitted sender) smtp.mailfrom=macfij7@wp.pl
From: Maciek Fijalkowski <macfij7@wp.pl>
To: gregkh@linuxfoundation.org
Cc: aastha.gupta4104@gmail.com,
	hdegoede@redhat.com,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: make 'myid' function to follow kernel coding rules
Date: Tue, 13 Feb 2018 01:03:14 +0100
Message-Id: <20180213000314.27085-1-macfij7@wp.pl>
X-Mailer: git-send-email 2.16.1
X-WP-MailID: c183cff8a1238776d98c07ee0d139333
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [wZP0]                               
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241893459223114?=
X-GMAIL-MSGID: =?utf-8?q?1592241893459223114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Checkpatch.pl produced errors regarding inline keyword placement and
parenthesis around returned value in 'myid'.
Place inline after static keyword and remove mentioned parenthesis.

Signed-off-by: Maciek Fijalkowski <macfij7@wp.pl>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 32129ac8e169..16b81b1a3f33 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -692,9 +692,9 @@ int rtw_suspend_wow(struct adapter *padapter);
 int rtw_resume_process_wow(struct adapter *padapter);
 #endif
 
-__inline static u8 *myid(struct eeprom_priv *peepriv)
+static inline u8 *myid(struct eeprom_priv *peepriv)
 {
-	return (peepriv->mac_addr);
+	return peepriv->mac_addr;
 }
 
 /*  HCI Related header file */
-- 
2.16.1
