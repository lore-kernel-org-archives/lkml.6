Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1645187-1521031562-2-15332218875321460455
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
    t=1521031561; b=jVCgz1f2MioBGFBUMz8Mf1XEuyyhbdeJF9pHFPD2ok0gc05
    litUSu2C/nACPCCKOuvGjDGxyf8HEVL2jp8/up6jTuOJaqLwLPV7mz1/MWSB7X+Q
    +zQ2PGmBl/ghmnOeIK4Cv/7F+kSWckx8Fz3diF9CZvm8jy4UXSWZZhqzU9QR5YZ/
    IZvf7Tx3/ymOU6+eSYM+gJKdga0qdyGXM/niAeNE6soSkh19Zyc+/oj0NAqolqjS
    272AL7kwOZrmf5QxaqCCPqM2Sfuy03mkNdWN9DM9juFeAiix8DsYPKPE0JbbtZd6
    vE5Ez+aOjowQOWQXTwn5tIuIwaqwcsJDgrnQ8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521031561; bh=k
    N0U61BzISX7124beJUeKC2S5qt2rWIzp53wN3AbvCY=; b=LOv6plZDkcaGpiyTg
    BGNMTo/kKnoIUYn7WtVEyIgA2Vu5hEKH7i3nQOlIdUOLx2+iioOylhwq2OfwzadX
    dFEYTjtcQ5K/vkq0IZs3bylHP0VKWN/318nQePd0i7QGQCvMQZO55In11UJZfvZd
    99R6lEytC97lMW4Tf5iP6uOnIm5x95CDXfQXNBOZawh6U7jNR7EB988fhzs1uPpn
    imYGGnmq5NHISrt4kQWrytsk4Br/AW0w7sCtu3cVa5HqPeuGK4Z2TYGPU0oHMHFw
    ktUfgJpswRSF6Yibgx+Qni6T+pj4zZjMmvKqAGKVOyvdJ7DywnWOEgPg9rV8WB/V
    AK3xg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SJ1ODQNj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dRNEmaQc;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SJ1ODQNj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dRNEmaQc;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELsNceW7/sFJjo290oppguWt5buASVOEa35NDKiqqM+1T1gYzl7/dbLFEKns+umRqgK4QbFKEg==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com, gregkh@linuxfoundation.org,
 ganesh.krishna@microchip.com
Subject: [PATCH 7/7] staging: wilc1000: use kmemdup to replace kmalloc/memcpy
Date: Wed, 14 Mar 2018 18:15:05 +0530
Message-Id: <b6c247886023a9822120169aef4d5d279d065ebf.1521030891.git.hariprasath.elango@gmail.com>
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
