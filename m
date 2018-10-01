Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE10D2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zV/tUTq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeJANYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:24:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeJANYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:24:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w916mUfd002182;
        Mon, 1 Oct 2018 06:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CSJhoHH/lVzw6ZleDugyPcqjHiOn1WZ1cPd7lwFtl64=;
 b=zV/tUTq1vsznfoq5fO/3dv1ZnHNNCVE0ox3MKtPUMRUxwmr1as8IwDTw0zNpL8ICa7eU
 5gVXkmqyEazUrm3iKmLYXUTICIC9KemYibfS2AL62ETyX+dIaFeYkF/3M5xAYw15Lrrm
 r6bIpiOhMWHngIexwD987dZ5RUf8x9IlHre8hlAJdhxAFIncGAi8Yva38qFUY9sx/J0a
 4hpPukKtr6OPu+O/K+ncV8B0iRogHQADurvGN8H2dQ0POnOwHBGUx/sTy4m2EBOoGNuu
 OEmCTshj059OqWa1Rl5ywhD96vO2fhDUCa4ePOWMEPIGLxdOAojVDBQEKAbUoJAilVsV Ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mt0ttd2cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 06:48:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w916mMsl016208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 06:48:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w916mMqN026275;
        Mon, 1 Oct 2018 06:48:22 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Sep 2018 23:48:21 -0700
Date:   Mon, 1 Oct 2018 09:48:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     mchehab@kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] Staging: media: replaced deprecated probe method
Message-ID: <20181001064813.puc6ky4i55vmgn4q@mwanda>
References: <20180929185150.16657-1-st5pub@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929185150.16657-1-st5pub@yandex.ru>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=921
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 09:51:50PM +0300, Andrey Abramov wrote:
> drivers/staging/media/bcm2048/radio-bcm2048.c replaced i2c_driver::probe with i2c_driver::probe_new, because documentation says that i2c_driver::probe "soon to be deprecated"
> 

This needs to be line wrapped at 72 characters.

> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> ---
>  drivers/staging/media/bcm2048/radio-bcm2048.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
> index a90b2eb112f9..756f7f08c713 100644
> --- a/drivers/staging/media/bcm2048/radio-bcm2048.c
> +++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
> @@ -2574,8 +2574,7 @@ static const struct video_device bcm2048_viddev_template = {
>  /*
>   *	I2C driver interface
>   */
> -static int bcm2048_i2c_driver_probe(struct i2c_client *client,
> -				    const struct i2c_device_id *id)
> +static int bcm2048_i2c_driver_probe_new(struct i2c_client *client)

Don't rename the function.  Just remove the unused parameter.

regards,
dan carpenter

