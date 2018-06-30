Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377CC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985C24986
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5985C24986
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeF3QJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:09:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeF3QJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:09:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E0EE93C;
        Sat, 30 Jun 2018 16:09:55 +0000 (UTC)
Date:   Sat, 30 Jun 2018 18:09:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/2] FBTFT: fb_sh: Fix alignment and style problems Fixed
 Coding style issues Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
Message-ID: <20180630160952.GB20625@kroah.com>
References: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 02:32:39PM +0000, Tamir Suliman wrote:
> ---
>  drivers/staging/fbtft/fb_sh1106.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
> index 3fc18c0..c18763b 100644
> --- a/drivers/staging/fbtft/fb_sh1106.c
> +++ b/drivers/staging/fbtft/fb_sh1106.c
> @@ -36,27 +36,27 @@ static int init_display(struct fbtft_par *par)
>  	par->fbtftops.reset(par);
>  
>  	/* Set Display OFF */
> -	write_reg(par, 0xAE);
> +		write_reg(par, 0xAE);
>  
>  	/* Set Display Clock Divide Ratio/ Oscillator Frequency */
> -	write_reg(par, 0xD5, 0x80);
> +		write_reg(par, 0xD5, 0x80);
>  
>  	/* Set Multiplex Ratio */
> -	write_reg(par, 0xA8, par->info->var.yres - 1);
> +		write_reg(par, 0xA8, par->info->var.yres - 1);
>  
>  	/* Set Display Offset */
> -	write_reg(par, 0xD3, 0x00);
> +		write_reg(par, 0xD3, 0x00);
>  
>  	/* Set Display Start Line */
> -	write_reg(par, 0x40 | 0x0);
> +		write_reg(par, 0x40 | 0x0);
>  
>  	/* Set Segment Re-map */
>  	/* column address 127 is mapped to SEG0 */
> -	write_reg(par, 0xA0 | 0x1);
> +		write_reg(par, 0xA0 | 0x1);
>  
>  	/* Set COM Output Scan Direction */
>  	/* remapped mode. Scan from COM[N-1] to COM0 */
> -	write_reg(par, 0xC8);
> +		write_reg(par, 0xC8);
>  
>  	/* Set COM Pins Hardware Configuration */
>  	if (par->info->var.yres == 64)
> @@ -70,15 +70,15 @@ static int init_display(struct fbtft_par *par)
>  		write_reg(par, 0xDA, 0x02);
>  
>  	/* Set Pre-charge Period */
> -	write_reg(par, 0xD9, 0xF1);
> +		write_reg(par, 0xD9, 0xF1);
>  
>  	/* Set VCOMH Deselect Level */
> -	write_reg(par, 0xDB, 0x40);
> +		write_reg(par, 0xDB, 0x40);
>  
>  	/* Set Display ON */
> -	write_reg(par, 0xAF);
> +		write_reg(par, 0xAF);
>  
> -	msleep(150);
> +		msleep(150);
>  
>  	return 0;
>  }
> @@ -89,8 +89,8 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
>  
>  static int blank(struct fbtft_par *par, bool on)
>  {
> -	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
> -		      __func__, on ? "true" : "false");
> +	fbtft_par_dbg(DEBUG_BLANK, par, "%s(_func_=%s)\n",
> +			__func__, on ? "true" : "false");
>  
>  	write_reg(par, on ? 0xAE : 0xAF);
>  
> -- 
> 1.8.3.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
