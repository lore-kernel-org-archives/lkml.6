Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B1DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3432150C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xjHWSkJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3432150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeHVMiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:38:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHVMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:38:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7M8xh4e143389;
        Wed, 22 Aug 2018 09:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uN6St/J4AahnKxcFYcJrHOEoez28/2asPpw7k31cJ5o=;
 b=xjHWSkJ3wmc8p90kVYwL5iW65yaAu1AM71WS+btO4j1MDWxZVdkvvPjP72RYLeNPLI6p
 WHcQSY2GJ+HU6vaeT/qHs6f2hr5zqd13pSw+f1wP1R2LFad/J8wHUIY7+9eKdsffNIfd
 FUUDmrZqkQpO9XcfBuuBv0fsRyHBEym0vu8MvUT309ZE8u5TOYZ4iEjqxYbqlVHtPMAP
 kAr7B+tCKoIZGGtdhajaUHVxo0rAg6K9REzEWEhUKM8NzrcBj9v+0Vn+lXcHCZgN11jL
 +2ZE2VKUykdOvMSuoZ8Qoft1EIpAPqV9pWWNYQfBu29cKCanovE01+p9WzLXTuA1qX3T DQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavts7qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:13:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7M9DoXG024825
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:13:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7M9Dopb024907;
        Wed, 22 Aug 2018 09:13:50 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 02:13:49 -0700
Date:   Wed, 22 Aug 2018 12:13:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 2/4] staging: mt7621-mmc: Fix debug macro ERR_MSG and
 its usages
Message-ID: <20180822091342.kngqyebexaboo25g@mwanda>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <52fcb157ea0de00e7c08d90ebd8a5c1db3c33bae.1534923403.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fcb157ea0de00e7c08d90ebd8a5c1db3c33bae.1534923403.git.nishadkamdar@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:13:07PM +0530, Nishad Kamdar wrote:
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 04d23cc7cd4a..6b2c72fc61f2 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -466,7 +466,8 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
>  	//u8  clksrc = hw->clk_src;
>  
>  	if (!hz) { // set mmc system clock to 0 ?
> -		//ERR_MSG("set mclk to 0!!!");
> +		//dev_err(mmc_dev(host->mmc), "%d -> set mclk to 0!!!\n",
> +		//	  host->id);

Just delete commented out code.

>  		msdc_reset_hw(host);
>  		return;
>  	}

regards,
dan carpenter

