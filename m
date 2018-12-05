Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F85C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28AE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgjY+yAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28AE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeLEIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeLEIqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:46:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092DB206B7;
        Wed,  5 Dec 2018 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543999565;
        bh=L/68rIbG4jMAlNrx161Y2/eaqtv3L6sB0TXEJFVkv+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgjY+yAl7yEWWL0aQUNf28EtzqPDfM9X84Octy7JZNEyImhJqrxoFUA1WMF9XMFCf
         ZnRBuD6djFGrNsDNFYN0ruCA6VFKFxQrLv/eK4iW8nmucADT29FycHAJ3RyqI72G2Y
         kM6pR0mLkOGZ67ToRdXU5wIrMDXHvfzP3PNdaST8=
Date:   Wed, 5 Dec 2018 09:46:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Bryan O Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Align function call parameters to
 parenthesis
Message-ID: <20181205084603.GA4987@kroah.com>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <6087f45a8a4544fa6c671d8b42928fb48194e66e.1543956271.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6087f45a8a4544fa6c671d8b42928fb48194e66e.1543956271.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 09:58:14PM +0100, Cristian Sicilia wrote:
> Aligned some parameters to the previous parenthesis.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/greybus/loopback.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index e4d42c1..1085e06 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -638,7 +638,8 @@ static int gb_loopback_async_transfer(struct gb_loopback *gb, u32 len)
>  	retval = gb_loopback_async_operation(gb, GB_LOOPBACK_TYPE_TRANSFER,
>  					     request, len + sizeof(*request),
>  					     len + response_len,
> -					     gb_loopback_async_transfer_complete);
> +					     gb_loopback_async_transfer_complete
> +					     );

Ick, why do this?  That's not really needed.

thanks,

greg k-h
