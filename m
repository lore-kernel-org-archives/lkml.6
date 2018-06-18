Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BIUDydEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D5A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935088AbeFROkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:40:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934367AbeFROka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:40:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5IEctu9182275;
        Mon, 18 Jun 2018 14:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=5RIZ49z4R05Qv+exmZouM/1GAm6RFvWJsnPmGMoguB0=;
 b=BIUDydEZ9bASxSvr7BouR/NAfOVZBWbiCVmtJC5kFSTYZm68b9F8UBwVBWuf4ottco8v
 ohKrRRMS8bvhwLxz7KRqpDyhPn3A8FaNHiBzNxJg1BNnKY9+DesoVAaqGqXJvJP/Orbg
 eR3AwS9//GPZ7xB+btF4WMWISrnJ6k9JDUiRickLZ280R1HVMbwO0pevIG+Mgy36xqMq
 WQgJvqljHCbxc2cb45NEEf6RNHrDeX2brvomKS3JafUs/p+vtUNssW/LFvjbMVxq9j1G
 aQlMAMRaKiVzuAkENoThcQy4uajE7ekSSgBpB1gf4LEFB3JAV/sWsGp8MPkL9gUgXpm/ OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jmu6xmayt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 14:40:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5IEeOqG011547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 14:40:24 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5IEeNVj027530;
        Mon, 18 Jun 2018 14:40:23 GMT
Received: from mwanda (/197.157.0.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 07:40:23 -0700
Date:   Mon, 18 Jun 2018 17:40:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Taniya Das <tdas@codeaurora.org>
Cc:     kbuild-all@01.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 2/2] clk: qcom: Add lpass clock controller driver for
 SDM845
Message-ID: <20180618144011.v5uwk4lkiuynggl3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528961943-12506-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/Add-support-for-LPASS-clock-controller-for-SDM845/20180614-155144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

smatch warnings:
drivers/clk/qcom/lpasscc-sdm845.c:197 lpass_clocks_sdm845_probe() warn: passing zero to 'PTR_ERR'

# https://github.com/0day-ci/linux/commit/035d2520712de752be68d10a37650b65b6aee154
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 035d2520712de752be68d10a37650b65b6aee154
vim +/PTR_ERR +197 drivers/clk/qcom/lpasscc-sdm845.c

035d2520 Taniya Das 2018-06-14  179  
035d2520 Taniya Das 2018-06-14  180  static int lpass_clocks_sdm845_probe(struct platform_device *pdev,
035d2520 Taniya Das 2018-06-14  181  				     struct device_node *np,
035d2520 Taniya Das 2018-06-14  182  				     const struct qcom_cc_desc *desc)
035d2520 Taniya Das 2018-06-14  183  {
035d2520 Taniya Das 2018-06-14  184  	struct regmap *regmap;
035d2520 Taniya Das 2018-06-14  185  	struct resource res;
035d2520 Taniya Das 2018-06-14  186  	void __iomem *base;
035d2520 Taniya Das 2018-06-14  187  
035d2520 Taniya Das 2018-06-14  188  	if (of_address_to_resource(np, 0, &res))
035d2520 Taniya Das 2018-06-14  189  		return -ENOMEM;
035d2520 Taniya Das 2018-06-14  190  
035d2520 Taniya Das 2018-06-14  191  	base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
035d2520 Taniya Das 2018-06-14  192  	if (IS_ERR(base))
035d2520 Taniya Das 2018-06-14  193  		return -ENOMEM;
035d2520 Taniya Das 2018-06-14  194  
035d2520 Taniya Das 2018-06-14  195  	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
035d2520 Taniya Das 2018-06-14  196  	if (!regmap)
035d2520 Taniya Das 2018-06-14 @197  		return PTR_ERR(regmap);
                                                       ^^^^^^^^^^^^^^^
035d2520 Taniya Das 2018-06-14  198  
035d2520 Taniya Das 2018-06-14  199  	return qcom_cc_really_probe(pdev, desc, regmap);
035d2520 Taniya Das 2018-06-14  200  }
035d2520 Taniya Das 2018-06-14  201  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
