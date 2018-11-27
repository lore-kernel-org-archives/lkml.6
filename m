Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C186208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3xIOT4m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C186208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeK0Mle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:41:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeK0Mld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:41:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR1iBhv149997;
        Tue, 27 Nov 2018 01:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uVBzPEPkIcxGY6mU24uSp6qVrrOqadYmEYsmbcjEG6I=;
 b=3xIOT4m6rSEMDUFKEYi2hK5NFjlsB2lGX28ZISqXD/c40oOjLVSitSGTWjLEPZlUs9r1
 p6x9jzzAamllRXNNKvJ3504QKkkon9OJxzSKm78O/Hgs3rsRqpj0CJ5PYPSnccqfBh3n
 TwjMWRXpr1yEBMpEoCJ4t5KL4NK4YAVNSj3zCp7Mvjy0zkCbinlfv77wcZ6/w4lbAgQm
 +6izqdHibHTTC3PLQ2o/4dhGE3UnDpGAJ6ri82iBwUqsSJdshwY1ut+/g5ZKXJSvjj/g
 ld303Pya8lH4UHSyeDJNc1tiPuT6gFGaMOlKGmk2OzP1UA3eEW77ztqd+IXNqP6+t1N/ 7w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9r157n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 01:45:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAR1j8e2013326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 01:45:08 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAR1j8dm007246;
        Tue, 27 Nov 2018 01:45:08 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 17:45:07 -0800
Date:   Tue, 27 Nov 2018 04:44:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: emxx_udc: Added a temporary variable with
 address.
Message-ID: <20181127014458.GN2970@unbuntlaptop>
References: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
 <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:19:09AM +0100, Cristian Sicilia wrote:
> Replace the IO_ADDRESS call with a temporary variable.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index ebc622f..d55cadd 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -108,20 +108,22 @@ static void _nbu2ss_dump_register(struct nbu2ss_udc *udc)
>  
>  	dev_dbg(&udc->dev, "\n-USB REG-\n");
>  	for (i = 0x0 ; i < USB_BASE_SIZE ; i += 16) {
> -		reg_data =   _nbu2ss_readl(
> -			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i));
> +		u32 *tmp;
> +
> +		tmp = (u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i);
> +		reg_data = _nbu2ss_readl(tmp);


What problem are you trying to solve?  Shouldn't it just be:

		reg_data = _nbu2ss_readl(IO_ADDRESS(USB_BASE_ADDRESS + i));

regards,
dan carpenter

