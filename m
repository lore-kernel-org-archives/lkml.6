Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-127826-1518018585-2-17161160416027784498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518018584; b=CMPiHon7P9JB3TkUsIyI3RF/2hBivR2dKGDW8+fZfY2NJXT
    E2XWJHxFTJqL53pp/W8vcJP0t4NiWEg6T0rERoABnIq3qbM3pA8YA+p2VyFPTtZg
    UwGT/VZJHHc2cWaJVzY52gM4z1vCXM1J41FXlUiss4LYr4g8lri5qKM+RbNCUXox
    B/9lO6EhhKQwyrr5ipk34082dBy5ifPEkBCcmjTu/vCBpiZPTWFNMaQFi2bVvBqa
    Xz6rajQtHGOOGCE2WPgsquu/U75lyAUAnvSxwedRVXS4xl95PZltwdDvu1cIncWn
    pmzaKyHl5/s4vRf7isyHhpYh28ttCjuSq4ra2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518018584; bh=u
    X5Ir+14+D/NESl+qSSJfytMjO+/XF+wMuqKZxAkj0c=; b=I1vUakh72HMDoJYjZ
    l0SrIR8iqEDulFcvU+K0qEWUBWVBFAol7XnCUYSgBhbbtphssMPrJhFRWSov9gBY
    cqfV3cKse3eVOs7ZZE5CxMCc9bVU6Yj4F8NsQ+7Rh2UhJJCT+O5gXw8jhfHTo6Rg
    rycqc7rOZlH55H9ie4Hf9gFst+4gUfSLELgLUFDjvQmjjc2QY6CMspDgkEdTbKhP
    15bJPF6M23SpO8LdnsdOnXwXN+tnmeD56ItfcSAB7N5kpeIIRQrUIF/+dKpYmwR+
    mEyVH2EvDh6hl4Ui6C6C1ouQcqLtHKy3yss/ZMuItWZYbDwAmkNb8d8bvOAbuuTS
    tG6pQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000"; d="scan'208";a="16695422"
Subject: Re: staging: ion: ION allocation fall back order depends on heap
 linkage order
To: Laura Abbott <labbott@redhat.com>, devel@driverdev.osuosl.org
References: <CAM7Y4U8FmTNrn=BYN-J+_hVz7JTuaiV+y5Bao78wj3vYCPrz+w@mail.gmail.com>
 <58951af2-a84e-7d7c-e956-ece3190aa8c2@redhat.com>
 <CAM7Y4U_hw5anfgGyAK2uVxOxA3zPoJtOa93mrw8k7xfyOaSTUA@mail.gmail.com>
 <0217ee91-25fa-f563-81bd-ba4ad4dc9377@intel.com>
 <a210baff-4124-b0d7-bcd9-a2ee8b986c7a@redhat.com>
 <3f77b591-6248-da0a-e20d-88ca26a60a95@intel.com>
 <9aab5e55-a2f1-b05d-3568-0a4491ff51f1@redhat.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <6fdcc9d7-1a40-f450-c8ed-8f77f4f6768f@intel.com>
Date: Wed, 7 Feb 2018 17:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9aab5e55-a2f1-b05d-3568-0a4491ff51f1@redhat.com>
Content-Language: en-US
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/07/2018 05:32 PM, Laura Abbott wrote:
> On 02/07/2018 07:10 AM, Alexey Skidanov wrote:
>>
>>
>> On 02/07/2018 04:58 PM, Laura Abbott wrote:
>>> On 02/06/2018 11:05 PM, Alexey Skidanov wrote:
>>>>
>>>>
>>>>> Yup, you've hit upon a key problem. Having fallbacks be stable
>>>>> was always a problem and the recommendation these days is to
>>>>> not rely on them. You can specify a heap at a time and fallback
>>>>> manually if you want that behavior.
>>>>>
>>>>> If you have a proposal to make fallbacks work reliably without
>>>>> overly complicating the ABI I'm happy to review it.
>>>>>
>>>>> Thanks,
>>>>> Laura
>>>>>
>>>> I think it's possible to "automate" the "manual fallback" behavior. But
>>>> the real issues is using heap id to specify the particular heap object.
>>>>
>>>> Current API (allocation IOCTL) requires to specify the particular heap
>>>> object by using heap id. From the other hand, the user space doesn't
>>>> control the heaps creation order and heap id assignment. So it may be
>>>> tricky, especially when more than one object of the same heap type is
>>>> created automatically.
>>>>
>>>> Thanks,
>>>> Alexey
>>>>
>>>>
>>>
>>> The query ioctl is designed to get the heap ID information without
>>> needing to rely on the linking order or anything else defined in
>>> the kernel.
>>>
>>> Thanks,
>>> Laura
>>
>> That is true. But if we have 2 *automatically created* heaps of the same
>> type, how userspace can distinguish between them?
>>
>> Thanks,
>> Alexey
>>
> 
> The query ioctl also gives the name which should be different
> for each heap. It's not ideal but the name/heap type are the best
> way to differentiate between heaps without resorting to hard
> coding.
> 
> Thanks,
> Laura

You are correct ... It will work (assuming that user space developer
knows where to look for the name :) )

So, the userspace may pass the list of pairs [heap type, name] (as part
of allocation ioctl) defining the fallback order.

Thanks,
Alexey

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
