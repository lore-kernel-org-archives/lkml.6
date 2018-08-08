Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBC02174B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8NYppyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBC02174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHD0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:26:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45598 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeHHD0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:26:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so253237pfo.12;
        Tue, 07 Aug 2018 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ttqKQoIhHzKwUAeWebdTS3B6pWFccBrSTjErG8GWQFY=;
        b=d8NYppyXz2zgWJQNmClQ70Dd2C25NzQvKt36zruP0+FjSDtDeLQ3w1BE0gkpslgcrg
         mD/Xa/ghFiR4Z+Nd8qmNCQjPAqd35f0EM9AUpEr97oetEyKLvewJruF09fAbV75fqemt
         Zj/b5yNlFMhNymJ2tTIe93BJMkLbqqVdgrT4mD6HmySmVAAANTZZThklS4MrkKwSgW+t
         BYWiMg0XDW2kkv8RkRJwGZZZUg/cxS83h1iE6qAj4jjRFikZxbMB1gDMsjOEZYZxaqo7
         cZoJNfBVsuAwGNk4xNLAyYlbv5N5OzbM3LNGf+l4yVr67jjODodvcelYNuZBy/qeVHue
         HJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ttqKQoIhHzKwUAeWebdTS3B6pWFccBrSTjErG8GWQFY=;
        b=WI2HKJyIsMDSfKsN4nVzVgdB7ZecGYCXausZvwCiiQHnKnBcbE/RcvkIBJFLry54Eo
         VqRneW0aVAp/oDfegT1Z5BJirDOe/lTJERITTSNUCW1FCioLyP5bAFGJgtyfW7fOB2Yc
         6ajlE4btEzyJKlFtA917NWAohbI+8fJtk6py3Pl1nS8ub+lrBwSxliFmjTrGuzLyo/By
         Wz1vWhiUvFwt/vJRZ8Mm3PWYy0yI1xOadW50Ts7TIlq8YVWERSc//2D2FjNMmFS7SFfZ
         j0XYCb997cV9UAEDSMLhxv0l5qzAZaR1FHKm0kn1HFoTkYfkaxAn5HaqOCImTzPE3RDH
         Vh5A==
X-Gm-Message-State: AOUpUlHFaSyNGhYWQZ4JhEz9I1wWlYJBbdXRiSlNzBIAWGW7e6Uk+keq
        9qJxvVcTDYTKiMXeJ1P6vPM=
X-Google-Smtp-Source: AA+uWPwnUmCf9en80WNdei6NG+K1fQJj0o6+ZxJYj4D5pESE0tFqTaQWlVCL/DMq7aih06WiMcsl9A==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr545564pgj.15.1533690539520;
        Tue, 07 Aug 2018 18:08:59 -0700 (PDT)
Received: from [10.66.0.122] ([104.207.83.31])
        by smtp.gmail.com with ESMTPSA id u69-v6sm3325479pgd.43.2018.08.07.18.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 18:08:58 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
To:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802040557.GL160746@Turing-Arch-b> <20180802142243.GA3481@redhat.com>
 <20180803034721.GC91035@Turing-Arch-b> <20180803143944.GA4079@redhat.com>
 <20180806031252.GG91035@Turing-Arch-b> <20180806153257.GB6002@redhat.com>
From:   Kenneth Lee <nek.in.cn@gmail.com>
Message-ID: <11bace0e-dc14-5d2c-f65c-25b852f4e9ca@gmail.com>
Date:   Wed, 8 Aug 2018 09:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806153257.GB6002@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018年08月06日 星期一 11:32 下午, Jerome Glisse 写道:
> On Mon, Aug 06, 2018 at 11:12:52AM +0800, Kenneth Lee wrote:
>> On Fri, Aug 03, 2018 at 10:39:44AM -0400, Jerome Glisse wrote:
>>> On Fri, Aug 03, 2018 at 11:47:21AM +0800, Kenneth Lee wrote:
>>>> On Thu, Aug 02, 2018 at 10:22:43AM -0400, Jerome Glisse wrote:
>>>>> On Thu, Aug 02, 2018 at 12:05:57PM +0800, Kenneth Lee wrote:
>>>>>> On Thu, Aug 02, 2018 at 02:33:12AM +0000, Tian, Kevin wrote:
>>>>>>>> On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> [...]
>
>>>>>> But doorbell is just a notification. Except for DOS (to make hardware busy) it
>>>>>> cannot actually take or change anything from the kernel space. And the DOS
>>>>>> problem can be always taken as the problem that a group of processes share the
>>>>>> same kernel entity.
>>>>>>
>>>>>> In the coming HIP09 hardware, the doorbell will come with a random number so
>>>>>> only the process who allocated the queue can knock it correctly.
>>>>> When doorbell is ring the hardware start fetching commands from
>>>>> the queue and execute them ? If so than a rogue process B might
>>>>> ring the doorbell of process A which would starts execution of
>>>>> random commands (ie whatever random memory value there is left
>>>>> inside the command buffer memory, could be old commands i guess).
>>>>>
>>>>> If this is not how this doorbell works then, yes it can only do
>>>>> a denial of service i guess. Issue i have with doorbell is that
>>>>> i have seen 10 differents implementations in 10 differents hw
>>>>> and each are different as to what ringing or value written to the
>>>>> doorbell does. It is painfull to track what is what for each hw.
>>>>>
>>>> In our implementation, doorbell is simply a notification, just like an interrupt
>>>> to the accelerator. The command is all about what's in the queue.
>>>>
>>>> I agree that there is no simple and standard way to track the shared IO space.
>>>> But I think we have to trust the driver in some way. If the driver is malicious,
>>>> even a simple ioctl can become an attack.
>>> Trusting kernel space driver is fine, trusting user space driver is
>>> not in my view. AFAICT every driver developer so far always made
>>> sure that someone could not abuse its device to do harmfull thing to
>>> other process.
>>>
>> Fully agree. That is why this driver shares only the doorbell space. There is
>> only the doorbell is shared in the whole page, nothing else.
>>
>> Maybe you are concerning the user driver will give malicious command to the
>> hardware? But these commands cannot influence the other process. If we can trust
>> the hardware design, the process cannot do any harm.
> My questions was what happens if a process B ring the doorbell of
> process A.
>
> On some hardware the value written in the doorbell is use as an
> index in command buffer. On other it just wakeup the hardware to go
> look at a structure private to the process. They are other variations
> of those themes.
>
> If it is the former ie the value is use to advance in the command
> buffer then a rogue process can force another process to advance its
> command buffer and what is in the command buffer can be some random
> old memory values which can be more harmfull than just Denial Of
> Service.

