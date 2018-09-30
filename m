Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89BC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2B206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE2B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeI3WWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:22:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeI3WWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:22:18 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27591E32;
        Sun, 30 Sep 2018 15:48:46 +0000 (UTC)
Date:   Sun, 30 Sep 2018 08:48:45 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
Message-ID: <20180930154845.GA13200@kroah.com>
References: <20180912144327.3130-1-atull@kernel.org>
 <20180912144327.3130-6-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912144327.3130-6-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Use platform_get_drvdata() in remove() function of
> the platform driver rather than dev_get_drvdata()
> to match the platform_set_drvdata in the probe().
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 51a5ac2..3fa0de2 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
>  
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +	struct fpga_region *region = platform_get_drvdata(pdev);

This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.

thanks,

greg k-h
