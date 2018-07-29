Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA9C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0084920857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0084920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG2Vwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:52:53 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:53774 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeG2Vwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:52:53 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-68-182-nat.elisa-mobile.fi [85.76.68.182])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 6108D30028;
        Sun, 29 Jul 2018 23:21:09 +0300 (EEST)
Date:   Sun, 29 Jul 2018 23:21:09 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Staging: octeon-usb: Using defined error codes
 and applying coding style
Message-ID: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
References: <20180729124320.GA27275@kroah.com>
 <20180729143338.2251-1-tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729143338.2251-1-tsotsos@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 29, 2018 at 05:33:38PM +0300, Georgios Tsotsos wrote:
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index 3f44ac260eff..edf87d1b3609 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -2590,6 +2590,7 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
>  		}
>  	} else {
>  		pipe->next_tx_frame += pipe->interval;
> +
>  		cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);

Unrelated whitespace change...

>  	}
>  }
> @@ -2624,16 +2625,16 @@ static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
>  		cvmx_usb_write_csr32(usb,
>  				     CVMX_USBCX_HCCHARX(channel, usb->index),
>  				     usbc_hcchar.u32);
> -		return -1;
> +		return -EINVAL;
>  	} else if (hcint_xfercompl) {
>  		/*
>  		 * Successful IN/OUT with transfer complete.
>  		 * Channel halt isn't needed.
>  		 */
>  	} else {
> -		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
> +		dev_	err(dev, "USB%d: Channel %d interrupt without halt\n",
>  			usb->index, channel);

...also here. Does this even compile?

> -		return -1;
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> -- 
> 2.16.4

A.
