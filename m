Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-29863-1518016226-2-14515886033810946648
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
    t=1518016224; b=ugtQoUkHEFWvjRznD6NAEcOIGcl4Du+P4JQ+4FMPeVP5YfH
    rU23bFFcn6KXNSp9v7NJIP8f6HQRRHnP9tOnV6JGLEy09RAQgDgHNLlMy7r12Z1p
    k9Ud3hXQCEbXJAGA5zUjD6w7PlVk/aRegUAkX4iIUMKGuo7+flhAD/e+CEPDMzTi
    611U08taKXo2akCkSdehuMFhtreAy9GNlREXgx7bNEibDwA6nYi2S55WsBoN+9wk
    c4qp68Etvt8/5sdWvSB3FxwvH8kCgEah0eZCGLyOMvJindv/ztdDpuN9l6oq5cFt
    BnbnpWbpMoLj7E51C6wgzrKVRe+rcSxOLkN7cIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518016224; bh=U
    JwAl24x14loUpzLRFXGVH8+3dyjff7wsMauMtBphpY=; b=GGxlOPqbnBWa6yKei
    gBPd38phOmL+3D/iEW7CmmPW3dCmJ4p4syRtfRg8+HIT/8QE/9uM0dgD2uPCUeYY
    GH4Hxc2AGz9ASVIbuLdVOfZ2miAXZhLckOnW2NkBzT3vAELBxK8uXG5pi96w1OD9
    pUtSlTtxY/v0CUBdjQQOzr/1eejcIFImP1MGnbJFnWKxs+vUd3abjJPGM5Yjicl0
    d8g8016ACmHhY1owMH8Th9DWciTaw6Dirb6PiBxYGOLV79cUMOU9jztSWnU8dk2O
    KvkGo+o0qbHvHl+1lrbwIwCGOxLij19hGzFOyLlj2wQVhrCP3e5hEeNTl4WxLB6d
    d2wlg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000"; d="scan'208";a="199401662"
Subject: Re: staging: ion: ION allocation fall back order depends on heap
 linkage order
To: Laura Abbott <labbott@redhat.com>, devel@driverdev.osuosl.org
References: <CAM7Y4U8FmTNrn=BYN-J+_hVz7JTuaiV+y5Bao78wj3vYCPrz+w@mail.gmail.com>
 <58951af2-a84e-7d7c-e956-ece3190aa8c2@redhat.com>
 <CAM7Y4U_hw5anfgGyAK2uVxOxA3zPoJtOa93mrw8k7xfyOaSTUA@mail.gmail.com>
 <0217ee91-25fa-f563-81bd-ba4ad4dc9377@intel.com>
 <a210baff-4124-b0d7-bcd9-a2ee8b986c7a@redhat.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <3f77b591-6248-da0a-e20d-88ca26a60a95@intel.com>
Date: Wed, 7 Feb 2018 17:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a210baff-4124-b0d7-bcd9-a2ee8b986c7a@redhat.com>
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



On 02/07/2018 04:58 PM, Laura Abbott wrote:
> On 02/06/2018 11:05 PM, Alexey Skidanov wrote:
>>
>>
>>> Yup, you've hit upon a key problem. Having fallbacks be stable
>>> was always a problem and the recommendation these days is to
>>> not rely on them. You can specify a heap at a time and fallback
>>> manually if you want that behavior.
>>>
>>> If you have a proposal to make fallbacks work reliably without
>>> overly complicating the ABI I'm happy to review it.
>>>
>>> Thanks,
>>> Laura
>>>
>> I think it's possible to "automate" the "manual fallback" behavior. But
>> the real issues is using heap id to specify the particular heap object.
>>
>> Current API (allocation IOCTL) requires to specify the particular heap
>> object by using heap id. From the other hand, the user space doesn't
>> control the heaps creation order and heap id assignment. So it may be
>> tricky, especially when more than one object of the same heap type is
>> created automatically.
>>
>> Thanks,
>> Alexey
>>
>>
> 
> The query ioctl is designed to get the heap ID information without
> needing to rely on the linking order or anything else defined in
> the kernel.
> 
> Thanks,
> Laura

That is true. But if we have 2 *automatically created* heaps of the same
type, how userspace can distinguish between them?

Thanks,
Alexey
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
