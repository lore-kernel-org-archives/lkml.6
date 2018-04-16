Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851856-2-8227661347725868841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851855; b=mKdqiaFBZSRL+pnwQ7KGSrTlVwHpCLRZGZBV4QLCbf2sQ8KCW4
    +gRuYfOfH1o6sR+UKnI2xYJdMKPeLGFDv0QqxB3ULWyWhU/PY6EIOUBrRJtptsl8
    paBDMKJi2pDqBz4f0nqQIwJx22CZRxgmtZh2fYeGSVMU3PoYOTlX47eTzX0fYcBA
    xxZQ40Dv6cVmdiRdWNLRAlf5Lo7+ZuYTKkGR5B3rpIyVFmLA1b1XffTc9zsQxa0w
    3KORpgK4PcMHM6b94oyaQ5zDhWQABn6a36SiX2BHUAvd/he3yMXmyloKXQOZJk2+
    pInJmjSA/NEcWevRNkoMRnxKaJBnra6/87pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851855; bh=jqp7V
    wdFOeG5wXbXZWhJeYBKJ3AOvI3McvyK/R6RJ3c=; b=MumBZIqvG0Yo/Patq3N6W
    vgy7H4O1fVurPke42Q8V+JZzp8oQDEzyIKwgxi+xRvWLH5iAIJ38u6RfH6Dd2dcc
    dBySceIors41jyzApypan2uwGYITc3w2XAhMleVmLul2oqKITDHvU0scz/J6Cluz
    WWggL/gUysboB3SE5RColLs/s4Ok1P9KFZEmy9rKH+NXeWPnV8d8KVAR7LE8nFzk
    WSZvJvLPy5sDKXQO1kPX0pcryZzh2BglP/1H8Xfkw59QHvPWDV1PgdAO081PCKkQ
    VXtYaGsnowxWO7ZejbpZU3wktUVrdblDTeyTNUXnhfR5ZKi40mxGt7kdvleFXQ5Q
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfIm55wjgLQ9xZDeGz0qynKgp1EKb/bXzfr+jOM9f5G6+CV40MzcDikLqcSXF0uKXzZqvfDK9oCl/w0296djf5BJEic+S2mVwQnGR0bFsGtDi3SuQ96Y3
    UGIv/BfqRDiZcZ/LWnO//lPK7jTKJfibQs2D/mqyQGa0ds3AdDiFIHJqSQS6SCQj9VG3F6iLCFLjQRU+6GLYne2C2L3oRQiSgkDg8je02hypRqleMc6DKHBw
    2Xt5crpbT2V8H+G9plvftw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=suR7hewdfILTPmQ208IA:9
    a=qhstkwv3lp4FKEyo:21 a=8c8dhGoqFIaAYRAd:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 24/25] staging: lustre: libcfs: change CPT estimate algorithm
Date: Mon, 16 Apr 2018 00:10:06 -0400
Message-Id: <1523851807-16573-25-git-send-email-jsimmons@infradead.org>
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

The main idea to have more CPU partitions is based on KNL experience.
When a thread submit IO for network communication one of threads from
current CPT is used for network stack. Whith high parallelization many
threads become involved in network submission but having less CPU
partitions they will wait until single thread process them from network
queue. So, the bottleneck just moves into network layer in case of
small amount of CPU partitions. My experiments showed that the best
performance was when for each IO thread we have one network thread.
This condition can be provided having 2 real HW cores (without hyper
threads) per CPT. This is exactly what implemented in this patch.

Change CPT estimate algorithm from 2 * (N - 1)^2 < NCPUS <= 2 * N^2
to 2 HW cores per CPT. This is critical for machines with number of
cores different from 2^N.

Current algorithm splits CPTs in KNL:
LNet: HW CPU cores: 272, npartitions: 16
cpu_partition_table=
    0       : 0-4,68-71,136-139,204-207
    1       : 5-9,73-76,141-144,209-212
    2       : 10-14,78-81,146-149,214-217
    3       : 15-17,72,77,83-85,140,145,151-153,208,219-221
    4       : 18-21,82,86-88,150,154-156,213,218,222-224
    5       : 22-26,90-93,158-161,226-229
    6       : 27-31,95-98,163-166,231-234
    7       : 32-35,89,100-103,168-171,236-239
    8       : 36-38,94,99,104-105,157,162,167,172-173,225,230,235,240-241
    9       : 39-43,107-110,175-178,243-246
    10      : 44-48,112-115,180-183,248-251
    11      : 49-51,106,111,117-119,174,179,185-187,242,253-255
    12      : 52-55,116,120-122,184,188-190,247,252,256-258
    13      : 56-60,124-127,192-195,260-263
    14      : 61-65,129-132,197-200,265-268
    15      : 66-67,123,128,133-135,191,196,201-203,259,264,269-271

