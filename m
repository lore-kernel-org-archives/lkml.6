Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeEKOFt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:05:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59337 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752563AbeEKOFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:05:48 -0400
Subject: Re: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB and
 the MAILBOX
To: Leo Yan <leo.yan@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
 <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
 <CABb+yY2ke__W2ZW4c_Z9CejZzup52ykRDyNecTs0+nkvf5cbNA@mail.gmail.com>
 <20180509040255.GF23540@leoy-ThinkPad-X240s>
CC: Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        "Kaihua Zhong" <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <", linux-arm-kernel"@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        "Haojian Zhuang" <haojian.zhuang@linaro.org>, <xuwei5@hisilicon.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AF5A328.7080001@hisilicon.com>
Date: Fri, 11 May 2018 15:05:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180509040255.GF23540@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2018/5/9 5:02, Leo Yan wrote:
> On Wed, May 09, 2018 at 09:19:13AM +0530, Jassi Brar wrote:
>> On Wed, Apr 4, 2018 at 8:44 AM, Leo Yan <leo.yan@linaro.org> wrote:
>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> The current defconfig is inconsistent as it selects the mailbox and
>>> the clock for the hi6220 and the hi3660 without having their Kconfigs
>>> making sure the dependencies are correct. It ends up when selecting
>>> different versions for the kernel (for example when git bisecting)
>>> those options disappear and they don't get back, leading to unexpected
>>> behaviors. In our case, the cpufreq driver does no longer work because
>>> the clock fails to initialize due to the clock stub and the mailbox
>>> missing.
>>>
>>> In order to have the dependencies correctly set when defaulting, let's
>>> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
>>> automatically") where we select automatically the driver when the
>>> parent driver is selected. With sensible defaults in place, we can leave
>>> other choices for EXPERT.
>>>
>> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Thanks Jassi & Stephen.
> 
> Wei, could you pick this patch?

Thanks!
Series applied into the hisilicon tree.

BR,
Wei

> 
> Thanks,
> Leo Yan
> 
> .
> 
