Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23097C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E695A2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E695A2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeJCEYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:24:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJCEYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:24:19 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8EE3CB6B;
        Tue,  2 Oct 2018 21:38:55 +0000 (UTC)
Date:   Tue, 2 Oct 2018 14:38:46 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        uli+renesas@fpond.eu,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
Message-ID: <20181002213846.GA1677@kroah.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
 <CAMuHMdWdByKxivbQwWL9yF9_r8XObnZuXEZvf_9ZWKYYLWr1bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWdByKxivbQwWL9yF9_r8XObnZuXEZvf_9ZWKYYLWr1bQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:38:19AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Thu, Aug 30, 2018 at 2:54 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Due to an unfortunate oversight, commit 2d4dd0da45401c7a ("serial: sh-sci:
> > Allow for compressed SCIF address") broke earlycon on all Renesas ARM
> > platforms using a SCIF port for the serial console (R-Car, RZ/A1, RZ/G1,
> > RZ/G2 SoCs), due to an incorrect value of port->regshift.
> >
> > This patch series fixes that by reverting that commit, and a (reverse)
> > dependency.
> >
> > Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
> > separate patch.
> >
> > Thanks for applying!
> >
> > Geert Uytterhoeven (2):
> >   Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
> >   Revert "serial: sh-sci: Allow for compressed SCIF address"
> >
> >  drivers/tty/serial/sh-sci.c | 56 +++++++++++++++++++++++++++----------
> >  include/linux/serial_sci.h  |  1 +
> >  2 files changed, 42 insertions(+), 15 deletions(-)
> 
> These are now in tty-next:
> 
>     10c63443b74d1ef5 Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
>     a1c2fd7e1098ea49 Revert "serial: sh-sci: Allow for compressed SCIF address"
> 
> Can you please include them in v4.19-rc6, as they fix a regression introduced
> in v4.19-rc1?
> 
> In addition:
> 
>     3d8b43ad9c0cf023 serial: sh-sci: Add earlycon for R7S9210
> 
> (also in tty-next) enables earlycon on RZ/A2 again, as it was disabled
> by the two
> reverts above.
> 
> Thanks a lot!

Now fixed up, thanks.

greg k-h
