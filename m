Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1581203-1522761685-2-12633299353066293461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522761684; b=kB8VE6czsM9x+drhKaw4Oejm1Ddwl2EzHTxYfwPjCIL/pi6MCP
    CjeVLrVK/njJj64dT1CG8LsIop7MnxZeD6xyAsIp+arm7fAJkqNPVHSbtTyP8YJ0
    3KgQTaXyeWhAOfoA1PZHjnZWvyQsJDh4WPnH/HMvAUKVh5wAfccSs2L2s8Mxhlzg
    4tEYQwVhnwfmRw3EnGHTOJ6IHdF8De/lXu6UfudkbMqLgRMt0KlcwUC1YvitnbqX
    T0TvPQ1Hs17FRFQ9dVFzqM/RS26BS9PoDmYnjQzAKYaWWJTwkDR6my9hwk5ChxjG
    49LKIUxWTjjD/biJwVX4k3bORP60e7zMysVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522761684;
    bh=iQuemmnM6numsz9FHVPjbELZQ67E7hXcSfLqgd+TX0Y=; b=rT3CLQl9DW0E
    0iNDTimf6F69YT4WLlncFp6xHRpGwUxrn1Pq8VuU7GtCS9Ma3sVTpVbZ/J8if9OA
    ewVCzwUxivw8ydwoNzTtrWMNPvUIcKVGRMMtqA14iXTfc/z38jSqtwjK3vJZVi6O
    0syxlkncjoAhwlpWOx+pAnWtXKeQ/43fVSzbkZESfU+6ChttQIcirRXYJqGSNSzT
    BNUERcxTRh1//mAM19P+4Xl/ElRd/DP6qdKjZ8w0EDny0X95mV2QN4fSjedZaQIQ
    Zc1S57e452ya5x25+cG+v2O2ZIlFNou9Sq4GwYy4rpJj2pMS2TIaB+OiGD2nMaeW
    tcOjyV7JIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/pKHfeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/pKHfeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPJH5LS3By3P2kvH9B3GCBme/kscXpHBMdunxjX/4lXT6N8DAZeO6gvuUV8Zeptxa4bK2IoQX4OzsFNilfOw0OUr2+I6n4zbD9EX9nEWI7DZUJc8mH2V
    D0Wx9DBFXBHf1XJmfy0f49GWwFxsbFNHUza8X23MMNvs5NumWmP183NcKrExdD3WEzfXAuSY2UdMU4WcBnkDtLbMxObkIINHT91rchYkgFoePzg11XD9PUCC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=HwnQe0mpdDxb1mh0KecA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeDCNU7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 09:20:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38672 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbeDCNU6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 09:20:58 -0400
X-Google-Smtp-Source: AIpwx4/kqWyct/HBEIFwVebDUvqXUbOELvuLHrBOYYOeVZh2x4ue7Il0IDWhfmbPOA/4Bf6hHUcZvA==
Subject: Re: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc
 for DMA32 memory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329112116.26488-2-hdegoede@redhat.com>
 <20180329115831.GD6734@kroah.com>
 <435d7f8e-9247-4523-5ab4-7c91cfa54475@redhat.com>
 <20180329163936.GA4579@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <a40fa6a3-f137-2adb-b432-8d60cbf3f525@redhat.com>
Date: Tue, 3 Apr 2018 15:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329163936.GA4579@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 29-03-18 18:39, Greg Kroah-Hartman wrote:
> On Thu, Mar 29, 2018 at 03:42:59PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 29-03-18 13:58, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 29, 2018 at 01:21:15PM +0200, Hans de Goede wrote:
>>>> It is not possible to get DMA32 zone memory through kmalloc,
>>>
>>> Why can't we just fix that issue here instead?
>>
>> AFAIK that would go against the design of the whole slab
>> allocator, it creates buckets (kmem_cache objects) for
>> differently sized allocs out of the normal memzone,
>> you cannot select what memzone you want with kmalloc,
>> if you need to specify a memzone you need to use either
>> dma specific malloc functions such as the dmapool.h
>> functions, or directly call alloc_pages / get_free_pages.
>>
>> A quick grep on the drivers dir shows 50 files using
>> GFP_DMA32 and almost all are passing it to alloc_page
>> or __get_page.
> 
> If there are 50 users of such an api, why is the mm core not handling
> this for drivers automatically?  It seems harsh that they all have to do
> this type of allocation on their own.

True, but fixing that falls outside the scope of this patch-set,
which is purely a small bug-fix patchset fixing a bug which
is being hit be users in the field atm.

So it would be nice if we can get (version 2) of this patch-set
merged.

>> I do actually see 2 drivers which are passing it to
>> kmalloc, which as said will not work I will mail the
>> maintainers of those about this.
> 
> If they haven't noticed that their hardware isn't working, perhaps they
> don't need to set that flag?  :)

Or they have never tested with more then 4G of RAM, which is what
caused me to not find this problem in my own testing of the
vboxguest driver.

Regards,

Hans
