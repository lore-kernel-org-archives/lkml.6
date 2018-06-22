Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D64C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1086B24737
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OBaZRU2W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y660YBLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1086B24737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934311AbeFVSaP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:30:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeFVSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:30:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C723605FD; Fri, 22 Jun 2018 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529692213;
        bh=NGNVyJ911kbzoMmhxApHbrIbCJ9QBNpGiW+3BSmTLFc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OBaZRU2W4gSNz+q2az/2kKLOfQsJwveqSmPvQLTgO/r8IpS3YGPBDpntHI48hEDhi
         tG8QUQ4oFhwKbFXUZJRDCoYUlLs7kw1k6spgIg+KkgGKnflyTygi0FiQ4dWb00IOME
         xjEAt4YDucxe56eQ774bGNboQZJ3wfYOluFpoOt8=
Received: from [10.177.57.83] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67094605FD;
        Fri, 22 Jun 2018 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529692212;
        bh=NGNVyJ911kbzoMmhxApHbrIbCJ9QBNpGiW+3BSmTLFc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y660YBLuyIXoPNYClP0BArYM5RJCK6xA1dBJts4RrrfZ8+dEdanHUfiIdaKt4XffZ
         7AYddq2t9l/GuLPaxptJEyJp54PLgWJqNFi0wir8wJhwTGBQetVMLeHRSBur6wQ5eU
         cPy29IQ4GYJ9WIyd9OaD9dDfMjDDuAFn/YPZIQL0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67094605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
 <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
Date:   Fri, 22 Jun 2018 14:30:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2018 2:01 PM, Ard Biesheuvel wrote:
>> Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
>> described as
>>
>> """
>> Base address of graphics linear frame buffer. Info contains
>> information required to allow software to draw directly to the
>> frame buffer without using Blt().Offset zero in
>> FrameBufferBase represents the upper left pixel of the
>> display.
>> """
> I just tried AMD Radeon and NVidia graphics cards on a system with
> non-1:1 mapped MMIO windows, and in both cases, the GOP protocol
> structure is populated correctly, i.e., using the CPU address not the
> PCIe address.
> 
> EDK2 only recently gained support for MMIO translation in the host
> bridge driver, so I so wonder if this is a platform issue rather than
> a driver issue. It may be worth a try to dump the results of
> GetBarAttributes() of all PCI I/O protocol instances (either in UEFI
> or in the stub), to double check that the correct values are returned.
> 

Thanks for checking out other platforms. I'll mark the issue as a BIOS
issue and bounce your feedback to the BIOS provider.

Let's hold onto this patch for the moment.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
