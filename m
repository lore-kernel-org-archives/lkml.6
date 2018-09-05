Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA08206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K35dJs+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA08206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIEMme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:42:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIEMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:42:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w858CC65102465;
        Wed, 5 Sep 2018 08:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hKRHXnsTX5yQXAD+cfR/6mWB92UFz0liaP0IFJ7+2GI=;
 b=K35dJs+XdSBtxVeMwZxbgsyJswCQCpaSfal8ejetYjb5B8ZATJe3VbD8gLFxzB0UoVK9
 N9nxBcR1o95m0FDWKdzhddsBpkp/QSBa9mKcp5y0m3VVtEaLT8JJ95XD7zLallMQwAWB
 9jTnrCyV3HX4M3QhVssHlxrceVDzlmKuBj503m5KINHlsdxZ1fx3LHcEPS4aQRbs9kFu
 a4rzo8DToB6lgjy7itWndMgTimbdV/GHZh/ILcgE56DEPVl2/9ZyghlVGDUbSUcLkGqx
 Ga6JJ78DpfTS99gvo5COOBXnrFdPmsialGubc1mbookwbbrf5zQXItZdhaZgSiyGt0aB sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m7j6tj7h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 08:13:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w858DOEx013428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 08:13:24 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w858DNvw005846;
        Wed, 5 Sep 2018 08:13:23 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 01:13:22 -0700
Date:   Wed, 5 Sep 2018 11:13:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove empty if statement in
 rtw_led.c
Message-ID: <20180905081315.bdbotkyfpdkdj537@mwanda>
References: <20180904111616.18508-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904111616.18508-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:16:15PM +0200, Michael Straube wrote:
> Remove empty if statement from 'if - else if' and replace the
> else if with if. Remove the now unused variable pmlmepriv.
> Also clears line over 80 characters and CamelCase checkpatch
> issues.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_led.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
> index cbef871a7679..39904ab284fd 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_led.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_led.c
> @@ -239,7 +239,6 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
>  {
>  	struct led_priv *ledpriv = &padapter->ledpriv;
>  	struct LED_871x *pLed = &ledpriv->SwLed0;
> -	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
>  	switch (LedAction) {
>  	case LED_CTL_POWER_ON:
> @@ -290,9 +289,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
>  		}
>  		break;
>  	case LED_CTL_SITE_SURVEY:
> -		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
> -			;
> -		} else if (!pLed->bLedScanBlinkInProgress) {
> +		if (!pLed->bLedScanBlinkInProgress) {

I think you have introduced a bug...

regards,
dan carpenter

