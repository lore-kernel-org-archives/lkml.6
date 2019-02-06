Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E2AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5554A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xtnmB8Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfBFPAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:00:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52640 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:00:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x16EwpP0044451;
        Wed, 6 Feb 2019 14:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1sT5PE6KsS9qOEFE1dkFfDpGU9Dm73ua+QSmea/cg1w=;
 b=xtnmB8Mj7az9FfYg4phKiZdkt24EEgze9QoyuLHe+NZbuKvbydclL2rekLBZ1T8UX21H
 TDovaM6+mnoreHDYe2n/U463jh12BBLueVVRjJTOdGPYAM1LynDOZ1s8WMEpa6szvT+1
 2nyQhDuzbB8syqw1uAMcZEV6e6VoGcbvylP1MB785HuIgx4Go8EG3KmFKI7L4QBk7McH
 umjmibKUNHBYe++rJqKF8JPmpvDNzUa+r9KJz+rBFJV6fshxxoaaohyhBw9CGynNHBMb
 +3HCYMohs79JWsyYineULJa/0qBnCt/zmtGqxc4Pzr3PQI5/qkr/yvNkcfNtK8rySOhG RA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97f1fbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Feb 2019 14:59:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x16ExWB9016319
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Feb 2019 14:59:32 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x16ExU0c018913;
        Wed, 6 Feb 2019 14:59:30 GMT
Received: from kadam (/41.202.241.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Feb 2019 14:59:29 +0000
Date:   Wed, 6 Feb 2019 17:59:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Beniamin Bia <biabeniamin@outlook.com>
Cc:     jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH 1/2] staging: iio: frequency: ad9834: Move frequency to
 standard iio types
Message-ID: <20190206145919.GA1978@kadam>
References: <20190206120542.16617-1-biabeniamin@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206120542.16617-1-biabeniamin@outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9158 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 02:05:41PM +0200, Beniamin Bia wrote:
> Frequency attribute is added with a standard type from iio framework
> instead of custom attribute. This is a small step towards removing any
> unnecessary custom attribute.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>


This doesn't match your email.  You should probably add a From: to
give your @analog.com address authorship credit.

> ---
>  drivers/staging/iio/frequency/ad9834.c | 97 +++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f036f75d1f22..370e8263899e 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -29,8 +29,7 @@
>  /* Registers */
>  
>  #define AD9834_REG_CMD		0
> -#define AD9834_REG_FREQ0	BIT(14)
> -#define AD9834_REG_FREQ1	BIT(15)
> +#define AD9834_REG_FREQ(chann)	(BIT(14) << (chann))

Only one 'n' in "chan", please.  But we actually pass the address not
the channel here so that was unexpected to me.  I think the channel is
always the same as the address?  So maybe it doesn't matter.

>  #define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
>  #define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
>  
> @@ -81,6 +80,9 @@ struct ad9834_state {
>  	struct spi_message		freq_msg;
>  	struct mutex                    lock;   /* protect sensor state */
>  
> +	unsigned long			frequency0;
> +	unsigned long			frequency1;

I don't understand why we have two frequencies when we only ever use
one.

> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -100,6 +102,25 @@ enum ad9834_supported_device_ids {
>  	ID_AD9838,
>  };
>  
> +#define AD9833_CHANNEL(_chan) {						\

No need for the underscore.  (I think?)

> +		.type = IIO_ALTVOLTAGE,					\
> +		.indexed = 1,						\
> +		.output = 1,						\
> +		.address = (_chan),					\
> +		.channel = (_chan),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +}

regards,
dan carpenter


