Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851833-2-8251738816421358149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851832; b=hHFOnS3h5zT8o99vrpKLaINE96Vp5iwLkVwv4B6jdDxoKp3JcB
    /vRq8BBfp7NV2Na3gIL//qMmPtfvPBBv9IX40xTpInVRSZv7NBx1JxXvvHu7gLeL
    oJPm59r0BAX3zzc3AtRSLOouKoKKwFP6HQHJTLwCJeaV8nDPgHmJ8ahgIanirhzd
    GF6KErmxxH0hgZVIE5lPTdQzn79x2FlHxo/+oVKk4V+8ipM7rM7/zQb1Pz4Xbg0b
    m7ygVlyysAC40ezA9LzQejk5EGlNBPfiknNSOkRkg9d7ZqKDAIv8vMxVT25h6iiG
    21uQ6WJ6qav3fxwc6HoTLF7k/liA8EGgJA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851832; bh=WlFgA
    HWg08Cj5SRUlF4HPy2r9BkAmWQ7slad+WUZOSY=; b=OvnbwjN19LM80CO1o6sT2
    YcCL5xAd7ndDSHtKKMoGoFvHcCQrt4qLtJnC3lHSVgmVNIEhTIlVPtGFqgV959UT
    DvxyrfQzvJQOfetLp09jJOwP9t/T8IpHmMkOtvjZNsOPoZXhVHvP/ph3/GhcOiCS
    3P0BvHkjCSx1FYR/h7nswIf9BPtw44J97dTNRhf77wAnKrR0VJ/4q0qn+LqtC2F7
    3apnin9l+A3cUsF7fJ7wCA/qvCu++uY5rEwjkdK1JXcGLIUKlniVcmVhEqSsuvex
    zB7WUyMH3/nauwCLbuM3zzRsWro1lgk5FLvPd32+koVqAvWCAykR3WS4NVcnG5YP
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDHx5FUeK++4AU0lXa/BXGXkIvYzslmvuMvmDIqYC5OFd6Fso74JoXe8tW3JAmiW//afJg6XwhyXWxwzT+JnkcsEPMTusseD6wTqcPIJ5IeM2zihI5gk
    MQMEp0P5Fh/shjIqRV7JcBiGS+BSegjs4lCfZ7J4iYynPEDlpmW8HGuakytRxncyDI/4Br4aUjNOAgL0cJNanl8JGnEeEJRjkW9O7ge41BU/tPIBLogZnEna
    SBAcff2pJsK8qZGPq9weXA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=T7SEOyOIhFajMi-nw_4A:9 a=5L1nZEDlKnB0KfkJ:21 a=OFjqFPtDhIYsJp6-:21
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 13/25] staging: lustre: libcfs: use int type for CPT
 identification.
Date: Mon, 16 Apr 2018 00:09:55 -0400
Message-Id: <1523851807-16573-14-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Eremin <dmitry.eremin@intel.com>

Use int type for CPT identification to match the linux kernel
CPU identification.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23304
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h   |  2 +-
 .../staging/lustre/include/linux/libcfs/linux/linux-cpu.h  |  6 +++---
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c            |  2 +-
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c       | 14 +++++++-------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index bda81ab..19a3489 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -108,7 +108,7 @@ static inline int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf,
 /**
  * create a cfs_cpt_table with \a ncpt number of partitions
  */
-struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt);
+struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt);
 /**
  * print distance information of cpt-table
  */
diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
index 4ac1670..b3bc4e7 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
@@ -55,17 +55,17 @@ struct cfs_cpu_partition {
 	/* NUMA distance between CPTs */
 	unsigned int			*cpt_distance;
 	/* spread rotor for NUMA allocator */
-	unsigned int			cpt_spread_rotor;
+	int				 cpt_spread_rotor;
 };
 
 /** descriptor for CPU partitions */
 struct cfs_cpt_table {
 	/* spread rotor for NUMA allocator */
-	unsigned int			ctb_spread_rotor;
+	int				ctb_spread_rotor;
 	/* maximum NUMA distance between all nodes in table */
 	unsigned int			ctb_distance;
 	/* # of CPU partitions */
-	unsigned int			ctb_nparts;
+	int				ctb_nparts;
 	/* partitions tables */
 	struct cfs_cpu_partition	*ctb_parts;
 	/* shadow HW CPU to CPU partition ID */
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index f9fcbb1..5d7d44d 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -43,7 +43,7 @@
 
 #define CFS_CPT_DISTANCE	1	/* Arbitrary positive value */
 
-struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt)
+struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt)
 {
 	struct cfs_cpt_table *cptab;
 
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 5c9cdf4..1669669 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -88,7 +88,7 @@ void cfs_cpt_table_free(struct cfs_cpt_table *cptab)
 }
 EXPORT_SYMBOL(cfs_cpt_table_free);
 
-struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt)
+struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt)
 {
 	struct cfs_cpt_table *cptab;
 	int i;
@@ -759,13 +759,13 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 	return rc;
 }
 
-#define CPT_WEIGHT_MIN  4u
+#define CPT_WEIGHT_MIN 4
 
-static unsigned int cfs_cpt_num_estimate(void)
+static int cfs_cpt_num_estimate(void)
 {
-	unsigned int nnode = num_online_nodes();
-	unsigned int ncpu = num_online_cpus();
-	unsigned int ncpt;
+	int nnode = num_online_nodes();
+	int ncpu = num_online_cpus();
+	int ncpt;
 
 	if (ncpu <= CPT_WEIGHT_MIN) {
 		ncpt = 1;
@@ -795,7 +795,7 @@ static unsigned int cfs_cpt_num_estimate(void)
 	/* config many CPU partitions on 32-bit system could consume
 	 * too much memory
 	 */
-	ncpt = min(2U, ncpt);
+	ncpt = min(2, ncpt);
 #endif
 	while (ncpu % ncpt)
 		ncpt--; /* worst case is 1 */
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
