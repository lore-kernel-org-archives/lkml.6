Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CBE21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zu5I/ANu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfABJKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:10:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37066 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfABJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:10:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0294FZ4102756;
        Wed, 2 Jan 2019 09:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PnPFuY64n8N1zt8suuiHCOKKINqeFJpbwpiyf2jfVtA=;
 b=zu5I/ANuM30Vd3Y8jt5yT4lJ5Exr3909OS7G6jkuJ9tisveZSkXhHmz0/y/c5tiYjaOU
 hHkPIqkLqKeGktbFls/b1mzLffLs0n3wPPZQilIO+4tt3Tx+Xoq5LUqoyV7XdzVwunDj
 M7kvlSeGOV7/AS55XehAvrDdbwRC8E5Da6f7PUC7iPxa16SKypcSqUgG0Ds9BTxw6AQZ
 zM7vRshH5b4u83eOW4QVqywixLd8mRSPKqOz7TSDggyOMlNQEGt4rgq9b1esUIRgaG2z
 wVqMVn514QaqJ5fw8abawzAEAbY2eLdiFZ07TUKGaUmggkIkRx2DgfFnuzr+XAYkXICL Yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pnxee188p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 09:10:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x029AcmP008463
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 09:10:38 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x029Ac7o009213;
        Wed, 2 Jan 2019 09:10:38 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 01:10:37 -0800
Date:   Wed, 2 Jan 2019 12:10:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] rtl8723bs/ioctl_linux: Add a security check to
 copy_from_user()
Message-ID: <20190102091016.GA3781@kadam>
References: <20181224001303.9032-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224001303.9032-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 06:13:02PM -0600, Aditya Pakki wrote:
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index b8631baf128d..9992caa8c839 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -2577,14 +2577,19 @@ static int rtw_wps_start(struct net_device *dev,
>  	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>  	struct iw_point *pdata = &wrqu->data;
>  	u32   u32wps_start = 0;
> -        unsigned int uintRet = 0;
>  
>  	if ((true == padapter->bDriverStopped) ||(true ==padapter->bSurpriseRemoved) || (NULL == pdata)) {
>  		ret = -EINVAL;
>  		goto exit;
>  	}
>  
> -	uintRet = copy_from_user((void*)&u32wps_start, pdata->pointer, 4);
> +	ret = copy_from_user((void *)&u32wps_start, pdata->pointer, 4);
> +
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto exit;

Good eye for spotting this bug.  :)

Really this function is not useful though so we should just delete it.
All the CONFIG_INTEL_WIDI stuff is dead code.

Also if copy_from_user() the correct error code is -EFAULT.  And we
would normally write it like this:

	if (copy_from_user((void *)&u32wps_start, pdata->pointer, 4)) {
		ret = -EFAULT;
		goto exit;
	}

But in this case, since this is dead code we should just delete
rtw_wps_start() and put a NULL in the rtw_private_handler[] array where
it used to be.

regards,
dan carpenter

