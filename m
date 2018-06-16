Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF9A2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fc82SJYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF9A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeFPJGe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:06:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53546 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbeFPJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:06:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5G95CrN079816;
        Sat, 16 Jun 2018 09:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ed6szCGuqXYWWxqK7W2phjWGTwN/JrxBbbwisQuyRbQ=;
 b=fc82SJYCqLo2CrnYAuYx/NmzuklyJzx9JnQ2xo/dTQw0lAZgsqDfZ44fPGixcyWBpBSc
 ZOsfb6YPYa8IXb0j+N6fpKdjoKi+BEFV+cgOuDii4PNTk5008ekI8sMs/Y5d2K4CkywX
 YIlPjl+uySewTymixZuQfxuAkXiRdI9Texmyvvv94yi2LtbZK0MVYzNY3WJzv3WGETq/
 IoNt1O3KaU9JJYyI3EOyV7xy87jHiMX4da/W4LLOJPFXw5DM7FKrR7AcYn8ffLm7gcFw
 fAl5jLRR4QshHQOziqmGuszm/rKX4TTufxmyAW7jhB/UZvyHUb3wTwDFP+KBy8JWMlqz uA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2m8gb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 09:06:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5G96O0X024834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 09:06:25 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5G96NwH003235;
        Sat, 16 Jun 2018 09:06:23 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Jun 2018 02:06:22 -0700
Date:   Sat, 16 Jun 2018 12:06:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "JoonHwan.Kim" <spilit464@gmail.com>
Cc:     alan@linux.intel.com, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: staging: atomisp: add a blank line after
 declarations
Message-ID: <20180616090609.s5s4q2ri7e2x24oo@mwanda>
References: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806160112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:30:48PM +0900, JoonHwan.Kim wrote:
> @@ -1656,6 +1659,7 @@ static void atomisp_pause_buffer_event(struct atomisp_device *isp)
>  /* invalidate. SW workaround for this is to set burst length */
>  /* manually to 128 in case of 13MPx snapshot and to 1 otherwise. */
>  static void atomisp_dma_burst_len_cfg(struct atomisp_sub_device *asd)
> +
>  {

This isn't right.

regards,
dan carpenter

