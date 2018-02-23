Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBWOUD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:20:03 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:48140 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:20:01 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: xuwei5@hisilicon.com
X-SENDER-IP: 220.200.59.233
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <49b551a64e298d199570de879180ec90>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: Jaehoon Chung <jh80.chung@samsung.com>, shawn.lin@rock-chips.com,
        linux-mmc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, "xuwei (O)" <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com>
 <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
Date: Fri, 23 Feb 2018 22:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/2/23 21:27, Andy Shevchenko wrote:
> On Fri, Feb 23, 2018 at 8:41 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> 'clock-freq-min-max' property had already deprecated.
>> Remove the 'clock-freq-min-max' property that is kept to maintain
>> the compatibility.
> 
> Removing a property without telling the user what to expect is a bad
> idea and ABI breakage.
> 

What's the general process to remove a property?

I guess we should do:
1) deprecate it in the first place and remove it from all upstream DT
2) wait some long enough days for expecting the stale of all old DTB
containing that property
3) remove the functionality of the deprecated property from the driver
but still leave some warning there
4) remove the left warning finally

And for the ABI breakage, we should add something in Documentation/ABI
/obsolete  or Documentation/ABI/removed ?

-- 
Best Regards
Shawn Lin
