Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757299AbeD0Dwt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:52:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3175 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbeD0Dwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:52:47 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 26 Apr 2018 20:52:45 -0700
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
To: Andrew Lunn <andrew@lunn.ch>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingju Hou <Jingju.Hou@synaptics.com>
References: <20180419160232.519d15be@xhacker.debian>
 <20180419121801.GC17888@lunn.ch>
 <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
 <20180426141508.6660a633@xhacker.debian>
 <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
 <20180426155619.2c5d87d1@xhacker.debian> <20180426124007.GC13467@lunn.ch>
From: Bhadram Varka <vbhadram@nvidia.com>
Message-ID: <7b63b6f5-d93c-f2c8-c448-b81a8323c305@nvidia.com>
Date: Fri, 27 Apr 2018 09:22:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426124007.GC13467@lunn.ch>
X-Originating-IP: [10.24.193.32]
X-ClientProxiedBy: DRBGMAIL104.nvidia.com (10.18.16.23) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/Jisheng,

On 4/26/2018 6:10 PM, Andrew Lunn wrote:
>> hmm, so you want a "stick" WOL feature, I dunno whether Linux kernel
>> requires WOL should be "stick".
> I see two different cases:
>
> Suspend/resume: The WoL state in the kernel is probably kept across
> such a cycle. If so, you would expect another suspend/resume to also
> work, without needs to reconfigure it.
Trying this scenario (suspend/resume) from my side. In this case WoL 
should be enabled in the HW. For Marvell PHY to generate WoL interrupt 
we need to clear WoL status.
Above mentioned change required to make this happen. Please share your 
thoughts on this.
>
> Boot from powered off: If the interrupt just enables the power supply,
> it is possible to wake up after a shutdown. There is no state kept, so
> WoL will be disabled in the kernel. So WoL should also be disabled in
> the hardware.
>
>      Andrew
