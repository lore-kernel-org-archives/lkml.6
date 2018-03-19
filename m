Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484993-2-12577946984099538172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484993; b=t5NLthFsqswT5PznlkheMa9oRcaOPF61y8zPVm0xmmVXHQ7
    oVuxoPQVdJ2m0s+bF8TLlfyzCW8NTdU+3BwdWPy2BFKpNpzcB2fbCzGXh94IEw2t
    kHW5qF2rAsnNzqfNPGc6Yq++TmsVmp/7ks1Ayt3DJGoMRsW0ayAK1MMUErJM7A/R
    EvrWVt80M6Wb4mncPGKuqs2SShrBqSB6/ogU76NtWsk946q55yHY+Sja7zMKlnNC
    oajauJefcI1+VC9WO2vXetVhp4nLqZLKHwCffIENhctepxdmdcCv1c7+gydWefc0
    Rs/25dyswm96T6ivryHllZpKb5DfNvE/uf+xJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484993; bh=j+QAicckKDvk181J0J2UtcKZPJ
    GIhFtH1agjKDyKDUk=; b=vAmjIHrY3DYsITSuxVlh0L387nTEr0lt3bc364Q8Qw
    OxM6eGVTkkyfrh+D0mCPyzAnpc/12lv8mHUZu0uOxf7ZtE9QCqoyVqEIPJreQ6Xd
    6fLbQ46KnpXwVMmEIEV5SS85QE7HN8dt5/XO7shRYsiPhPnjDE7hbXqlKArONaxi
    C3e1mcs2/owZrZ45vT/SandAYJfSnzgqCyZhbInfOVGCBEMJMJg4ZfMKDvSsmS18
    gmf3dG00anJmVz4101FrnFbdk0eiM5ihNG/3u6cJMduHSZ/py/2VFl6xCz7nXfOP
    t/hX9jYMTcEmkLkJtvkKAYkmXoasuFq3jhOpwMAvaMCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehudefheenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehudefheenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970294AbeCSSc2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:32:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934606AbeCSScY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 37/52] btrfs: Fix memory barriers usage with device stats counters
Date: Mon, 19 Mar 2018 19:08:35 +0100
Message-Id: <20180319180737.073560552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit 9deae9689231964972a94bb56a79b669f9d47ac1 upstream.

Commit addc3fa74e5b ("Btrfs: Fix the problem that the dirty flag of dev
stats is cleared") reworked the way device stats changes are tracked. A
new atomic dev_stats_ccnt counter was introduced which is incremented
every time any of the device stats counters are changed. This serves as
a flag whether there are any pending stats changes. However, this patch
only partially implemented the correct memory barriers necessary:

- It only ordered the stores to the counters but not the reads e.g.
  btrfs_run_dev_stats
- It completely omitted any comments documenting the intended design and
  how the memory barriers pair with each-other

This patch provides the necessary comments as well as adds a missing
smp_rmb in btrfs_run_dev_stats. Furthermore since dev_stats_cnt is only
a snapshot at best there was no point in reading the counter twice -
once in btrfs_dev_stats_dirty and then again when assigning stats_cnt.
Just collapse both reads into 1.

Fixes: addc3fa74e5b ("Btrfs: Fix the problem that the dirty flag of dev stats is cleared")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |   18 ++++++++++++++++--
 fs/btrfs/volumes.h |   12 ++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7093,10 +7093,24 @@ int btrfs_run_dev_stats(struct btrfs_tra
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
-		if (!device->dev_stats_valid || !btrfs_dev_stats_dirty(device))
+		stats_cnt = atomic_read(&device->dev_stats_ccnt);
+		if (!device->dev_stats_valid || stats_cnt == 0)
 			continue;
 
-		stats_cnt = atomic_read(&device->dev_stats_ccnt);
+
+		/*
+		 * There is a LOAD-LOAD control dependency between the value of
+		 * dev_stats_ccnt and updating the on-disk values which requires
+		 * reading the in-memory counters. Such control dependencies
+		 * require explicit read memory barriers.
+		 *
+		 * This memory barriers pairs with smp_mb__before_atomic in
+		 * btrfs_dev_stat_inc/btrfs_dev_stat_set and with the full
+		 * barrier implied by atomic_xchg in
+		 * btrfs_dev_stats_read_and_reset
+		 */
+		smp_rmb();
+
 		ret = update_dev_stat_item(trans, fs_info, device);
 		if (!ret)
 			atomic_sub(stats_cnt, &device->dev_stats_ccnt);
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -498,6 +498,12 @@ static inline void btrfs_dev_stat_inc(st
 				      int index)
 {
 	atomic_inc(dev->dev_stat_values + index);
+	/*
+	 * This memory barrier orders stores updating statistics before stores
+	 * updating dev_stats_ccnt.
+	 *
+	 * It pairs with smp_rmb() in btrfs_run_dev_stats().
+	 */
 	smp_mb__before_atomic();
 	atomic_inc(&dev->dev_stats_ccnt);
 }
@@ -523,6 +529,12 @@ static inline void btrfs_dev_stat_set(st
 				      int index, unsigned long val)
 {
 	atomic_set(dev->dev_stat_values + index, val);
+	/*
+	 * This memory barrier orders stores updating statistics before stores
+	 * updating dev_stats_ccnt.
+	 *
+	 * It pairs with smp_rmb() in btrfs_run_dev_stats().
+	 */
 	smp_mb__before_atomic();
 	atomic_inc(&dev->dev_stats_ccnt);
 }
