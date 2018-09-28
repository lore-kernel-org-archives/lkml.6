Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1076E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bNyWQ4Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1076E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeI1U4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:56:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47616 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI1U4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:56:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8SESSg6184981;
        Fri, 28 Sep 2018 14:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WEhzwGiHdxfYyJFfJE2dEdATgcfRskocApAjCXznkCY=;
 b=bNyWQ4Qx6BkO8Q6/Y4laP/i4KYeucg76JNBcZ8+jB8ibMQKDN0frzRF0VYLaOy5wJe72
 g4cieKpUCeyOtWkNZUOgVdYUf2zfGjlUn83s18MM9VF7TSYzrr04xdaBs1L//e5wWhzw
 N8IflxgdG1VnhxAyIspa8XC7hhtS80xfLWYZXr23T6w2zCB3mrPYQpe+ldBMymjNkXth
 OIf4ZsYhhJrsEhV5wRsM8w3PvdKFlGF5B3o7dqBAessppEkCP54BXqlVvN85m76NM43G
 K1DG/kYlLhjRcg4I4i98gvFI0nOaSiab43gxWBtDsgFi+XZ+3ISBgLwZ0hG9rJy0f+fw GA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mndpq0jw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:31:53 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8SEVlPX031597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:31:47 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8SEVlQp032204;
        Fri, 28 Sep 2018 14:31:47 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 07:31:47 -0700
Date:   Fri, 28 Sep 2018 17:31:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/13] staging:rtl8192u: Remove AdvCoding and GreenField
 - Style
Message-ID: <20180928143140.e5fwzgdpehiw527f@mwanda>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-6-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191704.16322-6-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:56PM +0100, John Whitmore wrote:
> The member variables AdvCoding and GreenField are unused in code so
> have been removed from the structure and associated initialisation
> function.
> 
> This is a coding style change which should have no impact on runtime
> code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> index 64d5359cf7e2..83fb8f34ccbd 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> @@ -39,10 +39,8 @@ enum ht_extension_chan_offset {
>  
>  struct ht_capability_ele {
>  	//HT capability info
> -	u8	AdvCoding:1;
>  	u8	ChlWidth:1;
>  	u8	MimoPwrSave:2;
> -	u8	GreenField:1;
>  	u8	ShortGI20Mhz:1;
>  	u8	ShortGI40Mhz:1;
>  	u8	TxSTBC:1;

I feel like we discussed this before.  I'm pretty sure this comes from
the firmware and so the format can't be changed.  When I look at
rtllib_parse_mife_generic() then I think that "info_element" probably
comes from the firmware.

I wouldn't want to accept this with out someone testing it.

regards,
dan carpenter

