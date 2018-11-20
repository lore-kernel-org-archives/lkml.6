Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F3C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E15720831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E15720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeKUBQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:16:37 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:40450 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbeKUBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:16:37 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEioKo020228;
        Tue, 20 Nov 2018 08:47:02 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984f1a-1;
        Tue, 20 Nov 2018 08:47:02 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B3864611E127;
        Tue, 20 Nov 2018 08:47:01 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:47:01 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEl0VR009822; Tue,
 20 Nov 2018 14:47:00 GMT
Date:   Tue, 20 Nov 2018 14:47:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
Message-ID: <20181120144700.GB16508@imbe.wolfsonmicro.main>
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
 <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
 <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=437 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
> On 2018-05-17 18:41, Mark Brown wrote:
> > Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number
> 
> This patch causes following kernel warning on Samsung Exynos4412 based
> Trats2 board:
> 
> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
> wm8994 4-001a: Failed to get supplies: -517

How is the wm8994 being registered on this board? I am having
difficulty finding a device tree or a board file that relates to
the board and includes the wm8994.

> > @@ -203,6 +203,18 @@ static const struct i2c_board_info wm1277_devs[] = {
> >  	{ I2C_BOARD_INFO("wm8958", 0x1a),  /* WM8958 is the superset */
> >  	  .platform_data = &wm8994_pdata,
> >  	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
> > +	  .dev_name = "wm8958",
> > +	},
> > +};
> > +
> > +static struct gpiod_lookup_table wm8994_gpiod_table = {
> > +	.dev_id = "i2c-wm8958", /* I2C device name */
> > +	.table = {
> > +		GPIO_LOOKUP("GPION", 6,
> > +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP("GPION", 4,
> > +			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
> > +		{ },
> >  	},
> >  };

If its being done through a board file I guess you will need the
equivalent of this.

Thanks,
Charles
