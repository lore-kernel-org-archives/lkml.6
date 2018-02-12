Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2211997-1518465138-2-17534387355206150148
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
    t=1518465137; b=J3yQaHPX6vaZxznuSaETErhwq0OUrWPu2wW6hyYZ2W+5Ann
    PBqV3Z9Cse1JhoVo2wi1Hp+2mnjbdHJC/4Xuan125MuRq//KaIVktlsasxUUhCEc
    EBY9QvUO/61EDvt3PXyNmtgszdy/VGyPr6x4DLsoNLtviPoxH8L82SAcYquWdxpU
    pP2CdTF/wvBZScVM6FODI6iwBmIOEHGpQjhuOwBGbShJcvoH9xwtMmNbVUv9K5Rk
    sUhK+47QRVK7DaJbGuVZ+IwLjNIXjZo/KMQ0IBIk4hbbdpFoQ14F833eyxVQMIgp
    +5gcNT9uue1+oWD6kcvTG/Vm5T6tqInAsBC9xoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518465137; bh=AXjTY/gl/K8/486EeUH9D0RBRvD5o5tltgLGnSUtVqw=; b=F
    25cnCnrWQJhczzq5bWTLOA/3A9sCO91aJlHg2gkvP0oVqVRzKH7jS7vq+N7CDw4H
    ITih7ioGvawqfW1JMJho7FXm7j+zvwtECepmHHX0LdJU0Q9hHB3YE1PyeZn8HW9M
    UsD2jWuwi3g7p5RRh4c4Djqa9mXU3xT+ihB3sSmxQdQo2uUZj1T0aR/TT6UrXPfA
    6v+PDMet/af5RpehpJaeAaerounODBbMWlHSPsdABo3cAsUuS4Rc6zbseDnaymEV
    GMoTE4cDvzRIM/RA2ips+IC3e83XkDhL07s16O9mO0uKzYExtcq9YeC0glhoE2fP
    +rZ3igwFdB5Ovy2Gc9oKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OzDveu3f;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OzDveu3f;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225iQ/uQ2fh8i/2VGYbwmkCATax1vUjKBrLjQMbHIY4PbvpH5Q3VQyP2dST0hMMFQJhacgPdFQ==
Subject: Re: [PATCH] staging: android: ion: Add requested allocation alignment
To: Alexey Skidanov <alexey.skidanov@intel.com>, sumit.semwal@linaro.org,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, devel@driverdev.osuosl.org
References: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
 <ae413008-6c8b-5e53-9251-d11f4ae9713a@redhat.com>
 <8284b2ba-a532-23fd-4c52-7ac556d63918@intel.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <ed842c91-4c4c-7dc0-3957-7e2684e24e32@redhat.com>
Date: Mon, 12 Feb 2018 11:52:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8284b2ba-a532-23fd-4c52-7ac556d63918@intel.com>
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

On 02/12/2018 11:11 AM, Alexey Skidanov wrote:
> 
> On 02/12/2018 08:42 PM, Laura Abbott wrote:
>> On 02/10/2018 02:17 AM, Alexey Skidanov wrote:
>>> Current ion defined allocation ioctl doesn't allow to specify the
>>> requested
>>> allocation alignment. CMA heap allocates buffers aligned on buffer size
>>> page order.
>>>
>>> Sometimes, the alignment requirement is less restrictive. In such cases,
>>> providing specific alignment may reduce the external memory fragmentation
>>> and in some cases it may avoid the allocation request failure.
>>>
>> I really do not want to bring this back as part of the regular
>> ABI.
> Yes, I know it was removed in 4.12.
> Having an alignment parameter that gets used for exactly
>> one heap only leads to confusion (which is why it was removed
>> from the ABI in the first place).
> You are correct regarding the CMA heap. But, probably it may be used by
> custom heap as well.

I can think of a lot of instances where it could be used but
ultimately there needs to be an actual in kernel user who wants
it.

>> The alignment came from the behavior of the DMA APIs. Do you
>> actually need to specify any alignment from userspace or do
>> you only need page size?
> Yes. If CMA gives it for free, I would suggest to let the ion user to decide

I'm really not convinced changing the ABI yet again just to let
the user decide is actually worth it. If we can manage it, I'd
much rather see a proposal that doesn't change the ABI.

>> Thanks,
>> Laura
>>
> Thanks,
> Alexey
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