New algorithm will split CPTs in KNL:
LNet: HW CPU cores: 272, npartitions: 34
cpu_partition_table=
    0       : 0-1,68-69,136-137,204-205
    1       : 2-3,70-71,138-139,206-207
    2       : 4-5,72-73,140-141,208-209
    3       : 6-7,74-75,142-143,210-211
    4       : 8-9,76-77,144-145,212-213
    5       : 10-11,78-79,146-147,214-215
    6       : 12-13,80-81,148-149,216-217
    7       : 14-15,82-83,150-151,218-219
    8       : 16-17,84-85,152-153,220-221
    9       : 18-19,86-87,154-155,222-223
    10      : 20-21,88-89,156-157,224-225
    11      : 22-23,90-91,158-159,226-227
    12      : 24-25,92-93,160-161,228-229
    13      : 26-27,94-95,162-163,230-231
    14      : 28-29,96-97,164-165,232-233
    15      : 30-31,98-99,166-167,234-235
    16      : 32-33,100-101,168-169,236-237
    17      : 34-35,102-103,170-171,238-239
    18      : 36-37,104-105,172-173,240-241
    19      : 38-39,106-107,174-175,242-243
    20      : 40-41,108-109,176-177,244-245
    21      : 42-43,110-111,178-179,246-247
    22      : 44-45,112-113,180-181,248-249
    23      : 46-47,114-115,182-183,250-251
    24      : 48-49,116-117,184-185,252-253
    25      : 50-51,118-119,186-187,254-255
    26      : 52-53,120-121,188-189,256-257
    27      : 54-55,122-123,190-191,258-259
    28      : 56-57,124-125,192-193,260-261
    29      : 58-59,126-127,194-195,262-263
    30      : 60-61,128-129,196-197,264-265
    31      : 62-63,130-131,198-199,266-267
    32      : 64-65,132-133,200-201,268-269
    33      : 66-67,134-135,202-203,270-271

'N' pattern in KNL works is not always good.
in flat mode it will be one CPT with all CPUs inside.

in SNC-4 mode:
cpu_partition_table=
    0       : 0-17,68-85,136-153,204-221
    1       : 18-35,86-103,154-171,222-239
    2       : 36-51,104-119,172-187,240-255
    3       : 52-67,120-135,188-203,256-271

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/24304
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 30 ++++------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 915cfca..ae5fd16 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -768,34 +768,14 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 
 static int cfs_cpt_num_estimate(void)
 {
-	int nnode = num_online_nodes();
+	int nthr = cpumask_weight(topology_sibling_cpumask(smp_processor_id()));
 	int ncpu = num_online_cpus();
-	int ncpt;
+	int ncpt = 1;
 
-	if (ncpu <= CPT_WEIGHT_MIN) {
-		ncpt = 1;
-		goto out;
-	}
-
-	/* generate reasonable number of CPU partitions based on total number
-	 * of CPUs, Preferred N should be power2 and match this condition:
-	 * 2 * (N - 1)^2 < NCPUS <= 2 * N^2
-	 */
-	for (ncpt = 2; ncpu > 2 * ncpt * ncpt; ncpt <<= 1)
-		;
-
-	if (ncpt <= nnode) { /* fat numa system */
-		while (nnode > ncpt)
-			nnode >>= 1;
+	if (ncpu > CPT_WEIGHT_MIN)
+		for (ncpt = 2; ncpu > 2 * nthr * ncpt; ncpt++)
+			; /* nothing */
 
-	} else { /* ncpt > nnode */
-		while ((nnode << 1) <= ncpt)
-			nnode <<= 1;
-	}
-
-	ncpt = nnode;
-
-out:
 #if (BITS_PER_LONG == 32)
 	/* config many CPU partitions on 32-bit system could consume
 	 * too much memory
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
