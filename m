Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3649678-1527052818-2-5713206701683047473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527052817; b=kODJBo+7mHln/Uq5q/NN0sanqonrYcJKm1s9LbgdMn9QYSoUiX
    x2msWomn4IqjJRLKiCxMATKDPZR6pLw0IJYcWu+2RS3eSn/NIt7DpQV8JkA91QRl
    Jgws2InR/OYuyCTDv5u6KPRGXv8fAjCEEkw17VvCFkGyNsxLm4yia4IXyDo8kw9Y
    heCM38mI3VsXpWCTNLD+LSYhH+WEleBTGuyX2b+Xt3RMop5zyNJ+VzEi1wCQ8sWM
    DYimk0NaBujEi2N+m1PM8l9vIZVp+TIOaBnkjHe2lMo5Pr1UXBse4io/QrVqPwzB
    g8wtxGGr8EmQpvTuZZm7t+D6D96FPoJdPrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527052817; bh=lbR4RWuaMKWJyuKGi2OikpoyofrT4k
    60M1yvkRS5qUw=; b=QEahj5Tm0YV8mvujY8rckwTzDPOo7ViS2yMz2kFF7fXteI
    SI8F/gFu0QKCGdrpaXSud2McSNxkbF83yjJc/gYZZYenv48WaGuNZ+igaj54Riui
    uw2dpQeTwreZvvWZ6+A9QIt5aLoT1uLMPpIm++2s58raKfoeCfl1k992sfmtJaYk
    JTMuY/r04OmF5olV+40G+EPreAJv9L2cZPvPQZSnLpxSVLXOIF+bvj09kRMmFRto
    CBxBA5UM0/hAbawdDU5GqmyWtJGz0sWDfYxRARFgG3ZN0CFxf1HpkJjbKOwZMfTW
    NcsKPOtuIcUdW63yfXGCeP0eedMvM42vKksrm8eQ==
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
X-CM-Envelope: MS4wfEmfJ1se/fnM6ICnM6UiiFwd6vLCu5d6VdovmnxoDYhxdzbQiL0HqTS8KsyKprxP19cj9cOh4TaMNVXgpPH4mZrLJHCFoafkelNSywkba0l6StpnQ57Q
    lCyV1Stj0LyTQ/L13CYAEGM9RSlWpXDLEuk1aIV1d2Sg+nfLgWwRZhODEN7WAZaPLlzXPex3tBxSQtoutPyF69mYnnShLANOduKdu/GbC38KeK8YHhGTNLmg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=D19gQVrFAAAA:8 a=MgTO5YS3Dgot8pfIxtcA:9 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeEWFUQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 01:20:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:5068 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbeEWFUP (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 01:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="51454456"
Subject: [PATCH v2 0/7] mm: Rework hmm to use devm_memremap_pages
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 22:10:17 -0700
Message-ID: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since v1: [1]
* Kill support for mapping System RAM as a nop. No one uses this
  functionality and it is broken relative to percpu_ref management.

* Fix percpu_ref teardown. Given that devm_memremap_pages() has strict
  assumptions about when the percpu_ref is killed, give it
  responsibility to make the live-dead transition explicitly. (Logan)

* Split the patch that adds HMM support to devm_memremap_pages() from
  the patch that converts HMM to use devm_memremap_pages(). This caught
  an incomplete conversion in v1. (Logan)

* Collect Christoph's reviewed-by.

[1]: https://lkml.org/lkml/2018/5/21/1109

---

Hi Andrew, here's v2 to replace the 5 currently in mm. The first and
last patch did not change.

For maintainability, as ZONE_DEVICE continues to attract new users,
it is useful to keep all users consolidated on devm_memremap_pages() as
the interface for create "device pages".

The devm_memremap_pages() implementation was recently reworked to make
it more generic for arbitrary users, like the proposed peer-to-peer
PCI-E enabling. HMM pre-dated this rework and opted to duplicate
devm_memremap_pages() as hmm_devmem_pages_create().

Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
the licensing on the exports given the deep dependencies on the mm.

Patches based on v4.17-rc6 where there are no upstream consumers of the
HMM functionality.

---

Dan Williams (7):
      mm, devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: Kill mapping "System RAM" support
      mm, devm_memremap_pages: Fix shutdown handling
      mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE support
      mm, hmm: Use devm semantics for hmm_devmem_{add,remove}
      mm, hmm: Replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: Mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL


 Documentation/vm/hmm.txt          |    1 
 drivers/dax/pmem.c                |   10 -
 drivers/nvdimm/pmem.c             |   18 +-
 include/linux/hmm.h               |    4 
 include/linux/memremap.h          |    7 +
 kernel/memremap.c                 |   85 +++++++---
 mm/hmm.c                          |  307 +++++--------------------------------
 tools/testing/nvdimm/test/iomap.c |   21 ++-
 8 files changed, 130 insertions(+), 323 deletions(-)
