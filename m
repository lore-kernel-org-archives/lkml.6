Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEFEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA850216EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA850216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbeHNTF7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:05:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeHNTF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:05:58 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 77B04476A9B4B;
        Tue, 14 Aug 2018 17:18:06 +0100 (IST)
Received: from FRAEMA707-CHM.china.huawei.com (10.206.14.56) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 14 Aug 2018 17:18:07 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.135]) by
 FRAEMA707-CHM.china.huawei.com ([169.254.7.74]) with mapi id 14.03.0399.000;
 Tue, 14 Aug 2018 18:17:55 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil.lnk@gmail.com" <mehta.salil.lnk@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        linyunsheng <linyunsheng@huawei.com>
Subject: RE: [PATCH net-next 1/9] net: hns3: Add support for serdes loopback
 selftest
Thread-Topic: [PATCH net-next 1/9] net: hns3: Add support for serdes
 loopback selftest
Thread-Index: AQHUMiGisAb3aZHHdk6UpTErYM83c6S9tisAgAG5jzA=
Date:   Tue, 14 Aug 2018 16:17:55 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BE870DE@FRAEML521-MBX.china.huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
        <20180812094738.14852-2-salil.mehta@huawei.com>
 <20180813.085456.1905254242911513146.davem@davemloft.net>
In-Reply-To: <20180813.085456.1905254242911513146.davem@davemloft.net>
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
> Sent: Monday, August 13, 2018 4:55 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil.lnk@gmail.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; linyunsheng <linyunsheng@huawei.com>
> Subject: Re: [PATCH net-next 1/9] net: hns3: Add support for serdes
> loopback selftest
> 
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Sun, 12 Aug 2018 10:47:30 +0100
> 
> > -#define HNS3_SELF_TEST_TPYE_NUM		1
> > +#define HNS3_SELF_TEST_TPYE_NUM		2

Sure, fixed in V2. Thanks.

> 
> Is this supposed to be the number of self test "types"?  If so, this
> CPP
> macro should be named "HNS3_SELF_TEST_TYPE_NUM".
> 
> > +
> > +		count ++;
>                      ^
> 
> Please remove that unnecessary space


Sure, fixed in V2 version, thanks.


> 
> > +	} while (++i < HCLGE_SERDES_RETRY_NUM  &&
>                                              ^^
> 
> Only need one space there, not two.

Thank you. Fixed in V2.

Best regards
Salil
 
