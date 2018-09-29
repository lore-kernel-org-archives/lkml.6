Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A8C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7B2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B7B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI3DNZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 23:13:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbeI3DNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 23:13:24 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E7DBCB4FD816;
        Sat, 29 Sep 2018 21:43:29 +0100 (IST)
Received: from FRAEML704-CAH.china.huawei.com (10.206.14.35) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Sat, 29 Sep 2018 21:43:31 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEML704-CAH.china.huawei.com ([10.206.14.35]) with mapi id 14.03.0399.000;
 Sat, 29 Sep 2018 22:43:22 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V2 net-next 00/10] Cleanups, minor additions & fixes for
 HNS3 driver
Thread-Topic: [PATCH V2 net-next 00/10] Cleanups, minor additions & fixes
 for HNS3 driver
Thread-Index: AQHUWATlvS0281ZzIE6gq2zkBiRlcqUHZzQAgABRdXA=
Date:   Sat, 29 Sep 2018 20:43:21 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF10EC6@FRAEML521-MBX.china.huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
 <20180929.104644.1898007175155937602.davem@davemloft.net>
In-Reply-To: <20180929.104644.1898007175155937602.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> From: David Miller [mailto:davem@davemloft.net]
> Sent: Saturday, September 29, 2018 6:47 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH V2 net-next 00/10] Cleanups, minor additions &
> fixes for HNS3 driver
> 
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Sat, 29 Sep 2018 15:56:12 +0100
> 
> > This patch-set contains cleans-ups, minor changes and fixes to the
> HNS3 driver.
> >
> > Change Summary:
> > v1->v2
> >   * Fixed Kbuild error due to missed patch in the current submission.
> >     For now, replaced HNAE3_REVISION_ID_21 macro with 0x21
> >   * Fixed issues identified by Eric Dumazet and spelling mistakes by
> David Miller
> >     Link: https://lkml.org/lkml/2018/9/28/842
> >
> > Note:
> > Hi David,
> > From v1->v2 changes only exists in below patch
> >      "net: hns3: Add serdes parallel inner loopback support"
> 
> I already applied v1, so you have to send me a build fix for that
> broken
> patch.
> 
> Nevermind, I'll do it myself, I can't have my tree broken like this for
> days.
> 
> In the future, when I've applied your changes, they cannot be reverted.
> You must send me relative fixups to what is in my tree already.

Ok sure, got it. Will take care in future.
Thanks so much for the help this time.

Best regards
Salil.

> 
> Thank you.
