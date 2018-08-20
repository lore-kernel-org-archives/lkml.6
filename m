Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7DAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7386921570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bnOvORT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHTMu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:50:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeHTMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:50:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K9Xjah028977;
        Mon, 20 Aug 2018 09:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GiLK+ODd6BXpGfgm8Mkq7jOxd86Y6qvnQm2am2tkc0s=;
 b=bnOvORT36eLfKQ5NLp4+wD3GeXdQXcniWmFHYolcKcih53763YOzL9853MWP19nc9xXb
 d5t8y+GF/vc7VHkH1Yil20xZ/b/YGI8u1ZD7pe5d4Er5eja+3s8bD2snR85vB4XItG5S
 +p7VZUP3P8YIw80NX/TXB+sB+icTpVPREgSwOcHiluWZjLfJDQnhrDQ78/zpSB6ECfYI
 Lb+6uKUmCxh7jEw+VgJZ9ZWSVzyERHRVVFt3co2EcHWdMQsb7rcqTWrGNDOG+i9bzGI0
 CV4Bgc9Nj8CaAHNdD7L2qxJCjpcsw3Xpkqa0EgRKLn6NgbbmisdYrNVhYBhhQLedrC11 nA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kxavtdaf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:35:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9Zsth028479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:35:54 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7K9Zr32012390;
        Mon, 20 Aug 2018 09:35:53 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 02:35:53 -0700
Date:   Mon, 20 Aug 2018 12:35:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Removed a function and coded inline
Message-ID: <20180820093546.whlekjpoqluqfeq2@mwanda>
References: <20180818190640.GA11687@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818190640.GA11687@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 12:36:40AM +0530, Bhaskar Singh wrote:
> This patch removed function named rtw_malloc2d.
> 
> I removed this function because this function is used exactly once and
> function call have some overhead also.
> 
> Maybe this will improve code runtime slightly.
> 
> Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_efuse.c        | 10 +++++++++-
>  drivers/staging/rtl8188eu/include/osdep_service.h |  2 --
>  drivers/staging/rtl8188eu/os_dep/osdep_service.c  | 14 --------------
>  3 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> index 0fd306a808c4..befc99c197b1 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> @@ -86,12 +86,20 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
>  	u16	**eFuseWord = NULL;
>  	u16	efuse_utilized = 0;
>  	u8 u1temp = 0;
> +	int z;

z is unusual name for an iterator.  Does it stand for something?  Just
use "int i;".

> +	void **a = NULL;

What does "a" mean in this context?  Maybe just say "void **tmp;"

>  
>  	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
>  	if (!efuseTbl)
>  		return;
>  
> -	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
> +	a = kzalloc(EFUSE_MAX_SECTION_88E * sizeof(void *) + EFUSE_MAX_SECTION_88E * EFUSE_MAX_WORD_UNIT * sizeof(u16), GFP_KERNEL);
> +	if (!a)
> +		goto out;


You can simplify the math a bit:

	tmp = kzalloc(EFUSE_MAX_SECTION_88E * (sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16)), GFP_KERNEL);

Then if it fails:

	if (!tmp)
		goto eFuseWord_failed;


regards,
dan carpenter

