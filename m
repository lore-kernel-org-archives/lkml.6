Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3023CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E632084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E632084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeKLBBe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:01:34 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728331AbeKLBBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:01:33 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6086EEAC5EBA5;
        Sun, 11 Nov 2018 15:12:42 +0000 (GMT)
Received: from FRAEML703-CAH.china.huawei.com (10.206.14.34) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 11 Nov 2018 15:12:43 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.209]) by
 fraeml703-cah.china.huawei.com ([10.206.14.34]) with mapi id 14.03.0415.000;
 Sun, 11 Nov 2018 16:12:35 +0100
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
Thread-Index: AQHUeHjKl7L/rK4Ga0KUIgRpv+IpHaVH+aMAgAKzxPA=
Date:   Sun, 11 Nov 2018 15:12:34 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF9FC72@FRAEML521-MBS.china.huawei.com>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
 <20181109224346.GD5259@lunn.ch>
In-Reply-To: <20181109224346.GD5259@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.221]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Thanks for replying. Sorry, for not being prompt as I was
traveling.

Please find some further follow-up questions below

Salil.

> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
> owner@vger.kernel.org] On Behalf Of Andrew Lunn
> Sent: Friday, November 9, 2018 10:44 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; yuvalm@mellanox.com; leon@kernel.org;
> Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to
> HNS3 driver
> 
> > 3. Debugfs looks more unstructured unlike sysfs. Is there any
> >    de-facto standard of the user-api or drivers are allowed to
> >    use it in any way to expose the information from kernel.
> 
> Hi Salil
> 
> You don't really have a user api using debugfs, because debugfs is
> unstable. Anything can change at any time. Any user tools which use
> debugfs can be expected to break at any time as the information in
> debugfs changes. debugfs is for debug, not to export an API. And in
> production systems, it is often not mounted.


Sure, I understand. 

> 
> As much as possible, you are recommended to use existing APIs,
> ethtool, devlink, etc.


Agreed. But what about if we want to expose anything related to
firmware to user-space using the debugfs, assuming we are presenting
information in structured way and not as a black-box to some user-space
application. Is it something which might be discouraged?

Many Thanks
