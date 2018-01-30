Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeA3IEr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:04:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeA3IEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:04:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDD1B6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2] of: use hash based search in of_find_node_by_phandle
To: Frank Rowand <frowand.list@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1516955496-17236-1-git-send-email-cpandya@codeaurora.org>
 <2d877704-47c5-c1fc-1b89-976cd9b1ccaa@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <7ebd275d-07ba-1972-011a-d05e53233a01@codeaurora.org>
Date: Tue, 30 Jan 2018 13:34:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2d877704-47c5-c1fc-1b89-976cd9b1ccaa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (1)
>
> Can you point me to the driver code that is invoking
> the search?
There are many locations. Few of them being,
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/of/irq.c?h=msm-4.9#n214
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/irqchip/irq-gic-v3.c?h=msm-4.9#n1107
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/clk/msm/msm-clock-controller.c?h=msm-4.9#n492
>
> (2)
>
> And also the .dts devicetree source file that you are seeing
> large overhead with.
SDM670 DTS tree starts here.
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sdm670.dtsi?h=msm-4.9
>
>
> (3) -- this one is less important, but if the info is easily
>         available to you
>
> Sorry about dribbling out questions instead of all at once....
>
> What is the hardware you are testing this on?
SDM670
> Processor?
Kryo-300 Silver
> Cache size?
 From DT,
L1 32KB (per CPU)
L2 128KB (per CPU)
L3 1MB (total)
> Memory size?
6GB
> Processor frequency?
Max 1.7GHz for core 0. Not sure about boot time frequency.
> Any other attribute of the system that will help me understand
> the boot performance you are seeing?
I'm not able to profile of_find_node_by_phandle specifically as timers are
not up by then. So, just observing overall boot time for comparison.

My recent results were taken on debug_defconfig which has many performance
slowing code. So, gap between base-build and w/ the test patches would be
more than the actual production build.

Thanks,
Chintan

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
