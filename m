Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDDLKj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:10:39 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:48668 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:10:38 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: djkurtz@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <b52cde1057183214458ecd5bcb5252bc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AC4B29C.8090002@rock-chips.com>
Date: Wed, 04 Apr 2018 19:10:20 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Daniel Kurtz <djkurtz@chromium.org>
CC: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, xxm <xxm@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com> <20180323073814.5802-12-jeffy.chen@rock-chips.com> <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com> <5AB8A7F0.1090305@rock-chips.com> <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
In-Reply-To: <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your reply.

On 04/04/2018 12:11 AM, Daniel Kurtz wrote:
> Hi Jeffy,
>
> Sorry for delayed response.
>
> On Mon, Mar 26, 2018 at 1:58 AM JeffyChen <jeffy.chen@rock-chips.com> wrote:
>
>> Hi Daniel,
>
>> Thanks for your reply.
>
>> On 03/26/2018 02:31 PM, Daniel Kurtz wrote:
>>>>> +struct rk_iommudata {
>>>>> +       struct rk_iommu *iommu;
>>>>> +};
>>> Why do we need this struct?  Can't we just assign a pointer to struct
>>> rk_iommu directly to dev->archdata.iommu?
>>>
>> hmmm, i was trying to add more device related data in patch[13]:
>
>>     struct rk_iommudata {
>> +       struct device_link *link; /* runtime PM link from IOMMU to master
> */
>>           struct rk_iommu *iommu;
>>     };
>>>
>
> Can't you just add link to rk_iommu directly?

adding link to rk_iommu would be fine if we only have one master device 
per rk_iommu.

but now we are supporting multiple master devices sharing a iommu device :)

>
>
>
