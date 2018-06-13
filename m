Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0D04C07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5334F20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q1ToAvQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5334F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935151AbeFMBib (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:38:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbeFMBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:38:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D1Zxu5115232;
        Wed, 13 Jun 2018 01:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=7fJ4JzlyVSqgQf6jugMidCvpuwVud0LwY/Wn6IvIA/c=;
 b=Q1ToAvQO20UInOtx9JW/yRnJoCoCv9p0b+2Au8GmRMSkQsyv7Ypi99CaTZNBSjPRyNw8
 GsrxJnPaVBSISXXg8nWPtt+jhZjLCg/tbkai7t0rBiDWDOnOxkyTfhgJUae03vpqKUMp
 STolJXt6ySVzK4GFInUcr0q4/1bQ8uT0E7cPXP1gM5pkfn/qcfh++ZUPlNVj8iAYepoC
 rW85AN9tHLEoA3vlVDtF9uD9F01gCdceQgALbLTG2Ztw05x/KcKTDwcj8Ab0QPEidjqi
 bbgGUt6/Yp+JS6kifKufUxH2E+axirRJUZ7TcCFR+WLmVPo/uahRQ10UUFnZzgfZdc5x oQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jjp6c8d2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:38:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D1cGU7005702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:38:16 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5D1cFAH012693;
        Wed, 13 Jun 2018 01:38:15 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 18:38:15 -0700
Subject: Re: [PATCH v3 6/9] xen/gntdev: Make private routines/structures
 accessible
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-7-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <fc339230-f1e1-303b-1b82-0bd23d7b69b3@oracle.com>
Date:   Tue, 12 Jun 2018 21:38:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-7-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> This is in preparation for adding support of DMA buffer
> functionality: make map/unmap related code and structures, used
> privately by gntdev, ready for dma-buf extension, which will re-use
> these. Rename corresponding structures as those become non-private
> to gntdev now.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/xen/gntdev-common.h |  86 +++++++++++++++++++++++
>   drivers/xen/gntdev.c        | 132 ++++++++++++------------------------
>   2 files changed, 128 insertions(+), 90 deletions(-)
>   create mode 100644 drivers/xen/gntdev-common.h
> 
> diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
> new file mode 100644
> index 000000000000..7a9845a6bee9
> --- /dev/null
> +++ b/drivers/xen/gntdev-common.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Common functionality of grant device.
> + *
> + * Copyright (c) 2006-2007, D G Murray.
> + *           (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
> + *           (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#ifndef _GNTDEV_COMMON_H
> +#define _GNTDEV_COMMON_H
> +
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/mmu_notifier.h>
> +#include <linux/types.h>
> +
> +struct gntdev_priv {
> +	/* maps with visible offsets in the file descriptor */
> +	struct list_head maps;
> +	/* maps that are not visible; will be freed on munmap.
> +	 * Only populated if populate_freeable_maps == 1 */


Since you are touching this code please fix comment style.


> +	struct list_head freeable_maps;
> +	/* lock protects maps and freeable_maps */
> +	struct mutex lock;
> +	struct mm_struct *mm;
> +	struct mmu_notifier mn;
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	/* Device for which DMA memory is allocated. */
> +	struct device *dma_dev;
> +#endif
> +};


With that fixed,

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

