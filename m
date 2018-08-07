Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4ED21734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wCKmI6tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4ED21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbeHGJCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:02:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeHGJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:02:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w776nrkX120692;
        Tue, 7 Aug 2018 06:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=VTMn43oxdPjaoeH3LOk8Q8rszJN4X/7GrwGjp4hGDO0=;
 b=wCKmI6tRzhrFf93AfyVg7qzTzYLBrUxV2fmnrjnYCUVj4FS0n/mgmU3f3dmumeb6b39V
 xu0rjGpNR00WNBbVhLKaaMlJ+ouxE6zkX1Fe59ibUnzFMJrx6jhDHOVh/MwD0UrCLMHT
 oGG5yJoVURpVDvdWnj6xj0yvYqjceddPdoBXZ82c5Nd15A5+XxuLm49erym+TnDU4X6U
 rrvR0BqBhSRUmIaZNXm4cuWRF4QOm2ldwJTLvPJXsxYcdO+yCrPl/TY8deQkhO+bkR6a
 rxEt3ty08sNqsmzB4AwM6/yZQgbErbBhqGvRraKM9gni/yqu7jZzAODSeDTuE5AW+hUF xQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kn4spqtxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 06:49:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w776nrDf010700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 06:49:53 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w776nqaG020428;
        Tue, 7 Aug 2018 06:49:52 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Aug 2018 23:49:51 -0700
Date:   Tue, 7 Aug 2018 09:49:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] staging: fbtft: Changes udelay(n) to
 usleep_range(n, n + 1). - Style
Message-ID: <20180807064944.6n5cofacsbtbqsxr@mwanda>
References: <cover.1533614243.git.leobras.c@gmail.com>
 <4822329bce6607da8bd434a083724569b61210ff.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4822329bce6607da8bd434a083724569b61210ff.1533614243.git.leobras.c@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8977 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We need a commit message here.

On Tue, Aug 07, 2018 at 01:04:56AM -0300, Leonardo Brás wrote:
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c |  2 +-
>  drivers/staging/fbtft/fb_ra8875.c      |  4 ++--
>  drivers/staging/fbtft/fb_tinylcd.c     |  2 +-
>  drivers/staging/fbtft/fb_upd161704.c   | 19 +++++++++----------
>  drivers/staging/fbtft/fb_watterott.c   |  4 ++--
>  5 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index f6f30f5bf15a..c936950ce56d 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpio_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20, 21);

Is this really the right range?  It feels tight.

>  	gpio_set_value(par->gpio.reset, 1);
>  	mdelay(120);

regards,
dan carpenter

