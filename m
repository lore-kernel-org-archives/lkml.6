Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeCRVmd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:42:33 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34164 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeCRVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:42:27 -0400
X-Google-Smtp-Source: AG47ELuM1xnpu6ExNoYdszK/YYAf0tbEJCzwZt5lq6NZVb6WdSnQlu9eEJ3vcY2ZANmgUKOywW9d+w==
Subject: Re: [PATCH net] net: fec: Fix unbalanced PM runtime calls
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, l.stach@pengutronix.de,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org
References: <20180318194952.31411-1-f.fainelli@gmail.com>
 <20180318.163501.2001276876693998811.davem@davemloft.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f1ba3f3e-adef-c7f0-d9b2-47bbdade91f5@gmail.com>
Date: Sun, 18 Mar 2018 14:42:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318.163501.2001276876693998811.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/18/2018 01:35 PM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Sun, 18 Mar 2018 12:49:51 -0700
> 
>> When unbinding/removing the driver, we will run into the following warnings:
>>
>> [  259.655198] fec 400d1000.ethernet: 400d1000.ethernet supply phy not found, using dummy regulator
>> [  259.665065] fec 400d1000.ethernet: Unbalanced pm_runtime_enable!
>> [  259.672770] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
>> [  259.683062] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: f2:3e:93:b7:29:c1
>> [  259.696239] libphy: fec_enet_mii_bus: probed
>>
>> Avoid these warnings by balancing the runtime PM calls during fec_drv_remove().
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Applied, thank you.
> 
> Queue this up for -stable?

I would be inclined to say yes, it was not exactly easy to track down a
set of commits, since this was changed quite a bit.
-- 
Florian
