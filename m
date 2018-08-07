Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA1BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C52219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LS7u9SdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C52219DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeHGJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:59:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46980 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeHGJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:59:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w777dLRv183887;
        Tue, 7 Aug 2018 07:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=JbwnX3/xGfOMV2n6ylp/LxUHx2DnO0ZdxrFoMc4PCMo=;
 b=LS7u9SdBRGd26Vf3FG5oY9/LxuDI7a3pCF2/OpW/u/Nn1oalWiI9INYhBUw/pQFS6pi9
 OTsOpEATduvF8df/WRSlZFXdu7YrRSmyWArid0QOLPFfuHADdiVsCz30m8wca/YSi4lS
 SV1L+TdL6nagbWIxpyrbt+v0qiHJLhZ5dmgSbgikzY3VVc97YoW0iNkAqXKBVhfpe1bh
 DeY4S5uFp49tbSvbglJexxirG6hpeuW7WLbcqzJKjEgHWkzK6WVtF/RHmyhDhXwljW2p
 OwJXrEXmWp0Cc7raxz8QpuWvz8opEzZf1b59dEdIDEDKcnxamC6Lsf3twSN5qmPgBUed aA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kn1nd0779-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 07:46:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w777kAa1018523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 07:46:10 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w777k9Rb017580;
        Tue, 7 Aug 2018 07:46:09 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 00:46:09 -0700
Date:   Tue, 7 Aug 2018 10:46:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] staging: fbtft: Includes parenthesis around macro
 parameters and avoids multiple usage of macro parameter - Style
Message-ID: <20180807074602.b4bksw5ridqvphxl@mwanda>
References: <cover.1533614243.git.leobras.c@gmail.com>
 <3cac26238f63cac9123ad767341daead9aec7717.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cac26238f63cac9123ad767341daead9aec7717.1533614243.git.leobras.c@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8977 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 01:07:41AM -0300, Leonardo Brás wrote:
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index 41ac00239aa3..eb2bdc4870be 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -411,17 +411,21 @@ module_exit(fbtft_driver_module_exit)
>  #define DEBUG_REQUEST_GPIOS_MATCH	BIT(30)
>  #define DEBUG_VERIFY_GPIOS		BIT(31)
>  
> -#define fbtft_init_dbg(dev, format, arg...)                  \
> -do {                                                         \
> -	if (unlikely((dev)->platform_data &&                 \
> -	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> -		dev_info(dev, format, ##arg);                \
> +#define fbtft_init_dbg(dev, format, arg...)				\
> +do {									\
> +	typeof(dev) _dev = (dev);					\
> +	struct fbtft_platform_data *pddev = (void *)_dev->platform_data;\
> +	if (unlikely(pddev &&				\
> +	    (pddev->display.debug &					\
> +	     DEBUG_DRIVER_INIT_FUNCTIONS)))				\
> +		dev_info(_dev, (format), ##arg);			\
>  } while (0)

We're never going to hit this bug ever...  Let's not over engineer
things just for pretend reasons.

Also let's just delete this and replace it with dev_dbg().  You can
turn dev_dbg on for just one function so it already provides everything
we need.

regards,
dan carpenter

