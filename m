Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401B1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41442082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sf5lDK42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41442082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeH3M3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:29:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeH3M3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:29:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7U8Nsgs005251;
        Thu, 30 Aug 2018 08:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GvMWC3MV6tLxxS1aBV3mm94Q387NPhw0GqU1aeAg6iI=;
 b=Sf5lDK42TDfVehU0pvz+QZLyucP1lEIMYIasIso/Jp9uhuvdZQijKruVre+D7lZ6l6po
 cMDwXoCi8XXHk97e8LTnuLFkw4SOQwwqCDzazS3DS7WnBeV3MgDhXSGoTxiIYEYVvP9D
 fVkQXIJlG5k4vYPw1XWl7Sss6MQb8RGfQ10hw6gMx5qbODOLY/KpiFsYxEKZiQJYndR+
 5c0OGq05YRnvEx+eUi6dqEk8Mk+3GRtH/kku1PP5NTx1l8RknjEZmeHt4gJ8KhuEBZOy
 Hoq8BWT1/Ks5bFRWr32fgvU7ju5TLPzb6ge+0Z+0OkUZN7v9Vv5T3u25AeHsZSmeAYTY VQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xhu05fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:28:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7U8SGIM011069
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 08:28:16 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7U8SGwi010222;
        Thu, 30 Aug 2018 08:28:16 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 01:28:15 -0700
Date:   Thu, 30 Aug 2018 11:28:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Krause <xerofoify@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:fwserial:Fix parentheses alignment in fwserial.c
Message-ID: <20180830082808.ylputgri7oit7jvo@mwanda>
References: <20180829220326.7447-1-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829220326.7447-1-xerofoify@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:03:26PM -0400, Nicholas Krause wrote:
> Fix a checkpatch warning for the file, fwserial.c that warns about
> alignment between parentheses and the line belows code not being
> properly aligned with each other.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/staging/fwserial/fwserial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
> index fa0dd425b454..f9fcabe7afa1 100644
> --- a/drivers/staging/fwserial/fwserial.c
> +++ b/drivers/staging/fwserial/fwserial.c
> @@ -1328,7 +1328,7 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
>  	if (state == -1) {
>  		set_bit(STOP_TX, &port->flags);
>  		ret = wait_event_interruptible_timeout(port->wait_tx,
> -					       !test_bit(IN_TX, &port->flags),
> +						       !test_bit(IN_TX, &port->flags),
>  					       10);

Now it goes over 80 characters and the "10);" isn't aligned properly.
The original is fine.

regards,
dan carpenter

