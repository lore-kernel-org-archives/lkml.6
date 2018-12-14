Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EEAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3CA206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544801609;
	bh=WKapRyjz7HNYZ3ibaGToFR2sfF+bIK3R2OypfuMMfU4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZapNPsEcdam/1HO/VsT+8HtyIVV8nZofGYI/YvB4U7wLYNV6Q2tzzstSk6roFHSHx
	 IpvUCd/ynw5bs1AUxgmsqs8Hef/Ts7qRTlHrkCqELHFtXFIKb6mH7DR16nptynUt0C
	 AWFX8/qWVphl9ifm1kpSyoauCKvO9oggygYr6Kjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeLNPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNPd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:33:27 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3C3206DD;
        Fri, 14 Dec 2018 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544801607;
        bh=WKapRyjz7HNYZ3ibaGToFR2sfF+bIK3R2OypfuMMfU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BYTo7u2UDPNr3dBYXwUSuEqOTyPkzEf6IotYufObFNx+sFW0JdnCorVunlV5smZy/
         bdguvX/pIgfnEztb1hjtI4FbsrLDGwXIZO1hYC+UkYE2YXZE2w9HqpiNQL2ED3rKuw
         aeNAootoM39PD9OZU36a4U8AbCnrwF+wTYD9vPHk=
Subject: Re: [PATCH v8 1/4] ACPI: Allow CONFIG_PCI to be unset for reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181214031252.28707-1-okaya@kernel.org>
 <20181214031252.28707-2-okaya@kernel.org>
 <CAJZ5v0ji7xSs=1By9x8VAZ1eRkyQdfvO67B+Vg+FajZmJLmi4Q@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <90d988a4-8097-0852-bb25-be477821ed39@kernel.org>
Date:   Fri, 14 Dec 2018 10:33:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ji7xSs=1By9x8VAZ1eRkyQdfvO67B+Vg+FajZmJLmi4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 4:18 AM, Rafael J. Wysocki wrote:
>>        case ACPI_ADR_SPACE_PCI_CONFIG:
>> +       {
> Why did you add the braces?
> 

I had to move these variables to the inner scope otherwise, I get an unused
variable warning from the compiler.

>> +#ifdef CONFIG_PCI
>> +               unsigned int devfn;
>> +               struct pci_bus *bus0;

