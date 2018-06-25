Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56ACC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A71925F50
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XYYTvxce";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U+alg4lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71925F50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934910AbeFYRbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:31:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:31:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4AFF06071C; Mon, 25 Jun 2018 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529947892;
        bh=WFVnVl644B1YG7Jfk6eHzaZZTfL0ySJJyKJbBvtboT4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XYYTvxceHF8F5lxIrZYTCvk2rdTdANiNv+b/ELEhVInsmaWWLWqbCipzrxsO6lT+t
         VIYtdyVEAHhYm8H3I8aP14bN+3cz+Fb3gWcgX1KUXGGGElMfcAVw65SvYX1otORDxb
         clQe6glq7jor+INGP3UekE3D2VaxlmnK0d4UBYLk=
Received: from [10.235.228.150] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0524D606FA;
        Mon, 25 Jun 2018 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529947890;
        bh=WFVnVl644B1YG7Jfk6eHzaZZTfL0ySJJyKJbBvtboT4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U+alg4lqHBiSHhTqY15tlSRJMFMn+MaJklSNcg7/LdIQvFBe3rUQmR/TEtthWSLf5
         bJ7EsuEcSVjSQb8XbK2IAxeV49q8RdKEyCgXOaq3bGT+DAEsryZRMDy/NkSy/0zyl2
         fNE5zY8e6vRy51MGQ4sbEpDnYJoKPinZ5+mLutgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0524D606FA
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
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org>
 <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
 <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
 <7777f7bfead902f2f5175d48907fccec@codeaurora.org>
 <eb16a77f-7950-7fa1-c436-0ce99a992d3b@codeaurora.org>
 <CAKv+Gu__a0yMcH6pyC0oxXZYgi=emuJA+6v1Zdmd4tbq_UR0Og@mail.gmail.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d8f060ec-bc58-666d-7f2f-b3732ef2fa46@codeaurora.org>
Date:   Mon, 25 Jun 2018 13:31:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu__a0yMcH6pyC0oxXZYgi=emuJA+6v1Zdmd4tbq_UR0Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 1:29 PM, Ard Biesheuvel wrote:
>>> Platform has been doing mmio translation for quite a while. Because all accesses go through pci io protocol, the rest of the UEFI never needed to be aware of bar address or do direct access.
>>>
>>> This is the first time I hear of direct access. Maybe, GOP is a special case.
>>>
>>> I started copying your response to the bios vendor.
>>>
>>> They are probably missing that patch. I will pass it along.
>> I was informed that they fixed the issue in BIOS by presenting CPU physical
>> address instead of PCI bus address in FrameBufferBase of the AST GOP UEFI driver.
>>
>> We can drop this patch now.
>>
> Excellent! Thanks for following up with the vendor ...
> 

Sure, appreciate the help.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
