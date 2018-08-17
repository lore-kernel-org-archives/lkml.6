Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F611C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB3218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jUb4M4vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEB3218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeHQMUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:20:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37826 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeHQMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:20:17 -0400
Received: from avalon.localnet (89-233-230-99.cust.bredband2.com [89.233.230.99])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 588DFCE;
        Fri, 17 Aug 2018 11:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534497458;
        bh=cMx5u2/lPk93KmbR1lfQlLcD10PssTzwqOtNyTJYAks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUb4M4vyxcQG2RGe4mMP24C6JCT1ncpQJF3WmGWeo5CkpQAFuJYW/CMeLiuapuJNP
         XfsYbRn++A2OTjISM3TFj9xoOwE0/TGWI7TK8hS0YApmDKISPO2kBaNH658ctyEqhw
         DtukKhMbHDZYTCmyC19eXyXxq38TDkUMZAgRtfqU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: NULL check is meaningless before debugfs_remove_recursive
Date:   Fri, 17 Aug 2018 12:18:30 +0300
Message-ID: <1783681.noYBAFkPT2@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1534477046-13795-1-git-send-email-zhongjiang@huawei.com>
References: <1534477046-13795-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong,

Thank you for the patch.

On Friday, 17 August 2018 06:37:26 EEST zhong jiang wrote:
> debugfs_remove_recursive has taken null pointer into account. so
> remove the unneeded check.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

I already have a similar patch in my tree (git://linuxtv.org/pinchartl/
media.git uvc/next) and will include it in my pull request for v4.20.

> ---
>  drivers/media/usb/uvc/uvc_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_debugfs.c
> b/drivers/media/usb/uvc/uvc_debugfs.c index 368f8f8..6995aeb 100644
> --- a/drivers/media/usb/uvc/uvc_debugfs.c
> +++ b/drivers/media/usb/uvc/uvc_debugfs.c
> @@ -128,6 +128,5 @@ void uvc_debugfs_init(void)
> 
>  void uvc_debugfs_cleanup(void)
>  {
> -	if (uvc_debugfs_root_dir != NULL)
> -		debugfs_remove_recursive(uvc_debugfs_root_dir);
> +	debugfs_remove_recursive(uvc_debugfs_root_dir);
>  }

-- 
Regards,

Laurent Pinchart



