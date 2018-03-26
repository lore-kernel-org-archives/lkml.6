Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeCZRFV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:05:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45126 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbeCZRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:05:18 -0400
X-Google-Smtp-Source: AG47ELs/vJgb/NTB92WtEzz4lpwRcCo9KV1m+Sr+9GEb4oDYF4H2n8iOh5GfCBLOTOZQry1R5cx95A==
Subject: Re: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
To: David Miller <davem@davemloft.net>, mike.looijmans@topic.nl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andrew@lunn.ch, robh+dt@kernel.org,
        frowand.list@gmail.com
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <20180326.125816.1498152294570222508.davem@davemloft.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <40e5302c-0c00-dba0-58d3-77407aa6bde8@gmail.com>
Date: Mon, 26 Mar 2018 10:05:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326.125816.1498152294570222508.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 09:58 AM, David Miller wrote:
> From: Mike Looijmans <mike.looijmans@topic.nl>
> Date: Mon, 26 Mar 2018 08:41:29 +0200
> 
>> It's common practice to store MAC addresses for network interfaces into
>> nvmem devices. However the code to actually do this in the kernel lacks,
>> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
>> address from an nvmem cell provider.
>>
>> This is particulary useful on devices where the ethernet interface cannot
>> be configured by the bootloader, for example because it's in an FPGA.
>>
>> Tested by adapting the cadence macb driver to call this instead of
>> of_get_mac_address().
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Use of_nvmem_cell_get to avoid needing the assiciated device
>>     Use void* instead of char*
>>     Add devicetree binding doc
> 
> Like Andrew, I think you should add a new interface for getting the MAC
> address from nvmem.
> 
> And drivers can call both of them if they want OF device tree and
> NVMEM probing for MAC addresses.
> 
> Later you can add a consolidated interface, if necessary, which does
> both and also take a reference to the MAC address buffer of the driver
> in order to deal with the resource allocation issues.

Agreed, also, how does this fit with Alban's patch series here:

https://lkml.org/lkml/2018/3/24/312

do you depend on those changes at all?
-- 
Florian
