Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3282151-1519144260-2-9795150233800983084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519144251; b=rnor3u9ncyjy9SKWmYbRnj32UmQi6/ezFXRbcnVxsyacrB6
    Y6RhcOxPfCtWGuOp7l3+ctAmW/qKpnQpifaRkWzBN2bWRbUyPJS+FiIZODzDSdSr
    nmDAPquQxOrfovVVNQSkJ357grC55DKLlQJwSq+6je3PpaL2Eiv/SEdAkEf+aTOh
    z9y9h075nXN3+5ci0xk3TYnjiKcZFdR0VekroFCmxdiSp34AHdvGZWRdLqzzBufo
    3Sc9ba5Ax2Q62pRnva7Z621vU9Ixt5NtRkkbGxP5H6iJ07Euxw2SSqStNXQQNrYc
    Y3OpKPAHqdF/hCD3fFcjbbbGqP2hx2jkToahg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519144251; bh=m
    Su3J/fkqBPZ4AlmTdHibwFJcp0R/wsP2FWfltUoXCg=; b=lgQunGgZgC/pxD0cN
    /c9VFFSDQYZdi/VN04ooblomKVrYU9oYxhU5B6sz0sOka7Lnw9QTLo7Nkfr8B29A
    jcTBP9/0CxVRp1zFnSKzr871zV2fN2mTrhpQffnsTYU6/AbpNFAQIKQFaa3TAKJL
    skx/YZEP1pZtxZf4Qsg67unJeTM7czaHMGy8GQtZZNvh6wvyiuaPTmLUn2bI9l/1
    emOwlwsk4o+fx+/lIgQ0F/ouetYH3mMuwl3j7xJRqrilok9WvBk3dipzrdw4blYZ
    v9bsLdER8WgjVHkeqQf4ySbv1/0f7ZgZurEctSbsAlCr8W9TgA/apY95Z1PchE3z
    we6Sg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: ganesanr@broadcom.com,
	gregkh@linuxfoundation.org
Subject: [PATCH-next] staging: net: netlogic: Remove unneeded cast
Date: Tue, 20 Feb 2018 11:30:33 -0500
Message-Id: <20180220163033.14172-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.16.2
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 jchandra@broadcom.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix Coccinelle alert:

drivers/staging//netlogic/xlr_net.c:996:12-30: WARNING: casting value returned by memory allocation function to (struct xlr_adapter *) is useless.

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 drivers/staging/netlogic/xlr_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 30532d8c310b..e461168313bf 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -993,8 +993,7 @@ static int xlr_net_probe(struct platform_device *pdev)
 	/*
 	 * Allocate our adapter data structure and attach it to the device.
 	 */
-	adapter = (struct xlr_adapter *)
-		devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
 	if (!adapter)
 		return -ENOMEM;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
