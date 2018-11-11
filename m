Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C39C2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeKLChC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:37:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbeKLChC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:37:02 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 757A76DE25D0C;
        Sun, 11 Nov 2018 16:47:11 +0000 (GMT)
Received: from FRAEML701-CAH.china.huawei.com (10.206.14.32) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 11 Nov 2018 16:47:12 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.209]) by
 FRAEML701-CAH.china.huawei.com ([10.206.14.32]) with mapi id 14.03.0415.000;
 Sun, 11 Nov 2018 17:47:05 +0100
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
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to HNS3
 driver
Thread-Topic: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to HNS3
 driver
Thread-Index: AQHUeHjKl7L/rK4Ga0KUIgRpv+IpHaVH+aMAgAKzxPCAAAU4AIAAGG2g
Date:   Sun, 11 Nov 2018 16:47:04 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFA0E3C@FRAEML521-MBS.china.huawei.com>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109224346.GD5259@lunn.ch>
 <F4CC6FACFEB3C54C9141D49AD221F7F93BF9FC72@FRAEML521-MBS.china.huawei.com>
 <20181111161822.GC15953@lunn.ch>
In-Reply-To: <20181111161822.GC15953@lunn.ch>
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

Hi Andrew,

> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Sunday, November 11, 2018 4:18 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; yuvalm@mellanox.com; leon@kernel.org;
> Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to
> HNS3 driver
> 
> > Agreed. But what about if we want to expose anything related to
> > firmware to user-space using the debugfs, assuming we are presenting
> > information in structured way and not as a black-box to some user-
> space
> > application. Is it something which might be discouraged?
> 
> Hi Salil
> 
> Please take a look at devlink. Mellonex have been adding commands to
> it for dumping firmware states.

sure, thanks for the info. Ill check.

Salil.

