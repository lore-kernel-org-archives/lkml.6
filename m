Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851846-2-11330848948199234030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851846; b=kSIcIB0KhDjL/b0VtcSdKnUjv4UYWcEkVD0fqKLhYb/JWBD6iB
    6obzda2IzwzeickXfdH9i5qKDhsZTtXbY/xQJEwNmqs3KKLE0+c1Bahp1GAPNVH+
    bwl6aB1b0R6WRSriiCr4eoJYMjf2sTMzSeN1RTsOhQ+s5kCCBu+SFtKZ4klCd1nF
    S9KWMJLUknaEHhWUUYz2rMhtCjARJeW9fHYUo/a+aD8PWl2vU3MIID+WhwXCBsLK
    76Sl9DxSoBwkIDurL2stPcUwsn2IyTK0d/39q988gc98gCvQnZ+502N+0BJKMXA7
    zCehbI8xx3Ygf5yY4FEDVm3y2GoZ0oaQS2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851846; bh=tYU3d
    LSctQZhid3QHqS92dvpPASlfvUm2yuL6u/ymOA=; b=boGNMKiyxxLKMsBDDS4fE
    n97Ml4DJprhr168pJMJfp10QZNO6F4xU6NeUSw3INx5s7nERWUSFMBndi85/IgvH
    byhLO1kQ//+T4HQIZyGP13a0dsvROhOmIrk6ltG8lUCg2gTgrScQIual6Lj4DInU
    Av67KrkDYR/x70lG4y2gQxXa3ayNfbHfnUGgUUBnGEOdMbSL5psFO4UW8/vIJ7dm
    YrVMcVEYsky7qGOKaP7x1lLuqNIFVKnsWJIASOaGFemV/XFQ6T/QCwlFqk2wM66j
    3qe7Q5Wk7AMUbUPVKn9uu+AA26rpDrW0Cxj8EcFDejeZMD3GSN8L2bEReF7rKE11
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdAE11fSUvR/jkxhGWac7GxY1A/Xeyb4ApslbPbOQUACpnGn0lWf51bZ3IgD6lvMlbYgpk45kS/XHDOpUNrRhSd9E0ozjoxJbbNkRjtdafCEfhfaWjC
    89mDDPt4LYn7cF+vFsylimc5xYWWbkmcZMfopB1xTp4CPRWPLUJIteM17krd+PoKolhMYbDOofa+JELwZWPTfOP+JsspKcTALqPuD7mPDtVV2V0nUebCMsm7
    OksZFp/ZUaKcejxSSM7pXQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=kBl-OI3rAAAA:8 a=MvuuwTCpAAAA:8 a=JfrnYn6hAAAA:8
    a=DDOyTI_5AAAA:8 a=LcVDymkrqZ6LYXwUvEAA:9 a=KhWPc4V0mR-72PoW:21
    a=H_lr2WLN4HcTeQPZ:21 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=pLxN2xGgR0OPbCgNAGn6:22 a=dVHiktpip_riXrfdqayU:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 22/25] staging: lustre: libcfs: update debug messages in CPT
 code
Date: Mon, 16 Apr 2018 00:10:04 -0400
Message-Id: <1523851807-16573-23-git-send-email-jsimmons@infradead.org>
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

Update the debug messages for the CPT table creation code. Place
the passed in string in quotes to make it clear what it is.
Captialize cpu in the debug strings.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23306
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
Reviewed-by: Olaf Weber <olaf.weber@hpe.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 28b2acb..a08816a 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -466,7 +466,7 @@ void cfs_cpt_unset_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 
 	} else if (cpt != cptab->ctb_cpu2cpt[cpu]) {
 		CDEBUG(D_INFO,
-		       "CPU %d is not in cpu-partition %d\n", cpu, cpt);
+		       "CPU %d is not in CPU partition %d\n", cpu, cpt);
 		return;
 	}
 
@@ -910,14 +910,14 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 	if (!ncpt ||
 	    (node && ncpt > num_online_nodes()) ||
 	    (!node && ncpt > num_online_cpus())) {
-		CERROR("Invalid pattern %s, or too many partitions %d\n",
+		CERROR("Invalid pattern '%s', or too many partitions %d\n",
 		       pattern, ncpt);
 		return NULL;
 	}
 
 	cptab = cfs_cpt_table_alloc(ncpt);
 	if (!cptab) {
-		CERROR("Failed to allocate cpu partition table\n");
+		CERROR("Failed to allocate CPU partition table\n");
 		return NULL;
 	}
 
@@ -948,11 +948,11 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		if (!bracket) {
 			if (*str) {
-				CERROR("Invalid pattern %s\n", str);
+				CERROR("Invalid pattern '%s'\n", str);
 				goto failed;
 			}
 			if (c != ncpt) {
-				CERROR("expect %d partitions but found %d\n",
+				CERROR("Expect %d partitions but found %d\n",
 				       ncpt, c);
 				goto failed;
 			}
@@ -960,7 +960,7 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 		}
 
 		if (sscanf(str, "%d%n", &cpt, &n) < 1) {
-			CERROR("Invalid cpu pattern %s\n", str);
+			CERROR("Invalid CPU pattern '%s'\n", str);
 			goto failed;
 		}
 
@@ -977,20 +977,20 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		str = strim(str + n);
 		if (str != bracket) {
-			CERROR("Invalid pattern %s\n", str);
+			CERROR("Invalid pattern '%s'\n", str);
 			goto failed;
 		}
 
 		bracket = strchr(str, ']');
 		if (!bracket) {
-			CERROR("Missing right bracket for partition %d, %s\n",
+			CERROR("Missing right bracket for partition %d in '%s'\n",
 			       cpt, str);
 			goto failed;
 		}
 
 		if (cfs_expr_list_parse(str, (bracket - str) + 1,
 					0, high, &el)) {
-			CERROR("Can't parse number range: %s\n", str);
+			CERROR("Can't parse number range in '%s'\n", str);
 			goto failed;
 		}
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
