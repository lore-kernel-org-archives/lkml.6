Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF792154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZCVDLhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF792154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeHTMhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:37:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51350 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:37:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K9E4Tw013590;
        Mon, 20 Aug 2018 09:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3ujEzLxmBBiWqw7BGriIhkzEah/CfMg/+eNn5Oi4P1I=;
 b=lZCVDLhSu/FC6pBbLAfgsITooPCseHR1NOv38D70YfEEZ1WTbFW1lPLwBYGDwMSCmMit
 bwAirZvnl6mq35FM9yi3sKuZqOBE7cgsV/hBahcaYnrRkjxkq+Pe1IUnqb9FcoCGPcQz
 Dnjs+4TqS7ZZH8eAo8zhUl6qPh1h5dwlzt6O0Eewrv/oA3irEx/GUmdQv6b66mol7eyy
 fnEsG36oO/49QVaR7tVk4L2JSBPn5MH+tpPJBNWW0SYXZNOEic6fNFGdu/4AXCaDXwAB
 HIhXTm/GFZJnWdGFaOL+Zdq/ErGd3BpEgt6XtJPSLc174D5kmMIE+hDELihQ6aIlBDvo Xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtd8n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:22:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9MQAD010886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:22:26 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9MPtH007536;
        Mon, 20 Aug 2018 09:22:25 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 02:22:24 -0700
Date:   Mon, 20 Aug 2018 12:22:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v3] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <20180820092214.bcm77upjqn3oaj3y@mwanda>
References: <20180819100458.GA13296@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819100458.GA13296@nishad>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 03:35:02PM +0530, Nishad Kamdar wrote:
>  #define N_MSG(evt, fmt, args...)
>  /*
> -do {    \
> -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> -    } \
> -} while(0)
> -*/
> -
> -#define ERR_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> -} while (0);
> -
> -#if 1
> -//defined CONFIG_MTK_MMC_CD_POLL
> -#define INIT_MSG(fmt, args...)
> -#define IRQ_MSG(fmt, args...)
> -#else
> -#define INIT_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> -} while (0);
> -
> -/* PID in ISR in not corrent */
> -#define IRQ_MSG(fmt, args...) \
> -do { \
> -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> -} while (0);
> -#endif
> + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> + *}
> + */

I'm sorry but this patch doesn't make any sort of sense at all...

regards,
dan carpenter

