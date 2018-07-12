Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8CECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CBB2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CBB2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeGLUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:04:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbeGLUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:04:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA9CCB14;
        Thu, 12 Jul 2018 19:53:19 +0000 (UTC)
Date:   Thu, 12 Jul 2018 21:53:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felix Siegel <felix.siegel@posteo.de>
Cc:     devel@driverdev.osuosl.org, John Joseph <jnjoseph@google.com>,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>
Subject: Re: [PATCH 4/4] staging: gasket: Use __func__ instead of hardcoded
 string - Style
Message-ID: <20180712195317.GA28761@kroah.com>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
 <1531423694-22478-4-git-send-email-felix.siegel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531423694-22478-4-git-send-email-felix.siegel@posteo.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:27:15PM +0200, Felix Siegel wrote:
> Changed logging statements to use %s and __func__ instead of hard coding
> the function name in a string.
> 
> Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
> ---
>  drivers/staging/gasket/apex_driver.c       | 15 ++++++++-------
>  drivers/staging/gasket/gasket_core.c       | 11 ++++++-----
>  drivers/staging/gasket/gasket_ioctl.c      |  4 ++--
>  drivers/staging/gasket/gasket_page_table.c | 13 ++++++++-----
>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> index ffcc59d..735d43d 100644
> --- a/drivers/staging/gasket/apex_driver.c
> +++ b/drivers/staging/gasket/apex_driver.c
> @@ -341,7 +341,7 @@ static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
>  	ulong page_table_ready, msix_table_ready;
>  	int retries = 0;
>  
> -	gasket_log_error(gasket_dev, "apex_add_dev_cb.");
> +	gasket_log_error(gasket_dev, "%s.", __func__);

Function calls that do nothing but log "Look at this function I just
entered/exited!" need to just be deleted entirely, as ftrace should be
used instead.

Care to do that here, and then send a patch for the remaining messages
that do need __func__?

thanks,

greg k-h
