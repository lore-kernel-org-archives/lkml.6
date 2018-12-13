Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D04C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7892087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7892087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeLMNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:40:54 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:47679
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbeLMNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:40:54 -0500
Received: from [192.168.0.55] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id XREQglIH2mEWgXRERgVOMz; Thu, 13 Dec 2018 06:40:52 -0700
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
References: <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz> <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com> <20181212233703.GB2947@ziepe.ca>
 <20181213000109.GK5037@redhat.com> <20181213032043.GA3204@ziepe.ca>
 <20181213124325.GA3186@redhat.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <81a731bb-6a8a-a554-cf99-5d0588b0a21f@talpey.com>
Date:   Thu, 13 Dec 2018 08:40:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213124325.GA3186@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH4ZsOSo2qBqMeTLvrltze/PolPPGRXhW/k5+6VbiSlh91RYqER/ae8QKssNUOLdAjNbfAChNY2g8O9dpVhpIevOrhunQr0pyKF6LqdrWtNR1DmOnZDe
 ZGWBMCCk0LilJHRQ6ll8JZZFlJfj2qSAupQl2GPdr91/+Hh7KwXA07VU45MSn0GMYNfS5bdhqtJkoapM1I5NiuhIDV14CUZKT4DDHlEwl2UHPycZR+Z3ex+L
 eJeXVTSiVEbwp43n9XM3ue9qPbE36BL8xIiFcl1Bn518lQjLGKc0cb/S4VzdaE+GVm4Y2AoQwT+y2Db+DO9+lsEbU1gY2Dsv+2m3CKvwjlG2AYGs5hkCItNM
 8iAL7XZcMDHql3Tt4VjiEzWsvtU1u8aSa1OdrizDoNpHT1klBPGKJbgxfztt8uqHEYLlWtSH35vhS6EqQX8QsTDHBx0WLbzwyJBOPIedOLpHb/x8ew7o3un1
 pk1BDWoBc+hfyAelZx/yXxheBKsk8J2SFRLPmo8l7DBEAJsUKjgwsqLK9hW4LvO7bJalQKzczrjYfaJRf6xixzH6eB0F9WND+z+ri0qnDic39/XuuNHOjM3g
 Q+Z0NJAb4+7Zd8sx84gRfgAw5vOfKeJBT4vYmUi7alenxiYtC5Y4CpS0mC98pYVDbFdaiAZ+1hb7wHwRSpSUH8WygrBEEAIXSYXjseuC91fV+Xr7u6NyRwfL
 Z4iCGxtnsxZ3IGBUsMoe+bSAjMNim23/pe65r521KFUcHz28cMZmPOVeE70yBUqNLmScDZN2dchyEHakLY0iTszsJ4hiVXEX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 7:43 AM, Jerome Glisse wrote:
> On Wed, Dec 12, 2018 at 08:20:43PM -0700, Jason Gunthorpe wrote:
>> On Wed, Dec 12, 2018 at 07:01:09PM -0500, Jerome Glisse wrote:
>>> On Wed, Dec 12, 2018 at 04:37:03PM -0700, Jason Gunthorpe wrote:
>>>> On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
>>>>>> Almost, we need some safety around assuming that DMA is complete the
>>>>>> page, so the notification would need to go all to way to userspace
>>>>>> with something like a file lease notification. It would also need to
>>>>>> be backstopped by an IOMMU in the case where the hardware does not /
>>>>>> can not stop in-flight DMA.
>>>>>
>>>>> You can always reprogram the hardware right away it will redirect
>>>>> any dma to the crappy page.
>>>>
>>>> That causes silent data corruption for RDMA users - we can't do that.
>>>>
>>>> The only way out for current hardware is to forcibly terminate the
>>>> RDMA activity somehow (and I'm not even sure this is possible, at
>>>> least it would be driver specific)
>>>>
>>>> Even the IOMMU idea probably doesn't work, I doubt all current
>>>> hardware can handle a PCI-E error TLP properly.
>>>
>>> What i saying is reprogram hardware to crappy page ie valid page
>>> dma map but that just has random content as a last resort to allow
>>> filesystem to reuse block. So their should be no PCIE error unless
>>> hardware freak out to see its page table reprogram randomly.
>>
>> No, that isn't an option. You can't silently provide corrupted data
>> for RDMA to transfer out onto the network, or silently discard data
>> coming in!!
>>
>> Think of the consequences of that - I have a fileserver process and
>> someone does ftruncate and now my clients receive corrupted data??
> 
> This is what happens _today_ ie today someone do GUP on page file
> and then someone else do truncate the first GUP is effectively
> streaming _random_ data to network as the page does not correspond
> to anything anymore and once the RDMA MR goes aways and release
> the page the page content will be lost. So i am not changing anything
> here, what i proposed was to make it explicit to device driver at
> least that they were streaming random data. Right now this is all
> silent but this is what is happening wether you like it or not :)
> 
> Note that  i am saying do that only for truncate to allow to be
> nice to fs. But again i am fine with whatever solution but you can
> not please everyone here. Either block truncate and fs folks will
> hate you or make it clear to device driver that you are streaming
> random things and RDMA people hates you.
> 
> 
>> The only option is to prevent the RDMA transfer from ever happening,
>> and we just don't have hardware support (beyond destroy everything) to
>> do that.
>>
>>> The question is who do you want to punish ? RDMA user that pin stuff
>>> and expect thing to work forever without worrying for other fs
>>> activities ? Or filesystem to pin block forever :)
>>
>> I don't want to punish everyone, I want both sides to have complete
>> data integrity as the USER has deliberately decided to combine DAX and
>> RDMA. So either stop it at the front end (ie get_user_pages_longterm)
>> or make it work in a way that guarantees integrity for both.
>>
>>>      S2: notify userspace program through device/sub-system
>>>          specific API and delay ftruncate. After a while if there
>>>          is no answer just be mean and force hardware to use
>>>          crappy page as anyway this is what happens today
>>
>> I don't think this happens today (outside of DAX).. Does it?
> 
> It does it is just silent, i don't remember anything in the code
> that would stop a truncate to happen because of elevated refcount.
> This does not happen with ODP mlx5 as it does abide by _all_ mmu
> notifier. This is for anything that does ODP without support for
> mmu notifier.

Wait - is it expected that the MMU notifier upcall is handled
synchronously? That is, the page DMA mapping must be torn down
immediately, and before returning?

That's simply not possible, since the hardware needs to get control
to do this. Even if there were an IOMMU that could intercept the
DMA, reprogramming it will require a flush, which cannot be guaranteed
to occur "inline".

>> .. and the remedy here is to kill the process, not provide corrupt
>> data. Kill the process is likely to not go over well with any real
>> users that want this combination.
>>
>> Think Samba serving files over RDMA - you can't have random unpriv
>> users calling ftruncate and causing smbd to be killed or serve corrupt
>> data.
> 
> So what i am saying is there is a choice and it would be better to
> decide something than let the existing status quo where we just keep
> streaming random data after truncate to a GUPed page.

Let's also remember that any torn-down DMA mapping can't be recycled
until all uses of the old DMA addresses are destroyed. The whole
thing screams for reference counting all the way down, to me.

Tom.

