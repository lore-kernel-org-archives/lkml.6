Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-377167-1520860824-2-10975373684474883589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520860823; b=BhW71b5zgyiX/CU3APUWjyviYX9SsbOge4sEjWe1+fNPp2Z
    15C2HymC+qyDqgBw87KSxlFFWngLaWkyNC7zMhmx44dvPhnKQBVp0kmXL1NpBGQv
    PxWb56Tql3i4YXBgV/u6JuT6H1e7eUvmVJOagTzWNypIIlDeF7rbZSQZCx/Wzg0s
    wgA5YqPRdUyrwStVkbjvCJ5UdILgNICel+GawOVGJJfHEbqE5UtCfd+POQJEWrZA
    VS+Dg/CPdMT+zKEVsO1ihdKlunVVvuThzvJwJWFS1bRAkjrq8pjXv5rsNTFVvxBQ
    ju6OwJ+sRsCXbCTfpVZz25rbcgBjg3eH1h39tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520860823; bh=N
    MsOCjynrPJxXp8LCxMIQ2SndqwsNjI6vjHF8fAfQ8M=; b=lPLR4NLfau8xHFvOS
    iTrKVqu1lCsns2/OYtYyXoXL4dAH2prNXZeTajfC6QwGiNDEJOkgFMxhZf4diCtr
    BIIBQGaEwBGZ/ij1Qgk0FHS+o0iqomESxHj4RcPZBNOvbRJ1Q8W2Y2QYMDvoMYlt
    +BEpL1wSjUiUrRyjLXariopWyjOUszANh3DbPIcn1YiYq6Oq9IR5zgi8yIRS5m2q
    CcjFRJ5G4TvBvuw8yyeO/SgDEBW1JgSh6d6whUHjW4vxkvq/HZccBk6hTdmJYAXo
    v7ofIazecWeRxs1Ln9JObE6PpWqUG0rJzDE9KbWdilWKwJgX+RaVl7KYxvdDrvNQ
    G3VKQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LKF7NGYK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L8dXYtl9;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LKF7NGYK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L8dXYtl9;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuxfr6GA5Td6PiPDwSYl2o7Dno6wQCNToPy4vYu31DYy+wvboAHA79yGVz/UmN18tY47ywvdQ==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com
Subject: [PATCH] staging: wilc1000: Destroy mutex object in deinitialization
Date: Mon, 12 Mar 2018 18:49:49 +0530
Message-Id: <20180312131950.12854-1-hariprasath.elango@gmail.com>
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com, Ganesh Krishna <ganesh.krishna@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Destroy the mutex object that is initialized in wlan_init_locks()

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/linux_wlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 1af3c14..38a83bd 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -678,6 +678,7 @@ static int wlan_deinit_locks(struct net_device *dev)
 
 	mutex_destroy(&wilc->hif_cs);
 	mutex_destroy(&wilc->rxq_cs);
+	mutex_destroy(&wilc->txq_add_to_head_cs);
 
 	return 0;
 }
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
