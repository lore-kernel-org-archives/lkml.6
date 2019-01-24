Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB3BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A9E218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfAXM2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:28:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbfAXM2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:28:40 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0FE7D8DDB7796471BA59;
        Thu, 24 Jan 2019 20:28:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 20:28:26 +0800
Subject: Re: Question: pause mode disabled for marvell 88e151x phy
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Weiwei Deng <dengweiwei@huawei.com>,
        "Yisen.Zhuang@huawei.com" <Yisen.Zhuang@huawei.com>,
        "huangdaode@hisilicon.com" <huangdaode@hisilicon.com>,
        "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        lijianhua 00216010 <lijianhua@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
 <20181215103736.GG26090@n2100.armlinux.org.uk>
 <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
 <20181217143633.GH26090@n2100.armlinux.org.uk>
 <6e8034d9-cd60-2846-ef33-f8a04069e1ee@huawei.com>
 <20190123224144.imzntelxqtf3xcuj@e5254000004ec.dyn.armlinux.org.uk>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3f67e7ab-3a68-2a24-1648-36cac34ad6c0@huawei.com>
Date:   Thu, 24 Jan 2019 20:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190123224144.imzntelxqtf3xcuj@e5254000004ec.dyn.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/24 6:41, Russell King - ARM Linux admin wrote:
> On Sat, Jan 05, 2019 at 11:28:19AM +0800, Yunsheng Lin wrote:
>> On 2018/12/17 22:36, Russell King - ARM Linux wrote:
>>> I'll try to do further diagnosis over Christmas in case I've missed
>>> something, but I suspect it may be one of those "weird behaviour" issues
>>> where the safest action is to disable pause mode as per my commit -
>>> which is far saner than having mismatched pause status on either end
>>> of a link.  However, given that Marvell specs are all NDA-only, it's
>>> very difficult to investigate beyond "this is the observed behaviour".
>>
>> Hi,
>>
>> Is there any update on the further diagnosis?
> 
> Hi,
> 
> I've finally been able to do some further diagnosis (with a 'scope).
> It would appear that the network adapter had PHY polling enabled,
> which meant that it overwrote the PHYs advertisement register
> during negotiation.  I thought I'd checked that scenario, but alas
> clearing the PHY poll enable bit on its own doesn't stop it polling!
> 
> I'll send a revert for the commit shortly.

Great. Thanks for the further diagnosis.

> 

