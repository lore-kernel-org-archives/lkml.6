Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1PuXCHOSGVtCOwAAmS7hNA
	; Thu, 07 Jun 2018 20:16:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CFE536074D; Thu,  7 Jun 2018 20:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3426F60452;
	Thu,  7 Jun 2018 20:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3426F60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeFGUQu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:16:50 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:43132 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750903AbeFGUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:16:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 00902837F24A;
        Thu,  7 Jun 2018 20:16:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: berry06_584755226b316
X-Filterd-Recvd-Size: 2087
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Jun 2018 20:16:46 +0000 (UTC)
Message-ID: <685aee141a45b09c46089a8bc777a037261ab447.camel@perches.com>
Subject: Re: [PATCH] usb: Replace empty define with do while
From: Joe Perches <joe@perches.com>
To: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Thu, 07 Jun 2018 13:16:45 -0700
In-Reply-To: <1528401911-5263-1-git-send-email-clabbe@baylibre.com>
References: <1528401911-5263-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 20:05 +0000, Corentin Labbe wrote:
> It's dangerous to use empty code define.
> Furthermore it lead to the following warning:
> "suggest braces around empty body in an « else » statement"
> 
> So let's replace emptyness by "do {} while(0)"

I also suggest renaming COUNT to something more
intelligible like INCR as the uses are all for
incrementing variables that may not exist.

> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index c8e9a48e1d51..a60d91eac771 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -237,7 +237,7 @@ struct ehci_hcd {			/* one per controller */
>  	struct ehci_stats	stats;
>  #	define COUNT(x) ((x)++)
>  #else
> -#	define COUNT(x)
> +#	define COUNT(x) do {} while (0)
>  #endif
>  
>  	/* debug files */
> diff --git a/drivers/usb/host/fotg210.h b/drivers/usb/host/fotg210.h
> index 7fcd785c7bc8..dca46d04e288 100644
> --- a/drivers/usb/host/fotg210.h
> +++ b/drivers/usb/host/fotg210.h
> @@ -179,7 +179,7 @@ struct fotg210_hcd {			/* one per controller */
>  	struct fotg210_stats	stats;
>  #	define COUNT(x) ((x)++)
>  #else
> -#	define COUNT(x)
> +#	define COUNT(x) do {} while (0)
>  #endif
>  
>  	/* debug files */
