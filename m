Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3747066-1521227792-2-18070345011832442148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521227792; b=IWTcRVkiG0F5LpzX7OI6fqo6xdK/tKGa800rbktoNgCO3a+
    EoFQFm5gMr+BfVbHtlrJEo5pSKj4xD10ek/V/dsVa3I4Tee2aTNZJXiwMGD2Pxiy
    s/twnx63++6dio6V+D+f1ZoN90IwpGECEvEnJY5t2uy6lO155xBOh2CbKoDQoycz
    zo0gv9kHmr2yJ/7qjLhnC2LJuA9pvGY/e0ZAqiwqZKbAeN6eHcthejhAijWUkrn2
    M2Vmvw02lcjV07aQvaFi0WLxkgkCTl9I1p5K1RU3FIyqqvFPH1qrMncK9WVsU69S
    jGKjqAno9D7MkSAKgr1QFKlee44wVfyE8U+ER0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521227792; bh=ANInufuiZumn6wLKIDpgoxvYwYbwvEvvMB0oJnWUE4w=; b=n
    3KpXuxI5Trbq4hKBJIz14Sfm4HWuYY834nkOKXngMJdp6gLMcj5GodA5olSpFlAh
    jTAGcleVCp2Lw6oScAljr/hlhCGUNNmi3rp780uChzWG2o7hFJUSqC1brUVbjHga
    JbeRCOifAWPi3VEKFaeltztDKAEaLuwpPh4JA3enb+Ri51mH4UrNELXzPnLCziUm
    +heKuqMsIA9k3K4er2NUx4oUQL+wYPVfiIgANsr9ljOEGUbByUqDqMp1JurvF8PN
    F+d++ED2wsDTQVf/lNmJK6WuNNj5RwaTzlf5RvHfsIDUj78wcSZxsrbcaSIoxpyt
    VUpN4YuOAjIRqPjYCMgmQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeCPTQE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 15:16:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752106AbeCPTOU (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 15:14:20 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        stable@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is destroyed v2
Date: Fri, 16 Mar 2018 15:14:08 -0400
Message-Id: <20180316191414.3223-4-jglisse@redhat.com>
In-Reply-To: <20180316191414.3223-1-jglisse@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ralph Campbell <rcampbell@nvidia.com>

The hmm_mirror_register() function registers a callback for when
the CPU pagetable is modified. Normally, the device driver will
call hmm_mirror_unregister() when the process using the device is
finished. However, if the process exits uncleanly, the struct_mm
can be destroyed with no warning to the device driver.

Changed since v1:
  - dropped VM_BUG_ON()
  - cc stable

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: stable@vger.kernel.org
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h | 10 ++++++++++
 mm/hmm.c            | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index ef6044d08cc5..61b0e1c05ee1 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -218,6 +218,16 @@ enum hmm_update_type {
  * @update: callback to update range on a device
  */
 struct hmm_mirror_ops {
+	/* release() - release hmm_mirror
+	 *
+	 * @mirror: pointer to struct hmm_mirror
+	 *
+	 * This is called when the mm_struct is being released.
+	 * The callback should make sure no references to the mirror occur
+	 * after the callback returns.
+	 */
+	void (*release)(struct hmm_mirror *mirror);
+
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
diff --git a/mm/hmm.c b/mm/hmm.c
index 320545b98ff5..6088fa6ed137 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -160,6 +160,21 @@ static void hmm_invalidate_range(struct hmm *hmm,
 	up_read(&hmm->mirrors_sem);
 }
 
+static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct hmm *hmm = mm->hmm;
+	struct hmm_mirror *mirror;
+	struct hmm_mirror *mirror_next;
+
+	down_write(&hmm->mirrors_sem);
+	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
+		list_del_init(&mirror->list);
+		if (mirror->ops->release)
+			mirror->ops->release(mirror);
+	}
+	up_write(&hmm->mirrors_sem);
+}
+
 static void hmm_invalidate_range_start(struct mmu_notifier *mn,
 				       struct mm_struct *mm,
 				       unsigned long start,
@@ -185,6 +200,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
+	.release		= hmm_release,
 	.invalidate_range_start	= hmm_invalidate_range_start,
 	.invalidate_range_end	= hmm_invalidate_range_end,
 };
@@ -230,7 +246,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
-	list_del(&mirror->list);
+	list_del_init(&mirror->list);
 	up_write(&hmm->mirrors_sem);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
-- 
2.14.3
