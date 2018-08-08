Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1B208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCmE+EUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE1B208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeHHDuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:50:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46302 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeHHDuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:50:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14-v6so260511pgv.13;
        Tue, 07 Aug 2018 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UgW2MfTEnhx0gGNZjXhQwevRzaso8UJX2MpD4qDmm7Y=;
        b=gCmE+EUY6d7eUSiwSTKBaUvmiYrMj/a3qtfPXD2vsT3A8CYXfbhD3zu/95uRHaPrR2
         g+LNiDZd7D6J9r5zLtoy1oL9Qn+9fbDwAU/drsw8H2FF73zYbq7Y37/r1SV4NkdAyCv6
         OSkRfnFMQZTuGnl8+detseg1+MO/iftbhm5O5PqWvAC9l/VCOAlM3pBku3W6HCu3Qkyo
         bJoAqeRwE4HbejL6teHjXpAtvGyK0plAhqwqXvomJER74zECP8tDjzH2PgvyYH4tiuOF
         ZJj3UWsXahoCN+odD4ha+PkaICgTU2MXpXKLuwCTGEjtPP/rBpTWOD3W0Xlau6nqQwPM
         Obfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UgW2MfTEnhx0gGNZjXhQwevRzaso8UJX2MpD4qDmm7Y=;
        b=sv565sSAxSxBKUIbJCBkjYgtxk2dA4TlrSOHL3bntwFTbkNXL1dFJq4b6WC79gOXkW
         9exi1OVZYJH1EilLrx8RAeKBrv78VHm7L85E0HPBKB9nmTvXQoBIgFOfAs9E1ROmmQTh
         U03tdVUoRJytqPv5BBBX9P/La4s4VuWmH3SgQ3pvgXPGKp/HKLUP1f95OKpk7Mrt7br3
         9tWAV63s9/8uFRypMTps0otZW4CMhvCsbvFKGWcn4chzg6psfIsFrPEIAptYykAauhf0
         LzNtZlC26O0Qo0lp8meDy23+K/PqDQZpeOyOXVH/LF0oxRR6tg5rPjuyAyt21SqNTek2
         cf7g==
X-Gm-Message-State: AOUpUlES6H5DYAiDvVmiYW/GNMjJGknUYkJjtagZqoroN6tS7TU924Vr
        uXqFvP7WEgv6KpoH3447J1s=
X-Google-Smtp-Source: AA+uWPwLrBc0Ebng0kzo3pwpER+2HrXEiG6YIF7FG3CAWpU+srQgaDdFmvKLcTvju7RcHp6NQbOaxA==
X-Received: by 2002:a63:1d5e:: with SMTP id d30-v6mr621833pgm.12.1533691990194;
        Tue, 07 Aug 2018 18:33:10 -0700 (PDT)
Received: from [10.66.0.122] ([104.207.83.31])
        by smtp.gmail.com with ESMTPSA id k125-v6sm2983380pgk.41.2018.08.07.18.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 18:33:09 -0700 (PDT)
Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
To:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Kenneth Lee <liguozhu@hisilicon.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Zaibo Xu <xuzaibo@huawei.com>, sanjay.k.kumar@intel.com,
        Hao Fang <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, linuxarm@huawei.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cornelia Huck <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F7B@SHSMSX101.ccr.corp.intel.com>
 <20180802034727.GK160746@Turing-Arch-b>
 <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
 <20180802073440.GA91035@Turing-Arch-b>
 <20180802103528.0b863030.cohuck@redhat.com>
 <20180802124327.403b10ab@t450s.home> <20180806014004.GF91035@Turing-Arch-b>
 <20180806094940.47c70be9@t450s.home> <20180806163428.GB32409@otc-nc-03>
 <20180806110521.0b708e0b@t450s.home>
From:   Kenneth Lee <nek.in.cn@gmail.com>
Message-ID: <23740eea-4afd-26f6-7407-3cf5b850933e@gmail.com>
Date:   Wed, 8 Aug 2018 09:32:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806110521.0b708e0b@t450s.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年08月07日 星期二 01:05 上午, Alex Williamson 写道:
> On Mon, 6 Aug 2018 09:34:28 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
>
>> On Mon, Aug 06, 2018 at 09:49:40AM -0600, Alex Williamson wrote:
>>> On Mon, 6 Aug 2018 09:40:04 +0800
>>> Kenneth Lee <liguozhu@hisilicon.com> wrote:
>>>> 1. It supports thousands of processes. Take zip accelerator as an example, any
>>>> application need data compression/decompression will need to interact with the
>>>> accelerator. To support that, you have to create tens of thousands of mdev for
>>>> their usage. I don't think it is a good idea to have so many devices in the
>>>> system.
>>> Each mdev is a device, regardless of whether there are hardware
>>> resources committed to the device, so I don't understand this argument.
>>>     
>>>> 2. The application does not want to own the mdev for long. It just need an
>>>> access point for the hardware service. If it has to interact with an management
>>>> agent for allocation and release, this makes the problem complex.
>>> I don't see how the length of the usage plays a role here either.  Are
>>> you concerned that the time it takes to create and remove an mdev is
>>> significant compared to the usage time?  Userspace is certainly welcome
>>> to create a pool of devices, but why should it be the kernel's
>>> responsibility to dynamically assign resources to an mdev?  What's the
>>> usage model when resources are unavailable?  It seems there's
>>> complexity in either case, but it's generally userspace's responsibility
>>> to impose a policy.
>>>    
>> Can vfio dev's created representing an mdev be shared between several
>> processes?  It doesn't need to be exclusive.
>>
>> The path to hardware is established by the processes binding to SVM and
>> IOMMU ensuring that the PASID is plummed properly.  One can think the
>> same hardware is shared between several processes, hardware knows the
>> isolation is via the PASID.
>>
>> For these cases it isn't required to create a dev per process.
> The iommu group is the unit of ownership, a vfio group mirrors an iommu
> group, therefore a vfio group only allows a single open(2).  A group
> also represents the minimum isolation set of devices, therefore devices
> within a group are not considered isolated and must share the same
> address space represented by the vfio container.  Beyond that, it is
> possible to share devices among processes, but (I think) it generally
> implies a hierarchical rather than peer relationship between
> processes.  Thanks,
Actually, this is the key problem we concerned. Our logic was: The PASID 
refer to the connection between the device and the process. So the 
resource should be allocated only when the process "make use of" the 
device. This strategy also bring another advantage that the kernel 
driver can also make use of the resource if no user application open it.

We do have another branch that allocate resource to mdev directly. It 
looks not so nice (many mdevs and user agent is required for resource 
management). If the conclusion here is to keep the mdev's original 
semantics, we will send that branch for discussion in next RFC.

Cheers
Kenneth
>
> Alex
>

