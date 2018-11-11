Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF7EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D432148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D432148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeKLCen convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:34:43 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbeKLCen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:34:43 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1F69DEECE421F;
        Sun, 11 Nov 2018 16:45:39 +0000 (GMT)
Received: from FRAEMA701-CHM.china.huawei.com (10.206.14.50) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 11 Nov 2018 16:45:40 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.209]) by
 FRAEMA701-CHM.china.huawei.com ([169.254.1.146]) with mapi id 14.03.0415.000;
 Sun, 11 Nov 2018 17:45:32 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "yuvalm@mellanox.com" <yuvalm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Liuzhongzhu <liuzhongzhu@huawei.com>
Subject: RE: [RFC PATCH 04/10] net: hns3: Add "promisc mode" config info
 query function
Thread-Topic: [RFC PATCH 04/10] net: hns3: Add "promisc mode" config info
 query function
Thread-Index: AQHUeHjSxcb8HNenB0mGsMs0JKMavKVH+x2AgALPj/A=
Date:   Sun, 11 Nov 2018 16:45:32 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFA0E16@FRAEML521-MBS.china.huawei.com>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109220743.10264-5-salil.mehta@huawei.com>
 <20181109224903.GE5259@lunn.ch>
In-Reply-To: <20181109224903.GE5259@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Friday, November 9, 2018 10:49 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; yuvalm@mellanox.com; leon@kernel.org;
> Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Liuzhongzhu <liuzhongzhu@huawei.com>
> Subject: Re: [RFC PATCH 04/10] net: hns3: Add "promisc mode" config info
> query function
> 
> On Fri, Nov 09, 2018 at 10:07:37PM +0000, Salil Mehta wrote:
> > From: liuzhongzhu <liuzhongzhu@huawei.com>
> >
> > This patch prints promiscuous mode status.
> 
> netstat -i
> 
> Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-
> OVR Flg
> lo       65536   871698      0      0 0        871698      0      0
> 0 LRU
> tun0      1500  1052639      0      0 0       1013998      0      0
> 0 MOPRU
> 
> The flag P means promisc.

sure, got the point. Anything which is available in the tools should be
avoided in the debugfs?

Many thanks

