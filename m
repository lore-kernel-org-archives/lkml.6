Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4175590-1523113261-2-9314606017710325518
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523113260; b=JfiFAhZAW+NPWBDbivOLZYP4aZfGE+ztQS6wfeJPs+MvFSfv7L
    7JDTclC8M1FBhHkAiykne3/CEHwTcWIB7XzU3qrEW++HuPnl/UI6pj8xwbYZsg3z
    mNyHnyitdFQ4JiQ4V3GNkHQIZhvSLQIcOiucww7AQ92YNlWCHyvSgxEjFcerJ8nC
    84VxReaXwS3sCrqNuhm8VXwBoEWFm2RuQVLtggslzul8BvBq/r078JJR9D0rzx45
    N9KxRbd11DMB5LdUtbhCK32z2H0EBX2eUF5y8rZHndtqvBJLZcUq8Vzr9dodhLK9
    30Aqy0L+GXxaeeDnOaYItZzKRcjBYtxIsUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523113260; bh=Kjlvtj8kmf5uaWvugpWv/VE/yklp40
    GXfPzZBhoFmiM=; b=TuUYbf+99kL/mUHnYvqSZjrrDe+2Cd1nUQO4GdQUV2aRIX
    44Qti29F5B00pJDqrZ5uaz6Fk7XPU1IuIEEYYHb/sr6gFVdJcp2Xeb43mwTthqnv
    8Mv/ncVa0Pl9MkmFPuyDDrKBSm54gXysV8Ssl96Q7/DEH2TKN+S9CUBuDdtPgJLm
    ZHNzaTUpbm06x+00KKEKy0HIkYC4EzIQPzps5VcA/hWeemiYaITSeImCy2gUJpHZ
    d2jBPm2O0Kv4kv7NEmOQhVmV1Lc8g/hlFivc82w5oCJnHGybuJ9MhhOIt8hwaBx8
    OWkkgC3ha8umQdChmBObq21zp2qkjqHag38Iesnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCeqn5upTbFTOd7IEGZZQYJP8OlpGb4AKZp6uPHHzlm+ST25ee1qqLG+3n+Kr2daMwbiCpQr/5Ng9LJNeDKLOO4JjBqW/1Uz/OlSGZAvokeiZbJVXXII
    QqmPqoWxmCgoX0YHtfx12cmZrVwp3fpfbEk0Y3gC6/caQvuFSXntu2RSIIurI9+EjLxmV/aRUP2HVrfOnhMFHBB5D46L0rN2k7SyiC+Y+SkvEi2v5fr41B4t
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=MJNPoyvyYSJl_GFrPXoA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeDGPAu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 11:00:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:44238 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeDGPAs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 7 Apr 2018 11:00:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="41459314"
Subject: [PATCH] libnvdimm, namespace: use a safe lookup for dimm device name
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 07:50:52 -0700
Message-ID: <152311265227.13507.15898106957113137141.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following NULL dereference results from incorrectly assuming that
ndd is valid in this print:

  struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);

  /*
   * Give up if we don't find an instance of a uuid at each
   * position (from 0 to nd_region->ndr_mappings - 1), or if we
   * find a dimm with two instances of the same uuid.
   */
  dev_err(&nd_region->dev, "%s missing label for %pUb\n",
                  dev_name(ndd->dev), nd_label->uuid);

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 IP: nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 43 PID: 673 Comm: kworker/u609:10 Not tainted 4.16.0-rc4+ #1
 [..]
 RIP: 0010:nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 [..]
 Call Trace:
  ? devres_add+0x2f/0x40
  ? devm_kmalloc+0x52/0x60
  ? nd_region_activate+0x9c/0x320 [libnvdimm]
  nd_region_probe+0x94/0x260 [libnvdimm]
  ? kernfs_add_one+0xe4/0x130
  nvdimm_bus_probe+0x63/0x100 [libnvdimm]

Switch to using the nvdimm device directly.

Fixes: 0e3b0d123c8f ("libnvdimm, namespace: allow multiple pmem...")
Cc: <stable@vger.kernel.org>
Reported-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 89b40ff83025..28afdd668905 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1921,7 +1921,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	}
 
 	if (i < nd_region->ndr_mappings) {
-		struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);
+		struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
 
 		/*
 		 * Give up if we don't find an instance of a uuid at each
@@ -1929,7 +1929,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				dev_name(ndd->dev), nd_label->uuid);
+				nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
