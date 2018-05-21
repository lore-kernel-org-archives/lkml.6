Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1450116-1526942717-3-9045897818434238807
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
    1526942716; b=cKFhBWXFr7MRX34iEudtgOEW4OEntHlDNVS7KxghHjNVMyLpGi
    2jlsQ4gJLBh94PjElTDh+UGnxweAPmXCjdsuEqkWR2IexJH71/BZluQ4AmPDnMjB
    /SmU/V3AkWaM9AYfS6K5pYlCMi9iMOOHdnRlAPHzUYnqviZ3jPOLsM8z0gz87++e
    yaWGdrjZ3yeHm3RoO3FqMnYaPzxZQ7R3SlvumhtaWj3cH2xso/zx3i1VkKH1gkzi
    eks19Wd5aoujkMOKAuZN9f7NYHXcuXj21xxO3qNjNT0+XPFb2V3PhC7AGJ+xqB2P
    mLImWf1KSo7RJ/J/MdaIi6hKPx6w+T7Qx1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526942716; bh=sCD8m1E3AV3WBskxFZPQVCWCmLQLaM
    jiIVZ+iC27i+o=; b=HNSSeGAsvNR2acjgBk9eKfKCW8VrxZ3hzunDgrAHGO/W15
    X+MFEmd8/hmtBfhVU06DEMj1Za/sYzQzR001wCi3x/uoPvkWtIoRzqr4gm+1WK2Y
    4XJdwbhssHb72AA3RRdAViktigegZx8mABVXYVUmvSIPPaf3zDFbszH28WSLD1AI
    Kyy+V69ZrdLTl1kufZQbvahLtaB1XgvsBCzztKMaAQQF19bqQDXjo76XNsvuWlRI
    i9E9yy9xCrhOjB68CGfLfJudQKNVjC8vXiCKpqi9sE2NPiP748uJP7SjxQa93L2u
    WoxfV+YByRpCbaeRkV+CXaJ0hKCPuJsOy++8to7g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGi5M/CfaxcL8fRikMvVp9wZPzxY/5wJvu7wyHR8tKG35/8oWBTS2httx0UvPrH/2kcO8sOo4Nz3IXrgc8Kpv3sp/GTop6c01daDMJpCblZ+pPtr68Ry
    uJyvzGPPSh9tXFdx1UBuM2UNBiLymwhROph+SognjY0ArrKPWkQ6/VrLNA2dEtp+Ve/2e2+TCw/BbwFU1uXPY4KuF+LrimGNo/Tw+udBYl0B8aFyFExpEVcn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=wQXKdW6MxTjcW9zIw0wA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeEUWpM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 18:45:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:28501 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeEUWpL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 18:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="52713699"
Subject: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date: Mon, 21 May 2018 15:35:14 -0700
Message-ID: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew, please consider this series for 4.18.

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

Dan Williams (5):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: handle errors allocating final devres action
      mm, hmm: use devm semantics for hmm_devmem_{add,remove}
      mm, hmm: replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL


 Documentation/vm/hmm.txt |    1 
 include/linux/hmm.h      |    4 -
 include/linux/memremap.h |    1 
 kernel/memremap.c        |   39 +++++-
 mm/hmm.c                 |  297 +++++++---------------------------------------
 5 files changed, 77 insertions(+), 265 deletions(-)
