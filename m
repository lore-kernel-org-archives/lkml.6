Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEFF252B7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 04:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ9/nIrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEFF252B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeGAEjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 00:39:06 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37571 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeGAEjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 00:39:02 -0400
Received: by mail-ot0-f196.google.com with SMTP id q11-v6so11852801otk.4;
        Sat, 30 Jun 2018 21:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWtqc0nNyT3q1rY3QA1g++ui7vzbh58HnPXDWcEipbE=;
        b=JQ9/nIrSFsN/7B3J+dC2cUUP3TLXqH48p9vAtXxsaROd/ElUoQfvABeXbSbuMafQdV
         XDM/f+5TSIHrxdgojQd25bAXuRN+KQi2NoeJw6BCH6ekNTsGNFGyLuTO00CRBUvHtcJy
         FkNtUcx/YI34pkqjzliepmG/sZWoI0Z3VJ0hWrEOXqcxyRina6EdzKLYfVhX0aaNsjGf
         YRDoC1rw6r/3+Yo9IJvDoARz5xnH3ALn1VBklHeLbxYXNVbKw7hCiClLBzGjsX0dIzOq
         Dh6mXg/1FmBC204dp8kxC0LX6uM2pqzcv1P7G/FFATILL+9oQmr2vJ90bVTg/0fSPsIE
         62Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWtqc0nNyT3q1rY3QA1g++ui7vzbh58HnPXDWcEipbE=;
        b=TSLcp3xtuR/UefwRbO7t5/zmfW+axQn/RokQFWpKOVX39pZXum/TqdoOBbA2XsLADX
         /GzZHRQiDyZskQPN8z1207c43zjM3DfSWud4TBHcePY2KeIXZ0AJDDAMpGkrpz751Ptz
         qCL+gDHMLESPb6WcG3mdym0SGD+8juSJUXQu7dedTC0QudTC9t7Ce0yxnCb2K4VlN46R
         maQHizcKkpScWV2xCVJiVWf7dI3xtlnv+c6Iypghu+8k6CxBJhtDmoAIM3ALLXpNVKUn
         Enarhf5V/OO715LDNru6/DH+9PL4zGgHjnJvzVGux8gUtNn9maUOvLs8hKue0agNNeTR
         oP8w==
X-Gm-Message-State: APt69E1IjjIyO7IpGi3J78oAgAhy7g8I8zA7jrPpuWAWgY2fPic2XIqt
        rkS3ch1SSm/bbjFBC9Kl0HU=
X-Google-Smtp-Source: AAOMgpedCJBU0vbpKDRYXGUkZsA7HRsx59n0xsWwlUoTnUYib+GZjcfrLVb4fGAuGkVKV4NP7mdbVQ==
X-Received: by 2002:a9d:61c9:: with SMTP id h9-v6mr222050otk.4.1530419942190;
        Sat, 30 Jun 2018 21:39:02 -0700 (PDT)
Received: from nuclearis2.gtech ([2601:2c1:8500:500b:da50:e6ff:fe00:4a96])
        by smtp.gmail.com with ESMTPSA id z17-v6sm1784459otd.9.2018.06.30.21.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 21:39:01 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
 <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <fdc547c3-e4f7-4967-7216-9379e6d28139@gmail.com>
Date:   Sat, 30 Jun 2018 23:39:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2018 04:31 PM, Bjorn Helgaas wrote:
> [+cc Borislav, linux-acpi, since this involves APEI/HEST]

Borislav is not the relevant maintainer here, since we're not contingent 
on APEI handling. I think Keith has a lot more experience with this part 
of the kernel.

> On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
>> According to the documentation, "pcie_ports=native", linux should use
>> native AER and DPC services. While that is true for the _OSC method
>> parsing, this is not the only place that is checked. Should the HEST
>> table list PCIe ports as firmware-first, linux will not use native
>> services.
> 
> Nothing in ACPI-land looks at pcie_ports_native.  How should ACPI
> things work in the "pcie_ports=native" case?  I guess we still have to
> expect to receive error records from the firmware, because it may
> certainly send us non-PCI errors (machine checks, etc) and maybe even
> some PCI errors (even if the Linux AER driver claims AER interrupts,
> we don't know what notification mechanisms the firmware may be using).

I think ACPI land shouldn't care about this. We care about it from the 
PCIe stand point at the interface with ACPI. FW might see a delta in the 
sense that we request control of some features via _OSC, which we 
otherwise would not do without pcie_ports=native.

> I guess best-case, we'll get ACPI error records for all non-PCI
> things, and the Linux AER driver will see all the AER errors.

It might affect FW's ability to catch errors, but that's dependent on 
the root port implementation.

> Worst-case, I don't really know what to expect.  Duplicate reporting
> of AER errors via firmware and Linux AER driver?  Some kind of
> confusion about who acknowledges and clears them?

Once user enters pcie_ports=native, all bets are off: you broke the 
contract you have with the FW -- whether or not you have this patch.

> Out of curiosity, what is your use case for "pcie_ports=native"?
> Presumably there's something that works better when using it, and
> things work even *better* with this patch?

Corectness. It bothers me that actual behavior does not match the 
documentation:

  native  Use native PCIe services associated with PCIe ports
                         unconditionally.


> I know people do use it, because I often see it mentioned in forums
> and bug reports, but I really don't expect it to work very well
> because we're ignoring the usage model the firmware is designed
> around.  My unproven suspicion is that most uses are in the black
> magic category of "there's a bug here, and we don't know how to fix
> it, but pcie_ports=native makes it work better".

There exist cases that firmware didn't consider. I would not call them 
"firmware bugs", but there are cases where the user understands the 
platform better than firmware.
Example: on certain PCIe switches, a hardware PCIe error may bring the 
switch downstream ports into a state where they stop notifying hotplug 
events. Depending on the platform, firmware may or may not fix this 
condition, but "pcie_ports=native" enables DPC. DPC contains the error 
without the switch downstream port entering the weird error state in the 
first place.

All bets are off at this point.

> Obviously I would much rather find and fix those bugs so people
> wouldn't have to stumble over the problem in the first place.

Using native services when firmware asks us not to is a crapshoot every 
time. I don't condone the use of this feature, but if we do get a 
pcie_ports=native request, we should at least honor it.


>> This happens because aer_acpi_firmware_first() doesn't take
>> 'pcie_ports' into account. This is wrong. DPC uses the same logic when
>> it decides whether to load or not, so fixing this also fixes DPC not
>> loading.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/pci/pcie/aer.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> Changes since v1:
>>   - Re-tested with latest and greatest (v4.18-rc1) -- works great
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e88386af28..98ced0f7c850 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -291,7 +291,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
>>   
>>   	rc = apei_hest_parse(aer_hest_parse, &info);
>>   
>> -	if (rc)
>> +	if (rc || pcie_ports_native)
>>   		pci_dev->__aer_firmware_first = 0;
>>   	else
>>   		pci_dev->__aer_firmware_first = info.firmware_first;
>> @@ -327,6 +327,9 @@ bool aer_acpi_firmware_first(void)
>>   		apei_hest_parse(aer_hest_parse, &info);
>>   		aer_firmware_first = info.firmware_first;
>>   		parsed = true;
>> +		if (pcie_ports_native)
>> +			aer_firmware_first = 0;
>> +
>>   	}
>>   	return aer_firmware_first;
>>   }
>> -- 
>> 2.14.3
>>
