Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3282151-1519144564-2-8903349843261749310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519144563; b=q0P1zEreQ2KdNTrLrCb+ggbLdVsSb2Z5TyH7Nc5OtVvRX1m
    1G614FBPt8XKnLTg3sdIkrOqpDbOyt+fikUXwufOyqECbpiWA8xr8wUlShi/tjc5
    WuWtqEIG+rSxWwhpsPXzDtvYfRYpN8JDvRA35cYC+bf2F3SMufpXMD73f0M5FMNp
    NAV5TgJprtoq3e4Vo4J+T8rfK0LVV4tOroAMCPgcfaCNJ/he1/F1BuGR2mzSyWxL
    86DMrAv27AAiECzemjdwQWbpULgCVikWNtnYtEQOaoq5O7HB7wxFg4I2PvtnlU4W
    S0/5Mshro7lgWDNwlX/Y0WDC9v5JzC6h5iNI0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519144563; bh=7
    khm5sNwyffoUET4EZuvunT/gtpwdbmNe7ZtdsTLQjE=; b=tMrt9b40oj0e1AZHQ
    gvTrqYZWqsEUq/rL+dQHOth2PCfdT3h6P7zweqD7a+RJS+/r0HyKujybs9J8HjXh
    g3F+RAqmJrSFBcK1cfpu8rtxuD0rQx++39OHJlwGH7BLJF6oa35dHWUQTQB0323Y
    HgwLGs+qh3YzP40rlACsRBJDiOTHIZNM1g9w7d1H3F+/CmpGQr0rln3z17r3d84q
    wynJBxMkxu9gCsgF/uqmxYAbMcRCfXuZ3cQez+B023KemvL7rUweq2Aw/7ljmVxf
    +QlMedagfjekqGu639bMaSob4jzCn9hi0w4htI9GbjCO1SlT4POQbjMLE7EZKoj/
    63HRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gentoo.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gentoo.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH-next] staging: emxx_udc: Remove unneeded cast
Date: Tue, 20 Feb 2018 11:35:53 -0500
Message-Id: <20180220163553.14553-1-chrisadr@gentoo.org>
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
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix Coccinelle alert:

drivers/staging//emxx_udc/emxx_udc.c:2689:19-21: WARNING: casting value returned by memory allocation function to (u8 *) is useless.

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 7517001fb8f0..ad69a1e536a7 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -2686,7 +2686,7 @@ static int nbu2ss_ep_queue(
 
 	if (req->unaligned) {
 		if (!ep->virt_buf)
-			ep->virt_buf = (u8 *)dma_alloc_coherent(
+			ep->virt_buf = dma_alloc_coherent(
 				NULL, PAGE_SIZE,
 				&ep->phys_buf, GFP_ATOMIC | GFP_DMA);
 		if (ep->epnum > 0)  {
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
