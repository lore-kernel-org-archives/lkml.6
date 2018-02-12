Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2293173-1518468422-2-10225443948588194996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518468421; b=ZJruf1gYQdMljXYt3BLgECnm2UYn7ZUZfW9afgOMSLFHe73
    tmh1iZ6wTXLbQxpukEnp2DtlxCDDQ57euxM+zZJzZLeSEmsOcDgbxq4jreUvV2y1
    tznXDcJHGAsen59LMcOqcZDR/Jne1nZ7kmrKsrS6HJxoMDcz4FUf8p7gtUDgZry/
    bO5SirDLn/U+ATiCcHAVO8/LxGxMclLknJcpUv2n57zRn+mF+LRWKBmroqGBuDNc
    qX6hddMV04I9xVrf/gPdsWNl27qdGMWk3g78ViHBUfiB7blA1BTdFvPRIPyIIfNM
    1W4nufsjZdZ20SwJEfkywgFnUXZbj9fv8d3YBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518468421; bh=qXXifniMDhNykCC6zbCx7STt39/5h8+dIozcix8O4jA=; b=r
    WGFzVz9S39fIrbHlNFSBF2B26Xps/OZ9VPK6HtzoC6sGg1cg2O/+VT6Upur7vH5U
    j/9o0twkGkPU4QHGc1z6fG1CdcoNG4Na/PhID87Almww2SmRiZjZuD7ZwYVpQD3n
    b3ybNi0k0l+igcj7ZUYCBcKFmc7ks8gvQcezuA3w6BjBuN+nHMEFxTsS24ib2ZtJ
    rJ4f/znx0cq9ozQaRH2BSEua70U2n8MB2SF4OqQwN53YIDbWyp3/pHorhpeYYIAD
    CP6pMyfcyqTzWHtAmRy+qTAY1RgdVvkqlfXZx9haJnLMl05EHLngwRm8h7FzuhYq
    dGRuBfQxdH7d1J+S+XF/g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jSXfp8c7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jSXfp8c7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227v8eP5Y+RRBoRnJKWqeMjsFGeW3f1y3ZETlAkXG9+/fdoZO8jmnFXT9lSOWGEjCbZ38tvWoQ==
Subject: Re: [PATCH] staging: android: ion: Add requested allocation alignment
To: Alexey Skidanov <alexey.skidanov@intel.com>, sumit.semwal@linaro.org,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org
References: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
 <ae413008-6c8b-5e53-9251-d11f4ae9713a@redhat.com>
 <8284b2ba-a532-23fd-4c52-7ac556d63918@intel.com>
 <ed842c91-4c4c-7dc0-3957-7e2684e24e32@redhat.com>
 <8eb1f6c9-e08d-c6a5-934a-c7e7873d79f2@intel.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <de9c0071-c45b-608c-67ab-015b284a6082@redhat.com>
Date: Mon, 12 Feb 2018 12:46:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8eb1f6c9-e08d-c6a5-934a-c7e7873d79f2@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/12/2018 12:22 PM, Alexey Skidanov wrote:
> 
> 
> On 02/12/2018 09:52 PM, Laura Abbott wrote:
>> On 02/12/2018 11:11 AM, Alexey Skidanov wrote:
>>>
>>> On 02/12/2018 08:42 PM, Laura Abbott wrote:
>>>> On 02/10/2018 02:17 AM, Alexey Skidanov wrote:
>>>>> Current ion defined allocation ioctl doesn't allow to specify the
>>>>> requested
>>>>> allocation alignment. CMA heap allocates buffers aligned on buffer size
>>>>> page order.
>>>>>
>>>>> Sometimes, the alignment requirement is less restrictive. In such
>>>>> cases,
>>>>> providing specific alignment may reduce the external memory
>>>>> fragmentation
>>>>> and in some cases it may avoid the allocation request failure.
>>>>>
>>>> I really do not want to bring this back as part of the regular
>>>> ABI.
>>> Yes, I know it was removed in 4.12.
>>> Having an alignment parameter that gets used for exactly
>>>> one heap only leads to confusion (which is why it was removed
>>>> from the ABI in the first place).
>>> You are correct regarding the CMA heap. But, probably it may be used by
>>> custom heap as well.
>>
>> I can think of a lot of instances where it could be used but
>> ultimately there needs to be an actual in kernel user who wants
>> it.
>>
>>>> The alignment came from the behavior of the DMA APIs. Do you
>>>> actually need to specify any alignment from userspace or do
>>>> you only need page size?
>>> Yes. If CMA gives it for free, I would suggest to let the ion user to
>>> decide
>>
>> I'm really not convinced changing the ABI yet again just to let
>> the user decide is actually worth it. If we can manage it, I'd
>> much rather see a proposal that doesn't change the ABI.
> I didn't actually change the ABI - I just use the "unused" member:
> struct ion_allocation_data {
> @@ -80,7 +79,7 @@ struct ion_allocation_data {
>          __u32 heap_id_mask;
>          __u32 flags;
>          __u32 fd;
> -       __u32 unused;
> +       __u32 align;
>   };
> 

Something that was previously unused is now being used. That's a change
in how the structure is interpreted which is an ABI change, especially
since we haven't been checking that the __unused field is set
to 0.

> As an alternative, I may add __u64 heap_specific_param - but this will
> change the ABI. But, probably it makes the ABI more generic?

Why does the ABI need to be more generic? If we change the ABI
we're stuck with it and I'd like to approach it as the very last
resort.

Thanks,
Laura
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
