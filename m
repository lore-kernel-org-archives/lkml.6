Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18797C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7C32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBKDng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:43:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:30254 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKDng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:43:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2019 19:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,357,1544515200"; 
   d="scan'208";a="113906495"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2019 19:43:32 -0800
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/7] iommu/vt-d: Remove unnecessary local variable
 initializations
To:     bjorn@helgaas.com
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <154966356809.132359.5318207850182898116.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <63ae370c-2239-62c5-2378-98916608acc4@linux.intel.com>
 <CABhMZUUKe0b9RkscDX6WR0tpQmhW_nFoYKHTvthpKwZ4vMirOA@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <886e860a-f620-7b12-2611-228adcfa82c8@linux.intel.com>
Date:   Mon, 11 Feb 2019 11:38:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABhMZUUKe0b9RkscDX6WR0tpQmhW_nFoYKHTvthpKwZ4vMirOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/19 11:33 AM, Bjorn Helgaas wrote:
> On Sun, Feb 10, 2019 at 8:00 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 2/9/19 6:06 AM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> A local variable initialization is a hint that the variable will be used in
>>> an unusual way.  If the initialization is unnecessary, that hint becomes a
>>> distraction.
>>>
>>> Remove unnecessary initializations.  No functional change intended.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>    drivers/iommu/intel-iommu.c |   27 +++++++++++++--------------
>>>    1 file changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 81077803880f..2acd08c82cdc 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -865,7 +865,7 @@ static void free_context_table(struct intel_iommu *iommu)
>>>    static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>>>                                      unsigned long pfn, int *target_level)
>>>    {
>>> -     struct dma_pte *parent, *pte = NULL;
>>> +     struct dma_pte *parent, *pte;
>>>        int level = agaw_to_level(domain->agaw);
>>>        int offset;
>>>
>>> @@ -922,7 +922,7 @@ static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
>>>                                         unsigned long pfn,
>>>                                         int level, int *large_page)
>>>    {
>>> -     struct dma_pte *parent, *pte = NULL;
>>> +     struct dma_pte *parent, *pte;
>>>        int total = agaw_to_level(domain->agaw);
>>>        int offset;
>>>
>>> @@ -954,7 +954,7 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
>>>                                unsigned long start_pfn,
>>>                                unsigned long last_pfn)
>>>    {
>>> -     unsigned int large_page = 1;
>>> +     unsigned int large_page;
>>>        struct dma_pte *first_pte, *pte;
>>>
>>>        BUG_ON(!domain_pfn_supported(domain, start_pfn));
>>> @@ -1132,7 +1132,7 @@ static struct page *domain_unmap(struct dmar_domain *domain,
>>>                                 unsigned long start_pfn,
>>>                                 unsigned long last_pfn)
>>>    {
>>> -     struct page *freelist = NULL;
>>> +     struct page *freelist;
>>
>> I am afraid this change might cause problem. "freelist" might go through
>> dma_pte_clear_level() without any touches.
> 
> Thanks for your review!  Can you clarify your concern?  "freelist"
> isn't passed into dma_pte_clear_level().  Here's the existing code

Oh!

Yes, you are right. I confused it with another function. Sorry about it.

Best regards,
Lu Baolu
