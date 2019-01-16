Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6B20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfAPRjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:39:42 -0500
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:59573 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbfAPRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:39:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CC82C1E2530;
        Wed, 16 Jan 2019 17:39:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hat12_3738f11029831
X-Filterd-Recvd-Size: 1613
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Jan 2019 17:39:39 +0000 (UTC)
Message-ID: <8b1f7aac7a3b5261f42979f6ed53713264557bf4.camel@perches.com>
Subject: Re: [PATCH 2/8] vop: Cast pointers to uintptr_t
From:   Joe Perches <joe@perches.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Date:   Wed, 16 Jan 2019 09:39:37 -0800
In-Reply-To: <20190116163253.23780-3-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
         <20190116163253.23780-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 17:32 +0100, Vincent Whitchurch wrote:
> Fix these on 32-bit:
> 
>  vop_vringh.c:711:13: error: cast from pointer to integer of different
>  size [-Werror=pointer-to-int-cast]
[]
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
[]
> @@ -497,7 +497,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
>  	vdev->desc = d;
>  	vdev->dc = (void __iomem *)d + _vop_aligned_desc_size(d);
>  	vdev->dnode = dnode;
> -	vdev->vdev.priv = (void *)(u64)dnode;
> +	vdev->vdev.priv = (void *)(uintptr_t)dnode;

trivia:

unsigned long is more commonly used in the kernel for
these casts.


