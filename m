Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeC0Na6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:30:58 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61481 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeC0Na4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:30:56 -0400
Subject: Re: [net-next PATCH 2/5] soc: ti: K2G: provide APIs to support driver
 probe deferral
To: Andrew Lunn <andrew@lunn.ch>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-3-git-send-email-m-karicheri2@ti.com>
 <20180326204802.GC5862@lunn.ch>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <4aeeda56-c68b-cb64-1314-a669f721ff20@ti.com>
Date: Tue, 27 Mar 2018 09:32:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180326204802.GC5862@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 03/26/2018 04:48 PM, Andrew Lunn wrote:
> On Mon, Mar 26, 2018 at 04:15:09PM -0400, Murali Karicheri wrote:
>> This patch provide APIs to allow client drivers to support
>> probe deferral. On K2G SoC, devices can be probed only
>> after the ti_sci_pm_domains driver is probed and ready.
>> As drivers may get probed at different order, any driver
>> that depends on knav dma and qmss drivers, for example
>> netcp network driver, needs to defer probe until
>> knav devices are probed and ready to service. To do this,
>> add an API to query the device ready status from the knav
>> dma and qmss devices.
> 
> Hi Murali 
> 
> Shouldn't you really re-write this to be a dma driver?  You would then
> do something like of_dma_request_slave_channel() in the ethernet
> driver probe function. That probably correctly returns EPROBE_DEFER.
> 
>        Andrew
> 

Could you please elaborate? These knav dma and qmss drivers are
introduced to support packet DMA hardware available in Keystone
NetCP which couldn't be implemented using the DMA APIs available
at the time this driver was introduced. Another reason was that
the performance was really bad. We had an internal implementation
based on DMA API before which couldn't be upstreamed at that time
due to the reason that we were mis-using the API for this driver.
So we introduced these knav_dma driver to support NetCP. We don't
have any plan to re-write the driver at this time.

If your question is about EPROBE_DEFER being returned from an
existing knav_dma API and using the return code to achieve probe
defer instead of introducing these APIs, I can take a look into
that and respond. So please clarify.

-- 
Murali Karicheri
Linux Kernel, Keystone
