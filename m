Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851827-5-9137425025034318332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851827; b=Clf9yqWI5SxYqHicy0I+hJf9M3mD66svOgxRRoVXj4OacR3i1M
    g7cwdpSFDd+fOgMWCp1Qf2IKuWsNqTCyQzzWNRqs8kEmoyLsMNt1p2x50L0+IT8d
    V3a28D0WtyliuEp9ezEu7zQQtiVXcF3uyXvRZcGiyc1r/evNdT/9VTgGVY42QxN0
    qxZWT3adrJPA8pp4JLIsyQKBg39fxaj2TS6WNmLoxNICMWV4+GXgWw7Ix2MlggXO
    pSk+5jwCOpymXlI5ZsmlmjwBUdGsKJ6+P14VNx+b5rzgcNft1EbSuA3gD2WdU1Yj
    QaWvtivJiXqT1aVlxY/9QwA7tWamHauF3pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851827; bh=sD7I0
    k9gaCHPA9BI1kVZipSwf8jUqkxNs9jgpQQWtAw=; b=hlz7YHYT0+jdPj6Y50nI8
    x5NB7G7lZtJQphFgEYLH4BI/b9FdBhXXJ2aoToF4vJji9F5L8mLbZN080nrIHGra
    YWjPW0liM1t403qBbkKldCtXKXnR5DXH3mgWA4VJRvy1vfAOaRYqY+9f5/DXeMAH
    MvGOVbJbUit084NUgnvm7v49c0rp60xZR5qqesduVj49yMVb+DP8NA3+akO+I6z8
    SpFEmFJbzk0skQ05lvbHPlQE/H0ZblPHxuXcbVYmCp68wFPRUwkd3l8Qaook6Xs6
    SRUhfYuYOSuhvs5EWeNZnYqkNO4bBCSYc1TVlqHmMWyDoF+dNuHeNCs86FPN1bwu
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPtXwL6VqEOdjGJD81zxtya4GuYDji4sHEUHKd7I1QU11udc3xMEwKRWynrvGM8i2+uFN2qYjZoPAP4OPnn910d4uDBKW1e3UEeqKPlIP3A1cyq2LSMX
    oUBSxRtFXXKYGIGYVDF8Oqaeb0K3L4wThIE2VZLYVWT9CvAzeTt2ekO2RtxR70ASwfJW82FYlJmhWXpTvBlOaMnMdHlrPymGsyIJ0TlwlwP2rr4cQHGtJD9t
    qy9tUEE5gjLFFnOV4GVbZg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=74Icq-6CX9mtowBv7goA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 04/25] staging: lustre: libcfs: replace MAX_NUMNODES with
 nr_node_ids
Date: Mon, 16 Apr 2018 00:09:46 -0400
Message-Id: <1523851807-16573-5-git-send-email-jsimmons@infradead.org>
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
Cc: Amir Shehata <amir.shehata@intel.com>,
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

From: Amir Shehata <amir.shehata@intel.com>

Replace depricated MAX_NUMNODES with nr_node_ids.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index d8c190c..d207ae5 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -368,7 +368,7 @@ struct cfs_cpt_table *
 {
 	const cpumask_t *mask;
 
-	if (node < 0 || node >= MAX_NUMNODES) {
+	if (node < 0 || node >= nr_node_ids) {
 		CDEBUG(D_INFO,
 		       "Invalid NUMA id %d for CPU partition %d\n", node, cpt);
 		return 0;
@@ -385,7 +385,7 @@ struct cfs_cpt_table *
 {
 	const cpumask_t *mask;
 
-	if (node < 0 || node >= MAX_NUMNODES) {
+	if (node < 0 || node >= nr_node_ids) {
 		CDEBUG(D_INFO,
 		       "Invalid NUMA id %d for CPU partition %d\n", node, cpt);
 		return;
@@ -809,7 +809,7 @@ struct cfs_cpt_table *
 		return cptab;
 	}
 
-	high = node ? MAX_NUMNODES - 1 : nr_cpu_ids - 1;
+	high = node ? nr_node_ids - 1 : nr_cpu_ids - 1;
 
 	for (str = strim(pattern), c = 0;; c++) {
 		struct cfs_range_expr *range;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
