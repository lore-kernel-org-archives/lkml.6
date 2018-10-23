Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE87C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B4420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B4420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeJXGDB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:03:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbeJXGDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:03:01 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3D17A891BC266;
        Tue, 23 Oct 2018 22:37:45 +0100 (IST)
Received: from FRAEMA704-CHM.china.huawei.com (10.206.14.53) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 23 Oct 2018 22:37:46 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEMA704-CHM.china.huawei.com ([169.254.4.109]) with mapi id 14.03.0415.000;
 Tue, 23 Oct 2018 23:37:36 +0200
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@01.org" <kbuild@01.org>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
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
Thread-Index: AQHUZ+BciIFXkRH7e0SKx8aGH/K9/KUsld4AgADGWZA=
Date:   Tue, 23 Oct 2018 21:37:35 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BF51DF4@FRAEML521-MBX.china.huawei.com>
References: <20181019191532.10088-7-salil.mehta@huawei.com>
 <20181023112852.4pmcezetrudduvna@mwanda>
In-Reply-To: <20181023112852.4pmcezetrudduvna@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.81.34]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
Thanks for letting us know about this. We have a fix for this
but I guess now net-next is closed and David might not accept
the fix for the below problem. It looks problematic case 
might rarely hit so we might be safe deferring it for next cycle.


