Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767E120817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLXXtygM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeK0IHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:07:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47574 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeK0IHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:07:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQHwciU034164;
        Mon, 26 Nov 2018 18:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uIhQR04eNmoGK0YesR/8RoDS7hlZIGH/KZ+Ir6w9isk=;
 b=gLXXtygMRdpPRGzaTHWaSFJGjAi91pN+M7iOoPcJhlhnzGtCl+bKmh7+CP/zUtm+QfPr
 pNxCGQ9yIdKBlQpVtdUaUxkpxJ7ppa/5L6zuJEBUNVgfr1FphTuCuwQBe1bSO32CCaGS
 u9Lq+r0uOSXPWCW4nthA4EY25S4TViun5I+f0GYN2gMywCAPVAiSa9xPaq6hFJMyBlfS
 QsbnsLMXnrYZ/0KDa/VPRO/0Pz12dKK+imTRYg4WqlvtnTd5XAJx/IUTHs23SzTTcgs/
 DNrvd5cfruoP4oTEdIBOT/YcEVFC7nR6R5nRmQFmyGvRsrpaoNiNcDmaj5NHTabjCmxY CA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nxx2tydxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 18:01:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAQI1GkQ028350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 18:01:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQI1F8o001080;
        Mon, 26 Nov 2018 18:01:15 GMT
Received: from unbuntlaptop (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 10:01:14 -0800
Date:   Mon, 26 Nov 2018 21:01:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux@wolf-entwicklungen.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add missing call to cdev_del()
Message-ID: <20181126180105.GM2970@unbuntlaptop>
References: <20181126175355.18800-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126175355.18800-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:53:55PM +0100, Michael Straube wrote:
> If cdev_add() fails, cdev_del() should be called.
> Add the missing cdev_del() call as pointed out by
> Dan Carpenter.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index d72de2105053..abc98a544929 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -1254,6 +1254,7 @@ static int pi433_probe(struct spi_device *spi)
>  	retval = cdev_add(device->cdev, device->devt, 1);
>  	if (retval) {
>  		dev_dbg(device->dev, "register of cdev failed");
> +		cdev_del(device->cdev);
>  		goto cdev_failed;

No no...  That's not the right thing.  Do "goto del_cdev;" and add a
label at the end.

del_cdev:
	cdev_del(device->cdev);

regards,
dan carpenter

