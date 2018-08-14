Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76BDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD5421731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD5421731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbeHNTXk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:23:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732191AbeHNTXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:23:40 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DFCE27B766179;
        Tue, 14 Aug 2018 17:35:44 +0100 (IST)
Received: from FRAEMA708-CHM.china.huawei.com (10.206.14.57) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 14 Aug 2018 17:35:45 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.135]) by
 FRAEMA708-CHM.china.huawei.com ([169.254.8.165]) with mapi id 14.03.0399.000;
 Tue, 14 Aug 2018 18:35:37 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil.lnk@gmail.com" <mehta.salil.lnk@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        linyunsheng <linyunsheng@huawei.com>
Subject: RE: [PATCH net-next 5/9] net: hns3: Fix for vf vlan delete failed
 problem
Thread-Topic: [PATCH net-next 5/9] net: hns3: Fix for vf vlan delete failed
 problem
Thread-Index: AQHUMiGrM+IecmcwNUSDd5CXw7fWD6S9tqSAgAG56YA=
Date:   Tue, 14 Aug 2018 16:35:36 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BE87166@FRAEML521-MBX.china.huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
        <20180812094738.14852-6-salil.mehta@huawei.com>
 <20180813.085637.2236041056676583980.davem@davemloft.net>
In-Reply-To: <20180813.085637.2236041056676583980.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.54]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, August 13, 2018 4:57 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil.lnk@gmail.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; linyunsheng <linyunsheng@huawei.com>
> Subject: Re: [PATCH net-next 5/9] net: hns3: Fix for vf vlan delete
> failed problem
> 
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Sun, 12 Aug 2018 10:47:34 +0100
> 
> > Fixes: 9dba194574e3 ("{topost} net: hns3: fix for vlan table
> problem")
> 
> This commit ID doesn't exist.

Thanks for catching this. This commit ID was from our internal branch
and ideally should have been from net-next - I should have caught this
earlier, sorry for this!

I have for now dropped this patch from the series as there is another
related patch(being referred in the Fixes string) that would need to
be merged with this patch before sending to net-next. Therefore, will
refloat this patch along with other related patch later in next cycle.

> 
> Also, I really don't think the string "{topost}" would be in the commit
> header line.

Yes, this is stray and will be removed when this patch is sent next.

Thank you
Salil
