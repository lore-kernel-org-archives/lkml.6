Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A789C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F28F2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F28F2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbeG0Qhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:37:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbeG0Qhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:37:53 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84720DBE;
        Fri, 27 Jul 2018 15:15:30 +0000 (UTC)
Date:   Fri, 27 Jul 2018 17:15:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/3] Staging: octeon-usb: Change coding style of
 CVMX_WAIT_FOR_FIELD32 marco.
Message-ID: <20180727151527.GA2209@kroah.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
 <37553f45bfb34de4b0af476286b1b782ea834963.1532610629.git.tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37553f45bfb34de4b0af476286b1b782ea834963.1532610629.git.tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 06:41:52PM +0300, Georgios Tsotsos wrote:
> Fixing coding style for CVMX_WAIT_FOR_FIELD32 was confusing. Also
> encapsulates into parentheses timeout_usec.
> 
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 44 +++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index cff5e790b196..c8e0ebf1434f 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -378,27 +378,29 @@ struct octeon_hcd {
>  };
>  
>  /* This macro spins on a register waiting for it to reach a condition. */
> -#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	    \
> -	({int result;							    \
> -	do {								    \
> -		u64 done = cvmx_get_cycle() + (u64)timeout_usec *	    \
> -			   octeon_get_clock_rate() / 1000000;		    \
> -		union _union c;						    \
> -									    \
> -		while (1) {						    \
> -			c.u32 = cvmx_usb_read_csr32(usb, address);	    \
> -									    \
> -			if (cond) {					    \
> -				result = 0;				    \
> -				break;					    \
> -			} else if (cvmx_get_cycle() > done) {		    \
> -				result = -1;				    \
> -				break;					    \
> -			} else						    \
> -				__delay(100);				    \
> -		}							    \
> -	} while (0);							    \
> -	result; })
> +#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	\
> +({									\
> +	int result;							\
> +	do {								\
> +		u64 done = cvmx_get_cycle() + (u64)(timeout_usec) *	\
> +			   octeon_get_clock_rate() / 1000000;		\
> +		union _union c;						\
> +									\
> +		while (1) {						\
> +			c.u32 = cvmx_usb_read_csr32(usb, address);	\
> +									\
> +			if (cond) {					\
> +				result = 0;				\
> +				break;					\
> +			} else if (cvmx_get_cycle() > done) {		\
> +				result = -1;				\
> +				break;					\
> +			} else						\
> +				__delay(100);				\
> +		}							\
> +	} while (0);							\
> +	result;								\
> +})

It's still a mess, why not just make this a function call instead?

thanks,

greg k-h
