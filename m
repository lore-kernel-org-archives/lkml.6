Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E746E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551263862;
	bh=8reh5R+p3uzYPMNz4CDRZ//ESWXqumpup/0FpQODICA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CjQE32ruIOe9xg0ZOE5++IyZZOPBMItTrO8Dq/RmMqVW4VYARC8rRJqvbkDKHj9G1
	 tL1BPMS51/sGEtTH8H51OPRL9QzP83XXFhGSEvtyhDHyruwEf/MVZ3CfSyYeJIbtA1
	 X86q1FdA/CRUi9pOhWn6mbTxFX16PVbmiGL7tikE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfB0Khk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfB0Khk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:37:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACD720830;
        Wed, 27 Feb 2019 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551263859;
        bh=8reh5R+p3uzYPMNz4CDRZ//ESWXqumpup/0FpQODICA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ji7CEamFhzfgt+7UijX9olvRs13xWIVjXawRltKsP/zH8NEOwQ7GNK4p5ERwqBlP
         pReV0sRoNL4sO97ktQdLXbIEoIttnlzbCEeDpO/6wG4KfNzPBMiurS2rWcRKtW34kY
         AN2y1v3V0HSKmDcFRBqZvrZS+6Q79NBRSmU0qK7I=
Date:   Wed, 27 Feb 2019 11:37:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix driver conflict issues
Message-ID: <20190227103737.GA18663@kroah.com>
References: <20190227100622.3779-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227100622.3779-1-saumah@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:06:22PM +0800, Morris Ku wrote:
> I am an engineer in the software team at SUNIX Inc.,
> maintain SUNIX Multi-I/O Board Device driver,we plan to submit drivers to
> the kernel,therefore,i want to modify file for resolve driver conflict issue.
> ---
>  tty/serial/8250/8250_pci.c | 163 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 162 insertions(+), 1 deletion(-)

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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

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
