Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96179C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8D2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BkMFx6Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8D2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeKZVHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:07:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:07:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQA4isM015138;
        Mon, 26 Nov 2018 10:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=eKFxNx5fObgx18PX2+VyaPMjtszHipKTBF40Y5nwCQA=;
 b=BkMFx6Sap4R+E6fVx5ouz6EJbpUnVaACfnrrS+iZBXLph6lg9lPaYtTSBPEGRMES8Zc0
 ylKxh7ApnME68BJ4lWOPOsanOYZmOSN+w+FoEODqbUeKYviv6C3T+m8SPmsMmpL+u0Px
 ktw5c9ZwUPIQkputUEf7gVflvAJvmBN0sRohzZ3+7Ya+QupPwHG4lW1ZNO8lMHpaMUE1
 dR/3mARYBSCQNuysxlsl9chv0R/OPCA12HXboJkIcHad+7WfrWgiVf6/QrRXQmFR9fV6
 47dE2CYMV7qvZ0uZ6SBsxVdIKw4Hw6HTSPQQJnrkZEkb4gBMzLpyLcDfRZG4mfSNf2P2 tA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2tvumb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 10:13:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQADHhT004374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 10:13:17 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQADGlL023338;
        Mon, 26 Nov 2018 10:13:16 GMT
Received: from unbuntlaptop (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 02:13:16 -0800
Date:   Mon, 26 Nov 2018 13:13:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/26] Staging: fbtft: flexfb: Switch to the gpio
 descriptor interface
Message-ID: <20181126101308.GI3088@unbuntlaptop>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
 <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 04:56:29PM +0530, Nishad Kamdar wrote:
> This switches the flexfb.c to use GPIO descriptors
> rather than numerical gpios.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/fbtft/flexfb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
> index 2af474469e7d..c5fa59105a43 100644
> --- a/drivers/staging/fbtft/flexfb.c
> +++ b/drivers/staging/fbtft/flexfb.c
> @@ -9,7 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/vmalloc.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/delay.h>
>  
> @@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
>  {
>  	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
>  
> -	if (par->gpio.dc < 0) {
> +	if (!par->gpio.dc) {
>  		dev_err(par->info->device,
>  			"Missing info about 'dc' gpio. Aborting.\n");
>  		return -EINVAL;

We changed par->gpio.c from an int to a pointer in patch 1 so we have
to update all the checks as well in the same patch.  Otherwise it breaks
`git bisect`.

(I don't know this code well.  But it just feels like it has to be
breaking git bisect just from from glancing at the patches.  Perhaps I
have misunderstood).

regards,
dan carpenter

