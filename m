Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D25214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D25214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHBKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:47:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:47:49 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61BC374;
        Thu,  2 Aug 2018 08:57:37 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:57:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: gasket: core: move driver loaded log after
 error cases
Message-ID: <20180802085734.GB23992@kroah.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
 <20180802084245.239689-4-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802084245.239689-4-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:42:40AM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Gasket could claim to have loaded a driver and then print an error
> indicating it actually did not.  Move the driver registration message
> after the last error check.  Replace the existing "loaded successfully"
> message with this instead.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index e550c9060dcd2..2160c2de78e77 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -1759,10 +1759,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
>  	}
>  	mutex_unlock(&g_mutex);
>  
> -	pr_info("gasket: Loaded %s driver version %s, framework version %s\n",
> -		driver_desc->name, driver_desc->driver_version,
> -		GASKET_FRAMEWORK_VERSION);
> -
>  	if (desc_idx == -1) {
>  		pr_err("Too many Gasket drivers loaded: %d\n",
>  		       GASKET_FRAMEWORK_DESC_MAX);
> @@ -1810,7 +1806,10 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
>  		goto fail2;
>  	}
>  
> -	pr_info("Driver registered successfully.\n");

Same here, just drop this line.

thanks,

greg k-h
