Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851830-3-11914506661241667776
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
    1523851829; b=WFCU3UGdVDI9wuO6oHv5YXZNpGLwYxN55skaEwSCeUhPDusZqA
    0IINT0uaY1uy39JjXT3fYFeA3e7CzhNa5pi/6pJ0ufX1OAXsyLRHtYIVP2eaBBPw
    0YLcs3U7F+0J7AeyZx2b3tfd4l7/iDFXDNHQ1bo8+Vvmc3RJ6MdkLisvyHokSHIV
    JZQCbFkSKwUmdl7nH5UmrVfKZ8wLCKiNtyifYppDrMClf7Lyv4Yw1saiHp+jDYlu
    odAExjE44QYXblS/NCu7thMbRnH4sCEKjW4nPe8eYZChIxQZARkwWGclemx+EVbk
    mbxQN4m+SjbVUvVD+755uRyCtVUCzg0ymjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851829; bh=Wfoct
    lVtYJmW5mMFP1oImx1pk0OaWIW1dMJqsIFWJ1E=; b=ZqNqESQqqw7pyQz/8zhQZ
    ckTc8qFiMoJUY1ZdKv4wbFqdWm+LtUOwdBqT3j5tRj873BiV03KORWzWowPEgou+
    tMMQW/eP7p7qM28tKYpF9YuITg2gW4KAK/pIENESUAdQxWW6+7btiXGIP83tP2PP
    XyqI3LKIi061UR415ncBqQI918h163lezUJywZHTJuBcvvsn9mHjo/cxQ44qZih2
    y/HAsvmp6IpoOudf4TI2fh3RWPVwyItlFaoko3znU4YkScYIPYUoLOQdeTsGv4qI
    xJtYiUUyk2qUPIUbWARXG2LxwOwxgfIxwCXbhtnieynLlN/THdqLTS3sNqhQFaN2
    Q==
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
X-CM-Envelope: MS4wfCGVmCsm1GgysO+zJD+fAmIsZoMNVmvHliArfGHTUB/rVHICheRRYJzNTIT1/PARAYhOPfF5ufbJ4b1qswVCWa8U5Ia/bvtMhqPygbSoX+RwQ07diej8
    sbHllboLjXvmFmBgRPKOnOF0WH3Wu8jZ1U+p8oaoFdd9GO/wR4YRGUQJX+tsnmPpSpszSF5J53ehNoenVVpfn+5zXkkKtGNPDg5Ab4Knx9lFSgsT4LvZ89Im
    JBTSNUAYSmtPQoK4B6Tvsg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=Hp1nwjGFV1aQ_ZM79WcA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 10/25] staging: lustre: libcfs: provide debugfs files for
 distance handling
Date: Mon, 16 Apr 2018 00:09:52 -0400
Message-Id: <1523851807-16573-11-git-send-email-jsimmons@infradead.org>
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

On systems with large number of NUMA nodes and cores it is easy
to incorrectly configure their use with Lustre. Provide debugfs
files which can help track down any issues.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/module.c | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
index a03f924..95af000 100644
--- a/drivers/staging/lustre/lnet/libcfs/module.c
+++ b/drivers/staging/lustre/lnet/libcfs/module.c
@@ -336,6 +336,53 @@ static int proc_cpt_table(struct ctl_table *table, int write,
 				    __proc_cpt_table);
 }
 
+static int __proc_cpt_distance(void *data, int write,
+			       loff_t pos, void __user *buffer, int nob)
+{
+	char *buf = NULL;
+	int len = 4096;
+	int rc = 0;
+
+	if (write)
+		return -EPERM;
+
+	LASSERT(cfs_cpt_table);
+
+	while (1) {
+		buf = kzalloc(len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		rc = cfs_cpt_distance_print(cfs_cpt_table, buf, len);
+		if (rc >= 0)
+			break;
+
+		if (rc == -EFBIG) {
+			kfree(buf);
+			len <<= 1;
+			continue;
+		}
+		goto out;
+	}
+
+	if (pos >= rc) {
+		rc = 0;
+		goto out;
+	}
+
+	rc = cfs_trace_copyout_string(buffer, nob, buf + pos, NULL);
+out:
+	kfree(buf);
+	return rc;
+}
+
+static int proc_cpt_distance(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return lprocfs_call_handler(table->data, write, ppos, buffer, lenp,
+				    __proc_cpt_distance);
+}
+
 static struct ctl_table lnet_table[] = {
 	{
 		.procname = "debug",
@@ -365,6 +412,12 @@ static int proc_cpt_table(struct ctl_table *table, int write,
 		.proc_handler = &proc_cpt_table,
 	},
 	{
+		.procname = "cpu_partition_distance",
+		.maxlen	  = 128,
+		.mode	  = 0444,
+		.proc_handler = &proc_cpt_distance,
+	},
+	{
 		.procname = "debug_log_upcall",
 		.data     = lnet_debug_log_upcall,
 		.maxlen   = sizeof(lnet_debug_log_upcall),
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
