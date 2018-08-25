Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7642C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DF8206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Omkkn3F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DF8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHYKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 06:53:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeHYKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 06:53:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7P7EGS2122828;
        Sat, 25 Aug 2018 07:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JTjxeJWwfMAtI0V6+t7nnC36RQAkLVsmhcKxpu8E+mY=;
 b=Omkkn3F+mHywggQ2QizH7pKaKtKm4ttqH2QM0sSh3874HCIW9OJC6gHplJdsHt65TJKK
 w0H7wkHelmQI7MtoOzSTbLh79hGpiZBwX2ULy/S+Ie1dc65QtDgHITAWk2+wGckmNACY
 9rCBb41tAIdA3J95JDddoVVkjlERlQr6ogbH/rLfUfysA49AdoG7X5PUIhflVhB6aMZr
 G2nDC3SRWfA4eQq/hkgZyOScoOs8Ogfh8VffvC363E5IPvLGDkoM3kYoGdHlTfncDrZy
 7R4e/Oa5JNddLi3tYfCxrejI9KfD2MncJ9tpwJOuUPzXO4y4+kzHE/J+G6DpF0LYQxer PQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m2xht89b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 07:15:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7P7F1jJ024574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 07:15:01 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7P7Ewe4003240;
        Sat, 25 Aug 2018 07:14:58 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Aug 2018 00:14:57 -0700
Date:   Sat, 25 Aug 2018 10:14:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sven Luthi <dev@svenluthi.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        abbotti@mev.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: drivers: adl_pci9118: Fixes format of
 line 1283.
Message-ID: <20180825071450.pwque6fw6vvy3sl7@mwanda>
References: <20180824210657.16926-1-dev@svenluthi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824210657.16926-1-dev@svenluthi.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808250077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 11:06:56PM +0200, Sven Luthi wrote:
> Checkpatch repored "Lines should not end with a '('" for line 1283.
> 
> Moved opening parenthesis of function on line 1283 onto next line.
> 
> Signed-off-by: Sven Luthi <dev@svenluthi.com>
> ---
>  drivers/staging/comedi/drivers/adl_pci9118.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/adl_pci9118.c b/drivers/staging/comedi/drivers/adl_pci9118.c
> index 2528ca0ede6d..07431dc9cde9 100644
> --- a/drivers/staging/comedi/drivers/adl_pci9118.c
> +++ b/drivers/staging/comedi/drivers/adl_pci9118.c
> @@ -1280,8 +1280,8 @@ static int pci9118_ai_cmdtest(struct comedi_device *dev,
>  			} else {
>  				arg = cmd->convert_arg * cmd->chanlist_len;
>  			}
> -			err |= comedi_check_trigger_arg_min(
> -				&cmd->scan_begin_arg, arg);
> +			err |= comedi_check_trigger_arg_min
> +			       (&cmd->scan_begin_arg, arg);

The original is fine.  It's probably better than the new version.
Checkpatch.pl is just a hint, not a command.

regards,
dan carpenter

