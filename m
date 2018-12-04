Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0864920850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0864920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLDUzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:55:39 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbeLDUzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:55:38 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id ECF939022A973;
        Tue,  4 Dec 2018 20:55:33 +0000 (GMT)
Received: from FRAEML703-CAH.china.huawei.com (10.206.14.34) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 20:55:36 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.167]) by
 fraeml703-cah.china.huawei.com ([10.206.14.34]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 21:55:30 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     David Miller <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
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
Thread-Index: AQHUipRWcc4RvlD+b0Kh0MVNnjjtYqVtlV4AgAAAJYCAALCJsIAAE+IAgABlhbA=
Date:   Tue, 4 Dec 2018 20:55:29 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93C06C4F4@FRAEML521-MBX.china.huawei.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
 <20181202230933.15560-4-salil.mehta@huawei.com>
 <20181203151222.6e56efcd@cakuba.netronome.com>
 <20181203.151253.1348214769326219632.davem@davemloft.net>
 <F4CC6FACFEB3C54C9141D49AD221F7F93C06855D@FRAEML521-MBX.china.huawei.com>
 <20181204105554.GD741@lunn.ch>
In-Reply-To: <20181204105554.GD741@lunn.ch>
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

> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Tuesday, December 4, 2018 10:56 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: David Miller <davem@davemloft.net>; jakub.kicinski@netronome.com;
> Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
> Liuzhongzhu <liuzhongzhu@huawei.com>; jiri@resnulli.us;
> f.fainelli@gmail.com
> Subject: Re: [RFC net-next 3/9] net: hns3: Add "port vlan table"
> information query function
> 
> > > > Adding debugfs files for basic switch concepts like MAC and VLAN tables
> > > > seems like a bit of a stretch to me.  I wonder what others think.
> > >
> > > Agreed.
> >
> >
> > I was wondering how other vendors are solving this? One way I could
> > understand is to use "Switchdev" framework which in turn will expose
> > entries to the kernel using the switch driver. In our NIC we don't
> > have a proper switch and it cannot learn/age entries.
> 
> Your hardware is there to accelerate what linux can do in software.
> How do we manage the software version of this feature?

Yes, so it can kind of represent switch in the hardware, has vports and has
tables for mac-vlan, port-vlan, vlan (which I guess kernel also supports in
vlan aware mode of bridging?). Perhaps, only way I can understand now to be
able to use standard bridge, ip link tools to fetch this info is by having
represented them by "Switchdev"?

> 
> > Also, on-SoC NIC contains other tables which might not have any standard
> > user-space interface at all. What are your suggestions regarding that?
> 
> How are these tables map to software features the Linux stack
> implements?

If you refer output shown in patch you will get an idea, 
[RFC net-next 5/9] net: hns3: Add "manager table" information query function

Manager Table stores entries for any exception packet matching or for matching
any special types like control packets which we might not want to forward
using general forwarding route using mac-vlan table.

Not sure if this makes sense inside Linux kernel? Therefore, we thought of
exposing them through the debugfs.


Thanks
Salil
