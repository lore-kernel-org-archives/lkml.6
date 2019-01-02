Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C61CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021D2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfABKo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:44:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfABKo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:44:27 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84F72207875AA;
        Wed,  2 Jan 2019 18:44:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 18:44:16 +0800
Subject: Re: hns3: Compilation of hns3_enet.c is triggered without changes
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
References: <430207483.256478.1546089053476@email.ionos.de>
CC:     <netdev@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <199310fa-e088-1b36-77b9-da696fea4dec@huawei.com>
Date:   Wed, 2 Jan 2019 10:44:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <430207483.256478.1546089053476@email.ionos.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2018 13:10, Stefan Wahren wrote:
> Hi,
>
> during development i noticed that hns3_enet.c is compiled even without any changes to this file.
>
> I think the reason for this is the usage of VERMAGIC_STRING in this file. So it would be nice if you could somehow replace this define.
>
> Kind regards
> Stefan
>
>

I reported this issue internally some time ago. Apparently it is 
required to reference VERMAGIC_STRING, but I don't know why.

I see that this driver has similar issue:
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/netronome/nfp/nfp_main.c#L34

Another annoying thing I find is the amount of references to UTS_RELEASE 
(which also causes rebuilds), like:
https://elixir.bootlin.com/linux/latest/source/drivers/base/firmware_loader/main.c#L281

Can't we just make a static string for these, to save the rebuilding the 
dependent modules?

Thanks,
John