Yes. We have considered that. There is no other information in the 
doorbell. The indexes, such as head and tail pointers, are all in the 
shared memory between the hardware and the user process. The other 
process cannot touch it.
>
>>>>>>>> My more general question is do we want to grow VFIO to become
>>>>>>>> a more generic device driver API. This patchset adds a command
>>>>>>>> queue concept to it (i don't think it exist today but i have
>>>>>>>> not follow VFIO closely).
>>>>>>>>
>>>>>> The thing is, VFIO is the only place to support DMA from user land. If we don't
>>>>>> put it here, we have to create another similar facility to support the same.
>>>>> No it is not, network device, GPU, block device, ... they all do
>>>>> support DMA. The point i am trying to make here is that even in
>>>> Sorry, wait a minute, are we talking the same thing? I meant "DMA from user
>>>> land", not "DMA from kernel driver". To do that we have to manipulate the
>>>> IOMMU(Unit). I think it can only be done by default_domain or vfio domain. Or
>>>> the user space have to directly access the IOMMU.
>>> GPU do DMA in the sense that you pass to the kernel a valid
>>> virtual address (kernel driver do all the proper check) and
>>> then you can use the GPU to copy from or to that range of
>>> virtual address. Exactly how you want to use this compression
>>> engine. It does not rely on SVM but SVM going forward would
>>> still be the prefered option.
>>>
>> No, SVM is not the reason why we rely on Jean's SVM(SVA) series. We rely on
>> Jean's series because of multi-process (PASID or substream ID) support.
>>
>> But of couse, WarpDrive can still benefit from the SVM feature.
> We are getting side tracked here. PASID/ID do not require VFIO.
>
Yes, PASID itself do not require VFIO. But what if:

1. Support DMA from user space.
2. The hardware makes use of standard IOMMU/SMMU for IO address translation.
3. The IOMMU facility is shared by both kernel and user drivers.
4. Support PASID with the current IOMMU facility
>>>>> your mechanisms the userspace must have a specific userspace
>>>>> drivers for each hardware and thus there are virtually no
>>>>> differences between having this userspace driver open a device
>>>>> file in vfio or somewhere else in the device filesystem. This is
>>>>> just a different path.
>>>>>
>>>> The basic problem WarpDrive want to solve it to avoid syscall. This is important
>>>> to accelerators. We have some data here:
>>>> https://www.slideshare.net/linaroorg/progress-and-demonstration-of-wrapdrive-a-accelerator-framework-sfo17317
>>>>
>>>> (see page 3)
>>>>
>>>> The performance is different on using kernel and user drivers.
>>> Yes and example i point to is exactly that. You have a one time setup
>>> cost (creating command buffer binding PASID with command buffer and
>>> couple other setup steps). Then userspace no longer have to do any
>>> ioctl to schedule work on the GPU. It is all down from userspace and
>>> it use a doorbell to notify hardware when it should go look at command
>>> buffer for new thing to execute.
>>>
>>> My point stands on that. You have existing driver already doing so
>>> with no new framework and in your scheme you need a userspace driver.
>>> So i do not see the value add, using one path or the other in the
>>> userspace driver is litteraly one line to change.
>>>
>> Sorry, I'd got confuse here. I partially agree that the user driver is
>> redundance of kernel driver. (But for WarpDrive, the kernel driver is a full
>> driver include all preparation and setup stuff for the hardware, the user driver
>> is simply to send request and receive answer). Yes, it is just a choice of path.
>> But the user path is faster if the request come from use space. And to do that,
>> we need user land DMA support. Then why is it invaluable to let VFIO involved?
> Some drivers in the kernel already do exactly what you said. The user
> space emit commands without ever going into kernel by directly scheduling
> commands and ringing a doorbell. They do not need VFIO either and they
> can map userspace address into the DMA address space of the device and
> again they do not need VFIO for that.
Could you please directly point out which driver you refer to here? 
Thank you.
>
> My point is the you do not need VFIO for DMA in user land, nor do you need
> it to allow a device to consume user space commands without IOCTL.
>
> Moreover as you already need a device specific driver in both kernel and
> user space then there is not added value in trying to have all kind of
> devices under the same devfs hierarchy.
>
> Cheers,
> Jérôme
>

Cheers
Kenneth(Hisilicon)
