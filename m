Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4169591-1526659292-2-7393239248706985678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659291; b=eF4KRhQq0CH6cd/EZsOkTamv4AOAZJML/ilxU5O7yE38g8lOHc
    8JxcfARorcNZ0eUPNpAgMgKTo7FKnRptwp3c07V23+wS7+CFEXCSUBC8sd5KNGD0
    Tv9hIjBcaX/vAVTJJGA6eBfxp0KPoSztZh7YLtxuhBycP8k4rqu9oiylIJQ8gZb3
    HGmD3eCXDS9h0qZk2YgOmflOKwznZfhf1ZBy/aFBtffMWBZHgFmVYvs9gbN6nxgk
    6zw4h99/U3pgEDVId8EgV286oyMUI5eV5rRMJpkNdGSuCHuktZMuzA81WUfJqLdj
    gro0r86Kq4E201LCB3OqXLC3HEryzXEcvdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526659291;
    bh=PkKozU8W6af51fs1X9nOQ4f9c9ZsZCcGd3wgtQmvlXM=; b=kglX4Sv+4zGI
    Uj6OLmEWMnZZj212NNnfSu+e7vpcwgZcZqiYXNhX9aZVEpzCwxuXe1exngwL815G
    qFwul61gN1t8GjWtyJfWCPUXQsxP47lN/qzpWhmOPX0MlYJKprkPlENRqrt1yw+C
    9YdIf0a4CBxpN3QPmtc85TpofBP6w069Zy/MrS+bpEIupJ7SiNlSuJd6QZzX2foO
    x4OcV7y+7h6kMo5CZgRQjHU6CJlerg4CZea8kqO5K7H1oCaccvhlrjKkadc/7LK6
    3Qhra5Hz7Xk2aBYI452vaK+v7UOk1G19qc3aLRHwLS22+cwKFSOY3JliCgLOBdl6
    QczeVe9KNg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA8hwrTP6DCH06UF5sK0pDCfyJSaVXW1VJ6x6PdOIW5L4gJQZ0kiJZpH8mIEm5aYl4IWmBBouxyNKM+xHrMu6JXRtQP12sJ+XRqfAohKQUlmTTQHonBI
    7PyEU+50or+iETUTlVpTqaqtB/5Z8lQ8qNB/6d8f/Jv37tphZ5EzFdrMHPL8jttjvdB+Lt22RephCkkhKNddmJSPfk4l1L0DxSjMBoKs/xd8jLnnBuvAgmk2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Fa0RexZ47R90H7BigGIA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeERQBG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:01:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752223AbeERQBF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 12:01:05 -0400
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
From: David Hildenbrand <david@redhat.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
 <784dfdf6-8fc3-be08-833b-a9097c3d1b96@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6982f59e-c836-1064-c05c-a926446b6f48@redhat.com>
Date: Fri, 18 May 2018 18:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <784dfdf6-8fc3-be08-833b-a9097c3d1b96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.05.2018 17:57, David Hildenbrand wrote:
> On 01.02.2018 17:33, Andrey Ryabinin wrote:
>> KASAN uses different routines to map shadow for hot added memory and memory
>> obtained in boot process. Attempt to offline memory onlined by normal boot
>> process leads to this:
>>
>>     Trying to vfree() nonexistent vm area (000000005d3b34b9)
>>     WARNING: CPU: 2 PID: 13215 at mm/vmalloc.c:1525 __vunmap+0x147/0x190
>>
>>     Call Trace:
>>      kasan_mem_notifier+0xad/0xb9
>>      notifier_call_chain+0x166/0x260
>>      __blocking_notifier_call_chain+0xdb/0x140
>>      __offline_pages+0x96a/0xb10
>>      memory_subsys_offline+0x76/0xc0
>>      device_offline+0xb8/0x120
>>      store_mem_state+0xfa/0x120
>>      kernfs_fop_write+0x1d5/0x320
>>      __vfs_write+0xd4/0x530
>>      vfs_write+0x105/0x340
>>      SyS_write+0xb0/0x140
>>
>> Obviously we can't call vfree() to free memory that wasn't allocated via
>> vmalloc(). Use find_vm_area() to see if we can call vfree().
>>
>> Unfortunately it's a bit tricky to properly unmap and free shadow allocated
>> during boot, so we'll have to keep it. If memory will come online again
>> that shadow will be reused.
>>
> 
> While debugging kasan memory hotplug problems I am having, stumbled over
> this patch.
> 
> Couldn't we handle that via VM_KASAN like in kasan_module_alloc/free
> instead?
> 

Just realized that this will most probably not work. So please ignore my
comment for now :)

-- 

Thanks,

David / dhildenb
