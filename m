Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-890949-1522330984-2-9252527967313994865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522330983; b=haXiNIKzkMzFHgJ3PB21lmOxNpIHtRkl8Tofkw0h7OWz4SeHGM
    ByMh3e44yEmCQ0wBnfeNa8rFrq9JD9tQniN1Zun+yF6pljI7Or99jZFGHedAXfiq
    qABY3u4ZafGThrJ+YfNRtiEyKfeY3pHt1ojvqox77ZvW57qlyk2RCkoQfs9M/spV
    aAiGdRPULbq8O7uv1mdSRALmtNjnYn4y7uYLqxQT3CLgX7o7z7t8sbJIw/HS+oTM
    NSKSDIWm6R5m+NI++XQEjXsJeODmfiMx36oQstsPcxz+wAGPY1Za8hA4R2KN1yku
    7/PotCZubc4i5u30wul5JAkRK+QMJwAgniYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522330983;
    bh=ZCB3FRTZrlJtxPe/i+F6gtfYc2g6Ax4ePrc9/cwqRQ4=; b=rcM7AfbIXxif
    rNjqXngUeSw3n4POdpgl1KEf0G9vuKSywQOLtRvOM/JC6yRYqWmtcwWKiyAYc1fU
    Vq2gs8VP20LMBri8WEzNb7S5i+O5ywWpRZUMJ7CHov73tl7E8xy6XeHC30LHUu4k
    Vm5z0cBiKtmxmMsdLwaoh5rpo04n3xNJcrjToTgwDzCI82qPlutG5HW9W1MNKF79
    GAEzRWyhGWU40cANbM6fViENPI9w13mCXmnMdUf5Y8QN4Zq1OOHizdB5n7v2uTGo
    PtFhWpNVTFCi3HtAnyPSWdaDm7ufaMoypvzcklL4bwG4V3Oyk9GfskpP87W6jzhj
    y9YOCAFJjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VEfl0Fbw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VEfl0Fbw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNp47mPibB9NTfnvJ5ZFBgR0y6JvNkW2ctvtAt0ehakVG4NTxuh+13pqp+p1D41+NiegaHpRTfvD71rfSAO9ysyL72n1kWNsHaoXVpn5AUDRSCz/USn2
    hv+kONKfmlXAkujJmvwEHiMjv1g5Hq8aycS8LPgcRp86jaF+Vom+qvABEfuYQpYFVUIYO4KE9YpYECReeH3lsoQ06gOh7PzTKEB2AtwWim82hH/Q8158d6/6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=keEKlRtWLx4HDna6rg8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeC2NnC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 09:43:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38674 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeC2NnB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 09:43:01 -0400
X-Google-Smtp-Source: AIpwx4+KyEOavorgmVgdt354Ldmg6u/IwhB0jweB/xmn6zv9fxoDM0Dn3mz6eK+tjg5Dz/ngsSgJhQ==
Subject: Re: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc
 for DMA32 memory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329112116.26488-2-hdegoede@redhat.com>
 <20180329115831.GD6734@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <435d7f8e-9247-4523-5ab4-7c91cfa54475@redhat.com>
Date: Thu, 29 Mar 2018 15:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329115831.GD6734@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 29-03-18 13:58, Greg Kroah-Hartman wrote:
> On Thu, Mar 29, 2018 at 01:21:15PM +0200, Hans de Goede wrote:
>> It is not possible to get DMA32 zone memory through kmalloc,
> 
> Why can't we just fix that issue here instead?

AFAIK that would go against the design of the whole slab
allocator, it creates buckets (kmem_cache objects) for
differently sized allocs out of the normal memzone,
you cannot select what memzone you want with kmalloc,
if you need to specify a memzone you need to use either
dma specific malloc functions such as the dmapool.h
functions, or directly call alloc_pages / get_free_pages.

A quick grep on the drivers dir shows 50 files using
GFP_DMA32 and almost all are passing it to alloc_page
or __get_page.

I do actually see 2 drivers which are passing it to
kmalloc, which as said will not work I will mail the
maintainers of those about this.

Regards,

Hans
