Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520227131-2-6509623092688601121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227130; b=mfXNf8bNS5m9hsLWrb4QabXabaPxFw2fW62G1ZRdCWw0SqE
    1g5EHrEd8BYcHXGbTuQip1uMjcmeHQgbVVeEYHcrLDCYu0EiFU0i1Tyr1dIuM5wp
    9wd44aTIRHN1T8uvWdxI8hWNAOg6MTltuhdLZtcwzIldbiCZYiV6keXfaoRUvtTp
    6bOd4B/0we3bQCSqRQ1Ep5yTJKlvRMetJEkz/lw6DuoQ6ASPdtIfhZnDCPqO42ya
    QoKPXATHDrzTAf8B04cCUhH4s5DOEDHqwGE05XuQ1fnJ8w7RIATsQ5TjehuC4ui+
    GdWQr2NDjMEQrcOar3zpzLFjdbH9DOxvSlJLUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227130; bh=IehY+pZ5NjnYKNlf+9nAA8e5Z0PzX4bUGX8v88JirG0=; b=B
    ClPGb9HUPxYZa+utKS+atJgvPSMh0i5i4RX5g5Y0JzX25hG3BzrjyR3TbTAvD6vS
    49ZkG+Wn/UIMCiTICh6n4pZtFVCxRXxcdCQCTPpwdLuLDdh8ldKnmP/5pbni85sv
    WhyLL4oKOvWutOkEzpiZf41aTU4Kc2F2ENTVJoQvn1//bM4H5P/JOtPY3550ZoO1
    ie/PKXSfEXay34qj5nWHy627ic5GN+B5TpZk+6rEh33k9NI2Bj8vtSdwyl4AkYGJ
    D2wvTOO8R8NLcVFqFSWI3Bb87xXHhUIz+tqCNwiNaxG/2J43N2QXYKQo1DYK+2Dd
    BXQlIzFHsTnnpcrKZfgDw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 11/12] hv_balloon: fix bugs in num_pages_onlined accounting
Date: Sun,  4 Mar 2018 22:17:21 -0700
Message-Id: <20180305051722.19157-11-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfIlrs04KbsvJwBOada1kGsbtPgPRQJ9ul0P3tzLaVZW0c/mQWcoGq6l2eqkmi3yyh3PMiRTZvIQgE1y8KbT3tcbFtaLqcGw/M5HFBjHywGCsiUibZjvV
 K32h7Mi6ywTc0g7HHxjUR+lQE2Jq8lheV+QG7pT9NTd4fq1qgHr9seUiojyimL5JEodd6lzxpP1/FkmUhVSXCyzw95JUSLgNujx2KOXrS0PfhgZU/TfFb9iS
 P32Yo3u9m3O0lHmnNtZmuC6KisvAHuagY3hHIZLOvIoJzUmwmP9jB3+jCCrRQhUjgBx3dkVgKVqw45p7HrXxQ1isU+4/mLfrxHj3KVfuw4le9+vvDPt9GNSf
 WuU+ry8WiX9iBguCLAbaYic6UOT/WfvZpJjvIvp89WrQZxBL2ymNdS4or4U78ZT9ikGkbR/2f5DeM9pNtFJLF1WViLsTFsoYeHbyHsFR7AU0i+a/hJ+m4yCs
 oi5YEHa0NIxHfsk2Vi/5LdFNBnj2+I1OIpyrqsm9wlaKFe0+3jqTbJBkrMrMRva05WMafM4liSI9V2D7vR/hfMzMeaNB8FbGGgx93A==
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

Our num_pages_onlined accounting is buggy:
1) In case we're offlining a memory block which was present at boot (e.g.
   when there was no hotplug at all) we subtract 32k from 0 and as
   num_pages_onlined is unsigned get a very big positive number.

2) Commit 6df8d9aaf3af ("Drivers: hv: balloon: Correctly update onlined
   page count") made num_pages_onlined counter accurate on onlining but
   totally incorrect on offlining for partly populated regions: no matter
   how many pages were onlined and what was actually added to
   num_pages_onlined counter we always subtract the full region (32k) so
   again, num_pages_onlined can wrap around zero. By onlining/offlining
   the same partly populated region multiple times we can make the
   situation worse.

Solve these issues by doing accurate accounting on offlining: walk HAS
list, check for covered range and gaps.

Fixes: 6df8d9aaf3af ("Drivers: hv: balloon: Correctly update onlined page count")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 5b8e1ad1bcfe..7514a32d0de4 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -576,11 +576,65 @@ static struct hv_dynmem_device dm_device;
 static void post_status(struct hv_dynmem_device *dm);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
+				     unsigned long pfn)
+{
+	struct hv_hotadd_gap *gap;
+
+	/* The page is not backed. */
+	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
+		return false;
+
+	/* Check for gaps. */
+	list_for_each_entry(gap, &has->gap_list, list) {
+		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
+			return false;
+	}
+
+	return true;
+}
+
+static unsigned long hv_page_offline_check(unsigned long start_pfn,
+					   unsigned long nr_pages)
+{
+	unsigned long pfn = start_pfn, count = 0;
+	struct hv_hotadd_state *has;
+	bool found;
+
+	while (pfn < start_pfn + nr_pages) {
+		/*
+		 * Search for HAS which covers the pfn and when we find one
+		 * count how many consequitive PFNs are covered.
+		 */
+		found = false;
+		list_for_each_entry(has, &dm_device.ha_region_list, list) {
+			while ((pfn >= has->start_pfn) &&
+			       (pfn < has->end_pfn) &&
+			       (pfn < start_pfn + nr_pages)) {
+				found = true;
+				if (has_pfn_is_backed(has, pfn))
+					count++;
+				pfn++;
+			}
+		}
+
+		/*
+		 * This PFN is not in any HAS (e.g. we're offlining a region
+		 * which was present at boot), no need to account for it. Go
+		 * to the next one.
+		 */
+		if (!found)
+			pfn++;
+	}
+
+	return count;
+}
+
 static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			      void *v)
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
-	unsigned long flags;
+	unsigned long flags, pfn_count;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -593,7 +647,19 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 
 	case MEM_OFFLINE:
 		spin_lock_irqsave(&dm_device.ha_lock, flags);
-		dm_device.num_pages_onlined -= mem->nr_pages;
+		pfn_count = hv_page_offline_check(mem->start_pfn,
+						  mem->nr_pages);
+		if (pfn_count <= dm_device.num_pages_onlined) {
+			dm_device.num_pages_onlined -= pfn_count;
+		} else {
+			/*
+			 * We're offlining more pages than we managed to online.
+			 * This is unexpected. In any case don't let
+			 * num_pages_onlined wrap around zero.
+			 */
+			WARN_ON_ONCE(1);
+			dm_device.num_pages_onlined = 0;
+		}
 		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 		break;
 	case MEM_GOING_ONLINE:
@@ -612,19 +678,9 @@ static struct notifier_block hv_memory_nb = {
 /* Check if the particular page is backed and can be onlined and online it. */
 static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 {
-	struct hv_hotadd_gap *gap;
-	unsigned long pfn = page_to_pfn(pg);
-
-	/* The page is not backed. */
-	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
+	if (!has_pfn_is_backed(has, page_to_pfn(pg)))
 		return;
 
-	/* Check for gaps. */
-	list_for_each_entry(gap, &has->gap_list, list) {
-		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
-			return;
-	}
-
 	/* This frame is currently backed; online the page. */
 	__online_page_set_limits(pg);
 	__online_page_increment_counters(pg);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
