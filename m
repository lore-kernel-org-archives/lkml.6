Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725742086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547812803;
	bh=F9X5j0jVzmIAPP4MDxX1GDp7B180P4ab3PwcjVshChY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iB+d1MIKxAnjWS3lifMn4qi7g0NWeCqng5fM4SxIl23qT9L4OwVQk6t3uCYRNj91Q
	 LhzuisLi/B42rKDxe9Q4S3LhVfa63WNIDla1vxSS8VrKIvKpw422q0ZpeX/F3Zl+H7
	 yPQcqQMFC+nVNc7Dnt9H6wYT6vaB8kl1NFjpVrmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfARMAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfARMAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:00:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD5F2086D;
        Fri, 18 Jan 2019 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547812800;
        bh=F9X5j0jVzmIAPP4MDxX1GDp7B180P4ab3PwcjVshChY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBgMurFCowIShZeYb9MPGekKMAtwElEIk2Ps3ox67WIGiPSGyVkonCJpjfq5ZmYcn
         U6ArCtw+GPaNW0+TwrKTlEBuYAC4TKrcmPWZuKV/e9mZKXzZl3ITmmj8yjh7mmv08M
         CJwkQpFPGAxEDkNNasitgq8rg8fwDmcqC+iilqmg=
Date:   Fri, 18 Jan 2019 12:59:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190118115958.GA5532@kroah.com>
References: <20190114012528.2367-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114012528.2367-1-tony@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 05:25:25PM -0800, Tony Lindgren wrote:
> Hi all,
> 
> Here's a series of patches to add initial serdev support to n_gsm
> TS 27.010 line discipline.
> 
> This allows handling vendor specific protocols on top of TS 27.010 and
> allows creating simple serdev drivers where it makes sense. So far I've
> tested it with droid 4 for it's modem to provide char devices for AT
> ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.
> 
> I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
> For reference, the MFD driver is at [0], the GNSS driver at [1], and
> the Alsa ASoC driver at [2] below.

I have applied the first two patches to my tree, as those are nice
cleanups.

The last one I want some feedback from the serdev developers to verify
all is set up properly, and Johan, to see if this ends up conflicting
with the gnss code, as that would not be good.

thanks,

greg k-h
