Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4929EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF920841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPUyLwHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CF920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeIBNew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:34:51 -0400
Received: from archlinux (82-132-217-68.dab.02.net [82.132.217.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B1520841;
        Sun,  2 Sep 2018 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535879986;
        bh=ViCL6ihUd8eloczJfs1pEvKJ/bL7gkGgiJZB2I3GKHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RPUyLwHhIFljsvl0Ijfavgs78QlyHYhrW8W48enksfqNBO90sLELIYy8rs1yMD4qR
         rLbEYFSAvFdBO4zHiVWhE1J8Xp7VIMMUWjMDqIum8qDmu6Ah7QWEfFOdxsMvcFFuqy
         qItwBiZZ4CZX5FiCyb2viglB9a0b9IAYylbVCKR0=
Date:   Sun, 2 Sep 2018 10:19:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
Subject: Re: [PATCH TRIVIAL] iio: fix position relative kernel version
Message-ID: <20180902101941.4c6534cf@archlinux>
In-Reply-To: <1535452234-13184-1-git-send-email-eugen.hristev@microchip.com>
References: <1535452234-13184-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 13:30:34 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Position relative channel type was added in 4.19 kernel version
> 
> Fixes: "3055a6cfa04ba" ("iio: Add channel for Position Relative")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied, thanks.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a5b4f22..8127a08 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -199,7 +199,7 @@ Description:
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
> -KernelVersion:	4.18
> +KernelVersion:	4.19
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Relative position in direction x or y on a pad (may be
> -- 
> 2.7.4
> 

