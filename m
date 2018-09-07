Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486F20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeIGNYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:24:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49484 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727746AbeIGNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:24:16 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w878hlVG011487;
        Fri, 7 Sep 2018 03:44:15 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com ([141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mbne001ed-1;
        Fri, 07 Sep 2018 03:44:15 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id D81DD611C8B7;
        Fri,  7 Sep 2018 03:44:14 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 7 Sep 2018
 09:44:14 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w878iDfK005081; Fri,
 7 Sep 2018 09:44:13 +0100
Date:   Fri, 7 Sep 2018 09:44:13 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20180907084413.GG1653@imbe.wolfsonmicro.main>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
 <201809070844.CGeY6FIt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201809070844.CGeY6FIt%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809070091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 08:06:52AM +0800, kbuild test robot wrote:
> Hi Charles,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v4.19-rc2 next-20180906]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Charles-Keepax/mfd-lochnagar-Add-support-for-the-Cirrus-Logic-Lochnagar/20180907-010308
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: alpha-allmodconfig (attached as .config)
> compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=alpha 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mfd/lochnagar-i2c.o: In function `lochnagar_i2c_probe':
> >> (.text+0x4ec): undefined reference to `__devm_regmap_init_i2c'
>    (.text+0x500): undefined reference to `__devm_regmap_init_i2c'

Sorry seems I am missing a select REGMAP_I2C in the Kconfig will
fix up for v2 after any other comments.

>    drivers/mfd/lochnagar-i2c.o: In function `lochnagar_i2c_init':
> >> (.init.text+0x10): undefined reference to `i2c_register_driver'
>    (.init.text+0x24): undefined reference to `i2c_register_driver'

Not sure what is causing this one there is a depends on I2C in
there will have a look and see if I can figure that out.

Thanks,
Charles
