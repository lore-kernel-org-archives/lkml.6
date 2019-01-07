Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6EAC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78120989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAGGq0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:46:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60450 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAGGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:46:25 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggOg3-0000pX-Cl
        for linux-kernel@vger.kernel.org; Mon, 07 Jan 2019 06:46:23 +0000
Received: by mail-pg1-f197.google.com with SMTP id t26so33240636pgu.18
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 22:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GVSf7DqHMtHmefQq+lklV7dEktIQmD72Mc+9UPCwgFw=;
        b=L0vVo3+LGiosIrueg9rYDTAHcZ5tH3AKtk4lO/nNtE8rEjupp/2T79x0H8AWhez5YH
         vVJDYRU22ySpGsB2buYQXVIL+cByS5qe+ZIw7HrvskmMO4qthkNpR1BDvSMp+lsNWWTh
         qcwBxiVlBUG0e26yxWW8IScerjaems/PuyeYqFtBYvT076xRyuW/xnVfXfn5hNF6mXYV
         wZlI+WLUwskjBOXy7iE3SIBZVnE5tL8Sxawfvk99NS6c22kV8VLKgUlg3yEHcJOw/C/K
         tMhAEtT+GRiJA/AG5QEZKWi65Vj5EOPZrWvbnoNFsyAdMa8XzuwSiJ9CJpXOCy0TMtxT
         PMDQ==
X-Gm-Message-State: AJcUukfW++H7ZRAWJcY07xk4ogCUShzLnNiaSCoxEz8jCJhHy4nKWMd+
        glEMo37yckHqwKu+pK+cKBQkRY2UhRgCUkiGXGTuhjhOnh6RXg8s75KVqMxF5OwbFIg6b87B+PF
        OYwDiEoC6FNgMEDbPqfnpqzg40SEn2EhLkwpuAxVzvw==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr61182642plb.10.1546843582063;
        Sun, 06 Jan 2019 22:46:22 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5qGlcdxE1vo0BiiKbWv6LOCsG77sS9ITcgHp1YOxH8TLD0i+kRh0/LZRWISWnwmdMx+bbWpQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr61182614plb.10.1546843581792;
        Sun, 06 Jan 2019 22:46:21 -0800 (PST)
Received: from 2001-b011-380f-3f3d-8c0d-0ee6-8d41-4b74.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-8c0d-0ee6-8d41-4b74.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:8c0d:ee6:8d41:4b74])
        by smtp.gmail.com with ESMTPSA id b202sm129558105pfb.88.2019.01.06.22.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 22:46:21 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: r8152: data corruption in various scenarios
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2ed9c380-c299-586e-a036-49cdf0387766@pobox.com>
Date:   Mon, 7 Jan 2019 14:46:18 +0800
Cc:     Ansis Atteka <aatteka@nicira.com>,
        Hayes Wang <hayeswang@realtek.com>,
        David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E9946B82-6F51-404E-8A72-C24CB5E7A7BA@canonical.com>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
 <3F1015D1-B2B5-4A2B-87EC-8AB2A516A2F1@canonical.com>
 <2ed9c380-c299-586e-a036-49cdf0387766@pobox.com>
