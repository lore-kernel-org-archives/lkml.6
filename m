Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7671C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9BF2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9BF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbeKOTnX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:43:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728887AbeKOTnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:22 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 018FEA423ECD6;
        Thu, 15 Nov 2018 09:36:16 +0000 (GMT)
Received: from FRAEMA702-CHM.china.huawei.com (10.206.14.51) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 09:36:17 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.76]) by
 FRAEMA702-CHM.china.huawei.com ([169.254.2.148]) with mapi id 14.03.0415.000;
 Thu, 15 Nov 2018 10:36:10 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH net-next 1/5] net: hns3: Enable HW GRO for Rev B(=0x21)
 HNS3 hardware
Thread-Topic: [PATCH net-next 1/5] net: hns3: Enable HW GRO for Rev B(=0x21)
 HNS3 hardware
Thread-Index: AQHUezmnt+3C9Q8AW0CD0gBKHyEzqqVNf78AgAMVqvA=
Date:   Thu, 15 Nov 2018 09:36:10 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFB6F3E@FRAEML521-MBX.china.huawei.com>
References: <20181113101307.6020-1-salil.mehta@huawei.com>
 <20181113101307.6020-2-salil.mehta@huawei.com>
 <20181113112446.GC3759@mtr-leonro.mtl.com>
In-Reply-To: <20181113112446.GC3759@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Leon Romanovsky [mailto:leon@kernel.org]
> Sent: Tuesday, November 13, 2018 11:25 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> lipeng (Y) <lipeng321@huawei.com>; mehta.salil@opnsrc.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH net-next 1/5] net: hns3: Enable HW GRO for Rev
> B(=0x21) HNS3 hardware
> 
> On Tue, Nov 13, 2018 at 10:13:03AM +0000, Salil Mehta wrote:
> > From: Peng Li <lipeng321@huawei.com>
> >
> > HNS3 hardware Revision B(=0x21) supports Hardware GRO feature. This
> > patch enables this feature in the HNS3 PF/VF driver.
> >
> > Signed-off-by: Peng Li <lipeng321@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>


> >
> > +	ret = hclge_config_gro(hdev, true);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to enable GRO in hardware, ret =%d\n", ret);
> 
> You already printed an error in the hclge_config_gro().

sure. thanks.

> 
> > +		goto err_mdiobus_unreg;
> > +	}
> > +
> >  	ret = hclge_init_vlan_config(hdev);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "VLAN init fail, ret =%d\n", ret);
> > @@ -7221,6 +7250,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
> >  		return ret;
> >  	}
> >
> > +	ret = hclge_config_gro(hdev, true);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to enable GRO in hardware, ret =%d\n", ret);
> 
> Ditto

ok.


> >  static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
> >  {
> >  	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
> > @@ -2122,6 +2145,13 @@ static int hclgevf_reset_hdev(struct
> hclgevf_dev *hdev)
> >  		return ret;
> >  	}
> >
> > +	ret = hclgevf_config_gro(hdev, true);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"failed to enable VF GRO in hardware, ret =%d\n",
> ret);
> > +		return ret;
> 
> Ditto

sure.


> 
> > +	}
> > +
> >  	ret = hclgevf_init_vlan_config(hdev);
> >  	if (ret) {
> >  		dev_err(&hdev->pdev->dev,
> > @@ -2199,6 +2229,13 @@ static int hclgevf_init_hdev(struct hclgevf_dev
> *hdev)
> >  		goto err_config;
> >  	}
> >
> > +	ret = hclgevf_config_gro(hdev, true);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to enable VF GRO in hardware, ret =%d\n",
> ret);
> 
> Ditto

Fixed in V2. Thanks Leon.


Best regards
Salil.
