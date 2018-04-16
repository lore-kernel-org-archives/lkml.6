Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851827-2-6046973142127249246
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851826; b=aDCb++9nr4YAuBZmmAVlOBCjvLCzV5IM+gYiJAOPKN6SR2YV4o
    VjljSUBF0DDHoe9BZAZVuJqP41khISLnl2dTPzNsafhfSB4NSeRCJ8B7mhFMFYSj
    OCgMufDR22YnGT8DgI5REqoBKEAVmA9kidzeUZHNyA4WJNG9l0kSLY3yciNFz7bR
    DOZs9ZGpfCiZAhLBxMRinOaeNRz4r7axgc1BbHV4uYrxjdkI+VsbMbsQ1vCVBiy5
    iXJj/8IBfg25s+YPfb8st5jXg7TuIsJAFwRbO0Wu5g62c83YWS1lBHx1tir5FoEd
    r3rtBOOnh44Clf4A3yB9BR/KrnEUprutiW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851826; bh=WluSx
    mBTl7q7FaU1O69v5uKXZ7wAcmMjxKU/tyh0Lo0=; b=DQa5yq+D0mBFF0tgbruN3
    b/JJ8CIG7NKaHij2aYKWnv1EYzilfLguyyu49S6fiWQUya6dto6QhX/h2N9BzQBP
    vSUIadPMrbsOPNt6oDhTrD5t9hRsJlk5Q01ZCQTRBpjPAoNVjL4lWZ25ykxG0FJo
    Zj7sEhg+Qa10rQL3g9S3r37XpUgGLWviQqfJYkWlZb0g3jjpzW+zr6FcvnXVEPz1
    LrUjXV5iQctFESvVmbh8bWgT3rik1oeTh8IMxJi6kpGGTshex1VsifwG4FsKH+vU
    UTKMuTaPV/t5hef5GXTRPMiwa9UcrJO+5nMI0Rt5KR0lIobF8T72stDEwm/wUp+e
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNe1S6NtPFPjlaEGCxQ6RbbUa4mI6jUPMx/GRL6fMVwUDnjY7v1BjPfV39F+S+oKJBwgSazk8bcofuL4actgeT94M1jDHnBA6LSfpP6P0lhOfVcpLCrT
    IJWCgI+gp1pUmouZ69JH0FoGF7uP43zY49XQtElUy5PlIZHNI0HoPDT/d9DHd8ydOVj1Gw2egihgK+vUK8nOlxPxdOGKa/WykqxlkW905UVHFvj027TAJHbm
    eqnvbB5O7ymC9ngByP4lPA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=ZEmNN31uhRY-HY4zUKgA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 02/25] staging: lustre: libcfs: rename variable i to cpu
Date: Mon, 16 Apr 2018 00:09:44 -0400
Message-Id: <1523851807-16573-3-git-send-email-jsimmons@infradead.org>
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

Change the name of the variable i used for for_each_cpu() to cpu
for code readability.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23303
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 134b239..d8c190c 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -334,7 +334,7 @@ struct cfs_cpt_table *
 int
 cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt, const cpumask_t *mask)
 {
-	int i;
+	int cpu;
 
 	if (!cpumask_weight(mask) ||
 	    cpumask_any_and(mask, cpu_online_mask) >= nr_cpu_ids) {
@@ -343,8 +343,8 @@ struct cfs_cpt_table *
 		return 0;
 	}
 
-	for_each_cpu(i, mask) {
-		if (!cfs_cpt_set_cpu(cptab, cpt, i))
+	for_each_cpu(cpu, mask) {
+		if (!cfs_cpt_set_cpu(cptab, cpt, cpu))
 			return 0;
 	}
 
@@ -356,10 +356,10 @@ struct cfs_cpt_table *
 cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt,
 		      const cpumask_t *mask)
 {
-	int i;
+	int cpu;
 
-	for_each_cpu(i, mask)
-		cfs_cpt_unset_cpu(cptab, cpt, i);
+	for_each_cpu(cpu, mask)
+		cfs_cpt_unset_cpu(cptab, cpt, cpu);
 }
 EXPORT_SYMBOL(cfs_cpt_unset_cpumask);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
