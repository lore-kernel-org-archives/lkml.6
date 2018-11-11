Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D51C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC5A2081C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC5A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeKLCMb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:12:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728712AbeKLCMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:12:31 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A2B967E0BD713;
        Sun, 11 Nov 2018 16:23:29 +0000 (GMT)
Received: from FRAEML704-CAH.china.huawei.com (10.206.14.35) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 11 Nov 2018 16:23:30 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.209]) by
 FRAEML704-CAH.china.huawei.com ([10.206.14.35]) with mapi id 14.03.0415.000;
 Sun, 11 Nov 2018 17:23:23 +0100
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
Subject: RE: [RFC PATCH 07/10] net: hns3: Add checksum info query function
Thread-Topic: [RFC PATCH 07/10] net: hns3: Add checksum info query function
Thread-Index: AQHUeHjY6gnFU/ReJkWFXwM7TwSKf6VH+7kAgALAP/A=
Date:   Sun, 11 Nov 2018 16:23:22 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFA0DEA@FRAEML521-MBS.china.huawei.com>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109220743.10264-8-salil.mehta@huawei.com>
 <20181109225114.GF5259@lunn.ch>
In-Reply-To: <20181109225114.GF5259@lunn.ch>
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

> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Andrew Lunn
> Sent: Friday, November 9, 2018 10:51 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; yuvalm@mellanox.com; leon@kernel.org;
> Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Liuzhongzhu <liuzhongzhu@huawei.com>
> Subject: Re: [RFC PATCH 07/10] net: hns3: Add checksum info query
> function
> 
> On Fri, Nov 09, 2018 at 10:07:40PM +0000, Salil Mehta wrote:
> > From: liuzhongzhu <liuzhongzhu@huawei.com>
> >
> > This patch prints checksum config information
> > related to various layers of headers.
> >
> > debugfs command:
> > echo dump checksum > cmd
> 
> How does the information here differ from ethtool -k

Sure, this should be enough. Will drop this patch.

Thanks

