Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BE1BBC07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6C32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933895AbeFMCxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:53:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51720 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933226AbeFMCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:52:59 -0400
Received: from mail-pg0-f72.google.com ([74.125.83.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fSvu6-00041Z-Ra
        for linux-kernel@vger.kernel.org; Wed, 13 Jun 2018 02:52:58 +0000
Received: by mail-pg0-f72.google.com with SMTP id d1-v6so349204pga.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 19:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Brukz1IHrrzWDQqRoNaQ6t+e0uiF+OebCMwZLblIDqM=;
        b=Tp9UJaLXvMg6Zbm2kuTy03AmQv8aBejZnBbxGOYUDY4g+X/TTCaphSLMKhUuapg7Xz
         T4YKYXPmESiPmBUgVbL0i6zvX7VqD2YpfdztUNr+3A7MPNvrPtGJF+MffgMFnSgg09Yy
         eLVJEHw8rek4AtE+MGphWtFzWgDTBo3pPW8e7nz4MyL8kEvQStMolPRskUMcsnBgHZhA
         5s9BzWMqHcVdFImtBpLEDrrvo+XvOBTQdzkwqfmtUhkPoV188BjcG0a1oCsTdx1ovhsP
         VYZ5fLHiy7peFf+HGJN5ZKVqJv6Dg8a1Q/5lIUY3KSwbrqRrL3CMuAg9UzSL2xEkse6U
         KmMQ==
X-Gm-Message-State: APt69E1BI4rEV6zz/y/UzQe3Sbyx0Cozk1zoKXfJh1krro8Kda5SJIzj
        gXmakJU2KgMJsu6T2zukYeb+NHcdO1wM2GcZef2q4GovJzV/0u8mQoKUGS9xzQGavKmNkdO3xNC
        MeWLcddBCTPKDHg5fpShUOAM6v/a60Ofz+ety2LeiVg==
X-Received: by 2002:a63:b742:: with SMTP id w2-v6mr2456316pgt.200.1528858377494;
        Tue, 12 Jun 2018 19:52:57 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKITdhbYAqXgrrklB3xWLvNIWHmuKk8FqJrSYUJNZxn6Co6rkx0jx7ZECrwy2MtFQgrHpTFVzw==
X-Received: by 2002:a63:b742:: with SMTP id w2-v6mr2456306pgt.200.1528858377222;
        Tue, 12 Jun 2018 19:52:57 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id t23-v6sm2269483pfa.86.2018.06.12.19.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 19:52:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH 1/2] r8169: Don't disable ASPM in the driver
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <caa66d98-e5cc-8bcd-1052-cef4ff00c32d@gmail.com>
Date:   Wed, 13 Jun 2018 10:52:52 +0800
Cc:     David Miller <davem@davemloft.net>, Ryankao <ryankao@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>, Hau <hau@realtek.com>,
        romieu@fr.zoreil.com, bhelgaas@google.com,
        Linux Netdev List <netdev@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E67CB62D-D400-4556-B00C-18892E1E2AC4@canonical.com>
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
 <caa66d98-e5cc-8bcd-1052-cef4ff00c32d@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

> On Jun 13, 2018, at 3:30 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 12.06.2018 11:57, Kai-Heng Feng wrote:
>> Enable or disable ASPM should be done in PCI core instead of in the
>> device driver.
>>
>> Commit ba04c7c93bbc ("r8169: disable ASPM") uses
>> pci_disable_link_state() to disable ASPM. This is incorrect, if the
>> device really needs to disable ASPM, we should use a quirk in PCI core
>> to prevent the PCI core from setting ASPM altogether.
> I wouldn't call using pci_disable_link_state() in a driver incorrect
> (as it works), there is just a better way which is more in line with
> the PCI subsystem architecture.

Ok, I'll amend the commit log in next version.

>
>> Let's remove pci_disable_link_state() for now. Use PCI core quirks if
>> any regression happens.
> The vendor driver disables ASPM unconditionally for chip version 25
> (there it's METHOD_9), so I think ASPM support is broken in this chip
> version. I'll cook a PCI quirk.

I actually asked Ryankao about this. He said that variant is more then a  
decades old and he can't find why it doesn't support ASPM.

Since METHOD_9 might be a platform issue instead, my intention was to  
enable ASPM for all variants. If users hit any issue, then we can introduce  
new PCI quirks.

>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Please note that netdev is closed currently. Once 4.18-RC1 is out it
> will be re-opened. Then please re-submit properly annotating PATCH
> with "net-next" (I've forgotten this often enough myself).

Will do for next version. Thanks!

Kai-Heng

>
>> ---
>> v2:
>> - Remove module parameter.
>> - Remove pci_disable_link_state().
>>
>>  drivers/net/ethernet/realtek/r8169.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.c  
>> b/drivers/net/ethernet/realtek/r8169.c
>> index 75dfac0248f4..9b55ce513a36 100644
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -25,7 +25,6 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/firmware.h>
>> -#include <linux/pci-aspm.h>
>>  #include <linux/prefetch.h>
>>  #include <linux/ipv6.h>
>>  #include <net/ip6_checksum.h>
>> @@ -7647,10 +7646,6 @@ static int rtl_init_one(struct pci_dev *pdev,  
>> const struct pci_device_id *ent)
>>  	mii->reg_num_mask = 0x1f;
>>  	mii->supports_gmii = cfg->has_gmii;
>>
>> -	/* disable ASPM completely as that cause random device stop working
>> -	 * problems as well as full system hangs for some PCIe devices users */
>> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
>> -				     PCIE_LINK_STATE_CLKPM);
>>
>>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>>  	rc = pcim_enable_device(pdev);
