Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3086335-1520945398-5-10278891755122190600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520945397; b=Yppoy+oooE/RR9g2HFbVQpzez2R0pONC7ui0Ri6famn1ktI
    QiZe0l2HNwovc5lXzrvwIO07+uiLioIgUqz7xCiybZ8YeOZJcfF32S73YubJT6He
    H5z8DrgzcugBOamh8hl2RwautdIo4c0nwryx0R/stgkKvDQCXrdJW5/HQ8lFykRm
    DtW09iw9tU4BeRpIloO3NDTm6lFW4bai0vBOpCC/La0X2tiMxDYNA7atKA5zBsFF
    8ooIDOh5jLL16jy1WDCtQXeZmsELrlVYEQr+7GSVyJTCM4UqidXQKzRPYwYAPfHi
    t9v1fa2sw00+e72TAvuQ8XeeKzfZFwU05WqjkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520945397; bh=k
    N0U61BzISX7124beJUeKC2S5qt2rWIzp53wN3AbvCY=; b=ZWd1kTwZW4E7OdCNj
    zHCsXcgiMhCeC6zCkyberPopIUBnNYJA2Xkgr9UeQhOZppI9W8zK28NHzkRa9ueD
    2nj2+N65RouCk/yMZMRvLOujCwm+hrd4X7jsuAxjONotWR1iDfGq76foZNas52Ta
    mTVv3JnegqEf32OKPHy/WLYz2m5o1fbkgANGu6hmSVZtD3+HVN0Pf7lYO2Vf7YP5
    42FwqJmd6Puz+mXjSzOuJG+WguxLYMwvKwtvvpbGqx9YwmbyIMOHX5P4vQZQGH10
    Kk50LVWmYwU7pYr+Mi7KLDkp2BAcIJf9QkPxitQHc9BRjeIA4K64lIFkXAvqE7aq
    ad0Mg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kYj6iNdz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tb/JiFxE;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kYj6iNdz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tb/JiFxE;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtc81EAZMnA4E8GsBM6dE2vGQelw4x2OZzGrHDR6ZFg0auI8PqVuwlM+wMflKs1fRVdE/WHbw==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com,
	ganesh.krishna@microchip.com
Subject: [PATCH] staging: wilc1000: use kmemdup to replace kmalloc/memcpy
Date: Tue, 13 Mar 2018 18:19:32 +0530
Message-Id: <20180313124932.15038-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

kmalloc followed by memcpy can be replaced by kmemdup.Also added the
related error handling part

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index 0fac8e1..4ae2da6 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -992,9 +992,13 @@ static s32 handle_connect(struct wilc_vif *vif,
 
 	if (memcmp("DIRECT-", pstrHostIFconnectAttr->ssid, 7)) {
 		info_element_size = hif_drv->usr_conn_req.ies_len;
-		info_element = kmalloc(info_element_size, GFP_KERNEL);
-		memcpy(info_element, hif_drv->usr_conn_req.ies,
-				info_element_size);
+		info_element = kmemdup(hif_drv->usr_conn_req.ies,
+				       info_element_size,
+				       GFP_KERNEL);
+		if (!info_element) {
+			result = -ENOMEM;
+			goto ERRORHANDLER;
+		}
 	}
 
 	wid_list[wid_cnt].id = (u16)WID_11I_MODE;
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
