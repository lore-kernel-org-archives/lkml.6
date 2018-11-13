Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8AFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585C222507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXXrxYhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C222507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeKMKVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:21:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33377 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:21:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so10000953wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qPv0iq215ZN7AkXTF2XcssGZeR9rigT78LID6JoMQYI=;
        b=NXXrxYhl5Wov7d4majX5MlUZ5+jTp+QWi1Ggu7zYwoJ1NMtJQs96HMr2T/7HBww/dn
         fAvM3IYrKxUSOL8LDFp0L+aNiOY3cymz8ucf1yChq3fJ+ep9aF2yQm0hz3ihCQOe796/
         Jla0boAwyk+1mzGwAyszhz+aTljPQmWzbl6Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qPv0iq215ZN7AkXTF2XcssGZeR9rigT78LID6JoMQYI=;
        b=Mscl+WaCtLCzq+rq5bnsL1BRp3g439rS4pIRgP/F6+pgn4eMR2fPZ6+fklwlgptc8M
         ZQCwg5UrO00xOyVLkLLq/Fq/IMMh1R/uTcFWZ2ZsSiKEhmIk99Qp30kq2HnWxed4rKXi
         YQ57XCcfTCNXoYDT6X9B2+7QzyrFX5Mvez3eA8wAumUiJsg0qEws7TbbvFSfPkRN6R25
         JsYltqFFcGnx3FTxq1sGAtQ08eSWSh1YAongPGh5fKw+b7FBHlB6fjyBWxNDdKKwpv+w
         osRIRdrlpgSBNzsPliwTLw7ohkbW+/dqGHJnIM8SuXXb+Erp9+dImvAYkyc0mSMGp5R8
         01+w==
X-Gm-Message-State: AGRZ1gJsJLq1YWMNkr5pbYe/VcSf8J4v0zEjbWqaL4J8JD5jEyIXQXd/
        svH2V0zX1rRn1cAPL/qIo3FPVCfIf8Hi1KODURgw6Q==
X-Google-Smtp-Source: AJdET5fc3L9iPoJ06V9CVg7RcqYK1PqpEbh1vtLno3T97ulLyFQpoOOKSAx/hlHAGkxIHIPZdCt8YI3lqakFERYr2Xw=
X-Received: by 2002:a1c:7203:: with SMTP id n3-v6mr1493896wmc.5.1542068780522;
 Mon, 12 Nov 2018 16:26:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 16:26:19
 -0800 (PST)
In-Reply-To: <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 12 Nov 2018 16:26:19 -0800
Message-ID: <CALAqxLV8u7rFKRc19J7z_TKLbkG4YbAfj8HjOnPeDH3-uYXPDQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 4:07 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Nov 8, 2018 at 11:49 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>>
>>> Any suggestions for how to further debug what might be going wrong
>>> would be appreciated!
>>
>> Very odd.  In the end map_sg and map_page are defined to do the same
>> things to start with.  The only real issue we had in this area was:
>>
>> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>>
>> so with current mainline + that you still see a problem, and if you
>> rever the commit we are replying to it still goes away?
>
> Just to confirm, as of 4.20-rc2 (which includes the of/device patch
> above), I'm still seeing this issue, but it isn't as reliable to
> reproduce as before.
>
> With "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs" reverted
> (along with the dependent swiotlb patches) it doesn't seem to trigger
> (no matter what I try).  But re-applying that patch it tends to
> trigger by itself at boot up, but sometimes I have to run "find /" to
> trigger the io hang/stall.

Also, I wanted to mention I've not seen this issue on the original
hikey board. So far only on the hikey960, which might mean this is
tied to something in the hisi UFS driver?

thanks
-john
