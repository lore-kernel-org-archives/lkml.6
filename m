Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851844-2-13532023844102687319
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
    1523851843; b=iNz9vLLc6KfCc+RCLzHpD0Wa67fy2t9H/VQl/M63of2vN3WMyR
    pVQOzrMeyzQwUxoED+8xCMZPuTGrP8hKna0sGvXfFchgZmKtlNVmO65w+XjV73Ga
    X6RsFeYwoyFcI4UhPBoKMpH4mee8wbXDBp9h+X2knBMnsM9kDGLzuMu1aV3sDY/s
    tJKe1W+KyJw2p1riycmof+26wMIAJOB5SjifTldpNeRjHljsaUJzK2uFGFgUT7Us
    YZ/qti3VLJRVaD9dwa7DsurQJ8fKXnBcaOVX8PywbzoUAbF0cjxbCwPjjiTs9UuM
    8Z6XNXGumOEx56chghw1sliaZItsKM+wnc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851843; bh=jb3J+
    SIACFJl9rTTTRd98H+mArYT6MVmHK2dWadXXw8=; b=Cn2XwN3Z5vT+Zg7YVb9pp
    oaLOJNSlUkl1Xw4cfvz+9WE2l4LrZVbqgpveE+4Wxoh46RVUO53lEeCrw0Rr3ddA
    I3U1LEvTIQluhWByheROxmzpUf+70Qa5aCFyYnjmfCaDvXIERWnOp1PBbNHd2xNZ
    gVbqP5QPWs0NCao+kJ2nlidAmBxjnt4EQ7RhrB8H9AUE8q2q6tFfKSyWNTeNd9QB
    fjq6Lzv2OAzYo+FC/kadkXWi0H8Bj7zsfCpeBwW8GuyRM8dIywhJwov/PZX/7g0G
    3594ZCpiZOBrlNvQCJCBGrK0Jkcj4qoyBsRIsU3v0zqPNQaWp3bi1bzgoWQg+2j4
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfB8nryKI6X6XN5SpY/xPKAm7jjKZMeKQw7Wf6yqWbCTphVCQS37wUng9QXJACAw9oO/CPtmty9HDGN7BWFFMGBxBTqNhuTv0hGVxr3ZGc7tPIXFEDmXN
    ye8UUpB5mIzXfspFRlLTSa8oJyeOs4hjZdXE6gkpDNvCmrgQINyUdoknmj7Km3gDaCgvZLNGtqXdeqr8zcItI/FzjCa561drrIbmOkdkQoAxCa0lA3O3jCI/
    m9FJ4873NXv4/PMkBZIh3g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=kBl-OI3rAAAA:8 a=MvuuwTCpAAAA:8 a=JfrnYn6hAAAA:8
    a=DDOyTI_5AAAA:8 a=86DVg9xqzNvRCHOuqD8A:9 a=eyyjjvTGHaLEUTiZ:21
    a=N1TKTXwWhhxLTWHK:21 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=pLxN2xGgR0OPbCgNAGn6:22 a=dVHiktpip_riXrfdqayU:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 21/25] staging: lustre: libcfs: report NUMA node instead of
 just node
Date: Mon, 16 Apr 2018 00:10:03 -0400
Message-Id: <1523851807-16573-22-git-send-email-jsimmons@infradead.org>
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

Reporting "HW nodes" is too generic. It really is reporting
"HW NUMA nodes". Update the debug message.

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
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 80db008..28b2acb 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -1108,7 +1108,7 @@ int cfs_cpu_init(void)
 
 	put_online_cpus();
 
-	LCONSOLE(0, "HW nodes: %d, HW CPU cores: %d, npartitions: %d\n",
+	LCONSOLE(0, "HW NUMA nodes: %d, HW CPU cores: %d, npartitions: %d\n",
 		 num_online_nodes(), num_online_cpus(),
 		 cfs_cpt_number(cfs_cpt_table));
 	return 0;
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