Best regards

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, October 23, 2018 12:29 PM
> To: kbuild@01.org; Salil Mehta <salil.mehta@huawei.com>
> Cc: kbuild-all@01.org; davem@davemloft.net; Salil Mehta
> <salil.mehta@huawei.com>; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> lipeng (Y) <lipeng321@huawei.com>; mehta.salil@opnsrc.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
> Subject: Re: [PATCH net-next 6/7] net: hns3: Add enable and process hw
> errors from PPP
> 
> Hi Shiju,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Salil-Mehta/Adds-
> support-of-RAS-Error-Handling-in-HNS3-Driver/20181021-183911
> 
> smatch warnings:
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:700
> hclge_log_and_clear_ppp_error() error: uninitialized symbol
> 'hw_err_lst3'.
> 
> # https://github.com/0day-
> ci/linux/commit/9a8545e85954ec55367e8881d18cc2ae95c56d98
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 9a8545e85954ec55367e8881d18cc2ae95c56d98
> vim +/hw_err_lst3 +700
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> 
> 19049622e Shiju Jose 2018-10-19  653
> 9a8545e85 Shiju Jose 2018-10-19  654  static int
> hclge_log_and_clear_ppp_error(struct hclge_dev *hdev, u32 cmd,
> 9a8545e85 Shiju Jose 2018-10-19  655
> enum hclge_err_int_type int_type)
> 9a8545e85 Shiju Jose 2018-10-19  656  {
> 9a8545e85 Shiju Jose 2018-10-19  657  	enum hnae3_reset_type
> reset_level = HNAE3_NONE_RESET;
> 9a8545e85 Shiju Jose 2018-10-19  658  	struct device *dev = &hdev-
> >pdev->dev;
> 9a8545e85 Shiju Jose 2018-10-19  659  	const struct hclge_hw_error
> *hw_err_lst1, *hw_err_lst2, *hw_err_lst3;
> 9a8545e85 Shiju Jose 2018-10-19  660  	struct hclge_desc desc[2];
> 9a8545e85 Shiju Jose 2018-10-19  661  	u32 err_sts;
> 9a8545e85 Shiju Jose 2018-10-19  662  	int ret;
> 9a8545e85 Shiju Jose 2018-10-19  663
> 9a8545e85 Shiju Jose 2018-10-19  664  	/* read PPP INT sts */
> 9a8545e85 Shiju Jose 2018-10-19  665  	ret =
> hclge_cmd_query_error(hdev, &desc[0], cmd,
> 9a8545e85 Shiju Jose 2018-10-19  666
> HCLGE_CMD_FLAG_NEXT, 5, int_type);
> 9a8545e85 Shiju Jose 2018-10-19  667  	if (ret) {
> 9a8545e85 Shiju Jose 2018-10-19  668  		dev_err(dev,
> "failed(=%d) to query PPP interrupt status\n",
> 9a8545e85 Shiju Jose 2018-10-19  669  			ret);
> 9a8545e85 Shiju Jose 2018-10-19  670  		return -EIO;
> 9a8545e85 Shiju Jose 2018-10-19  671  	}
> 9a8545e85 Shiju Jose 2018-10-19  672
> 9a8545e85 Shiju Jose 2018-10-19  673  	/* log error */
> 9a8545e85 Shiju Jose 2018-10-19  674  	if (cmd ==
> HCLGE_PPP_CMD0_INT_CMD) {
> 9a8545e85 Shiju Jose 2018-10-19  675  		hw_err_lst1 =
> &hclge_ppp_mpf_int0[0];
> 9a8545e85 Shiju Jose 2018-10-19  676  		hw_err_lst2 =
> &hclge_ppp_mpf_int1[0];
> 9a8545e85 Shiju Jose 2018-10-19  677  		hw_err_lst3 =
> &hclge_ppp_pf_int[0];
> 9a8545e85 Shiju Jose 2018-10-19  678  	} else if (cmd ==
> HCLGE_PPP_CMD1_INT_CMD) {
> 9a8545e85 Shiju Jose 2018-10-19  679  		hw_err_lst1 =
> &hclge_ppp_mpf_int2[0];
> 9a8545e85 Shiju Jose 2018-10-19  680  		hw_err_lst2 =
> &hclge_ppp_mpf_int3[0];
> 
> Not set here.
> 
> 9a8545e85 Shiju Jose 2018-10-19  681  	} else {
> 9a8545e85 Shiju Jose 2018-10-19  682  		dev_err(dev, "invalid
> command(=%d)\n", cmd);
> 9a8545e85 Shiju Jose 2018-10-19  683  		return -EINVAL;
> 9a8545e85 Shiju Jose 2018-10-19  684  	}
> 9a8545e85 Shiju Jose 2018-10-19  685
> 9a8545e85 Shiju Jose 2018-10-19  686  	err_sts =
> le32_to_cpu(desc[0].data[2]);
> 9a8545e85 Shiju Jose 2018-10-19  687  	if (err_sts) {
> 9a8545e85 Shiju Jose 2018-10-19  688  		hclge_log_error(dev,
> hw_err_lst1, err_sts);
> 9a8545e85 Shiju Jose 2018-10-19  689  		reset_level =
> HNAE3_FUNC_RESET;
> 9a8545e85 Shiju Jose 2018-10-19  690  	}
> 9a8545e85 Shiju Jose 2018-10-19  691
> 9a8545e85 Shiju Jose 2018-10-19  692  	err_sts =
> le32_to_cpu(desc[0].data[3]);
> 9a8545e85 Shiju Jose 2018-10-19  693  	if (err_sts) {
> 9a8545e85 Shiju Jose 2018-10-19  694  		hclge_log_error(dev,
> hw_err_lst2, err_sts);
> 9a8545e85 Shiju Jose 2018-10-19  695  		reset_level =
> HNAE3_FUNC_RESET;
> 9a8545e85 Shiju Jose 2018-10-19  696  	}
> 9a8545e85 Shiju Jose 2018-10-19  697
> 9a8545e85 Shiju Jose 2018-10-19  698  	err_sts =
> (le32_to_cpu(desc[0].data[4]) >> 8) & 0x3;
> 9a8545e85 Shiju Jose 2018-10-19  699  	if (err_sts) {
> 9a8545e85 Shiju Jose 2018-10-19 @700  		hclge_log_error(dev,
> hw_err_lst3, err_sts);
> 
> ^^^^^^^^^^^
> Uninitialized.
> 
> 9a8545e85 Shiju Jose 2018-10-19  701  		reset_level =
> HNAE3_FUNC_RESET;
> 9a8545e85 Shiju Jose 2018-10-19  702  	}
> 9a8545e85 Shiju Jose 2018-10-19  703
> 9a8545e85 Shiju Jose 2018-10-19  704  	/* clear PPP INT */
> 9a8545e85 Shiju Jose 2018-10-19  705  	ret =
> hclge_cmd_clear_error(hdev, &desc[0], NULL, 0,
> 9a8545e85 Shiju Jose 2018-10-19  706
> HCLGE_CMD_FLAG_NEXT);
> 9a8545e85 Shiju Jose 2018-10-19  707  	if (ret) {
> 9a8545e85 Shiju Jose 2018-10-19  708  		dev_err(dev,
> "failed(=%d) to clear PPP interrupt status\n",
> 9a8545e85 Shiju Jose 2018-10-19  709  			ret);
> 9a8545e85 Shiju Jose 2018-10-19  710  		return -EIO;
> 9a8545e85 Shiju Jose 2018-10-19  711  	}
> 9a8545e85 Shiju Jose 2018-10-19  712
> 9a8545e85 Shiju Jose 2018-10-19  713  	return 0;
> 9a8545e85 Shiju Jose 2018-10-19  714  }
> 9a8545e85 Shiju Jose 2018-10-19  715
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
