Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851840-2-10265465970264489198
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
    1523851839; b=SXRhDKmBAg39nFi3AKUp+E62fdnBiZm9xTLgnwRd6kjba1OKy1
    CIF+f9leT6gezTU01Xm2XDMj4sQcPqtIefr8U+Rv+3b1GNfAezDbDF/ksLrBJ6eY
    gUH+xrn9Ken6PYvPl9hJSU/IG5W0iVZkgw3/Du9LltHH1N4CE/XPMfd84N2LvhPY
    bIMThL2t7GeccG71ALGmUPIq6VfghPD1SuwIG6XizorCO1PEffjU1h6O51xgEKSf
    /mv04rkV3BXaiJ3hGqFikoALsIion5dMBRt52CsrcDvKTnyG3xfRAQG10S4dnELa
    P4nPH65nCblY682dSoU0zUkJGblal6f/EPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851839; bh=VG8cf
    PGOOE/y0ohoCyDSMijJZC+Zs3C61D1+6iYQc2I=; b=brFxepwhiL2gVOXqShE88
    j8ISTQBltmqO0gpTpTjZ/v/Ou8Z4K24PRi15qEQSJfoaCmIuSuKq5PBuxyHCZs1T
    N7cRuBDP3UbnBuovBBtdxfekp9XBEhrqxAfN+vpmcR5yQKPyytf89q3E2de5j3/Y
    LrVaSXZwgdwgne0NjqRZMcY8S1/vHttg+8rRqLlpKikG+BNEqSaBviqQW9rRnIz3
    ezhHPHy/4ZQGzAB83KkkiY7Tc5kC1qToCfL/lX3CafZfun+AeNIMO0UPkqwrgnbI
    pODPYbXZF7MHiyivlaWXdZkhqwRbzY447XuY5kuvlVcrZMvEibAPsRRcQM1FcUjg
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
X-CM-Envelope: MS4wfKMtg7SEtptV8ojq4aQN9zTwx1qmPHoO46mIy/Y95iSN2mhKJjioJgOD4PZ+rcyf1TiNFASE6hyP8lrnf6tOSejAmGjk4L0YCp5jtF/AgBoJvYiXOYvD
    LJxz9tqqWPDHnQOOhPNaU+fXbC9CgeMwgIc5P2YitmRWR3pkYLH4wvsqE1f505xfIibVIU++yvCKF/A+Ncmhumf2ndzkj4IQS/s2Ac36gc1X4XVF1IVvWXuJ
    Nqkvy9W2VrjBlLbtjT6JAg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=Rs2o5WIsgiskSj8yFDUA:9
    a=gQbfib_qL8cYl1iE:21 a=QSSm4e_QwFUS-uan:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 19/25] staging: lustre: libcfs: update debug messages
Date: Mon, 16 Apr 2018 00:10:01 -0400
Message-Id: <1523851807-16573-20-git-send-email-jsimmons@infradead.org>
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

For cfs_cpt_bind() change the CERROR to CDEBUG. Make the debug
message in cfs_cpt_table_create_pattern() more understandable.
Report rc value for when cfs_cpt_create_table() fails.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index c4f53ab..32ebd0f 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -655,7 +655,8 @@ int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
 	}
 
 	if (cpumask_any_and(*cpumask, cpu_online_mask) >= nr_cpu_ids) {
-		CERROR("No online CPU found in CPU partition %d, did someone do CPU hotplug on system? You might need to reload Lustre modules to keep system working well.\n",
+		CDEBUG(D_INFO,
+		       "No online CPU found in CPU partition %d, did someone do CPU hotplug on system? You might need to reload Lustre modules to keep system working well.\n",
 		       cpt);
 		return -EINVAL;
 	}
@@ -886,8 +887,8 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 failed_mask:
 	free_cpumask_var(node_mask);
 failed:
-	CERROR("Failed to setup CPU-partition-table with %d CPU-partitions, online HW nodes: %d, HW cpus: %d.\n",
-	       ncpt, num_online_nodes(), num_online_cpus());
+	CERROR("Failed (rc = %d) to setup CPU partition table with %d partitions, online HW NUMA nodes: %d, HW CPU cores: %d.\n",
+	       rc, ncpt, num_online_nodes(), num_online_cpus());
 
 	if (cptab)
 		cfs_cpt_table_free(cptab);
@@ -1002,7 +1003,7 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		bracket = strchr(str, ']');
 		if (!bracket) {
-			CERROR("missing right bracket for cpt %d, %s\n",
+			CERROR("Missing right bracket for partition %d, %s\n",
 			       cpt, str);
 			goto failed;
 		}
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
