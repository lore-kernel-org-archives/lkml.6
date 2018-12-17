Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D86C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJ96UORW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbeLQHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:46:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44308 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeLQHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:46:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBH7csWc179272;
        Mon, 17 Dec 2018 07:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cHqyWIVGvHqjra346FRxccAEo88k+fmoqCJgujZ5P08=;
 b=KJ96UORWIXzopdY6k5CHAEvP+pglAuySwI7EQ19yrZL27Uv5MbPYfK8goIu094pQIHbN
 ohzzBSk0ch88BbPraPMAFu3ln6h1V414nlh5BkE75KWKSghG7u36aXAwnxS63B5TE6mH
 AY1uN9vZ2kUTSvtLYyL+rTq62CjcvrDNw9n0XQnsquR81k0PGO7BwW5p8rU80wui7BMi
 7Lle40+76PnhqylYm7aABMySht4nyNMZeWKmVKBhmauCctmLpgNw2oOAsYzHwMCRgNMj
 LeHE379DX9+zA05/DwF9I+3strsfSCbuPa4gfx1pPNQTHd7BlvDmV1ifiQAVIV8uvs89 nQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pcs1tc9h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 07:46:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBH7juaH006568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 07:45:56 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBH7jrtX011080;
        Mon, 17 Dec 2018 07:45:54 GMT
Received: from kadam (/197.157.0.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Dec 2018 23:45:52 -0800
Date:   Mon, 17 Dec 2018 10:45:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sergey Efimochkin <sergeyanton2007@gmail.com>
Cc:     devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Efimochkin <efimochkin.sv@phystech.edu>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging:iio:adc: fix codestyle
Message-ID: <20181217074540.GC15451@kadam>
References: <20181217014333.75969-1-efimochkin.sv@phystech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217014333.75969-1-efimochkin.sv@phystech.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9109 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812170073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch prefix should be "staging: iio: adc: ad7280a:".  Do
git log --oneline drivers/staging/iio/adc/ad7280a.c and copy what
other people do.

On Mon, Dec 17, 2018 at 04:43:33AM +0300, Sergey Efimochkin wrote:
> staging:iio:adc: fix codestyle

Only to do one thing per patch.  We need a better patch description.

> Signed-off-by: Sergey Efimochkin <efimochkin.sv@phystech.edu>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..52e12d1201b3 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -706,8 +706,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  				st->cell_threshhigh)
>  				iio_push_event(indio_dev,
>  					       IIO_EVENT_CODE(IIO_VOLTAGE,
> -							1,
> -							0,
> +							      1,
> +							      0,
>  							IIO_EV_DIR_RISING,
>  							IIO_EV_TYPE_THRESH,
>  							0, 0, 0),

No.  Now the IIO_EV_DIR_RISING, and later columns are not aligned
correctly.  Just ignore the checkpatch warning.  It's fine as-is.

> @@ -987,6 +985,6 @@ static struct spi_driver ad7280_driver = {
>  };
>  module_spi_driver(ad7280_driver);
>  
> -MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");

This change needs to come from Michael.  Just leave the code as-is.

regards,
dan carpenter

