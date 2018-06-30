Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D13EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1877B24225
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1877B24225
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeF3QUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:20:34 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:41656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751113AbeF3QUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:20:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EFB85837F24C;
        Sat, 30 Jun 2018 16:20:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glove03_5b89a582b1525
X-Filterd-Recvd-Size: 2122
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jun 2018 16:20:28 +0000 (UTC)
Message-ID: <fc7149540b1e70e82adb0f2698da78ed65e45ffb.camel@perches.com>
Subject: Re: [PATCH 1/2] FBTFT: fb_sh: Fix alignment and style problems
 Fixed Coding style issues Signed-off-by: Tamir Suliman
 <tsuliman@linuxvaults.com>
From:   Joe Perches <joe@perches.com>
To:     Tamir Suliman <tsuliman@linuxvaults.com>,
        thomas.petazzoni@free-electrons.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Sat, 30 Jun 2018 09:20:27 -0700
In-Reply-To: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
References: <1530369159-23872-1-git-send-email-tsuliman@linuxvaults.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 14:32 +0000, Tamir Suliman wrote:
> ---
>  drivers/staging/fbtft/fb_sh1106.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Adding to what Greg's patchbot already wrote:

> diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
[]
> @@ -36,27 +36,27 @@ static int init_display(struct fbtft_par *par)
>  	par->fbtftops.reset(par);
>  
>  	/* Set Display OFF */
> -	write_reg(par, 0xAE);
> +		write_reg(par, 0xAE);


Nope.

You are overly indenting already correctly indented code.
Statements start in the same column unless following an
if/for/do/while/else/case.

> @@ -89,8 +89,8 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
>  
>  static int blank(struct fbtft_par *par, bool on)
>  {
> -	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
> -		      __func__, on ? "true" : "false");
> +	fbtft_par_dbg(DEBUG_BLANK, par, "%s(_func_=%s)\n",
> +			__func__, on ? "true" : "false");

Again, nope.

Here you are misaligning a multi-line continuation
which is correctly aligned to the open parenthesis.

