Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15628C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75E52081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75E52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeJXOtC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:49:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbeJXOtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:49:02 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5EF865FFC5082;
        Wed, 24 Oct 2018 07:22:19 +0100 (IST)
Received: from FRAEMA704-CHM.china.huawei.com (10.206.14.53) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 24 Oct 2018 07:22:19 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEMA704-CHM.china.huawei.com ([169.254.4.109]) with mapi id 14.03.0415.000;
 Wed, 24 Oct 2018 08:22:12 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@01.org" <kbuild@01.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: RE: [PATCH net-next 6/7] net: hns3: Add enable and process hw
 errors from PPP
Thread-Topic: [PATCH net-next 6/7] net: hns3: Add enable and process hw
 errors from PPP
Thread-Index: AQHUZ+BciIFXkRH7e0SKx8aGH/K9/KUsld4AgADGWZCAAHWNgIAAIgSw
Date:   Wed, 24 Oct 2018 06:22:11 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF522E2@FRAEML521-MBX.china.huawei.com>
References: <20181019191532.10088-7-salil.mehta@huawei.com>
 <20181023112852.4pmcezetrudduvna@mwanda>
 <F4CC6FACFEB3C54C9141D49AD221F7F93BF51DF4@FRAEML521-MBX.china.huawei.com>
 <20181024061931.6tp4skg5tspxy4o2@mwanda>
In-Reply-To: <20181024061931.6tp4skg5tspxy4o2@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.91.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, October 24, 2018 7:20 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: kbuild@01.org; kbuild-all@01.org; davem@davemloft.net; Zhuangyuzeng
> (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y) <lipeng321@huawei.com>;
> mehta.salil@opnsrc.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Shiju Jose
> <shiju.jose@huawei.com>
> Subject: Re: [PATCH net-next 6/7] net: hns3: Add enable and process hw
> errors from PPP
> 
> On Tue, Oct 23, 2018 at 09:37:35PM +0000, Salil Mehta wrote:
> > Hi Dan,
> > Thanks for letting us know about this. We have a fix for this
> > but I guess now net-next is closed and David might not accept
> > the fix for the below problem. It looks problematic case
> > might rarely hit so we might be safe deferring it for next cycle.
> >
> 
> New features and cleanups should be delayed during the merge window but
> one line bugfixes are acceptable.  Just send it.

sure, thanks for the clarification. Will do today.

> 
> regards,
> dan carpenter
> 

