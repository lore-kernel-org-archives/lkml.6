Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70969C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292C72172B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYvsBA/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292C72172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeHHEAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:00:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34760 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeHHEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:00:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so298090pgv.1;
        Tue, 07 Aug 2018 18:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AB7TcnrV6LXzlQCIIWkyJVsv0fQHvbuoT4YfobIhaLU=;
        b=YYvsBA/ZWXUQCKfnDD2tOv8uFvoz4QSSHCX1RvRMdBQCMZz+7b8UTVLjH8u7D9o1Rn
         MF9X3yQzWu4EV0Zk28U80Y0A3TdAEO/cl9wZ3mTSiY4ABGMvBvBiXgvBoNM2/3q/MVgA
         dDggauCS4aMJzvZY4uZPWDgRXXeS53sOYMkZlqhJXZliMd4pCxtz4CKtmPGHVRj2DC+X
         RxETc6DbeaWhAIvd7FMjzkWaDKKJlTFW1NoM7YNn24ya8G1LolOxue85sDcvYWM8ZY79
         LrGDbWH8DXn4PCkbR4p18SfeaxhfNtVuLDQs8fSA5BCdXK9AduSxRDQl4Wto2IUDqoDm
         MO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AB7TcnrV6LXzlQCIIWkyJVsv0fQHvbuoT4YfobIhaLU=;
        b=dJ/+dl5AggM0LQSvCxK524mBAIs45kjYTWq3rOObMY4CfWYyP7Ct1rHrtkJThlTD6i
         V02iY4Ej1qlVqdd9Hu9PnYoX9kGzEoH7VMGC4qVyH8e83YrltFdByCE4fYdDbSMHzCbE
         kOuovCL842iAHtP8gNNA1fVTS4TViErdk1YKugfnEegDf/18vusvHki/ZEH6N2N4SwTp
         220HSmhoURWlQ0z7vYRQQ6HgIiEThJ8aW9uNIbycGCf7p7ohWm4yi0HdjVEZ/XCyHi67
         PUAkNiOX+PzG7wQKgH0BFWkEJ6GAuVKmuF2QCmWadgq4t6mka2XWqIPV1NwOh+6NP7Jq
         CtCQ==
X-Gm-Message-State: AOUpUlEbNsoU8X/0L9RV4kLQB1dlwGGJ/SfJqjRXGLbLaUXl7fw1zY48
        MkqmKDDtbEZa9y2emBwVrV8=
X-Google-Smtp-Source: AA+uWPwNrDa2O4Rb4PFuqQAyQ8h5YqIc+XtzFN57mslVxCgd/Z9X8z3QoUvbgpzjOrXvYVhxFLV65g==
X-Received: by 2002:a62:1b4a:: with SMTP id b71-v6mr710884pfb.221.1533692598336;
        Tue, 07 Aug 2018 18:43:18 -0700 (PDT)
Received: from [10.66.0.122] ([104.207.83.31])
        by smtp.gmail.com with ESMTPSA id z19-v6sm2965538pgi.33.2018.08.07.18.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 18:43:17 -0700 (PDT)
Subject: Re: [RFC PATCH 1/7] vfio/spimdev: Add documents for WarpDrive
 framework
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, linuxarm@huawei.com
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-2-nek.in.cn@gmail.com>
 <20180806122733.GA17232@xo-6d-61-c0.localdomain>
From:   Kenneth Lee <nek.in.cn@gmail.com>
Message-ID: <7977ce04-35db-92b4-71b8-54a31484ef0b@gmail.com>
Date:   Wed, 8 Aug 2018 09:43:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806122733.GA17232@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年08月06日 星期一 08:27 下午, Pavel Machek 写道:
> Hi!
>
>> WarpDrive is a common user space accelerator framework.  Its main component
>> in Kernel is called spimdev, Share Parent IOMMU Mediated Device. It exposes
> spimdev is really unfortunate name. It looks like it has something to do with SPI, but
> it does not.
>
Yes. Let me change it to Share (IOMMU) Domain MDev, SDMdev:)
>> +++ b/Documentation/warpdrive/warpdrive.rst
>> @@ -0,0 +1,153 @@
>> +Introduction of WarpDrive
>> +=========================
>> +
>> +*WarpDrive* is a general accelerator framework built on top of vfio.
>> +It can be taken as a light weight virtual function, which you can use without
>> +*SR-IOV* like facility and can be shared among multiple processes.
>> +
>> +It can be used as the quick channel for accelerators, network adaptors or
>> +other hardware in user space. It can make some implementation simpler.  E.g.
>> +you can reuse most of the *netdev* driver and just share some ring buffer to
>> +the user space driver for *DPDK* or *ODP*. Or you can combine the RSA
>> +accelerator with the *netdev* in the user space as a Web reversed proxy, etc.
> What is DPDK? ODP?
DPDK：https://www.dpdk.org/about/
ODP: https://www.opendataplane.org/

will add the reference in the next RFC
>
>> +How does it work
>> +================
>> +
>> +*WarpDrive* takes the Hardware Accelerator as a heterogeneous processor which
>> +can share some load for the CPU:
>> +
>> +.. image:: wd.svg
>> +        :alt: This is a .svg image, if your browser cannot show it,
>> +                try to download and view it locally
>> +
>> +So it provides the capability to the user application to:
>> +
>> +1. Send request to the hardware
>> +2. Share memory with the application and other accelerators
>> +
>> +These requirements can be fulfilled by VFIO if the accelerator can serve each
>> +application with a separated Virtual Function. But a *SR-IOV* like VF (we will
>> +call it *HVF* hereinafter) design is too heavy for the accelerator which
>> +service thousands of processes.
> VFIO? VF? HVF?
>
> Also "gup" might be worth spelling out.
But I think the reference [1] has explained this.
>
>> +References
>> +==========
>> +.. [1] Accroding to the comment in in mm/gup.c, The *gup* is only safe within
>> +       a syscall.  Because it can only keep the physical memory in place
>> +       without making sure the VMA will always point to it. Maybe we should
>> +       raise the VM_PINNED patchset (see
>> +       https://lists.gt.net/linux/kernel/1931993) again to solve this probl
>
> I went through the docs, but I still don't know what it does.
Will refine the doc in next RFC, hope it will help.
> 											Pavel
>

