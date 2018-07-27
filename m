Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578FEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171E2208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171E2208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeG0Q34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:29:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:29:55 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35DCBC93;
        Fri, 27 Jul 2018 15:07:35 +0000 (UTC)
Date:   Fri, 27 Jul 2018 17:07:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] staging: gasket: sysfs: convert to standard logging
Message-ID: <20180727150731.GA3713@kroah.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
 <20180727030737.231268-7-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727030737.231268-7-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:07:33PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Drop gasket logging calls in favor of standard logging.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.c | 73 +++++++++++++--------------
>  1 file changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
> index 1c5f7502e0d5e..418b81797e638 100644
> --- a/drivers/staging/gasket/gasket_sysfs.c
> +++ b/drivers/staging/gasket/gasket_sysfs.c
> @@ -3,7 +3,9 @@
>  #include "gasket_sysfs.h"
>  
>  #include "gasket_core.h"
> -#include "gasket_logging.h"
> +
> +#include <linux/device.h>
> +#include <linux/printk.h>
>  
>  /*
>   * Pair of kernel device and user-specified pointer. Used in lookups in sysfs
> @@ -66,7 +68,7 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
>  	int i;
>  
>  	if (!device) {
> -		gasket_nodev_error("Received NULL device!");
> +		pr_debug("%s: Received NULL device\n", __func__);

I know you are just trying to clean up the logging mess, but this type
of check isn't even needed, as it's impossible.

thanks,

greg k-h
