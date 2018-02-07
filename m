Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-422771-1518026267-2-1648807943913584252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518026266; b=bn22+ctSBulUrFUazm635nM4h/LXQ7KQfq2eAIKyyY0C2+Z
    6rspzFXp2a4xwvAetBhkWSmM8ejWW4Cn6oFTUrkpXWUWS6wasgv+wdnPzgxwZFDm
    mSIrm9tmyCeb3XtaGEWZJY/oOYxd+lnlMjiLg66RGJL1W6teh6cE5XGhtSjUOhEO
    xcqdRHmmQhiBwS4EnTGsGvQUQHfAkzIUk2XvExXWnRtuA6sMoViCmsQOf19fmT+J
    X4ZpXOsc7C5c8cPULnSNc/ixzlTub68qDYPhtGiQLuG4SP2SR2OiliiAZ3ibNG6v
    I1u+8Fbp27Rzns1g5KsVu08kUGwCTz2Wa2A/PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518026266; bh=t
    bQ88yGZ0UF5GRl7E6bVqB7ug8VYAcafgmK5BZ4Y3jU=; b=GCkZA6BaQSaT+2P2x
    Kw04kuXL5kCwbmbHEvul7tHeVk0P94GyvQ1PmFPkjKrSSEgWr7JjIvgoPd/42FEz
    wlbQCd/EIkZ/cxPPZiSopkAyW4pteJcP0wbuAbHmGusjkb3IVJQlG+RaH4GBrDRz
    74730rAPGRFJAB/NUOjBDJJjnx+MlqqqpSZYuxi21xdeBHUt4O4b6B9VPApydPGr
    zos4DcBEyg91L5sDkDiN+uVNYRsZKGyRsOFBp722Tw911FDDB+tCwa4BbWnw3+lS
    kq7f/m4vsf6CePQaIG+/hvC8AFsnkEqyRTxlWEhlVf2ued2VLxBEa/P30aTRpkE2
    DCRqQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Subject: [PATCH RESEND 2/4] hv_balloon: simplify
 hv_online_page()/hv_page_online_one()
Date: Wed,  7 Feb 2018 18:50:01 +0100
Message-Id: <20180207175003.28859-3-vkuznets@redhat.com>
In-Reply-To: <20180207175003.28859-1-vkuznets@redhat.com>
References: <20180207175003.28859-1-vkuznets@redhat.com>
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
Cc: Eduardo Otubo <otubo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Alex Ng <alexng@microsoft.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of doing pfn_to_page() and continuosly casting page to unsigned
long just cache the pfn of the page with page_to_pfn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_balloon.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 1aece72da9ba..5b8e1ad1bcfe 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -612,28 +612,17 @@ static struct notifier_block hv_memory_nb = {
 /* Check if the particular page is backed and can be onlined and online it. */
 static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 {
-	unsigned long cur_start_pgp;
-	unsigned long cur_end_pgp;
 	struct hv_hotadd_gap *gap;
-
-	cur_start_pgp = (unsigned long)pfn_to_page(has->covered_start_pfn);
-	cur_end_pgp = (unsigned long)pfn_to_page(has->covered_end_pfn);
+	unsigned long pfn = page_to_pfn(pg);
 
 	/* The page is not backed. */
-	if (((unsigned long)pg < cur_start_pgp) ||
-	    ((unsigned long)pg >= cur_end_pgp))
+	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
 		return;
 
 	/* Check for gaps. */
 	list_for_each_entry(gap, &has->gap_list, list) {
-		cur_start_pgp = (unsigned long)
-			pfn_to_page(gap->start_pfn);
-		cur_end_pgp = (unsigned long)
-			pfn_to_page(gap->end_pfn);
-		if (((unsigned long)pg >= cur_start_pgp) &&
-		    ((unsigned long)pg < cur_end_pgp)) {
+		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
 			return;
-		}
 	}
 
 	/* This frame is currently backed; online the page. */
@@ -726,19 +715,13 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 static void hv_online_page(struct page *pg)
 {
 	struct hv_hotadd_state *has;
-	unsigned long cur_start_pgp;
-	unsigned long cur_end_pgp;
 	unsigned long flags;
+	unsigned long pfn = page_to_pfn(pg);
 
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
-		cur_start_pgp = (unsigned long)
-			pfn_to_page(has->start_pfn);
-		cur_end_pgp = (unsigned long)pfn_to_page(has->end_pfn);
-
 		/* The page belongs to a different HAS. */
-		if (((unsigned long)pg < cur_start_pgp) ||
-		    ((unsigned long)pg >= cur_end_pgp))
+		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
 			continue;
 
 		hv_page_online_one(has, pg);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
