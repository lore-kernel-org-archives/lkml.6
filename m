Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEEF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbfAKTnl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:43:41 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732097AbfAKTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:43:40 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D52B3CA9BD4F993EF10A;
        Fri, 11 Jan 2019 19:43:38 +0000 (GMT)
Received: from FRAEMA703-CHM.china.huawei.com (10.206.14.52) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 19:43:38 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.121]) by
 FRAEMA703-CHM.china.huawei.com ([169.254.3.216]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 20:43:30 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: RE: hns: question regarding ae_node device node refcounting
Thread-Topic: hns: question regarding ae_node device node refcounting
Thread-Index: AQHUmkEQfoEKVWjY3kaJv102UJfyGaWqlq9g
Date:   Fri, 11 Jan 2019 19:43:30 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93C0F34A1@FRAEML521-MBS.china.huawei.com>
References: <1545515681-29561-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1545515681-29561-1-git-send-email-khoroshilov@ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

> From: Alexey Khoroshilov [mailto:khoroshilov@ispras.ru]
> Sent: Saturday, December 22, 2018 9:55 PM
> To: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; Salil Mehta
> <salil.mehta@huawei.com>; lipeng (Y) <lipeng321@huawei.com>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>; David S. Miller
> <davem@davemloft.net>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; ldv-project@linuxtesting.org
> Subject: net: hns: question regarding ae_node device node refcounting
> 
> Hello,
> 
> hns_nic_dev_probe() increments refcount of ae_node device node:
> 	ae_node = of_parse_phandle(dev->of_node, "ae-handle", 0);
> 
> But there is no of_node_put() for ae_node.
> What is the right place to decrement the ae_node refount?
> 
> Should it be placed in hns_nic_dev_probe() or in hns_nic_dev_remove()?
> Or may be it is managed by fwnode somehow?

Thanks for bringing this to notice. Yes, you are right of_node_put()
is missing. We will float a fix for this soon.

Cheers
Salil
