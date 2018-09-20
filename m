Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181ED206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181ED206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbeITMvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:51:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeITMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:51:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13522BD4;
        Thu, 20 Sep 2018 07:09:39 +0000 (UTC)
Date:   Thu, 20 Sep 2018 09:09:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Todd Kjos <tkjos@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ARM: amba: Fix leak of driver_override attribute value
Message-ID: <20180920070937.GA9609@kroah.com>
References: <20180919234721.16042-1-tpiepho@impinj.com>
 <CAMuHMdVMbjkvEXex_Z8ELPUo8hVZucFBCd2Wy4ENpiqEaLES_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVMbjkvEXex_Z8ELPUo8hVZucFBCd2Wy4ENpiqEaLES_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:48:36AM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 20, 2018 at 1:48 AM Trent Piepho <tpiepho@impinj.com> wrote:
> > If driver_override was set when a device was released the string would
> > not be kfree'ed in amba_device_release and thus leaked when the amba
> > device was freed.
> >
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device
> binding path 'driver_override'")

Then it should also have a cc: stable, right?

thanks,

greg k-h
