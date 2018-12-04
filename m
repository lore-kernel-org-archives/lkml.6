Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F2020878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F2020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLDKKo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:10:44 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDKKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:10:44 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6D3AD5BDFCD35;
        Tue,  4 Dec 2018 10:10:40 +0000 (GMT)
Received: from FRAEML701-CAH.china.huawei.com (10.206.14.32) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:10:41 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.167]) by
 FRAEML701-CAH.china.huawei.com ([10.206.14.32]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 11:10:33 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Liuzhongzhu <liuzhongzhu@huawei.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: RE: [RFC net-next 3/9] net: hns3: Add "port vlan table" information
 query function
Thread-Topic: [RFC net-next 3/9] net: hns3: Add "port vlan table"
 information query function
Thread-Index: AQHUipRWcc4RvlD+b0Kh0MVNnjjtYqVtlV4AgAAAJYCAALCJsA==
Date:   Tue, 4 Dec 2018 10:10:32 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93C06855D@FRAEML521-MBX.china.huawei.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
        <20181202230933.15560-4-salil.mehta@huawei.com>
        <20181203151222.6e56efcd@cakuba.netronome.com>
 <20181203.151253.1348214769326219632.davem@davemloft.net>
In-Reply-To: <20181203.151253.1348214769326219632.davem@davemloft.net>
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

> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, December 3, 2018 11:13 PM
> To: jakub.kicinski@netronome.com
> Cc: Salil Mehta <salil.mehta@huawei.com>; Zhuangyuzeng (Yisen)
> <yisen.zhuang@huawei.com>; lipeng (Y) <lipeng321@huawei.com>;
> mehta.salil@opnsrc.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Liuzhongzhu
> <liuzhongzhu@huawei.com>; jiri@resnulli.us; f.fainelli@gmail.com
> Subject: Re: [RFC net-next 3/9] net: hns3: Add "port vlan table"
> information query function
> 
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Date: Mon, 3 Dec 2018 15:12:22 -0800
> 
> > On Sun, 2 Dec 2018 23:09:27 +0000, Salil Mehta wrote:
> >> From: liuzhongzhu <liuzhongzhu@huawei.com>
> >>
> >> This patch prints port vlan table information.
> >>
> >> debugfs command:
> >> echo dump port vlan tbl > cmd
> >>
> >> Sample Command:
> >> root@(none)# echo dump port vlan tbl > cmd
> >>  vlan | port filter bitMap:
> >>  0000 | 00000000:00000000:00000000:00000000:00000000:00000001
> >> root@(none)#
> >>
> >> Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
> >> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >
> > Adding debugfs files for basic switch concepts like MAC and VLAN tables
> > seems like a bit of a stretch to me.  I wonder what others think.
> 
> Agreed.


I was wondering how other vendors are solving this? One way I could 
understand is to use "Switchdev" framework which in turn will expose
entries to the kernel using the switch driver. In our NIC we don't
have a proper switch and it cannot learn/age entries.

Also, on-SoC NIC contains other tables which might not have any standard
user-space interface at all. What are your suggestions regarding that?


Thanks
Salil
