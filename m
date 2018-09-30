Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25546C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7014206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7014206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeI3WWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:22:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbeI3WWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:22:55 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1283E32;
        Sun, 30 Sep 2018 15:49:22 +0000 (UTC)
Date:   Sun, 30 Sep 2018 08:49:21 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
Message-ID: <20180930154921.GB13200@kroah.com>
References: <20180912144327.3130-1-atull@kernel.org>
 <20180912144327.3130-5-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912144327.3130-5-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:43:26AM -0500, Alan Tull wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Use platform_set_drvdata rather than dev_set_drvdata
> to match the platform_get_drvdata in the _remove()
> function of the platform driver.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 052a134..d6a70e4 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  		goto eprobe_free;
>  
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> -	dev_set_drvdata(dev, region);
> +	platform_set_drvdata(pdev, region);

Again, not really a bugfix :)
