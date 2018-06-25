Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AD620873
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHUpVjyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeFYR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:29:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35843 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeFYR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:29:22 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so13512713itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9avK4+xPNBc1sx1bpvRJuKet5B/HjXl1ECs8G/6Cdno=;
        b=KHUpVjyxsIOkHVU/l0+BwBuhfkfMuach+mcs9bA0dC7lJuIr3b4F/68k3bmWdcCpnE
         yUoWzJVwfsZpEI7oQmciQzk/LFU8vAqTtk5vhFK2GLpRdKT8PKriqbCEX0ZV+E5kRps6
         g8nUR0OEBSmAzxfeoixnAYCoQt6cEd5YemMIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9avK4+xPNBc1sx1bpvRJuKet5B/HjXl1ECs8G/6Cdno=;
        b=pB//MbFVrLOzO2WMxpUrsPDiet6JAi1pnDdj0+ZuNQqFOufYHwuY77jEEI9hw9P7dw
         vINaG8n7UDnYbyhbZQx64MDGnLk3O8qR1/hLVo1+yVRlU5HwIhFLJtto8rc60vPGiPkP
         OwAFwmOWnBw0u2eFfbf8q4W2Bk6Rm9nFXvlDjM8Yu8+MQS1rp1V2V+8pjPPRMJ+GkRug
         OUBRCsw1UZybkcgxq3hw3L15eMI0xwnUwxHwaKtw2Sh9WDNKY4zjpVr6sDlG7G3/Ow07
         uH5OdHH7HRiL2T4qC7RjaamfivoUtFYGf/hbq/UINUxm4lT9AIep29A9HbpUzzV26yA8
         ByLg==
X-Gm-Message-State: APt69E2gd/gDYu5U8dqQ5aJoeDraaLQe/UpRk8kvJMSJqNCpXmovh0y1
        5WClKafA7JzqcBRy75+tap5ciRHeXhAYLNjIEmkfqQ==
X-Google-Smtp-Source: AAOMgpeYm34NYwKZhnfz2Bnsk90dAW7ILB5p0dVDBy23PTOExLkYqbZ7OBQOM59qFwEOQFXRFz2v2MzH1j14NSxYdRU=
X-Received: by 2002:a24:d7c5:: with SMTP id y188-v6mr1674416itg.50.1529947761766;
 Mon, 25 Jun 2018 10:29:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 10:29:21
 -0700 (PDT)
In-Reply-To: <eb16a77f-7950-7fa1-c436-0ce99a992d3b@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com>
 <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org> <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
 <CAKv+Gu-WXLXqHSmiS2MmAMXHLKK_kg+3EK6L2rvO0SzN-c0UMg@mail.gmail.com>
 <37289a27-eb99-6a73-4d32-4a75edd11dcd@codeaurora.org> <CAKv+Gu-bwCFhCKiA7P1amMLeBaSxsjk0d6aPjAr9nCvOBPJA6w@mail.gmail.com>
 <CAKv+Gu96HQf0oJ1RC+wVU34FqqcCWrnDGag48vjNP_z86HhLBQ@mail.gmail.com>
 <7777f7bfead902f2f5175d48907fccec@codeaurora.org> <eb16a77f-7950-7fa1-c436-0ce99a992d3b@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 25 Jun 2018 19:29:21 +0200
Message-ID: <CAKv+Gu__a0yMcH6pyC0oxXZYgi=emuJA+6v1Zdmd4tbq_UR0Og@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 June 2018 at 19:28, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/25/2018 11:52 AM, okaya@codeaurora.org wrote:
>>> Note that this is not the only MMIO translation related change made by
>>> Heyi Guo to the generic PCI host bridge and bus drivers, but given
>>> that those did not support MMIO translation at all, I take it your
>>> affected platforms will already have their own changes to accommodate
>>> this.
>>
>> Platform has been doing mmio translation for quite a while. Because all accesses go through pci io protocol, the rest of the UEFI never needed to be aware of bar address or do direct access.
>>
>> This is the first time I hear of direct access. Maybe, GOP is a special case.
>>
>> I started copying your response to the bios vendor.
>>
>> They are probably missing that patch. I will pass it along.
>
> I was informed that they fixed the issue in BIOS by presenting CPU physical
> address instead of PCI bus address in FrameBufferBase of the AST GOP UEFI driver.
>
> We can drop this patch now.
>

Excellent! Thanks for following up with the vendor ...
