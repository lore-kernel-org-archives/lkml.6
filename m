Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C83204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C83204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIJN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:28:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:27:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 885D3D2A;
        Mon, 10 Sep 2018 08:35:04 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:35:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: comedi: Correct multiline dereference as
 per TODO
Message-ID: <20180910083502.GB29149@kroah.com>
References: <CAPMnawsnkBnRM--55G7tgJtZFKyn7VsCbWQ3jxssehznhA=_Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMnawsnkBnRM--55G7tgJtZFKyn7VsCbWQ3jxssehznhA=_Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:32:17PM -0400, Ray Clinton wrote:
> Using checkpatch.pl I was able to find a multiline dereference which goes
> again the coding style for the kernel. I'm still working on my email client so
> the indentation looks bad here (in gmail) but the arguments for
> comedi_check_trigger_arg_min should go just under the opening (
> 
> Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
> ---
>  drivers/staging/comedi/drivers/ni_labpc_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_labpc_common.c
> b/drivers/staging/comedi/drivers/ni_labpc_common.c
> index 7fa2d39..0fad809 100644
> --- a/drivers/staging/comedi/drivers/ni_labpc_common.c
> +++ b/drivers/staging/comedi/drivers/ni_labpc_common.c
> @@ -560,10 +560,10 @@ static int labpc_ai_cmdtest(struct comedi_device *dev,
>         /* make sure scan timing is not too fast */
>         if (cmd->scan_begin_src == TRIG_TIMER) {
>                 if (cmd->convert_src == TRIG_TIMER) {
> -                       err |= comedi_check_trigger_arg_min(&cmd->
> -                                                           scan_begin_arg,
> -                                                           cmd->convert_arg *
> -                                                           cmd->chanlist_len);
> +                       err |= comedi_check_trigger_arg_min(
> +                                                          &cmd->scan_begin_arg,
> +                                                          cmd->convert_arg *
> +                                                          cmd->chanlist_len);

Ick, this is still messy, just try making this:

			err |= comedi_check_trigger_arg_min(&cmd->scan_begin_arg,
							    cmd->convert_arg * cmd->chanlist_len);

Yeah, it's over 80 columns, but it looks better and is easier to read,
right?

Also, all your patches have the whitespace turned from tabs into spaces,
making them impossible to be applied even if I wanted to :)

thanks,

greg k-h
