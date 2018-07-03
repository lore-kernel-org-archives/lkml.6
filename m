Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7592923CB9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcaSif9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7592923CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934205AbeGCRNY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:13:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46698 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933568AbeGCRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:13:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so5286639oie.13;
        Tue, 03 Jul 2018 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uh71ulaA1LfzeXhOY5/Hx+a+R02bnZVW6b4dA7lhlRk=;
        b=jcaSif9M5qhueJZdM6P7k0fycicYY41ZuFalRXrnb8j77phGodAq7HAhsF+IMfSdCx
         mfI1kJ8Uv16Xj3JHbWUQVq8xzMOXIQDZHKArZSNaij1/urXbELrg+IFITAVAZHxJYSs4
         6uxKweQ+9+rP5eNOBoXgnH1Ke6Bz81gxRc8YLGGkHsdfrVovxpV2woidrQTKL4KzqGnO
         K6DpyX2G4mMsl75c1WYk/K0me3FIL/KEqv6p/14frG3qJdH68WVxCG6YW3F31YU4IMxL
         jKDxIy1oaPYJ2Y+tShm59UiDWjXSGZl5oh3P1eQXKqxlbC4SFCcHZqyP2UKvYDjLQDEu
         hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uh71ulaA1LfzeXhOY5/Hx+a+R02bnZVW6b4dA7lhlRk=;
        b=UmkEIXlJyMjsyzpXcnru5YH9juGRm7QUvWv6z9UmcNaP9WzsbFUfh7y4c0yIOA2fE1
         wBoMiskQcuUiDrengmXUEMphJRlViGxF+dKSV73f/E3fQQF1XcOPQYMPT0gWYqMaBJaA
         JmE+k6zsB94QHZLgnVVZpLSz1yFjUIraem/M9yvGIDCY++kLABxnxIPeSXcFpExWfBZ3
         2GTU6Rli854mdppMKd4xGh1ofCqlqazb3Wn28Oz0mDHuDmSu9Bh1mdVDChhhkNvxkyMt
         K4aTFzisABPRPXGwiCwz+ohkpga9pL/cDz1m9ehxC4Z6hins7Ni9oemXwOZ2Co3JRnkp
         BRJQ==
X-Gm-Message-State: APt69E3DCAevVyBQWOcT15qn0CXWyP1V0B2cVPlKKXpst0+SVzvqV3uN
        0m2HycCi5plRdFkSmcP1KDk3Ny9Z1x4=
X-Google-Smtp-Source: AAOMgpeW1TWc27Uw1kMEU1D/VFHjW80yc5kAJszG4mSCducUCZINzox82394l8gmkV6Rp/XVk0930g==
X-Received: by 2002:aca:6655:: with SMTP id a82-v6mr15653985oic.228.1530638001725;
        Tue, 03 Jul 2018 10:13:21 -0700 (PDT)
Received: from nuclearis2_1.gtech (c-98-201-114-184.hsd1.tx.comcast.net. [98.201.114.184])
        by smtp.gmail.com with ESMTPSA id 93-v6sm353953otc.27.2018.07.03.10.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:13:20 -0700 (PDT)
Subject: Re: [PATCH v3] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
 <20180702161611.2048-1-mr.nuke.me@gmail.com>
 <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <77bd7f4b-adf6-15f8-e506-61fe934c4493@gmail.com>
Date:   Tue, 3 Jul 2018 12:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 11:38 AM, Bjorn Helgaas wrote:
> On Mon, Jul 02, 2018 at 11:16:01AM -0500, Alexandru Gagniuc wrote:
>> According to the documentation, "pcie_ports=native", linux should use
>> native AER and DPC services. While that is true for the _OSC method
>> parsing, this is not the only place that is checked. Should the HEST
>> table list PCIe ports as firmware-first, linux will not use native
>> services.
>>
>> This happens because aer_acpi_firmware_first() doesn't take
>> 'pcie_ports' into account. This is wrong. DPC uses the same logic when
>> it decides whether to load or not, so fixing this also fixes DPC not
>> loading.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>  drivers/pci/pcie/aer.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e88386af28..db2c01056dc7 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -283,13 +283,14 @@ static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
>>  
>>  static void aer_set_firmware_first(struct pci_dev *pci_dev)
>>  {
>> -	int rc;
>> +	int rc = 0;
>>  	struct aer_hest_parse_info info = {
>>  		.pci_dev	= pci_dev,
>>  		.firmware_first	= 0,
>>  	};
>>  
>> -	rc = apei_hest_parse(aer_hest_parse, &info);
>> +	if (!pcie_ports_native)
>> +		rc = apei_hest_parse(aer_hest_parse, &info);
>>  
>>  	if (rc)
>>  		pci_dev->__aer_firmware_first = 0;
>> @@ -324,7 +325,9 @@ bool aer_acpi_firmware_first(void)
>>  	};
>>  
>>  	if (!parsed) {
>> -		apei_hest_parse(aer_hest_parse, &info);
>> +		if (!pcie_ports_native)
>> +			apei_hest_parse(aer_hest_parse, &info);
>> +
>>  		aer_firmware_first = info.firmware_first;
>>  		parsed = true;
>>  	}
> 
> I was thinking something along the lines of the patch below, so we
> don't have to work through the settings of "rc" and "info".  But maybe
> I'm missing something subtle?
> 
> One subtle thing that I didn't look into is the
> pcie_aer_get_firmware_first() stub for the non-CONFIG_ACPI_APEI case.
> 
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b24f2d252180..5ccbd7635f33 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -342,6 +342,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return 0;
>  
> +	if (pcie_ports_native)
> +		return 0;
> +

Here we're not setting dev->__aer_firmware_first_valid. Assuming we only
check for it via pcie_aer_get_firmware_first(), we should be fine. THis
field is used in portdrv.h, but its use seems safe. I think this
approach can work.

>  	if (!dev->__aer_firmware_first_valid)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
> @@ -362,6 +365,9 @@ bool aer_acpi_firmware_first(void)
>  		.firmware_first	= 0,
>  	};
>  
> +	if (pcie_ports_native)
> +		return false;
> +

This makes better sense.

>  	if (!parsed) {
>  		apei_hest_parse(aer_hest_parse, &info);
>  		aer_firmware_first = info.firmware_first;
> 