To:     Mark Lord <mlord@pobox.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 7, 2019, at 12:13, Mark Lord <mlord@pobox.com> wrote:
> 
> On 2019-01-06 11:09 p.m., Kai Heng Feng wrote:
>> 
>> 
>>> On Jan 7, 2019, at 05:16, Mark Lord <mlord@pobox.com> wrote:
>>> 
>>> On 2019-01-06 4:13 p.m., Mark Lord wrote:
>>>> On 2019-01-06 2:14 p.m., Kai Heng Feng wrote:>> On Jan 5, 2019, at 10:14 PM, Mark Lord
>>>> <mlord@pobox.com> wrote:
>>>> ..
>>>>>> There is even now a special hack in the upstream r8152.c to attempt to detect
>>>>>> a Dell TB16 dock and disable RX Aggregation in the driver to prevent such issues.
>>>>>> 
>>>>>> Well.. I have a WD15 dock, not a TB16, and that same hack also catches my dock
>>>>>> in its net:
>>>>>> 
>>>>>>  [5.794641] usb 4-1.2: Dell TB16 Dock, disable RX aggregation
>>>>> 
>>>>> The serial should be unique according to Dell.
>>>>> 
>>>>>> So one issue is that the code is not correctly identifying the dock,
>>>>>> and the WD15 is claimed to be immune from the r8152 issues.
>>>>> 
>>>>> The WD15 I tested didn't use that serial number though...
>>>> 
>>>> What info do you need from me about the WD15 so this can be corrected?
>>>> 
>>>>>> xhci_hcd 0000:39:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 13
>>>>>> comp_code 1
>>>>> 
>>>>> This is probably an xHC bug. A similar issue is fixed by commit 9da5a1092b13
>>>>> ("xhci: Bad Ethernet performance plugged in ASM1042A host”). 
>>>>> 
>>>>>> I just got that exact message above, with the r8152 in my 1-day old WD15 dock,
>>>>>> with the TB16 "workaround" enabled in Linux kernel 4.20.0.
>>>>> 
>>>>> Is the xHC WD15 connected an ASMedia one?
>>>> 
>>>> I don't know.  I *think* it identifies as a DSL6340 (see below).
>>>> 
>>>> Here is lspci and lsusb:
>>>> 
>>>> $ lspci -vt
>>>> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
>>>>          +-02.0  Intel Corporation UHD Graphics 620
>>>>          +-04.0  Intel Corporation Skylake Processor Thermal Subsystem
>>>>          +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller
>>>>          +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
>>>>          +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0
>>>>          +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1
>>>>          +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
>>>>          +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
>>>>          |                               +-01.0-[04-38]--
>>>>          |                               \-02.0-[39]----00.0  Intel Corporation DSL6340 USB 3.1
>>>> Controller [Alpine Ridge]
>>>>          +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter
>>>>          +-1d.0-[3b]----00.0  Samsung Electronics Co Ltd Device a808
>>>>          +-1f.0  Intel Corporation Device 9d4e
>>>>          +-1f.2  Intel Corporation Sunrise Point-LP PMC
>>>>          +-1f.3  Intel Corporation Sunrise Point-LP HD Audio
>>>>          \-1f.4  Intel Corporation Sunrise Point-LP SMBus
>>> 
>>> 
>>> Mmm.. lspci -vt isn't as verbose as I thought, so here is plain lspci to fill in the blanks:
>>> 
>>> $ lspci
>>> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM
>>> Registers (rev 08)
>>> 00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (rev 07)
>>> 
>>> 00:04.0 Signal processing controller: Intel Corporation Skylake Processor Thermal Subsystem (rev 08)
>>> 
>>> 00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21)
>>> 
>>> 00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
>>> 
>>> 00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0
>>> (rev 21)
>>> 00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1
>>> (rev 21)
>>> 00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
>>> 
>>> 00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port (rev f1)
>>> 
>>> 00:1c.4 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #5 (rev f1)
>>> 
>>> 00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #9 (rev f1)
>>> 
>>> 00:1f.0 ISA bridge: Intel Corporation Device 9d4e (rev 21)
>>> 
>>> 00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
>>> 
>>> 00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
>>> 
>>> 00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
>>> 
>>> 01:00.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
>>> 
>>> 02:00.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
>>> 
>>> 02:01.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
>>> 
>>> 02:02.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
>>> 
>>> 39:00.0 USB controller: Intel Corporation DSL6340 USB 3.1 Controller [Alpine Ridge]
>> 
>> So it’s not an ASMedia one.
>> 
>> Before digging further, please make sure the system firmware (BIOS), Thunderbolt controller NVM and WD15 firmware are all up-to-date.
> 
> Everything is completely up to date.

Do you happen to use a Dell system? We can do some test here.

Kai-Heng

> 
> 
> -- 
> Mark Lord
> Real-Time Remedies Inc.
> mlord@pobox.com

