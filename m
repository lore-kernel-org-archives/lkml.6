Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14218C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DB320883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwIgPYNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DB320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeKJCXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:23:40 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3724220818;
        Fri,  9 Nov 2018 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541781739;
        bh=nU5HawIvjE+XbE4JQJWx9wFWmUgfdXu6LR3JyHq6RNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwIgPYNqZNKVDjgGa/qwfyww9RTJBP6NiwhNR2nlbKMpUH08ktHKE70LDCWrd3Z5i
         rsl0zggXw0gEpD64HYKEDGckB+I/lZfAAfi6M3G2jXitiJpEYM4hN+R94AKmcyg0Bn
         CVNMylAbvJnStGoSb4t2bXCGEho64+xqy9BjFiYQ=
Date:   Fri, 9 Nov 2018 08:42:18 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tty: Fix whitespace before tab warnings
Message-ID: <20181109164218.GA10664@kroah.com>
References: <20181018223707.9891-1-tobin@kernel.org>
 <20181018223707.9891-2-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018223707.9891-2-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:37:01AM +1100, Tobin C. Harding wrote:
> This patch is whitespace only.
> 
> Checkpatch emits a BUNCH of warnings of type
> 
> 	WARNING: please, no spaces at the start of a line
> 	WARNING: please, no space before tabs
> 
> While these may seem trivial they hinder further cleanup efforts because
> there are so many that later cleanup touches many of the same lines,
> this makes the cleanup patches super noisy when parsed with
> checkpatch (although checkpatching this series is prohibitively noisy
> even with this patch).
> 
> In preparation for doing kernel-docs cleanup fix all the whitespace
> before tab and whitespace at start of line warnings.  We do not fix any
> that are obviously there for extra-ordinary formatting reasons.
> 
> Any line in the diff with obvious other formatting errors is fixed also
> excluding kernel-docs lines.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> 
> Actually, checkpatch is only noisy on a couple of patches from this
> set.  I ran checkpatch individually (instead of on the whole set) on
> each patch and fixed things within scope of this set while working on
> version 2 of the set.
> 
>  drivers/tty/amiserial.c                     |  43 ++++---
>  drivers/tty/hvc/hvc_console.c               |   2 +-
>  drivers/tty/ipwireless/tty.c                |   2 +-
>  drivers/tty/isicom.c                        |   4 +-
>  drivers/tty/moxa.c                          |  30 +++--
>  drivers/tty/mxser.c                         |  10 +-
>  drivers/tty/n_hdlc.c                        |  10 +-
>  drivers/tty/rocket.c                        |   8 +-
>  drivers/tty/serdev/core.c                   |   2 +-
>  drivers/tty/serial/8250/8250_dw.c           |   4 +-
>  drivers/tty/serial/amba-pl011.c             |   8 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |   8 +-
>  drivers/tty/serial/icom.c                   |   5 +-
>  drivers/tty/serial/ip22zilog.c              |   2 +-
>  drivers/tty/serial/jsm/jsm_neo.c            |   2 +-
>  drivers/tty/serial/mux.c                    |   6 +-
>  drivers/tty/serial/mxs-auart.c              |   2 +-
>  drivers/tty/serial/pmac_zilog.c             |   4 +-
>  drivers/tty/serial/pxa.c                    |  20 +--
>  drivers/tty/serial/serial_txx9.c            |   2 +-
>  drivers/tty/serial/sn_console.c             |  38 +++---
>  drivers/tty/serial/sunsab.c                 |   2 +-
>  drivers/tty/serial/sunsu.c                  |   4 +-
>  drivers/tty/serial/sunzilog.c               |   2 +-
>  drivers/tty/serial/ucc_uart.c               | 134 ++++++++++----------
>  drivers/tty/serial/vr41xx_siu.c             |   2 +-
>  drivers/tty/serial/zs.c                     |  12 +-
>  drivers/tty/sysrq.c                         |  34 ++---
>  drivers/tty/tty_baudrate.c                  |   2 +-
>  drivers/tty/tty_io.c                        |  22 ++--
>  drivers/tty/tty_ioctl.c                     |   2 +-
>  drivers/tty/tty_jobctrl.c                   |   8 +-
>  drivers/tty/vt/consolemap.c                 |   6 +-
>  drivers/tty/vt/keyboard.c                   |  29 +++--
>  drivers/tty/vt/selection.c                  |  12 +-
>  drivers/tty/vt/vt.c                         |  40 +++---
>  drivers/tty/vt/vt_ioctl.c                   |  14 +-
>  37 files changed, 271 insertions(+), 266 deletions(-)

The hard part about doing large patches like this that cross lots of
files is that it usually does not end up applying.  This patch currently
fails against 4.20-rc1 :(

But, if it were divided up into "one patch per driver" then I could have
applied the majority of them, as only a few drivers changed to require
this series to be rebased and reworked.

I really want to apply this patch series, but as-is, it just can't even
apply...  Can you rebase/break up the patches into smaller ones so that
we have a chance to get them merged eventually?

thanks,

greg k-h
