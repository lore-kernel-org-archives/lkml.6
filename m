Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-353908-1527090918-2-4222857951596818714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527090918; b=ZsXAw/hd2WxQOV+34I4rJEoUGk8JCsUdXoh0KQxCzsOo/BzlOY
    dMCivxFiIrND2DLxyMhCmKHZtFGscUmsyuUlNZJ5AVoTflB8MeftrlQkgDYXU88T
    DZkQBlSgcyAyPb82Psd48dxKDtau4QN9HTD1UqjzYI2EaWSfTA+My+X60cTPNimo
    EINlBidDZr+xXrkpKUGpJIkriFwoVOOpfjMg9J/Ox8pkwSB/A4KONSnIqHH3BF9u
    el4600MkSX4ndo3ZYvE/Zkii9CI+U2wfRlVb8axY2un2AG51KWZgWLnlTz0AYuIA
    laaC6MOWAH+dODsvemigQeZwelwF4iRV4OZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527090918; bh=1IKXMYnpt0j4qJqD/IIrpYmSrgmv0vvn/80uo1BTSY
    M=; b=KZE1Gm3e23pgLpKbJM3a4+bQA3D1KGDGZZwpC88oV1P8Be0BI/UqhawLAa
    2o8/sWQKwj6KB/OJ+E0UXYfXxtsVYlRwHlmsuKCbedxZ0Wt2bDDWvQwyHkF/xgwm
    tZ9kVgzYoR81x75HBS5/UzCyQn9El90JGmNjgaVzF4rKaS4uxGIe5kQWXTPZVRrY
    wKs1JUUYQ5wkR9qif0cAx2cAmf+d1dN++K5KWd4zsipfXERb3jn0yWqPfmKLX+Ab
    bi5mnYJGFiaTVAuAfnuhc1M6wAr27JJrbUf9YSBYmOiKIhZsS44sj4IELteJ7Ej7
    QEO0W1YcnLp/vQVLrt51b30ko7qA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=Bszg6igC
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=SjTnV+7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=Bszg6igC
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=SjTnV+7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNSyDXm5w6vcAMm2aXX3B1fh6AbduRpSBoITqJ/5yNcoGeiGmjRBo6qwbQ0bH7WhTYH/6Tr7e2Kz9V6UB9N1qPtL/mnngrpDscQkYQ2sQz8s8nhsfq40
    dLMNBhGpQDXijtqIzMMZosjU2dPQtpL69V5MuPsuBvHjB0scO40hnKnq8qWQWfAs9m1kwp+tBkob8xbGXrqh+i8pwVu7V5zFoEfhK2ohObwlUo6ZE5CBs/a4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gXLdhW2jAAAA:8 a=c6lbZdeGQCHjyFhW0NkA:9 a=QEXdDO2ut3YA:10
    a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeEWPzO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 11:55:14 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42283 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEWPzO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 11:55:14 -0400
X-Google-Smtp-Source: AB8JxZr2QLfqMOJcjby+dxos9BIn+NMFRdbZx2hNRoytRkSmaocKBzuFlw2HWcdk5Rx3swXyK3taCIKta8X9NILW72s=
MIME-Version: 1.0
In-Reply-To: <8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com>
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152705223396.21414.13388289577013917472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 May 2018 08:55:13 -0700
Message-ID: <CAPcyv4jBq9BDXcidvR10YO_pb0uQNVK_qPZ=x=k9kDRtaB2few@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm, devm_memremap_pages: Fix shutdown handling
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 8:47 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 22/05/18 11:10 PM, Dan Williams wrote:
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 7b4899c06f49..b5e894133cf6 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -106,6 +106,7 @@ typedef void (*dev_page_free_t)(struct page *page, void *data);
>>   * @altmap: pre-allocated/reserved memory for vmemmap allocations
>>   * @res: physical address range covered by @ref
>>   * @ref: reference count that pins the devm_memremap_pages() mapping
>> + * @kill: callback to transition @ref to the dead state
>>   * @dev: host device of the mapping for debug
>>   * @data: private data pointer for page_free()
>>   * @type: memory type: see MEMORY_* in memory_hotplug.h
>> @@ -117,13 +118,15 @@ struct dev_pagemap {
>>       bool altmap_valid;
>>       struct resource res;
>>       struct percpu_ref *ref;
>> +     void (*kill)(struct percpu_ref *ref);
>>       struct device *dev;
>>       void *data;
>>       enum memory_type type;
>>  };
>>
>>  #ifdef CONFIG_ZONE_DEVICE
>> -void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>> +void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
>> +             void (*kill)(struct percpu_ref *));
>
>
> It seems redundant to me to have the kill pointer both passed in as an
> argument and passed in as part of pgmap... Why not just expect the user
> to set it in the *pgmap that's passed in just like we expect ref to be
> set ahead of time?

I did this for grep-ability. Now you can grep for all
devm_memremap_pages and see the associated teardown actions,
everything else in pgmap is data. I'm not opposed to just requiring it
to be passed in with the pgmap, but I thought removing a step for
someone trying to grep through the code flow was worth it. Yes, not
the strongest argument, so if folks feel it adds too much clutter we
can switch it.

> Another thought (that may be too forward looking) is to pass the
> dev_pagemap struct to the kill function instead of the reference. That
> way, if some future user wants to do something extra on kill they can
> use container_of() to get extra context to work with.

We can cross that bridge if it comes to it, but as it stands being
able to get the container of the reference count seems to be enough
for all users.
