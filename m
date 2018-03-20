Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521546253; cv=none;
        d=google.com; s=arc-20160816;
        b=kDJmElF0SqxDCykpnIq8Osp4OZojSiXga4nP9LIk1QGXesF5GnCy8qEDkFbxd9gEPS
         RlJ2+Weq8a9RxFXk1cJ/cXDi+vlvE5C00jKqOzoJsnR1HdaKGDd1hJFA5st3uVbCA59x
         yUY+9u5oXWQiEZ+fMuHnwiVh9o94wzFm9pJralPWUjhIvwIlr/cXgGpQEK2wKAXw6Y/i
         dC0yinGCTZbRjw/6wzNflbIO24X5OkFUbLFmFOzdNaRIKSd6FniSlfWLQP4voAzjuzDN
         SKO8TaD8dnOvHUrjbT60yRxu+BderwAS8z2uuCh5d7yKgH+gAtdjKBNPUPLuD6q37Jp4
         mGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mvc/czDxJoE3A4GK7VdQ7LPGsKxQrxAVJDSLk2ytUWk=;
        b=soBBZW4vo3DRnoB0dwmrGXbESim+1DrI4S5xTWDSzep9V8ywqyHZqw7fUZjl2Ktzue
         IFVP3SbRIrYzNg3G50MwoA4wqQRf/SQ5xG2tiA/VwKRtR49MqkWD6XCvDQW1Sr+r0hgz
         DnSTjzZqp0DqPeV0HpuTeLaS/5wcoGdMk8QnOi0Sus0nP9WKV4gyfVmq+KWJf28Ns7Tu
         EdCcpWL7HRVLyiENwF0i/RVvuARa8pvmCopzU8HV6yoWHSKETeiz7OhdFGlyMe8eGa1v
         ZnU5JarMxtTX8P+NN2igQUUlM5IbO8WE1VOSNJhOTdGsXtnT9oOqK0sGrPJTAV38dj+L
         TlxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ezmCb7Bz;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ezmCb7Bz;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtJvLBM/RXoXCHxLJ7sDDirJJVXE8rSfbDZmcoZUtlEh2CttqQpa1xMqhY5tgE5ZQu81iEkqw==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com,
	gregkh@linuxfoundation.org,
	ganesh.krishna@microchip.com,
	dan.carpenter@oracle.com
Cc: gehariprasath@gmail.com,
	HariPrasath Elango <hariprasath.elango@gmail.com>,
	linux-wireless@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2] staging: wilc1000: replace switch statement by simple if condition
Date: Tue, 20 Mar 2018 17:13:31 +0530
Message-Id: <20180320114331.4084-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594917172280071605?=
X-GMAIL-MSGID: =?utf-8?q?1595456883721819850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

In this case,there is only a single switch case statement.So replacing
by a simple if condition

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 9d8d5d0..730d64f 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -776,14 +776,8 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (sme->crypto.n_akm_suites) {
-		switch (sme->crypto.akm_suites[0]) {
-		case WLAN_AKM_SUITE_8021X:
+		if (sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_8021X)
 			auth_type = IEEE8021;
-			break;
-
-		default:
-			break;
-		}
 	}
 
 	curr_channel = nw_info->ch;
-- 
2.10.0.GIT
