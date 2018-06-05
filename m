Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeFET1u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:27:50 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34137 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFET1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:27:47 -0400
X-Google-Smtp-Source: ADUXVKKCi5B3jzG8IOHGdhuWtvzTWUja0cDMf8cIzsbwPn6tOCJqO3b07M4DqtyL4RpCbMNj01ATuQ==
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>, Ryankao <ryankao@realtek.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
        "jrg.otte@gmail.com" <jrg.otte@gmail.com>,
        David Miller <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hau <hau@realtek.com>, linux-pci@vger.kernel.org
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
 <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
 <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com>
 <20180605191142.GA214338@bhelgaas-glaptop.roam.corp.google.com>
 <6c6b579a-5be4-ccc0-f64c-9998e51145f5@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d50e04b3-87be-f300-b0ea-2da7e3660ebb@gmail.com>
Date: Tue, 5 Jun 2018 12:27:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6c6b579a-5be4-ccc0-f64c-9998e51145f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 12:17 PM, Heiner Kallweit wrote:
> On 05.06.2018 21:11, Bjorn Helgaas wrote:
>> [+cc linux-pci]
>>
>> On Tue, Jun 05, 2018 at 12:28:05PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
>>>> Add realtek folk Hau
>>>>
>>>> -----Original Message-----
>>>> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
>>>> Sent: Tuesday, June 05, 2018 1:02 PM
>>>> To: jrg.otte@gmail.com
>>>> Cc: David Miller <davem@davemloft.net>; Hayes Wang <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com; Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
>>>> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
>>>>
>>>> Hi Jörg Otte,
>>>>
>>>> Can you give this patch a try?
>>>>
>>>> Since you are the only one that reported ALDPS/ASPM regression,
>>>>
>>>> And I think this patch should solve the issue you had [1].
>>>>
>>>> Hopefully we don't need to go down the rabbit hole of blacklist/whitelist...
>>>>
>>>> Kai-Heng
>>>>
>>>> [1] https://lkml.org/lkml/2013/1/5/36
>>>
>>> I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
>>> presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
>>> thing.  Changes to these two things should be in separate patches so
>>> they don't get tangled up.
>>>
> ALDPS = Advanced Link Down Power Saving
> And yes, it's a Realtek feature.

Link as in Ethernet link or PCI(e) link? Sorry too lazy to let me google
that for myself :)
-- 
Florian
