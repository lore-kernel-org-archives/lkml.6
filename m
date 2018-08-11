Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EDC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF6821A31
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drAo4IM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF6821A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeHKSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:01:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44805 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeHKSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:01:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so13299793qtp.11;
        Sat, 11 Aug 2018 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NjiOtMwrkE7eCLR5P4cIM8UwS1FO/jhA5jzal0l5upU=;
        b=drAo4IM+qziWZucV/j3zNicqfcRYRG/9CA80UlUdmQ6n8JE6JoeVjPhT8LDPlrgWWn
         Z/RtzYqT4mH96pbwXLS2XrmWM5Bdts4mNNW+bGztX2Bv4UERz+9WvjN1eb/zZAjCuxQx
         DkI37piHbZJTL1SpOGXUwnRc/0m9krt4cxm/8TER5M8LbkTtGghE3cSae91sN0u1VNx8
         Ya2iTfpW9C/IigwQolhLF9A2zL4NTIw4g/cVnAG7OaZWmtsIWFnl/VoxsAlNGJ232367
         N6GIVbnh4UaJI6K9cm0Qi4GuSb2D5dVdGV2UB/wYN7lQkXln2Md2QhQAsG6a7mBvOjr/
         4qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NjiOtMwrkE7eCLR5P4cIM8UwS1FO/jhA5jzal0l5upU=;
        b=POD3Dyk/BidhavESAhF+ZTPNGDkkowuL+Sg4YEYX0FDU30Uj9PUcV5kJK0J6HWRTEB
         4b2qrAB+iWSWuSWWYTY/psZGjjQ+ch2SnlBPW6FlRiWH/MGnclm23JhVQ1t/OohmI4pb
         /hYhoLt6NkflnZex2saGC3FfGEDBVeqO+IMu/RNqTSgogvAzI1kyc6idGIhHyZGPY0uL
         gW4UfQQ1OwjzT8Uhsw/Jit3OUoE2kapMKNzjUKv2bVS2Hh2pei9uh5eEH9KE0bGphHdi
         sT1BVc4FX8HX3LC1dJWuCWl3RxAgUZDMRR+eCRNQIbxTSKWg2wW4Mg94/ngSOsqO3ZpW
         ueFw==
X-Gm-Message-State: AOUpUlED8XsqhNDNIdhmfOFg9/LwkhyaZZTsX8neKnEw0V22w9VjTMeN
        cYR64Qek3LxLrqbFtAj1qG4=
X-Google-Smtp-Source: AA+uWPzauWeIyWrUJvXzOZWQHuaikxUaQtJEdzgcRGTT4khWHnPHX6ZHUzJDagMVhrWVjnuskXZgqg==
X-Received: by 2002:ac8:70c5:: with SMTP id g5-v6mr10509230qtp.376.1534001232266;
        Sat, 11 Aug 2018 08:27:12 -0700 (PDT)
Received: from [10.151.0.126] ([104.237.86.7])
        by smtp.gmail.com with ESMTPSA id d202-v6sm7238291qkb.38.2018.08.11.08.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 08:27:11 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hao Fang <fanghao11@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
References: <20180802040557.GL160746@Turing-Arch-b>
 <20180802142243.GA3481@redhat.com> <20180803034721.GC91035@Turing-Arch-b>
 <20180803143944.GA4079@redhat.com> <20180806031252.GG91035@Turing-Arch-b>
 <20180806153257.GB6002@redhat.com>
 <11bace0e-dc14-5d2c-f65c-25b852f4e9ca@gmail.com>
 <20180808151835.GA3429@redhat.com> <20180809080352.GI91035@Turing-Arch-b>
 <20180809144613.GB3386@redhat.com> <20180810033913.GK91035@Turing-Arch-b>
 <0f6bac9b-8381-1874-9367-46b5f4cef56e@arm.com>
