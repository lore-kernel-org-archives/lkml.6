Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6957C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DAC20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wkJyQgCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfBDTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:31:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34914 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfBDTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:31:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x14JTK9Z118994;
        Mon, 4 Feb 2019 19:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iaMjtbdV8M6WFtNRga/55WYQRKOhljKzX6eYEQRwnIU=;
 b=wkJyQgCU9YW5ZUSSVAUBygK5acOC5N1tIKFnyzQOk8ArJq5H9eWuxl0SIy3uLmPyXK3D
 tXG6d2ynelqVOEBMP5fqqfCdnouHBYs0DfgH15Dx2eVx/sKF4pH8WOLi9hDz/iIOSreH
 Y5rJ8oCeFntqC+25mu9MlPUtEtdxNCIIfgXqAdHc2r9wmVlXwP9VAM0OzooQBYW2ODkP
 uIYOIjfiyPzQ/VJmcU3wiX6RRvjtnEXWlGdfuHeyyTxCAtiscUp3+0fvNMdVTgd6LWBG
 FQ+PS5/U8cFyL6fEVkTNWECj3RG9w5wXgzdzlrR5csh8SSCHhHQl9LxLiPZhzC2jga4Q Zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qd9ar762k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Feb 2019 19:30:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x14JUrEN020976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Feb 2019 19:30:53 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x14JUqeC010490;
        Mon, 4 Feb 2019 19:30:52 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Feb 2019 19:30:51 +0000
Date:   Mon, 4 Feb 2019 22:30:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] regulator: axp20x: check rdev is null before
 dereferencing it
Message-ID: <20190204193042.GD2563@kadam>
References: <20181222113159.31029-1-colin.king@canonical.com>
 <66f320fe-7df1-2715-ec55-ef7dc3493aa0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f320fe-7df1-2715-ec55-ef7dc3493aa0@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 07:13:30PM +0000, Colin Ian King wrote:
> >  drivers/regulator/axp20x-regulator.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> > index 48af859fd053..0dfa4ea6bbdf 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -367,7 +367,7 @@ static const int axp209_dcdc2_ldo3_slew_rates[] = {
> >  static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> >  {
> >  	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> > -	const struct regulator_desc *desc = rdev->desc;
> > +	const struct regulator_desc *desc;

This is only called from set_machine_constraints() so "rdev" can't be
NULL.  (On my allmodonconfig build).

> >  	u8 reg, mask, enable, cfg = 0xff;
> >  	const int *slew_rates;
> >  	int rate_count = 0;
> > @@ -375,6 +375,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> >  	if (!rdev)
> >  		return -EINVAL;
> >  
> > +	desc = rdev->desc;
> > +
> >  	switch (axp20x->variant) {
> >  	case AXP209_ID:
> >  		if (desc->id == AXP20X_DCDC2) {
> > @@ -436,11 +438,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
> >  static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
> >  {
> >  	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
> > -	const struct regulator_desc *desc = rdev->desc;
> > +	const struct regulator_desc *desc;
> >  
> >  	if (!rdev)
> >  		return -EINVAL;
> >  
> > +	desc = rdev->desc;

Called from _regulator_do_enable() and rdev can't be NULL:

	ret = rdev->desc->ops->enable(rdev);

regards,
dan carpenter

