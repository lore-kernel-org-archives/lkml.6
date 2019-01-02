Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5051BC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDF218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wd+zzXhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfABLek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:34:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfABLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:34:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02BTDFC021085;
        Wed, 2 Jan 2019 11:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UmChkRnrEq6k2X3BG6k328rkxH6SwfkrBWfrbXBpbnI=;
 b=Wd+zzXhYT5kDXr3PxCtUF2CoiSkeeZilusZwFq8gnQrcKKTBT2ZtAuPEjeFQDEtdcqJz
 iUd4a5A33j5salQClSmRrf43FtDevNj3Bt39HxFe6La4Sz6YccAEONCrV8DBMBpVTbY0
 Kl+ImLUiMOM0vKxXT/1YgyBwsdmxpGpddc+ByN4TwOEGi5IXlSnvpbH0JbKsFZwP5xA4
 URxYq8/qnDSBi3eCAZlx7CyfT38XAIgIkAPQeLXk+9uWBW4TB4NGIZofGiTANxX+qqY3
 e2c19S/08gcWQ2QodIJFvfKZf41H/nobscHOkojr95aUaRc41m6d62aaoueITV8Az+xp +g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pp1jr1kej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 11:34:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02BY8Bq030729
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 11:34:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02BY6qd006308;
        Wed, 2 Jan 2019 11:34:06 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 03:34:06 -0800
Date:   Wed, 2 Jan 2019 14:33:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
Message-ID: <20190102113346.GM3781@kadam>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:26:26PM -0800, Amir Mahdi Ghorbanian wrote:
> Replaced bool in struct with unsigned int bitfield to conserve space and
> more clearly define size of varibales
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43..7d3e62f 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -35,13 +35,13 @@ struct ad7192_platform_data {
>  	u16		vref_mv;
>  	u8		clock_source_sel;
>  	u32		ext_clk_hz;
> -	bool		refin2_en;
> -	bool		rej60_en;
> -	bool		sinc3_en;
> -	bool		chop_en;
> -	bool		buf_en;
> -	bool		unipolar_en;
> -	bool		burnout_curr_en;
> +	unsigned int	refin2_en : 1;
> +	unsigned int	rej60_en : 1;
> +	unsigned int	sinc3_en : 1;
> +	unsigned int	chop_en : 1;
> +	unsigned int	buf_en : 1;
> +	unsigned int	unipolar_en : 1;
> +	unsigned int	burnout_curr_en : 1;

Don't put spaces around the :.  Just do:

	unsigned int    burnout_curr_en:1;

Otherwise it looks like part of a select statement or something.

regards,
dan carpenter

