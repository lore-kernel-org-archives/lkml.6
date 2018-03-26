Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCZS0K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:26:10 -0400
Received: from smtp01.mail.online.nl ([194.134.25.71]:54011 "EHLO
        smtp01.mail.online.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeCZS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:26:08 -0400
Subject: Re: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
 <20180326155010.GC3014@lunn.ch>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <e151482e-7f67-c072-e946-95f6819c3bc2@topic.nl>
Date: Mon, 26 Mar 2018 20:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326155010.GC3014@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-18 17:50, Andrew Lunn wrote:
> On Mon, Mar 26, 2018 at 08:41:29AM +0200, Mike Looijmans wrote:
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
> 
> Hi Mike
> 
> I can understand you not wanting to modify all the call sites for
> of_get_mac_address().
> 
> However, the name of_get_nvmem_mac_address() suggests it gets the MAC
> address from NVMEM. I think people are going to be surprised when they
> find it first tries for a MAC address directly in device tree. I would
> drop the call to of_get_mac_address(), and have the MAC driver call
> both.
> 
> You could also maybe take a look at fwnode_get_mac_address(). It
> should work for both OF and ACPI. It fits better because is passes a
> char * for the address. You could make that do both, and call it from
> the macb driver. dev_fwnode() probably does what you want.

fwnode_get_mac_address looks really new, there's only one user so far. 
Is it the intention that all drivers eventually migrate to that?

(It also means I cannot backport it to the kernel I'm actually using, 
'cause I haven't got the Zynq to work with the mainline macb driver yet. 
But that's just my problem...)

-- 
Mike Looijmans
