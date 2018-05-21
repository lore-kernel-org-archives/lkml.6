Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449503-1526942776-2-7953022961872081053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526942775; b=nlKDSTHgPQpSb0YIsN+F+alG6O2RWad4VNl6BZYoD5FGN9TSzo
    rcXuJDD3zDCcxMRldlRinL+K4sCqX/YqcNPxRJpH5sRIW05oSBan3IaFjX91cDf1
    evv9BUvOJorezZ0Cttu87V7r5/+4v6UiCxrxtqhGn5m4R3aWiKsSMaTygOt21NpQ
    7Hd//m6KRRa3Me0yrnc8U927nCTN1lYyFuzocTWhv+p0RE8+twVu21HSVN017rxU
    irmXcJwVQFislyyUJ+oMdXwAFU2QgisiOC2Kq4EGd7r48RMSXP53L1pM0IVKNjxQ
    0fBZJ1sKmYOcjRI5pgzm/6y9oZWjihD/uTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526942775;
    bh=hbeADj5VEdJCMLPcsBKuc9j+UyvB1Lw+KDJYgrneSrg=; b=ChrCJMgPPiKC
    XVkWEBgYiTTYrkTwJv/n8Vc9zGkm6JuWKBvR1u4vhYX4HEr5HLTLJ1qOtBS3rzKb
    nk4doRXfadhx0eghHfY9LoAe47M855aKRJ4BYQ2hmnLJzWsShpDySYRPfEv30JB7
    IjNvdAD2I4hOpNc0USr3OgoybII97LoFun01HZYEbhdv+cerHA0DMbwl2NJCBHCz
    GUhIAwvIP/1/CBoQgPSm52eyuh+D2mHdgRMZZmfAKKKW2ApNA+mvQe95pwOO+1PD
    XMq1L6uDp8Ho4tmV33tYXUVDh6PlN0Aohy3TI8K73pmnyYv/rLhg/n2881vzA/Fo
    X0b1N6/BWw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHoMiJFg0usdLf3p9Az4Yp9tN40q36M60Xh3H39ObbFxGq85CTLK0skx5vANaaPwnCdAKT+1o0/aiDC/g2c9aupzWQ9qEkXe9z90Mq0g2NxmbuwT/bqW
    xAnNpESU3W1BUV2hUbElsuo9PdjAZ01PjffCLaSd2ZTcIuofJfj3lM0FMQdmPqeH2OfVMKwFa0ZNo4rIxDF1oMXnn6OVzm+ubY5Uf+SmvIOKxRs+cdSyXG+9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=gXLdhW2jAAAA:8 a=QyXUC8HyAAAA:8
    a=fV8xDA9rCoNHS-mBjTkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEUWpZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 18:45:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:48426 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeEUWpW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 18:45:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="43098907"
Subject: [PATCH 2/5] mm,
 devm_memremap_pages: handle errors allocating final devres action
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Mon, 21 May 2018 15:35:24 -0700
Message-ID: <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The last step before devm_memremap_pages() returns success is to
allocate a release action to tear the entire setup down. However, the
result from devm_add_action() is not checked.

Checking the error also means that we need to handle the fact that the
percpu_ref may not be killed by the time devm_memremap_pages_release()
runs. Add a new state flag for this case.

Cc: <stable@vger.kernel.org>
Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |    1 +
 kernel/memremap.c        |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7b4899c06f49..44a7ee517513 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -115,6 +115,7 @@ struct dev_pagemap {
 	dev_page_free_t page_free;
 	struct vmem_altmap altmap;
 	bool altmap_valid;
+	bool registered;
 	struct resource res;
 	struct percpu_ref *ref;
 	struct device *dev;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index c614645227a7..30d96be5a965 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -296,7 +296,7 @@ static void devm_memremap_pages_release(void *data)
 	for_each_device_pfn(pfn, pgmap)
 		put_page(pfn_to_page(pfn));
 
-	if (percpu_ref_tryget_live(pgmap->ref)) {
+	if (pgmap->registered && percpu_ref_tryget_live(pgmap->ref)) {
 		dev_WARN(dev, "%s: page mapping is still live!\n", __func__);
 		percpu_ref_put(pgmap->ref);
 	}
@@ -418,7 +418,11 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		percpu_ref_get(pgmap->ref);
 	}
 
-	devm_add_action(dev, devm_memremap_pages_release, pgmap);
+	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
+			pgmap);
+	if (error)
+		return ERR_PTR(error);
+	pgmap->registered = true;
 
 	return __va(res->start);
 
