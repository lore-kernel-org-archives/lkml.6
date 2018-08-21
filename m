Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934AAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7621837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="d4L/vx+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C7621837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeHUXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:30:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42511 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeHUXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:30:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so8943297pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=r6a8kqVTk7X0wHsHZ/EUk7gz802HiHEyVd2InqG2rks=;
        b=d4L/vx+Y95jzW6FpzuzH7Sa37Fy+EcuHjiIXtaJM2HU+sVHiZmbH+KvmfT5HouQhT8
         QNI6t7xijcX9C7UN1plkVZUcZ8NYgtdbyR7aKbA2vRbZTsVzlumMggc4gHy3nCXxvA5s
         N92085FUPAl1VTkEX97RlMU9SMf3Yn3CyezrY8yBFe0I3Lv7YWz6HXC8+6uqWEjMatDO
         baBIY9cTXvblToL4YVSpVqCGmeSLBsuq/6DMwCu/gj/d6LIzQzYq0GNrJ3nnzaI3SFC0
         PFn+jBKjUEuIr3ovfnN2q363Mv30h6LJCFdr0DZkr3AifsgMcHs9QpbzVLh1FKkEZ/an
         /irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=r6a8kqVTk7X0wHsHZ/EUk7gz802HiHEyVd2InqG2rks=;
        b=IjGqGM4YChIpmMBm2dtcK7Dinu4S8FJw6oXXE1oZQjx90Ovffp5/5lbg4nKlJjBBIh
         9MIzLdVZ+aXlep/ejspiB0Cs14mO3lzykF7FyUj8wYoIRGjLQGJgHLmw8naUy9tq/ro+
         oXWNs7IgZ0+/wjAGTTKGdhRgpw4b5/obtLrU6sOKRq2Fa4epJFxVHzq0Q+Herm6MIzGp
         DvIGCDhVOM4bX73quSP/ZKrEatH/5GTD+tE0V6bnlRZWzgS5aLevKjZ0Yqo7gYehWtJO
         MfA/JZ6kbCM+Xs+dgmTk5or2ufD949wmnvigpHxuhxfO0eQsMfjpE3X/xFuSis9X9BMt
         TEUA==
X-Gm-Message-State: AOUpUlHWg66NlNKZUM1+dne9G5gvPgI5iI13w1ItaFAQMb2xsUcs2xgJ
        6bYgX1i0T97QkdQZ8NjEnerzcUMj/Ck=
X-Google-Smtp-Source: AA+uWPyXRXdloom/H8VcEO6f6ZA7K2QhBMZ2WdfMrrOwEvk6VSf1pN3fSfm9hAV0/4MltBvAMNzt8g==
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr47627203pgf.84.1534882105194;
        Tue, 21 Aug 2018 13:08:25 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o134-v6sm28272415pfg.74.2018.08.21.13.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 13:08:24 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:08:24 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 12:37:08 PDT (-0700)
Subject:     Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource() comment
In-Reply-To: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
CC:     lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, bharatku@xilinx.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     monstr@monstr.eu
Message-ID: <mhng-f16f3cf1-f440-47b7-b1b7-a73836ab1c58@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 23:24:53 PDT (-0700), monstr@monstr.eu wrote:
> On 20.8.2018 11:47, Lorenzo Pieralisi wrote:
>> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
>> Bridge IP driver")
>>
>> and
>>
>> commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()")
>>
>> first patched then removed pcibios_align_resource() from the microblaze
>> architecture code but failed to remove the comment that was added to
>> it.
>>
>> Remove it since it has now become stale and it is quite confusing.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> ---
>>  arch/microblaze/pci/pci-common.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
>> index f34346d56095..2ffd171af8b6 100644
>> --- a/arch/microblaze/pci/pci-common.c
>> +++ b/arch/microblaze/pci/pci-common.c
>> @@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>>  }
>>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
>>
>> -/*
>> - * We need to avoid collisions with `mirrored' VGA ports
>> - * and other strange ISA hardware, so we always want the
>> - * addresses to be allocated in the 0x000-0x0ff region
>> - * modulo 0x400.
>> - *
>> - * Why? Because some silly external IO cards only decode
>> - * the low 10 bits of the IO address. The 0x00-0xff region
>> - * is reserved for motherboard devices that decode all 16
>> - * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
>> - * but we want to try to avoid allocating at 0x2900-0x2bff
>> - * which might have be mirrored at 0x0100-0x03ff..
>> - */
>>  int pcibios_add_device(struct pci_dev *dev)
>>  {
>>  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>
>
> Applied.

Sorry, I missed this.  Thanks for the fix!
