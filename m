Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B9A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ssd2IS+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBYS5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:57:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBYS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:57:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1PInVYR177480;
        Mon, 25 Feb 2019 18:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tz0zIPjgCArlQbugO31M6fkL5Sh/SF+tAm//veYP3vM=;
 b=Ssd2IS+wwXycWwv3zxZDlxAet+1p6whYO7QkcoXyg8298HxaOFXGLcf9gD2vSZHGHHvR
 mxsSatJAOFJTsgYZv+3fyA+NDgTC7zxiQKwWU0tPSqDUCR57HmXXYaxp2BrM2cwPMFDL
 zKOoTkwACVl1/B9nFu/oJt/CN8Z5YJOYwsWdwBAIMOEPE/lVk9XwYdknfPImJ8ja1K32
 /6C4KBiEttkW54uAlP6bXbLgFHkaxtY3inesuIvQamuBB92p6WYr91jn/fhLHHKzrKrZ
 YGgzajL0SHkewaai0FuvZpFmph/lVA19S/Wkxqgi/XG8jmw2IsWOFPK7o/NHhOTDvv5H cw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qtwku01b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 18:57:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1PIvL4q018051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 18:57:22 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1PIvLoN014430;
        Mon, 25 Feb 2019 18:57:21 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 10:57:21 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id CB6436A0128; Mon, 25 Feb 2019 13:57:19 -0500 (EST)
Date:   Mon, 25 Feb 2019 13:57:19 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH RFC 20/39] xen-blkback: module_exit support
Message-ID: <20190225185719.GA16013@char.us.oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-21-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220201609.28290-21-joao.m.martins@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:15:50PM +0000, Joao Martins wrote:
> 
> Implement module_exit to allow users to do module unload of blkback.
> We prevent users from module unload whenever there are still interfaces
> allocated, in other words, do module_get on xen_blkif_alloc() and
> module_put on xen_blkif_free().

This patch looks like it can go now in right?

> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/block/xen-blkback/blkback.c |  8 ++++++++
>  drivers/block/xen-blkback/common.h  |  2 ++
>  drivers/block/xen-blkback/xenbus.c  | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..d51d88be88e1 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1504,5 +1504,13 @@ static int __init xen_blkif_init(void)
>  
>  module_init(xen_blkif_init);
>  
> +static void __exit xen_blkif_exit(void)
> +{
> +	xen_blkif_interface_exit();
> +	xen_blkif_xenbus_exit();
> +}
> +
> +module_exit(xen_blkif_exit);
> +
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_ALIAS("xen-backend:vbd");
> diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> index 1d3002d773f7..3415c558e115 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -376,8 +376,10 @@ struct phys_req {
>  	blkif_sector_t		sector_number;
>  };
>  int xen_blkif_interface_init(void);
> +void xen_blkif_interface_exit(void);
>  
>  int xen_blkif_xenbus_init(void);
> +void xen_blkif_xenbus_exit(void);
>  
>  irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
>  int xen_blkif_schedule(void *arg);
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4bc74e72c39..424e2efebe85 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -181,6 +181,8 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
>  	init_completion(&blkif->drain_complete);
>  	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
>  
> +	__module_get(THIS_MODULE);
> +
>  	return blkif;
>  }
>  
> @@ -328,6 +330,8 @@ static void xen_blkif_free(struct xen_blkif *blkif)
>  
>  	/* Make sure everything is drained before shutting down */
>  	kmem_cache_free(xen_blkif_cachep, blkif);
> +
> +	module_put(THIS_MODULE);
>  }
>  
>  int __init xen_blkif_interface_init(void)
> @@ -341,6 +345,11 @@ int __init xen_blkif_interface_init(void)
>  	return 0;
>  }
>  
> +void xen_blkif_interface_exit(void)
> +{
> +	kmem_cache_destroy(xen_blkif_cachep);
> +}
> +
>  /*
>   *  sysfs interface for VBD I/O requests
>   */
> @@ -1115,3 +1124,8 @@ int xen_blkif_xenbus_init(void)
>  {
>  	return xenbus_register_backend(&xen_blkbk_driver);
>  }
> +
> +void xen_blkif_xenbus_exit(void)
> +{
> +	xenbus_unregister_driver(&xen_blkbk_driver);
> +}
> -- 
> 2.11.0
> 
