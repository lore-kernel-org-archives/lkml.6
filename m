Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F497C4151A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F62173C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfBQK67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:58:59 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:21978 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBQK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:58:59 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1HAwakg030582;
        Sun, 17 Feb 2019 19:58:37 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Sun, 17 Feb 2019 19:58:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1HAwaEH030577
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 17 Feb 2019 19:58:36 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
 <1970132.3b67tCGWFf@phil>
 <c4ce7f7a-c791-ae0a-ad3d-02b2efa41709@katsuster.net>
 <2275914.n7pQDzs7mT@diego>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <16f4fcf0-e9c2-e925-e463-282cfff088c7@katsuster.net>
Date:   Sun, 17 Feb 2019 19:58:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2275914.n7pQDzs7mT@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2019/02/12 20:12, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 4. Februar 2019, 13:59:37 CET schrieb Katsuhiro Suzuki:
>> On 2019/02/03 18:06, Heiko Stuebner wrote:
>>> Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
>>>> This patch adds HDMI sound (I2S0) node and remove dma properties
>>>> from UART2 node for rock64.
>>>>
>>>> The DMAC of rk3328 can use 8 channels at same time. Currently, total
>>>>
>>>> 7 channels are used as follows:
>>>>     - I2S1  2ch
>>>>     - UART2 2ch
>>>>     - SPDIF 1ch
>>>>     - SPI0  2ch
>>>>
>>>> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
>>>>
>>>> UART2 can work without DMA resources, so this patch removes dma
>>>> allocation for UART2 and reuses it to I2S0.
>>>
>>> I don't follow that description. How can i2s0 re-use the uart2 dma
>>> channels? Looking at the dma table in the TRM, uart2 has channels 6+7
>>> while i2s0 uses channels 11+12. They should just run concurrently?
>>
>> Sorry for confusing... 6 or 7 is as ID number of slave DMA channel.
>> TRM calls it 'Req number'. Req number 6+7 and 11+12 can work
>> concurrently but TRM says DMAC can transfer 8 DMA channels at same
>> time. So all 16 Req numbers cannot activate at same time. It should
>> be keep less or equal than 8 numbers.
> 
> But that "shortcoming" of having more requests than channels is not
> something specific to the pl330, instead most dma controllers have that
> "problem", which seems to get solved by the virt-dma mechanism of
> dmaengine - which pl330 doesn't use so far. (but see pl080 for example)
> 

I understand. I drop these patches.


> The devicetree only describes the hardware and is never meant as a
> configuration space for kernel-code shortcomings.
> 

Yes, right. I don't want to use device-tree as configuration space,
so which is better?

- Fix the pl330 driver first and after that add HDMI-sound node
   to device-tree.
- Just add HDMI-sound node to device-tree. If someone (include me)
   want to support virt-dma on pl330 driver, they will fix it.
   (PL330 will face error but all sounds works fine and UART still
   works fine with DMA error)

> 
> Heiko
> 
> 
> 

Best Regards,
Katsuhiro Suzuki
