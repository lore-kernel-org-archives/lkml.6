Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95482C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38908204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQrwcbxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38908204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeI1U5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:57:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1U5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:57:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8SESiiA185269;
        Fri, 28 Sep 2018 14:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UlYoOP7R6YUauoXXmFc/+54fJRSxexc80fYaryv0E+Y=;
 b=lQrwcbxLSRjCjxR1p2NGtDzqO8tppg1fUTBKVAVSKkCv22GOybcg84jUNgLRRIEJm6tP
 01Wvuwp6F1hDNwtbwp9hVZ0Neqjf10BWAR7+CD1j9IPcs3GuXGwmHt6nr2tqKZC5JACA
 2RwK7ZMbHZNzAPHiCi3sWaM4YS9I4gLwdIDNPQdCsSkFP1CGunDcb2y+VSuYVA1J8Vcl
 pWsQniT8pv+UktXLP239pI1M+lFHEjVsEDRq4D/GKKP6U5xnwe7JZy0kTfsT9xt/q68L
 9hPtqW6G8qPlj1ZgBCmGE34IAlzX7yKtMqzbfZ9QCs4lOpmdNSVtuy8KV1LyGpzhm/95 dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mndpq0k3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:33:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8SEWxt6015840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:32:59 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8SEWw2F032164;
        Fri, 28 Sep 2018 14:32:59 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 07:32:58 -0700
Date:   Fri, 28 Sep 2018 17:32:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 06/13] staging:rtl8192u: Remove TxSTBC and RxSTBC - Style
Message-ID: <20180928143249.fcu3rafqaztcxd5v@mwanda>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-7-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191704.16322-7-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:57PM +0100, John Whitmore wrote:
> Remove the member variables TxSTBC and RxSTBC as neither is used in
> code.
> 
> This is a coding style change which should not impact runtime code
> execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> index 83fb8f34ccbd..52cce0dcf9a5 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> @@ -43,8 +43,6 @@ struct ht_capability_ele {
>  	u8	MimoPwrSave:2;
>  	u8	ShortGI20Mhz:1;
>  	u8	ShortGI40Mhz:1;
> -	u8	TxSTBC:1;
> -	u8	RxSTBC:2;
>  	u8	DelayBA:1;
>  	u8	MaxAMSDUSize:1;
>  	u8	DssCCk:1;

Same thing.  I suspect his is set by the firmware.

regards,
dan carpenter

