Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11033C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CCD20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="icU8YEd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CCD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeLMNWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:22:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51938 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeLMNWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:22:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBDDIU3F026069;
        Thu, 13 Dec 2018 13:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2d3idHNMaH8gHEtCqY2+FtPFMA3pern48EJVygpmTy4=;
 b=icU8YEd5lZRqt7syP0CHEvfMVYwh7Jt3iQcDd2Uidp6QHg4HnORlWWnXY8iiKsdsEM30
 oKUhFI0yEOVD6p0bRPq0VYIgxvHX7Jv+upQ92kBTDcJGF7mZgt+jt2xQFKM2BtfOjEW8
 ymJAuX6lNU/rmSf/aaWXtpeoErh0ER17acEEi8zQN1r+5yB7CvTcwQWrM9FYQhGfYu+2
 /Z203soLnM9a2FUwYcii5AXwfBuNXwtqTgCnUK0pVpwSXuGgb2/D0mbXlESqzV63X4M7
 p7Fs0kGIispz7GJnkcstbJmrfsguybn+XKOpRjcC8Zjbd2WBXsJ3qUxp9P0IbE0mTqj/ 6g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pb3n75s2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 13:21:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBDDLYl2011927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 13:21:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBDDLXuU021562;
        Thu, 13 Dec 2018 13:21:33 GMT
Received: from kadam (/41.202.241.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 05:21:32 -0800
Date:   Thu, 13 Dec 2018 16:21:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, stefan.popa@analog.co
Subject: Re: [PATCH 02/11] staging: iio: adc: ad7606: Use SPDX identifier
Message-ID: <20181213132120.GS3116@kadam>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
 <1544705183-13288-3-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544705183-13288-3-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=948
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:46:14PM +0200, Stefan Popa wrote:
> This patch replaces the license text at the top of ad7606 driver files
> and instead adds SPDX GPL-2.0+ license identifier.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  drivers/staging/iio/adc/ad7606.c     | 5 ++---
>  drivers/staging/iio/adc/ad7606.h     | 3 +--
>  drivers/staging/iio/adc/ad7606_par.c | 5 ++---
>  drivers/staging/iio/adc/ad7606_spi.c | 5 ++---
>  4 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 7308fa8..aa5ab1e 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * AD7606 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.

You've changed the license from 2 to 2+.  That's literally breaking the
law.  As in country laws with lawsuits and fines and what not.  Please
be very careful with this stuff.

regards,
dan carpenter


