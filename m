Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1630703-1521031556-2-15002172606804524597
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
    t=1521031555; b=lpLum5kNx4yfs0WEYKMUu8S4i5l2DnspHA6Doabm1etZxjt
    Kb0yMQEJfADPQ+bJvn3whQit0WLbFw+3I8zNu9ZXnMOGl1Qe7A770C+Ku9Ktka00
    NTfwgqe4wDaNSebooFjLRGZ+k51JFO13dLyblHFgHtSHMTelXI2I1XY355A99F0l
    mKwLuqxlRo8wEkc+QdF/36klP4YFa3n5NGs/I7+LiAZncLUqPiwEp294gxCaO2Qz
    kpxAPxaq/XM0dmnZ3Dxhs6ZyEiIrCrEfi74dCBbLbUb8qly2Zti4JPHbY60kCX/X
    SH4uJcKY5LvGJFvQnslg3F6Xpj3dO0fOs6VZScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521031555; bh=T
    c6VToFSLzW5aV6/U6c5VC/imSCL4k0GCYHf4irwjXU=; b=o8ZXiZx12qSuETUU4
    +8nJpe0YG5ZI3KWPXNYT7KANSza9a5HD3Orol4PdzGMZB94dV6t/qpLBWIeOf+9k
    tbCTwNlL2cMchTBzSiEsqRc8UUcs+G1bb1qAwW0ikcBhd04g9qNxJM9UugtFbfQJ
    Y/Otf+JcJxC9dP1RPJnXGASeB1GSK9KHgZkVc9qIBYOe1PA1sF6E6NfWvAcfhPqG
    Uz2AQoFrQaHMUOYxKg6dGpFPyvgu+xHPKjkXU5Aa8Pf1wUPNhElnOmUd5Lnqkww0
    jERyBTlpJvfkW+kyIzxXtqdu7ElaTzUgi8VEHnf0rty1V/Z1TdRWcDDmsE2e6OlN
    GFWoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PC3PtolA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E0xURptC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PC3PtolA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E0xURptC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELsx6bzvELZbqMg4wajEuIN2gZwy1qXJH+BkWTxypa2M/mIFTuSo7VjvXdimBJ4f3YySs59+gQ==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com, gregkh@linuxfoundation.org,
 ganesh.krishna@microchip.com
Subject: [PATCH 6/7] staging: wilc1000: remove unwanted braces and correct
 code alignment
Date: Wed, 14 Mar 2018 18:15:04 +0530
Message-Id: <31227bdc32df8b76d6a81ca224e1381020f681df.1521030891.git.hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
In-Reply-To: <cover.1521030891.git.hariprasath.elango@gmail.com>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
In-Reply-To: <cover.1521030891.git.hariprasath.elango@gmail.com>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, hariprasath.elango@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Remove the unwated brace and corrected the code block alignment
accordingly

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index a4ee175..0fac8e1 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -984,20 +984,19 @@ static s32 handle_connect(struct wilc_vif *vif,
 	wid_list[wid_cnt].val = (s8 *)(&(dummyval));
 	wid_cnt++;
 
-	{
-		wid_list[wid_cnt].id = WID_INFO_ELEMENT_ASSOCIATE;
-		wid_list[wid_cnt].type = WID_BIN_DATA;
-		wid_list[wid_cnt].val = hif_drv->usr_conn_req.ies;
-		wid_list[wid_cnt].size = hif_drv->usr_conn_req.ies_len;
-		wid_cnt++;
-
-		if (memcmp("DIRECT-", pstrHostIFconnectAttr->ssid, 7)) {
-			info_element_size = hif_drv->usr_conn_req.ies_len;
-			info_element = kmalloc(info_element_size, GFP_KERNEL);
-			memcpy(info_element, hif_drv->usr_conn_req.ies,
-			       info_element_size);
-		}
+	wid_list[wid_cnt].id = WID_INFO_ELEMENT_ASSOCIATE;
+	wid_list[wid_cnt].type = WID_BIN_DATA;
+	wid_list[wid_cnt].val = hif_drv->usr_conn_req.ies;
+	wid_list[wid_cnt].size = hif_drv->usr_conn_req.ies_len;
+	wid_cnt++;
+
+	if (memcmp("DIRECT-", pstrHostIFconnectAttr->ssid, 7)) {
+		info_element_size = hif_drv->usr_conn_req.ies_len;
+		info_element = kmalloc(info_element_size, GFP_KERNEL);
+		memcpy(info_element, hif_drv->usr_conn_req.ies,
+				info_element_size);
 	}
+
 	wid_list[wid_cnt].id = (u16)WID_11I_MODE;
 	wid_list[wid_cnt].type = WID_CHAR;
 	wid_list[wid_cnt].size = sizeof(char);
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
