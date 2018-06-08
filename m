Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LcOeKCdjGlt5HAAAmS7hNA
	; Fri, 08 Jun 2018 11:06:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8AC4B608B8; Fri,  8 Jun 2018 11:06:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCKOCBau"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 123E5607A4;
	Fri,  8 Jun 2018 11:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 123E5607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeFHLGM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:06:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHLGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:06:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w58B28rk121626;
        Fri, 8 Jun 2018 11:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=CxYSE9rnbEorIhd3GcnpfH3+ZL4QDyckl+yttqcX6+c=;
 b=lCKOCBauCidrpUIFbWKjy1prf56G4qipwG0nnm3dsb/DkRWJQhGYA/BOulgZy0ilSvpG
 YXKqHmlvsC46GF7Jphn/tam4uOdYZGrxFch023OAqHRbU9NZQdJqJPpOomDPjX+4XSJP
 gNKcHHwcrukd3FjXR0aCoaBXEfYuNuvoFLi2ezerMLGZjScsaiGBrjSUZIOUEnGHJO4f
 bkpxi7Nj4VsjilUTqDonf0EMTgGPGof1j7DSCBWr0I0u3GjilMesdqh9ddw5JzsxaDhH
 NlHU4yv2VsdUCh2VhDL1sNYA3uwlJjV7ZGZzNmm9lgUTGGFFni/KvBM/Zpji/m5umM6R tw==
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jbvypmjpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 11:06:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w58B60bh025369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 11:06:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w58B5wOt016240;
        Fri, 8 Jun 2018 11:05:59 GMT
Received: from mwanda (/41.202.241.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jun 2018 04:05:58 -0700
Date: Fri, 8 Jun 2018 14:05:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Janani Sankara Babu <jananis37@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        keescook@chromium.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Rene.Hickersberger@gmx.at,
        davem@davemloft.net
Subject: Re: [PATCH 2/4] Staging:rtl8192e Fix Comparison to False is error
 prone
Message-ID: <20180608110546.bv4hcgpeppvkxipv@mwanda>
References: <1528432436-9652-1-git-send-email-jananis37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528432436-9652-1-git-send-email-jananis37@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 12:33:56AM -0400, Janani Sankara Babu wrote:
> This patch removes comparison to False(ie. bool) in the code
> 
> Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 3c7ba33..ccd898a 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -258,7 +258,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
> 
>  	RT_TRACE(COMP_DBG, "====>rx ADDBAREQ from : %pM\n", dst);
>  	if (ieee->current_network.qos_data.active == 0  ||

Is .active the number of active or is it a boolean?  If it's boolean
then it should be changed to !ieee->current_network.qos_data.active
as well.

Keep your eyes open for stuff like this when you're doing checkpatch
fixes.

> -	    (ieee->pHTInfo->bCurrentHTSupport == false) ||
> +	    !(ieee->pHTInfo->bCurrentHTSupport) ||

Remove the parenthesis.

Same throughout.

regards,
dan carpenter
