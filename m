Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545D721019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfAWLm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:42:27 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49494 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbfAWLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:42:26 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NBctbT005338;
        Wed, 23 Jan 2019 05:42:11 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2q416tqysm-1;
        Wed, 23 Jan 2019 05:42:11 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id BC57E611C8B1;
        Wed, 23 Jan 2019 05:42:14 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 11:42:10 +0000
Received: from [198.90.251.142] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.142])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x0NBg89S026265;        Wed, 23 Jan 2019 11:42:08 GMT
Subject: Re: [PATCH v2 1/2] pinctrl: remove pinctrl/machine.h inclusion from
 pinctrl/pinconf.h
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20190122211822.7016-1-vz@mleia.com>
 <20190122211822.7016-2-vz@mleia.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <5a3eb1b0-5ea0-fdbf-3fe0-66d843d6869a@opensource.cirrus.com>
Date:   Wed, 23 Jan 2019 11:42:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190122211822.7016-2-vz@mleia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901230088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/19 21:18, Vladimir Zapolskiy wrote:
> The change adds explicit inclusion of linux/pinctrl/machine.h header
> to the only needed pinctrl-madera-core.c file, and therefore inclusion
> of pinctrl/machine.h header from pinctrl/pinconf.h can be removed.
> 
> The change is preparatory to a follow-up reversal of commit f07512e615dd
> ("pinctrl/pinconfig: add debug interface").
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes from v1 to v2:
> * new change to mitigate a compile time warning caused by a removal of
>    implicit header inclusion, the issue was reported against v1 change.
> 
> This change might be percepted as a bit awkward, but I leave a room to
> extend it to other drivers, if it becomes needed. However apparently
> only pinctrl/cirrus/pinctrl-madera-core.c misses explicit inclusion of
> linux/pinctrl/machine.h header.
> 
>   drivers/pinctrl/cirrus/pinctrl-madera-core.c | 1 +
>   include/linux/pinctrl/pinconf.h              | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> index a5dda832024a..7c9694593f79 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> @@ -14,6 +14,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/slab.h>
> +#include <linux/pinctrl/machine.h>
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/pinctrl/pinconf.h>

For the Madera change:
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>


> diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
> index 8dd85d302b90..109468d9d849 100644
> --- a/include/linux/pinctrl/pinconf.h
> +++ b/include/linux/pinctrl/pinconf.h
> @@ -14,8 +14,6 @@
>   
>   #ifdef CONFIG_PINCONF
>   
> -#include <linux/pinctrl/machine.h>
> -
>   struct pinctrl_dev;
>   struct seq_file;
>   
> 

