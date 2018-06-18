Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S/JrQ3rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD6E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbeFRMaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:30:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51806 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFRMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:30:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ICTSdC194193;
        Mon, 18 Jun 2018 12:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=PmexbElviRYbWHu8+PLJzIyzyjQ+rifJVhpMVNOo9Y0=;
 b=S/JrQ3rB5XefQxd/N4zo/qaKGOwHuwVWazEaDqk3iYIyY1I9WdlQKgIq9zks1U4YoF5r
 2Of4ICBfHdgKnJBY7XnTz7+tE6KbHTJZbZ0viAqNxseOMo64dcdxIMhTwyDsLOuAJvZC
 N3O+N1lzQtk50XdZHmYwBdho2hYOW6WXgYy30mDsqRjkYlrJq3NZSpN8MQEo7PFDrHYN
 5199BtE2qDwSLIjGiYvH9MFerEoQEpA7HdCAWXoAS7bLT5MsRq5CX2Pxrstm2q+3BvBn
 koc0V1nPz1tL1179tbsgI8a3/FgBhwx8VuElyrvM+s2w+7loSBVBfsAVvAKF6WQvaHbY +A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mbyfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 12:30:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5ICU155021314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 12:30:02 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5ICU0YI008014;
        Mon, 18 Jun 2018 12:30:00 GMT
Received: from mwanda (/197.157.0.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 05:29:59 -0700
Date:   Mon, 18 Jun 2018 15:29:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v2] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
Message-ID: <20180618122951.v55dxtjg4azezjvg@mwanda>
References: <20180618060709.14290-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618060709.14290-1-andr2000@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:07:09AM +0300, Oleksandr Andrushchenko wrote:
>  drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
>  drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 80a5115c3846..ce868ce288fb 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -436,7 +436,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
>  
>  	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>  	if (!sgt)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
>  			      cma_obj->paddr, obj->size);


If dma_get_sgtable() fails then we return NULL.

Fix that and it should be good.

regards,
dan carpenter

