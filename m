Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2403634-1520922083-2-16992395886819041329
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520922082; b=vqO3+ybD0hHxKhwxhS5To8aDSz7RVpcc1fwndgIkGn6U7q4
    gdjW9a2TnOxO//H4C4gFadBkkWtYnm78xa5imUdUBbcrGERqGb0y+xJb7gyIpeCY
    IDl56D2SnGB2wRhmjSe2u+IuqOF+iQd2x82hj692YyZNIfhCWs/lEkEVdoy7Qs+2
    XcZKjKo/3uWgE8iOuJkDcnNIAtsG5HnwZ1VVw1Zx+pgi0JFl4C/yxK1EYiGTYzww
    aa7ZrIE0JjScY9NGkKGqc78rdhrwaOfKblTDSde9Z2hkTaIMZYrH5KDDOdUbAb8r
    2fwhk4ZuPnzw6z2EJF3yuQxmxne4+N2RmfdliWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520922082; bh=0
    tzcKixFNY/5SeGGlI8+BIJ4Du+qXaipxKB8knhigXY=; b=ht6vYCkeD9SETXVrx
    0g9rBgPhUVaDa2P/4hy58ih4iu8xtLRZt2ooIbwvUQBYwlNhEfSbLn1o2+yCks0+
    4ot4FctrgLBLCeJ2D7/2ioN+hcPMEuNVgNFjt5t4FKDpJH7GAGohS/w19fW7ANPG
    8AQhxZnZNuUhE/JdfWK0/GVkQhpLwKCjGdIqThd8HD0649Y8ZvNG3T3vF8JHvvj0
    Ugx7VXhixN/KfKG+30bY7dlxVeYyKu1+H4KOfhML7A27D2TA18cuZLj/BlBe2uHT
    iJqPcFkCSd2uf47H5z75JBojQ5IIDXNeLCRy+6ncSsn4NtkuMFSAVvkm5Qjg1kTG
    ryK5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QRq+0ZxZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CpaRq+tS;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QRq+0ZxZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CpaRq+tS;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvrHK03stETomPPI6d8gYOMn3hsQcqmuHhBwqavbfMZZ9KNshcZkwhoCzBaKENKWRykE4aGoQ==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com
Subject: [PATCH] staging: wilc1000: use kmemdup instead of kmalloc and memcpy
Date: Tue, 13 Mar 2018 11:50:48 +0530
Message-Id: <20180313062049.6200-1-hariprasath.elango@gmail.com>
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

Kmalloc followed by memcpy can be replaced by kmemdup.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/linux_mon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc1000/linux_mon.c
index f93f411..c6fd6b3 100644
--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -146,7 +146,7 @@ static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
 	if (!mgmt_tx)
 		return -ENOMEM;
 
-	mgmt_tx->buff = kmalloc(len, GFP_ATOMIC);
+	mgmt_tx->buff = kmemdup(buf, len, GFP_ATOMIC);
 	if (!mgmt_tx->buff) {
 		kfree(mgmt_tx);
 		return -ENOMEM;
@@ -154,7 +154,6 @@ static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
 
 	mgmt_tx->size = len;
 
-	memcpy(mgmt_tx->buff, buf, len);
 	wilc_wlan_txq_add_mgmt_pkt(dev, mgmt_tx, mgmt_tx->buff, mgmt_tx->size,
 				   mgmt_tx_complete);
 
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
