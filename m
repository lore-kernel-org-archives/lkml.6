Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520227143-2-12097100834914690880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227143; b=XL8NEu/F7v4QHDtAXIR1q9rPWT+mAJ3yn7pnEx4wPtZ2niN
    oxsIbdpG13kq/yYYpDizyNGXaUNmUHkTIa12jsSIzt0EiaroPBQD4/dIysmRlU55
    qDRlVCVx7g1ECNs4uSw6LLKb4xgZ6hKs5512rlwgNfDE2Y5yh6HlMRcLi6oSXndj
    CU1/OpS3n8/iUcCwI5QutRLklEN0wp84lW/yqYd/lSDX6bmaBChhRIUNuJhw/mfj
    WbmeQJy0EXb9sreGtoFoeUepBrOkH2HRytcp2WBDibM6ueeYo8EYRAOHMWQCPf8H
    dtrQQTaB4rpjZIlVoj8CbECJs5U5ql14/320sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227143; bh=4j54YIU7PFyy4p10Cyj8wNajaB2R46MNFg2B3jMha+0=; b=X
    xTupMXeF6jSSX9ydEdeDPYO7eYJOR5YUhjIZBqrJfP5JoYkFDdCOKaysPjKJNWWK
    m44+h/095SudtIN7rXcQClEq1WqL43ZoPc9Z4jsFyM9rvfD5ADv7oVoiTKU4t71t
    4IRmR9J6CsHB1x67soaNB6F8Qq+ooj4h1Irz7QTCI2Z0TMYdsSZ38yT/COYN14fI
    azNphYfo38nCnZKiGrG+td9wg7adI1loAogqMJyGjjzJnHlmsS3TsZtIc7izxg1i
    X8mF9mrp+2O+bQ+ZIjziBvZrcs9rDzf900BRaHNK1PSvkHQMauAH08j0nGj+rZ4W
    1xN0q5A03q75/gXa8j4gg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 10/12] hv_balloon: simplify
 hv_online_page()/hv_page_online_one()
Date: Sun,  4 Mar 2018 22:17:20 -0700
Message-Id: <20180305051722.19157-10-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfGPod2Aq1F7Gl0vXcGjm8mc5VZZfYkcJzPxLWeMzb60LzC9bQxSgrYk54qNnqEOSPz9+zLbNRgGqHDgTNeRMK+h6LIqfys84BYE3fNZs8SpNi/rhjfFi
 C5uGqLVQu0lSGz64qLFVy9cbyFyWNHUpdC0U2Wz21/mr8GE13OJ2rLDATiGYOWU62VkNRomIKWFvmacmUw0V2+WOEut2op5pt4St+3OJWg4IRleudj8cy4IY
 dIsgFm0MvImhLe84gbb8bJqwDX8/42nhpyCxHcNNqdJuQ+XwhD5aS4Snqj5gT+W0lXnXEzIeSOpiQtG4WM9Q3tY6ASKMhNzKyl8czNrr3vGsUo6jknFuL0ZZ
 CwVNr2BVwypLU65mDGLY36P3xnS9dWxm2W3558yEVdRWVJoGyCCnzyexuqYVrNjvOo8WXnxWMiWgU2oey3u0A/hvTPyJDDxLSHRlUPMlbCtuUiAHfGy9FZ70
 LzVJcv1RQVw4Svr2OO9oPkfry12OEUPTkJxQNf1i08cUDac5Mqtdvsw+cJ7eW0jmLoInAufc7hPi9Q20Leaux0/06wscUJj5VVZ3bg==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Instead of doing pfn_to_page() and continuosly casting page to unsigned
long just cache the pfn of the page with page_to_pfn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
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
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
