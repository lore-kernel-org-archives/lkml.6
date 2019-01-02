Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67848C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3D42075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFRPu0hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfABLIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:08:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46228 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfABLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:08:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02B3Y4d044186;
        Wed, 2 Jan 2019 11:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=Rer7YTkVjZmBhmRXcQljAaapl/ro5OYl24kapfzBHRc=;
 b=JFRPu0hBaQ68fJyqdD7TZQDryZd+r2JDq+xm0fqmyHe7Hcz5KSLspUU1kMa6Cyg3HF36
 a5xY4kxBEUrNmiMOFj0Sf6ib2EQvGQW3pq/WBrC4kaH8dM5G9KPQQfEHjZ6RurIP/DpC
 FL9dkU3OUh4AdeFgFpjbQAsqIcRh2eGexsVHJLOIxEyv4rgtf6ZWZzXtx5MTHA3oKnDS
 N78Y6Wmdc0bNq/E6Nhmjc310vyAG5HF30x9YYA/UdZz1RgpQeb2SDi4qsDT4kBaOgadQ
 OEDuO6E6j42IaLCo8bkUWVlyq9EcERuwa7NqIxIKpa4SUZw+7z2kyxMkwmOCSiY4pgT0 Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pp0btsm2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 11:08:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02B85DW006135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 11:08:05 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02B83uB024182;
        Wed, 2 Jan 2019 11:08:03 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 03:08:03 -0800
Date:   Wed, 2 Jan 2019 14:07:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Petr =?iso-8859-1?Q?Sedl=E1k?= <hugosedlak@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Fix camel case of variable
Message-ID: <20190102110745.GJ3781@kadam>
References: <20181229225952.GA8447@PhilosophyOfMe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181229225952.GA8447@PhilosophyOfMe>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 11:59:52PM +0100, Petr Sedlák wrote:
> Replace variable uDelayUnit with u_delay_unit. Issue found by
> checkpatch.
> 
> Signed-off-by: Petr Sedlák <hugosedlak@gmail.com>
> ---
>  drivers/staging/vt6655/upc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
> index 61b3e568ff9a..384af225336a 100644
> --- a/drivers/staging/vt6655/upc.h
> +++ b/drivers/staging/vt6655/upc.h
> @@ -42,15 +42,15 @@
>  #define VNSvOutPortD(dwIOAddress, dwData) \
>  	iowrite32((u32)(dwData), dwIOAddress)
>  
> -#define PCAvDelayByIO(uDelayUnit)				\
> +#define PCAvDelayByIO(u_delay_unit)				\
>  do {								\
>  	unsigned char byData;					\
>  	unsigned long ii;					\
>  								\
> -	if (uDelayUnit <= 50) {					\
> -		udelay(uDelayUnit);				\
> +	if (u_delay_unit <= 50) {					\
> +		udelay(u_delay_unit);				\
>  	} else {						\
> -		for (ii = 0; ii < (uDelayUnit); ii++)		\
> +		for (ii = 0; ii < (u_delay_unit); ii++)		\
>  			byData = inb(0x61);			\
>  	}							\
>  } while (0)


This is a hilariously awful macro.  It reads from a register usec number
of times to introduce a delay.  :P

Just delete it and fix the callers to use normal delay functions.

regards,
dan carpenter
