Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D45C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8220824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P5kZ9yYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D8220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeJWTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:52:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbeJWTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:52:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NBJQdo154928;
        Tue, 23 Oct 2018 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=4YxQqTz+LlyYtFKXSv8At1mwi5uREh4Y2j2VMPFBvb8=;
 b=P5kZ9yYjwndP36g2ZWu2MFuSqv2hb66HKQ0FEwUJRPk9E7qrvMFJeMSR9O1eoCYBb4Cv
 pI9LU3ftmm1fY7OEuPFirpmKTVGx6Km1hyIL+jXrRheEndIR/bhk61FvM5c+zYyBaXAG
 xzjiESksOJNa55SIvGPfwZX6S6uq6ulDdNouqzfl6ekNC9jEqZejPty8Yn8xbUzHl4Gv
 Z4Q1UGF2E3XteBPpI8qhlwNr74fxFox1K7ipmSs7ur2Y1Bs65k0AMjXMNTq3xCWgHurY
 UjWJMjpjBPhMtFvrfLL9RgGGKQLwkjCpnrmbX2HXvDN8Gexi+p0Jp7wj18kWZ42dIqHu yQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usu4mhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 11:29:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9NBT2Co000768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 11:29:02 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NBT1tv014538;
        Tue, 23 Oct 2018 11:29:02 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 04:29:01 -0700
Date:   Tue, 23 Oct 2018 14:28:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Salil Mehta <salil.mehta@huawei.com>
Cc:     kbuild-all@01.org, davem@davemloft.net, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH net-next 6/7] net: hns3: Add enable and process hw errors
 from PPP
Message-ID: <20181023112852.4pmcezetrudduvna@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019191532.10088-7-salil.mehta@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiju,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Salil-Mehta/Adds-support-of-RAS-Error-Handling-in-HNS3-Driver/20181021-183911

smatch warnings:
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:700 hclge_log_and_clear_ppp_error() error: uninitialized symbol 'hw_err_lst3'.

# https://github.com/0day-ci/linux/commit/9a8545e85954ec55367e8881d18cc2ae95c56d98
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 9a8545e85954ec55367e8881d18cc2ae95c56d98
vim +/hw_err_lst3 +700 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c

