Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811FF208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="JR78PE3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811FF208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbeGMOQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:16:31 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35503 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeGMOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:16:31 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so31414435iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pko1GoJ1pOfD30f/OdemZYk91HK9FJtw+53DRjEwbB4=;
        b=JR78PE3ZNOpwsECWWZIY9D4vFDLJdSL1E47mJT38ZbGAC/6STPgRA+MEDISv6FuvxL
         tWHCA5uL1ppOIYD7Weks1CpjNKRY1Lo9KnOaLUeHvxQiJKK1Dyrawn3KPMXXnYEiYgtj
         +lWGxK1Vc1UxsWPy9+balxcm/pJwvxATNxWsInlPN9flri/0cY6f+A4VLqpoOUS6eyUZ
         qKUFynl5WYpHobFsPWigYeR/U+/H3VVKlKXjPlm7nxdX5wP6lIjZagIMUSnLG7yDTRTV
         5iudr4gNW+nR2hzaCsdGL7ybKgaFtSjwY3yGMxDRsD7H8CnPJLh+uN23yJ9IZilOty1B
         rrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pko1GoJ1pOfD30f/OdemZYk91HK9FJtw+53DRjEwbB4=;
        b=RD2GIVj/CroDuf/niV+CrQ7qrfvusleAYl3KdEhbFkEPtbdjqR7Alx3uZqcSlVqUJd
         9ZDNiiwomsEOk+YveDlidGAYbtmDw2I64Oq4SRLGtm9LidRuPHBmDHHn6wlADSHIqCjs
         KUNWzpt2ojz6QWyVMKq7n/OOIg0wcy63pzXD4InVe/dxXHN7sNRTyviToyL0IHniYU9j
         fhaZ8im/CggC+86AzFK1nfmKSy61FZn31bHl3vD5wX6tlhKuv3A8JA0nf2+vTIwNR0mA
         cV1JlVB+VrO5m0NlXlSbQqwgn+cnPtHX4Ca+EbMvYvQEuL4xg+9czw2dmpkw6fP+yfRC
         D7Kg==
X-Gm-Message-State: APt69E2TKdp6y3gDlZ2DazgeqsbiM1havZVzW7R/Gn2Uew5R7e0sa4u8
        sUH0PL1vHOnIJn0kiQqnBLEmy7bF
X-Google-Smtp-Source: AAOMgpcK+RyWShvonZcKF/GSgMIvVQ9d24RFIvW+8kifGojaloZ3LIHS6VO2Xlg7eGOF4kktELf6cA==
X-Received: by 2002:a6b:97c6:: with SMTP id z189-v6mr29537268iod.41.1531490504120;
        Fri, 13 Jul 2018 07:01:44 -0700 (PDT)
Received: from cisco.cisco.com ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id u15-v6sm10784200iog.62.2018.07.13.07.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 07:01:43 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:01:42 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180713140142.GH13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
 <20180712150822.GC13192@cisco.cisco.com>
 <20180712154015.GC13114@kroah.com>
 <20180712181846.GD13192@cisco.cisco.com>
 <20180712182545.GA30099@kroah.com>
 <20180712183001.GE13192@cisco.cisco.com>
 <20180713092828.GA6589@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713092828.GA6589@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:28:28AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 12, 2018 at 12:30:01PM -0600, Tycho Andersen wrote:
> > On Thu, Jul 12, 2018 at 08:25:45PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 12, 2018 at 12:18:46PM -0600, Tycho Andersen wrote:
> > > > On Thu, Jul 12, 2018 at 05:40:15PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jul 12, 2018 at 09:08:22AM -0600, Tycho Andersen wrote:
> > > > > > On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > > > > > > > +	if (uport)
> > > > > > > > +		spin_lock_irqsave(&uport->lock, flags);
> > > > > > > 
> > > > > > > That's the same thing as just calling uart_port_lock(), why aren't you
> > > > > > > doing that?
> > > > > > 
> > > > > > Because the compiler can't seem to "see" through the macros/ref calls,
> > > > > > and I get the warning I mentioned here if I use them:
> > > > > > 
> > > > > > https://lkml.org/lkml/2018/7/6/840
> > > > > 
> > > > > What horrible version of gcc are you using that give you that?  Don't
> > > > > open-code things just because of a broken compiler.
> > > > 
> > > > I've tried with both 7.3.0 and 5.4.0. I think the reason we see this
> > > > here but not elsewhere in the file is because there's an actual
> > > > function call (free_page()) in the critical section.
> > > > 
> > > > If we move that out, something like the below patch, it all works for
> > > > me.
> > > 
> > > Ick.  Which version of this series had the problem?  Let me test it out
> > > here...
> > 
> > v3, if you remove the initialization of flags from both functions you
> > should see it.
> 
> Ok, I tried v3 out and yes, you are right, removing the "= 0" causes gcc
> to complain.  The compiler is being dumb here, so I'll just leave it
> as-is.  I've queued up the v3 version now, thanks for sticking with
> this.

Great, thanks!

Tycho
