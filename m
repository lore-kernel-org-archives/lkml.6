Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2211997-1518466923-2-6101622569703748552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518466922; b=I5CcjaoDE2hhbD7ZZzqzfG12NNfRul8wRMwb6V8llIXN1RQ
    wQ5Vz7TuW4ms49A0W93j8QOsWYmf6rK5kHVyUco7mgf6ixiHjt3nGE18ddWfuEhZ
    kWJwadMIYGqrzIGDO4HurGl2JPcEG26Yhn7O9mwrsx0BCy85FpQ9NlhtQaW4Uz9C
    7eHHA7VyKiEyeB2d89gkFZKp6TCJUUh9j1AhPcL2TnE52oxWkfRQlMp08gZu2J8q
    sm9CVq35GhRVLK37mm+cmscigqtCNQGxqytEQOe32f0MqmcuqExKBy+e6WitCNn8
    I+l04j7Uca6rRpULd+QOLNE3sf3NLAnKd3eKhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518466922; bh=u
    Aw62z4GrGz9Mx25GXK1geytrffkoQwMpmJE2vGfeFY=; b=FGbY+xvTy2VF5Iz42
    CnvRj5EDQeX0aNcqJxfx3Fq2pv0HanazNI+64WyJXYHn7ejPI6Patks7o6QRNGrb
    wg50E98dQOJg/8nmAKCSKoU9QONjnpg8e+BHVUUxf+Byo8mQS/bkjCo5bwJiXyJc
    okGNubc4KqGYA6XhJ9FciMip1zvTDf1/m/550k9uOfzwcHaPgutMfzqxWvQ/YqLg
    lXM8gSnq/tw4TLnzEtuzVX98G7Q5MzcRksHkQLauTCaB3gg9weQjL/CPszJ1p3Gy
    G0JNb9DEpe1sjUJr3xfQRM2t0RrM6lKTB0YcE+ApgjYTz9w7KBBicXMY5PuNc6tM
    KNNsw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000"; d="scan'208";a="26757161"
Subject: Re: [PATCH] staging: android: ion: Add requested allocation alignment
To: Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org
References: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
 <ae413008-6c8b-5e53-9251-d11f4ae9713a@redhat.com>
 <8284b2ba-a532-23fd-4c52-7ac556d63918@intel.com>
 <ed842c91-4c4c-7dc0-3957-7e2684e24e32@redhat.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <8eb1f6c9-e08d-c6a5-934a-c7e7873d79f2@intel.com>
Date: Mon, 12 Feb 2018 22:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ed842c91-4c4c-7dc0-3957-7e2684e24e32@redhat.com>
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



On 02/12/2018 09:52 PM, Laura Abbott wrote:
> On 02/12/2018 11:11 AM, Alexey Skidanov wrote:
>>
>> On 02/12/2018 08:42 PM, Laura Abbott wrote:
>>> On 02/10/2018 02:17 AM, Alexey Skidanov wrote:
>>>> Current ion defined allocation ioctl doesn't allow to specify the
>>>> requested
>>>> allocation alignment. CMA heap allocates buffers aligned on buffer size
>>>> page order.
>>>>
>>>> Sometimes, the alignment requirement is less restrictive. In such
>>>> cases,
>>>> providing specific alignment may reduce the external memory
>>>> fragmentation
>>>> and in some cases it may avoid the allocation request failure.
>>>>
>>> I really do not want to bring this back as part of the regular
>>> ABI.
>> Yes, I know it was removed in 4.12.
>> Having an alignment parameter that gets used for exactly
>>> one heap only leads to confusion (which is why it was removed
>>> from the ABI in the first place).
>> You are correct regarding the CMA heap. But, probably it may be used by
>> custom heap as well.
> 
> I can think of a lot of instances where it could be used but
> ultimately there needs to be an actual in kernel user who wants
> it.
> 
>>> The alignment came from the behavior of the DMA APIs. Do you
>>> actually need to specify any alignment from userspace or do
>>> you only need page size?
>> Yes. If CMA gives it for free, I would suggest to let the ion user to
>> decide
> 
> I'm really not convinced changing the ABI yet again just to let
> the user decide is actually worth it. If we can manage it, I'd
> much rather see a proposal that doesn't change the ABI.
I didn't actually change the ABI - I just use the "unused" member:
struct ion_allocation_data {
@@ -80,7 +79,7 @@ struct ion_allocation_data {
        __u32 heap_id_mask;
        __u32 flags;
        __u32 fd;
-       __u32 unused;
+       __u32 align;
 };

As an alternative, I may add __u64 heap_specific_param - but this will
change the ABI. But, probably it makes the ABI more generic?
> 
>>> Thanks,
>>> Laura
>>>
>> Thanks,
>> Alexey
>>
> 

Thanks,
Alexey
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
