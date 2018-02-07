Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-130196-1518017583-2-4233078917693674023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518017583; b=Ncm5v9HXGKgMV5U5IYMCKpWTL/SfmY3roFraMc1/jZ4S6N+
    YnSlbYjPT6PXsi6qfmsQf0cUlHs1kfvdyFvQHc3u03z6LAsZTEJhgrvrlVGdwMig
    Ysd5cX688nX18nNO6D5Ib2hTxQe+p2T4ZE4Y8Fqkf5Dvh357Xy3PYeEeOdMWQtXX
    67sQYiu4OUvX85aQopWVz8Dz1iQnv/Juy522sNxqOf/kKG+V7BTwUVpOuakSyWR8
    FiK5zaGN0WfdssazKVgafQyalGeXy9BE8ycg8swGyWvDWGL9ZFdN3ncQ/FxT1UU6
    q9BvKjfbg/z01wqGUd+GBFkGKy6YCggfyfyR+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518017583; bh=WLGlHLrPpFPFP41kdQJDuQOr+Vhq9i6eqypz4GNCPns=; b=p
    wbOre3vvtTRfw+fevHGF1JMSreLEU2F0AgxloRH3z7aO7KyQYNqk9KuGD4aMTUKc
    0myfZ39J8P9F6r+TOr2xP94CJGEQBggepcP7WlIKrRYcjI/8x3a8EEusxWgmotwp
    tCzOZMwHqsyzACuD8HqjhUq1XYhwjXKXfiClhaTMUlX06VtwpLplSJ8uEDCWC8lj
    WmEvmILq+TtpV5H9yHs0h9USl4XoZ9hknBOpXat9anLOlWpCbzPS5n2XBV5qnPAp
    kJANdF+Sl09U0SQqZyjtakGe327nQvCDL/6fwrE7XHtjcNGoFp1TteP2PCHgokM+
    tk02CxsMaDQTxToU7wX1Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OD00Pd9q;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OD00Pd9q;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227VUOomzqAONj+MOFmMyXa0vqGeytnXgHgfmlGxjGvFBAY5hDhd3sTY0eU0m1HZy1YZ/jGjoA==
Subject: Re: staging: ion: ION allocation fall back order depends on heap
 linkage order
To: Alexey Skidanov <alexey.skidanov@intel.com>, devel@driverdev.osuosl.org
References: <CAM7Y4U8FmTNrn=BYN-J+_hVz7JTuaiV+y5Bao78wj3vYCPrz+w@mail.gmail.com>
 <58951af2-a84e-7d7c-e956-ece3190aa8c2@redhat.com>
 <CAM7Y4U_hw5anfgGyAK2uVxOxA3zPoJtOa93mrw8k7xfyOaSTUA@mail.gmail.com>
 <0217ee91-25fa-f563-81bd-ba4ad4dc9377@intel.com>
 <a210baff-4124-b0d7-bcd9-a2ee8b986c7a@redhat.com>
 <3f77b591-6248-da0a-e20d-88ca26a60a95@intel.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9aab5e55-a2f1-b05d-3568-0a4491ff51f1@redhat.com>
Date: Wed, 7 Feb 2018 07:32:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <3f77b591-6248-da0a-e20d-88ca26a60a95@intel.com>
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

On 02/07/2018 07:10 AM, Alexey Skidanov wrote:
> 
> 
> On 02/07/2018 04:58 PM, Laura Abbott wrote:
>> On 02/06/2018 11:05 PM, Alexey Skidanov wrote:
>>>
>>>
>>>> Yup, you've hit upon a key problem. Having fallbacks be stable
>>>> was always a problem and the recommendation these days is to
>>>> not rely on them. You can specify a heap at a time and fallback
>>>> manually if you want that behavior.
>>>>
>>>> If you have a proposal to make fallbacks work reliably without
>>>> overly complicating the ABI I'm happy to review it.
>>>>
>>>> Thanks,
>>>> Laura
>>>>
>>> I think it's possible to "automate" the "manual fallback" behavior. But
>>> the real issues is using heap id to specify the particular heap object.
>>>
>>> Current API (allocation IOCTL) requires to specify the particular heap
>>> object by using heap id. From the other hand, the user space doesn't
>>> control the heaps creation order and heap id assignment. So it may be
>>> tricky, especially when more than one object of the same heap type is
>>> created automatically.
>>>
>>> Thanks,
>>> Alexey
>>>
>>>
>>
>> The query ioctl is designed to get the heap ID information without
>> needing to rely on the linking order or anything else defined in
>> the kernel.
>>
>> Thanks,
>> Laura
> 
> That is true. But if we have 2 *automatically created* heaps of the same
> type, how userspace can distinguish between them?
> 
> Thanks,
> Alexey
> 

The query ioctl also gives the name which should be different
for each heap. It's not ideal but the name/heap type are the best
way to differentiate between heaps without resorting to hard
coding.

Thanks,
Laura
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
