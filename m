Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523851839-2-11682676848376842575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851837; b=nPVIxV1mM3/LfRMbi2TUfC4F6pBRiV7qOXWRANgcRglM8udQ//
    Mi13BjtlvdqYE5FHBS225U8oRhdXg+gVkuxmF3JxlAJxCIrkbFNdJWp+eZbNoxaK
    ktW5Vmbg9+0SlG4NHZCM9dlfrB/XTD3QFlGDC/57ntNY9v6jCpUNnYvZkdmNi3pY
    2YN2HrWdIilrcm1jnBT0DBM1grZlNOogPNlUXOJC/P8lS1+Mcmp4g5Erif08l5WT
    O4VsBO7i1XFdhZ8GTrTT569Mj+zEA6pVPB4/sMOabNsTKzr6SPByFuEGVnAWXqZK
    f10gKHLvzBNJ9n7ddfQ2ksMrd7b0zNF85ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851837; bh=YXfVT
    73tP+P+YtwOFtPWLcSPPpS9oWlThxqcZ5JBXvc=; b=S5Ji+Y47JUBS3h+/hv/Xo
    CG/d+4sF1ZpFxGDIc6DlkKXtLHNRED1sidMRUd1th30bapu5+x2CGJiWhAy/CJxk
    8tF7OyL30Xzjfs1pNg3fh0jxGfgcC+7R8GOC4bMTxPC9hDXa5b7GUc3D5BZtd94+
    2TeEjW070DNI7/4HuOd0Ja8X/RuLWRotF5rX5DirzPUEYvsk8CenaZ2cMsSzfYqJ
    6xBQDJOK7KaLnz06E1e38+ziRxQB60LhgvFJHCZaXsZAOoLmI//Ulh2Ad4rpgpAx
    y/8K/YTprU1Rq8n6Qk46/F6mTjE+1PArDf51hykQrTA7Dt/aqDo/CZa0I1OErU4t
    A==
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
X-CM-Envelope: MS4wfG7x9MxpUvJXuXkkZIPTFPpcPYz4LEzTudiHGq+8Cxbh9CjdjnQzDqHMqaCNFrsQPoXIpYsA0yp5jvOiimRTdYUMxPeH811hwB3u4omZkPZHzNU1PcuP
    wv0w/ZvMgochp7yI14S0bmU6pdhfKB+rq4JpByD98fAbD7lk+cmJxu9cItJrCGm51tik5iyEouTVwSv6x2qbOx012gwoh0BuiFTdXN9E2OyNZr3DdvrXp9N1
    qXQb7XMk6a1IllZnuzQXyQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=A4x1lHrSnH6UyoULov8A:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 17/25] staging: lustre: libcfs: rename goto label in
 cfs_cpt_table_print
Date: Mon, 16 Apr 2018 00:09:59 -0400
Message-Id: <1523851807-16573-18-git-send-email-jsimmons@infradead.org>
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

Change goto label out to err.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index ae5ff58..435ee8e 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -161,20 +161,20 @@ int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 
 	for (i = 0; i < cptab->ctb_nparts; i++) {
 		if (len <= 0)
-			goto out;
+			goto err;
 
 		rc = snprintf(tmp, len, "%d\t:", i);
 		len -= rc;
 
 		if (len <= 0)
-			goto out;
+			goto err;
 
 		tmp += rc;
 		for_each_cpu(j, cptab->ctb_parts[i].cpt_cpumask) {
 			rc = snprintf(tmp, len, " %d", j);
 			len -= rc;
 			if (len <= 0)
-				goto out;
+				goto err;
 			tmp += rc;
 		}
 
@@ -184,7 +184,7 @@ int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 	}
 
 	rc = 0;
-out:
+err:
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
