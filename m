Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF79C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D6B214E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D6B214E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeHBKsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:48:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeHBKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:48:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77BC329;
        Thu,  2 Aug 2018 08:58:17 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:58:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] staging: gasket: core: add subsystem and device info
 to error logs
Message-ID: <20180802085815.GD23992@kroah.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
 <20180802084245.239689-6-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802084245.239689-6-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:42:42AM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Identify gasket as the subsystem printing various error messages.
> Add the driver name to appropriate messages to indicate which driver
> has a problem.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 36c077fffc41c..19331feb9b09f 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -160,7 +160,7 @@ static int gasket_find_dev_slot(struct gasket_internal_desc *internal_desc,
>  	for (i = 0; i < GASKET_DEV_MAX; i++) {
>  		if (internal_desc->devs[i] &&
>  		    strcmp(internal_desc->devs[i]->kobj_name, kobj_name) == 0) {
> -			pr_err("Duplicate device %s\n", kobj_name);
> +			pr_err("gasket: Duplicate device %s\n", kobj_name);

same here with the prefix.

thanks,

greg k-h
