Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195F2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32A02064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A02064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeIFOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:21:53 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:13140 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:21:53 -0400
X-IronPort-AV: E=Sophos;i="5.53,337,1531785600"; 
   d="scan'208";a="64578226"
Date:   Thu, 6 Sep 2018 10:47:12 +0100
From:   Wei Liu <wei.liu2@citrix.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
CC:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove redundant put_device
Message-ID: <20180906094712.qc2ukrtvz2jzak64@zion.uk.xensource.com>
References: <1536215590-400-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1536215590-400-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:33:10PM +0800, Ding Xiang wrote:
> device_unregister will put device, do not need to do it one more time
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/xen/xenbus/xenbus_probe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 5b47188..cfaa878 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -369,7 +369,6 @@ static void xenbus_cleanup_devices(const char *path, struct bus_type *bus)
>  		bus_for_each_dev(bus, NULL, &info, cleanup_dev);
>  		if (info.dev) {
>  			device_unregister(&info.dev->dev);
> -			put_device(&info.dev->dev);

This is to match the get_device call in cleanup_dev. It is not redundant
IMHO.

Wei.