From:   Kenneth Lee <nek.in.cn@gmail.com>
Message-ID: <6ea4dcfd-d539-93e4-acf1-d09ea35f0ddc@gmail.com>
Date:   Sat, 11 Aug 2018 23:26:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0f6bac9b-8381-1874-9367-46b5f4cef56e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年08月10日 星期五 09:12 下午, Jean-Philippe Brucker 写道:
> Hi Kenneth,
>
> On 10/08/18 04:39, Kenneth Lee wrote:
>>> You can achieve everything you want to achieve with existing upstream
>>> solution. Re-inventing a whole new driver infrastructure should really
>>> be motivated with strong and obvious reasons.
>> I want to understand better of your idea. If I create some unified helper
>> APIs in drivers/iommu/, say:
>>
>> 	wd_create_dev(parent_dev, wd_dev)
>> 	wd_release_dev(wd_dev)
>>
>> The API create chrdev to take request from user space for open(resource
>> allocation), iomap, epoll (irq), and dma_map(with pasid automatically).
>>
>> Do you think it is acceptable?
> Maybe not drivers/iommu/ :) That subsystem only contains tools for
> dealing with DMA, I don't think epoll, resource enumeration or iomap fit
> in there.
Yes. I should consider where to put it carefully.
>
> Creating new helpers seems to be precisely what we're trying to avoid in
> this thread, and vfio-mdev does provide the components that you
> describe, so I wouldn't discard it right away. When the GPU, net, block
> or another subsystem doesn't fit your needs, either because your
> accelerator provides some specialized function, or because for
> performance reasons your client wants direct MMIO access, you can at
> least build your driver and library on top of those existing VFIO
> components:
>
> * open allocates a partition of an accelerator.
> * vfio_device_info, vfio_region_info and vfio_irq_info enumerates
> available resources.
> * vfio_irq_set deals with epoll.
> * mmap gives you a private MMIO doorbell.
> * vfio_iommu_type1 provides the DMA operations.
>
> Currently missing:
>
> * Sharing the parent IOMMU between mdev, which is also what the "IOMMU
> aware mediated device" series tackles, and seems like a logical addition
> to VFIO. I'd argue that the existing IOMMU ops (or ones implemented by
> the SVA series) can be used to deal with this
>
> * The interface to discover an accelerator near your memory node, or one
> that you can chain with other devices. If I understood correctly the
> conclusion was that the API (a topology description in sysfs?) should be
> common to various subsystems, in which case vfio-mdev (or the mediating
> driver) could also use it.
>
> * The queue abstraction discussed on patch 3/7. Perhaps the current vfio
> resource description of MMIO and IRQ is sufficient here as well, since
> vendors tend to each implement their own queue schemes. If you need
> additional features, read/write fops give the mediating driver a lot of
> freedom. To support features that are too specific for drivers/vfio/ you
> can implement a config space with capabilities and registers of your
> choice. If you're versioning the capabilities, the code to handle them
> could even be shared between different accelerator drivers and libraries.
Thank you, Jean,

The major reason that I want to remove dependency to VFIO is: I accepted 
that the whole logic of VFIO was built on the idea of creating virtual 
device.

Let's consider it in this way: We have hardware with IOMMU support. So 
we create a default_domain to the particular IOMMU (unit) in the group 
for the kernel driver to use it. Now the device is going to be used by a 
VM or a Container. So we unbind it from the original driver, and put the 
default_domain away,  create a new domain for this particular use case.  
So now the device shows up as a platform or pci device to the user 
space. This is what VFIO try to provide. Mdev extends the scenario but 
dose not change the intention. And I think that is why Alex emphasis 
pre-allocating resource to the mdev.

But what WarpDrive need is to get service from the hardware itself and 
set mapping to its current domain, aka defaut_domain. If we do it in 
VFIO-mdev, it looks like the VFIO framework takes all the effort to put 
the default_domain away and create a new one and be ready for user space 
to use. But I tell him stop using the new domain and try the original one...

It is not reasonable, isn't it:)

So why don't I just take the request and set it into the default_domain 
directly? The true requirement of WarpDrive is to let process set the 
page table for particular pasid or substream id, so it can accept 
command with address in the process space. It needs no device.

 From this perspective, it seems there is no reason to keep it in VFIO.

Thanks
Kenneth
>
> Thanks,
> Jean
>

