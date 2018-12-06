Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCF320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SYzUyOYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeLFOwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:52:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56016 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeLFOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:52:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6EioI9013135;
        Thu, 6 Dec 2018 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JNR1tyn1LqYAImmb2BHqBukemTzAOP9uiulyAtt5NGc=;
 b=SYzUyOYo5NXpmcY+vnyo+2DXIq31x+ZcrvGIUp+tr9pZVXOZmuaC4LzZ4d3FjmYTBOxM
 nFIsxpG445if9uHUr027zd0lipxDsbcWWIviwbfdYxNT3NoSuJMcmZW3JcQF/f2rw6Pp
 KoTtbiIqZXkZDZifbUB5LQ12DeKQWEKZ8Plh+N/HfoRNrM0s5dOSdEZ6HXZZo4nKoBWP
 28QmxDPL7/eafDCr3f5NpyL2wDY5wTr74i7i7smALeS0IYJGf8G5h+Z3FlroIO2o5ZcA
 OGamE+Bq3xwPXP+hka2bUf4EY79uDHMnS9+9+59rJ0fPtODzPte7wSVFebLcVWHx9H6g XA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2p3ftfck8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 14:52:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB6EqWOE022841
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 14:52:32 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6EqVt0027404;
        Thu, 6 Dec 2018 14:52:31 GMT
Received: from unbuntlaptop (/10.175.27.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 06:52:30 -0800
Date:   Thu, 6 Dec 2018 17:52:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Message-ID: <20181206145218.GQ3073@unbuntlaptop>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121154504.13052-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=519
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

I'm surprised you don't get deadlocks when you apply this patch.

On Wed, Nov 21, 2018 at 04:45:04PM +0100, Marek Szyprowski wrote:

> @@ -4020,9 +4008,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>  
>  	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
>  
> -	locked = spin_is_locked(&hsotg->lock);
> -	if (!locked)
> -		spin_lock_irqsave(&hsotg->lock, flags);
> +	spin_lock_irqsave(&hsotg->lock, flags);
>  

One of the callers is already holding the hsotg->log.  The
spin_is_locked() test would avoid the deadlock.

regards,
dan carpenter

