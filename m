Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689AD20823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBKIq2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:46:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725931AbfBKIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:46:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1B8fraO018517;
        Mon, 11 Feb 2019 09:46:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qjfy5w1m6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Feb 2019 09:46:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7137031;
        Mon, 11 Feb 2019 08:46:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C06B2452;
        Mon, 11 Feb 2019 08:46:21 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb
 2019 09:46:20 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 11 Feb 2019 09:46:20 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: stpmic1: Remove regul_id and *regmap from
 struct stpmic1_regulator
Thread-Topic: [PATCH] regulator: stpmic1: Remove regul_id and *regmap from
 struct stpmic1_regulator
Thread-Index: AQHUweZCcYMyvoWnsU+q1IYB39nl4w==
Date:   Mon, 11 Feb 2019 08:46:20 +0000
Message-ID: <5C61365C.8050709@st.com>
References: <20190209043935.24637-1-axel.lin@ingics.com>
In-Reply-To: <20190209043935.24637-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BDCE56A8FB73FC4AA3F63AC219DF9952@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Axel,

Le 02/09/2019 05:39 AM, Axel Lin a écrit :
> At the context with *rdev available, there is no problem to get regulator
> id and *regmap, so no need to store them in struct stpmic1_regulator.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/stpmic1_regulator.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
> index 963e67fa9ca6..dd5c8fb1ff86 100644
> --- a/drivers/regulator/stpmic1_regulator.c
> +++ b/drivers/regulator/stpmic1_regulator.c
> @@ -30,20 +30,16 @@ struct stpmic1_regulator_cfg {
>   
>   /**
>    * stpmic1 regulator data: this structure is used as driver data
> - * @regul_id: regulator id
>    * @reg_node: DT node of regulator (unused on non-DT platforms)
>    * @cfg: stpmic specific regulator description
>    * @mask_reset: mask_reset bit value
>    * @irq_curlim: current limit interrupt number
> - * @regmap: point to parent regmap structure
>    */
>   struct stpmic1_regulator {
> -	unsigned int regul_id;
>   	struct device_node *reg_node;
>   	const struct stpmic1_regulator_cfg *cfg;
>   	u8 mask_reset;
>   	int irq_curlim;
> -	struct regmap *regmap;
>   };
>   
>   static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode);
> @@ -477,7 +473,7 @@ static int stpmic1_set_icc(struct regulator_dev *rdev)
>   	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
>   
>   	/* enable switch off in case of over current */
> -	return regmap_update_bits(regul->regmap, regul->cfg->icc_reg,
> +	return regmap_update_bits(rdev->regmap, regul->cfg->icc_reg,
>   				  regul->cfg->icc_mask, regul->cfg->icc_mask);
Maybe this is not compatible with a recommandation from
include/linux/regulator/driver.h:438:
  * This should *not* be used directly by anything except the regulator
  * core and notification injection (which should take the mutex and do
  * no other direct access).

>   }
>
...


thank you,
pascal
