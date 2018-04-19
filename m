Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDSSdG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:33:06 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35960 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeDSSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:33:03 -0400
X-Google-Smtp-Source: AB8JxZqUHOxCIdvCpgtiUJmcy0KbX0OtTMz3WIrxtc5HWwxyAAphEARNLE+VpfmsuLvwHO3j1ioHBw==
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>, chris.ruehl@gtsys.com.hk,
        Lars Persson <lars.persson@axis.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
 <20180411183630.390575424@linuxfoundation.org>
 <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
 <1524154267.17017.15.camel@nxp.com>
 <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <223ffd4d-567e-6c5c-9581-5304494dd0b3@gmail.com>
Date: Thu, 19 Apr 2018 11:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Others who reported the same problem

On 04/19/2018 11:24 AM, Naresh Kamboju wrote:
> On 19 April 2018 at 21:41, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>> On Thu, 2018-04-19 at 17:02 +0530, Naresh Kamboju wrote:
>>> On 12 April 2018 at 00:05, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> 4.9-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Leonard Crestez <leonard.crestez@nxp.com>
>>>>
>>>> [ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]
>>>>
>>>> These bits seem to be lost after a suspend/resume cycle so just set them
>>>> again. Do this by splitting the handling of these bits into a function
>>>> that is also called on resume.
>>>>
>>>> This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
>>>>
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> Signed-off-by: David S. Miller <davem@davemloft.net>
>>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  drivers/net/phy/micrel.c |   42 ++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 28 insertions(+), 14 deletions(-)
>>
>>> arm32 x15 device booting 4.9 kernel shows kernel warning and
>>> the network is not working on the device.
>>>
>>> Linux version 4.9.95-rc1 (buildslave@lkft-01) (gcc version 6.2.1 20161016
>>>  (Linaro GCC 6.2-2016.11) ) #1 SMP Tue Apr 17 19:12:22 UTC 2018
>>>
>>> Boot log kernel crash log:
>>> --------------------------
>>> [   13.766589] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>>> [   13.805441] net eth0: initializing cpsw version 1.15 (0)
>>> [   13.930334] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000008
>>> [   13.982009] PC is at kszphy_config_reset+0x1c/0x150
>>> [   13.986909] LR is at kszphy_resume+0x24/0x64
>>> LAVA job id: https://lkft.validation.linaro.org/scheduler/job/187429#L3341
>>
>> Looking at this dump I'm guessing that phydev->priv is NULL at the
>> start of kszphy_config_reset and this really shouldn't be happening.
>>
>> The phydev->priv field is initialized by kszphy_probe but your
>> particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
>> kszphy_probe assigned in the struct phy_driver ksphy_driver array.
>>
>> In upstream this was added by commit bfe72442578b ("net: phy: micrel:
>> fix crash when statistic requested for KSZ9031 phy"). The message for
>> that patch claims to fix a kernel crash on this command:
>>
>>     ethtool --phy-statistics eth0
>>
>> Looking at the code this issue should affect linux-4.9.y on your board.
>> Naresh: can you please check?
> 
> After reverting the patch i have run this command and kernel oops showed up.
> ethtool --phy-statistics eth0
> 
> PC is at kszphy_get_stats+0x74/0xa8
> 
> ethtool --phy-statistics eth0 crashed on x15
> https://pastebin.com/8cGBMuxC

Chris proposed the following patch, which has not been formally
submitted yet:

https://www.mail-archive.com/netdev@vger.kernel.org/msg229742.html

Meanwhile, Greg seems to have reverted the offending patch, so we should
be good with 4.9.95.
-- 
Florian
