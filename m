Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2132234-1518983554-4-6328219568538595341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518983554; b=JkYAIQrNmsbFcIB5BuS9mDigXwDdOu6Bh5Nm8gtVkZi9o7s
    ey4jEritEbJtPOp4INn0Bsmg8Wu/lr/d7SyxgUvRtCJZzttXgQo3IbIszPLZmMom
    91HRVZmNlLVBrvrlrAl/xu+B36uKY718H8vuSbqBfyP7+OlucChzM+dR0bFSKfzR
    pWyH5axwaNaZ+zYl+lTyXl4CZ01lF2KXo5ZGefwhsblyteFcG9fzzTddtaglJf01
    IKAIqBJ69P43Dz65iOJsoOIJfEU5lz27ezT5jgqZFH0bkbCLAGCeWSIm28zgr79P
    MLMn9jGa8c6x45Q0TydEdqZVvessz1aCAnXVLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518983554; bh=1
    lreh0r7CLv+DIA/xilQ++WAK+x4NLfsaUtd9Q+ZVXU=; b=pB9cAZcGoPhWcry/T
    sDEp93+K54OMblFl/qpJqbKcU779g4oaoaBhC7vz6C/cc86ZGKFUU4nBNhV8If4v
    USvNPhqqURziql98VYVQY8MNGF5AqDzbCwRXqc2JRv4U36dgD6hB3BRKr0Nssi6P
    8MQtXpkmeR969RkkGGrksMbhQVIsg0zX90dAuENXmxZSfvm4Q/daa10nfvSouROu
    cZZiohgXT6tZgEmdIyxFZ6XrwahFnH1LZ+VXzWXp29A4+FLQkKXOaQPsEh4caMDw
    jTD00w0m13kvOic3euuutoE137Y30JPjgNOFEvOX35ki5JAc6V3PxiuxlPx00QRs
    U5VYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RDqvqwPy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tLQbCjvR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RDqvqwPy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tLQbCjvR;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227IkvG8eabPnEKDdU3gXRt23wSU3jGTjgtCQMOBKzW33CPgDJDA23+Y/eNI7wFHkZ8W3vRoug==
From: Stefano Manni <stefano.manni@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com
Subject: [PATCH v2 2/2] staging: rtl8712: fix signedness of length to
 rtl8717_set_ie
Date: Sun, 18 Feb 2018 20:52:13 +0100
Message-Id: <20180218195213.12755-2-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180218195213.12755-1-stefano.manni@gmail.com>
References: <20180218195213.12755-1-stefano.manni@gmail.com>
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

rtl8717_set_it() takes an unsigned int pointer as length,
fixed signedness in code using it.

Sparse warnings:

drivers/staging/rtl8712/ieee80211.c:191:53: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:191:53:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:191:53:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:197:57: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:197:57:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:197:57:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:199:63: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:199:63:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:199:63:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:202:67: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:202:67:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:202:67:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:206:73: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:206:73:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:206:73:    got int *<noident>
drivers/staging/rtl8712/ieee80211.c:209:75: warning: incorrect type in argument 5 (different signedness)
drivers/staging/rtl8712/ieee80211.c:209:75:    expected unsigned int [usertype] *frlen
drivers/staging/rtl8712/ieee80211.c:209:75:    got int *<noident>

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 612ccfe..7a4c00e 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -166,7 +166,8 @@ static uint r8712_get_rateset_len(u8 *rateset)
 
 int r8712_generate_ie(struct registry_priv *pregistrypriv)
 {
-	int sz = 0, rate_len;
+	int rate_len;
+	uint sz = 0;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
 	u8 *ie = pdev_network->IEs;
 	u16 beaconPeriod = (u16)pdev_network->Configuration.BeaconPeriod;
-- 
2.9.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