19049622e Shiju Jose 2018-10-19  653  
9a8545e85 Shiju Jose 2018-10-19  654  static int hclge_log_and_clear_ppp_error(struct hclge_dev *hdev, u32 cmd,
9a8545e85 Shiju Jose 2018-10-19  655  					 enum hclge_err_int_type int_type)
9a8545e85 Shiju Jose 2018-10-19  656  {
9a8545e85 Shiju Jose 2018-10-19  657  	enum hnae3_reset_type reset_level = HNAE3_NONE_RESET;
9a8545e85 Shiju Jose 2018-10-19  658  	struct device *dev = &hdev->pdev->dev;
9a8545e85 Shiju Jose 2018-10-19  659  	const struct hclge_hw_error *hw_err_lst1, *hw_err_lst2, *hw_err_lst3;
9a8545e85 Shiju Jose 2018-10-19  660  	struct hclge_desc desc[2];
9a8545e85 Shiju Jose 2018-10-19  661  	u32 err_sts;
9a8545e85 Shiju Jose 2018-10-19  662  	int ret;
9a8545e85 Shiju Jose 2018-10-19  663  
9a8545e85 Shiju Jose 2018-10-19  664  	/* read PPP INT sts */
9a8545e85 Shiju Jose 2018-10-19  665  	ret = hclge_cmd_query_error(hdev, &desc[0], cmd,
9a8545e85 Shiju Jose 2018-10-19  666  				    HCLGE_CMD_FLAG_NEXT, 5, int_type);
9a8545e85 Shiju Jose 2018-10-19  667  	if (ret) {
9a8545e85 Shiju Jose 2018-10-19  668  		dev_err(dev, "failed(=%d) to query PPP interrupt status\n",
9a8545e85 Shiju Jose 2018-10-19  669  			ret);
9a8545e85 Shiju Jose 2018-10-19  670  		return -EIO;
9a8545e85 Shiju Jose 2018-10-19  671  	}
9a8545e85 Shiju Jose 2018-10-19  672  
9a8545e85 Shiju Jose 2018-10-19  673  	/* log error */
9a8545e85 Shiju Jose 2018-10-19  674  	if (cmd == HCLGE_PPP_CMD0_INT_CMD) {
9a8545e85 Shiju Jose 2018-10-19  675  		hw_err_lst1 = &hclge_ppp_mpf_int0[0];
9a8545e85 Shiju Jose 2018-10-19  676  		hw_err_lst2 = &hclge_ppp_mpf_int1[0];
9a8545e85 Shiju Jose 2018-10-19  677  		hw_err_lst3 = &hclge_ppp_pf_int[0];
9a8545e85 Shiju Jose 2018-10-19  678  	} else if (cmd == HCLGE_PPP_CMD1_INT_CMD) {
9a8545e85 Shiju Jose 2018-10-19  679  		hw_err_lst1 = &hclge_ppp_mpf_int2[0];
9a8545e85 Shiju Jose 2018-10-19  680  		hw_err_lst2 = &hclge_ppp_mpf_int3[0];

Not set here.

9a8545e85 Shiju Jose 2018-10-19  681  	} else {
9a8545e85 Shiju Jose 2018-10-19  682  		dev_err(dev, "invalid command(=%d)\n", cmd);
9a8545e85 Shiju Jose 2018-10-19  683  		return -EINVAL;
9a8545e85 Shiju Jose 2018-10-19  684  	}
9a8545e85 Shiju Jose 2018-10-19  685  
9a8545e85 Shiju Jose 2018-10-19  686  	err_sts = le32_to_cpu(desc[0].data[2]);
9a8545e85 Shiju Jose 2018-10-19  687  	if (err_sts) {
9a8545e85 Shiju Jose 2018-10-19  688  		hclge_log_error(dev, hw_err_lst1, err_sts);
9a8545e85 Shiju Jose 2018-10-19  689  		reset_level = HNAE3_FUNC_RESET;
9a8545e85 Shiju Jose 2018-10-19  690  	}
9a8545e85 Shiju Jose 2018-10-19  691  
9a8545e85 Shiju Jose 2018-10-19  692  	err_sts = le32_to_cpu(desc[0].data[3]);
9a8545e85 Shiju Jose 2018-10-19  693  	if (err_sts) {
9a8545e85 Shiju Jose 2018-10-19  694  		hclge_log_error(dev, hw_err_lst2, err_sts);
9a8545e85 Shiju Jose 2018-10-19  695  		reset_level = HNAE3_FUNC_RESET;
9a8545e85 Shiju Jose 2018-10-19  696  	}
9a8545e85 Shiju Jose 2018-10-19  697  
9a8545e85 Shiju Jose 2018-10-19  698  	err_sts = (le32_to_cpu(desc[0].data[4]) >> 8) & 0x3;
9a8545e85 Shiju Jose 2018-10-19  699  	if (err_sts) {
9a8545e85 Shiju Jose 2018-10-19 @700  		hclge_log_error(dev, hw_err_lst3, err_sts);
                                                                     ^^^^^^^^^^^
Uninitialized.

9a8545e85 Shiju Jose 2018-10-19  701  		reset_level = HNAE3_FUNC_RESET;
9a8545e85 Shiju Jose 2018-10-19  702  	}
9a8545e85 Shiju Jose 2018-10-19  703  
9a8545e85 Shiju Jose 2018-10-19  704  	/* clear PPP INT */
9a8545e85 Shiju Jose 2018-10-19  705  	ret = hclge_cmd_clear_error(hdev, &desc[0], NULL, 0,
9a8545e85 Shiju Jose 2018-10-19  706  				    HCLGE_CMD_FLAG_NEXT);
9a8545e85 Shiju Jose 2018-10-19  707  	if (ret) {
9a8545e85 Shiju Jose 2018-10-19  708  		dev_err(dev, "failed(=%d) to clear PPP interrupt status\n",
9a8545e85 Shiju Jose 2018-10-19  709  			ret);
9a8545e85 Shiju Jose 2018-10-19  710  		return -EIO;
9a8545e85 Shiju Jose 2018-10-19  711  	}
9a8545e85 Shiju Jose 2018-10-19  712  
9a8545e85 Shiju Jose 2018-10-19  713  	return 0;
9a8545e85 Shiju Jose 2018-10-19  714  }
9a8545e85 Shiju Jose 2018-10-19  715  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
