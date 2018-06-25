Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E17C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AE825D53
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DgsZg11p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ga3vWhl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AE825D53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755024AbeFYPwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:52:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34328 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754933AbeFYPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:52:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 401AD60A06; Mon, 25 Jun 2018 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529941935;
        bh=g2mHT8KOdbvdZB6kn6IuACZJ2Nh/O0wr22i1uqnadDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DgsZg11pwDmPYEfFeHbYqI7SaCus1LeNX3hzAjbNCjZo1zFTh6hDTRgYSYcxQAEko
         FIe6X2SBIna4HF5BEt9vcBgYSUOCNtbn4XTaCwEN/YZae9fSrCIYh5UDWUQ2NNsQEF
         mcL6ucjqHTNRTAWjkHNLUJIWhtK0s6Ch/5eRGQ2E=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C194D60131;
        Mon, 25 Jun 2018 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529941934;
        bh=g2mHT8KOdbvdZB6kn6IuACZJ2Nh/O0wr22i1uqnadDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ga3vWhl/tLiW+79qMa4LGxOmmszSF7pgsdhM7uwdZWpks8Pudmb7zdg52g1n7Ryjh
         cfkxKhCyiUBive/tETfMRwQZGI6WuEb/y2L+sxCp9StsLINBs1xLGp3oZAsQupx+Uv
         uwFe/Or+wX/FcIVCfXzD1VVgw3i/apNczfFKd2jI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jun 2018 11:52:14 -0400
From:   okaya@codeaurora.org
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
 <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
 <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
 <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
Message-ID: <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-25 04:20, Ard Biesheuvel wrote:
> On 22 June 2018 at 21:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> 
> wrote:
>> On 22 June 2018 at 20:30, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>>>>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase 
>>>>> is
>>>>> described as
>>>>> 
>>>>> """
>>>>> Base address of graphics linear frame buffer. Info contains
>>>>> information required to allow software to draw directly to the
>>>>> frame buffer without using Blt().Offset zero in
>>>>> FrameBufferBase represents the upper left pixel of the
>>>>> display.
>>>>> """
>>>> I just tried AMD Radeon and NVidia graphics cards on a system with
>>>> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
>>>> structure is populated correctly, i.e., using the CPU address not 
>>>> the
>>>> PCIe address.
>>>> 
>>>> EDK2 only recently gained support for MMIO translation in the host
>>>> bridge driver, so I so wonder if this is a platform issue rather 
>>>> than
>>>> a driver issue. It may be worth a try to dump the results of
>>>> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
>>>> or in the stub), to double check that the correct values are 
>>>> returned.
>>>> 
>>> 
>>> Thanks for checking out other platforms. I'll mark the issue as a 
>>> BIOS
>>> issue and bounce your feedback to the BIOS provider.
>>> 
>> 
>> I screwed up my testing, unfortunately. Both the public AMD GOP driver
>> I tried, and the Nvidia GT218 under x86 emulation break when using
>> MMIO translation. However, GraphicsOutputDxe in the EDK2 tree gets it
>> right, and uses PciIo->GetBarAttributes() to get the address of the
>> framebuffer region, which will return the CPU address not the PCI
>> address.
>> 
>>> Let's hold onto this patch for the moment.
>>> 
>> 
>> Yes. I'd like to get this resolved as well, but if the drivers are
>> dereferencing BAR values as CPU addresses, this is unlikely to be the
>> only thing that is broken under outbound translation.
> 
> Note that this was fixed fairly recently in EDK2, so BIOS vendors
> providing UEFI firmware for ARM platforms with outbound MMIO
> translation should probably incorporate this EDK2 patch
> 
> commit dc080d3b61e570e7a3163fc24afa6f8388d0c0bf
> Author: Heyi Guo <heyi.guo@linaro.org>
> Date:   Thu Feb 8 11:13:27 2018 +0800
> 
>     MdeModulePkg/PciBus: return CPU address for GetBarAttributes
> 
>     According to UEFI spec 2.7, PciIo->GetBarAttributes should return 
> host
>     address (CPU view ddress) rather than device address (PCI view
>     address), and
>     device address = host address + address translation offset,
>     so we subtract translation from device address before returning.
> 
> Note that this is not the only MMIO translation related change made by
> Heyi Guo to the generic PCI host bridge and bus drivers, but given
> that those did not support MMIO translation at all, I take it your
> affected platforms will already have their own changes to accommodate
> this.

Platform has been doing mmio translation for quite a while. Because all 
accesses go through pci io protocol, the rest of the UEFI never needed 
to be aware of bar address or do direct access.

This is the first time I hear of direct access. Maybe, GOP is a special 
case.

I started copying your response to the bios vendor.

They are probably missing that patch. I will pass it along.
