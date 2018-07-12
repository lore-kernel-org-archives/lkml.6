Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C3EB71ED
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ECC2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="GLwF5z5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ECC2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeGLSkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:40:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33905 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeGLSky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:40:54 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so24971989qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tA3HDK0TCXsaY5W6Jb7kk0KxJYXoFW2pt7zKS2PMEac=;
        b=GLwF5z5+G5ltTCXUc0G2NIn/LtbQI7Anc71F5HoeOM+kmhesX/5A24UeF+U1vSiQMQ
         9rtQvlg4H4Lw2j3RReudebkr1B9fF2XHTXtLbPMxna4rPNOuubUqO7J7M60I7jgQnmcV
         cQEi9hopdc8rEzkxpJ5hAKCgKp+Xj0dlkA2TbT+vcKGXVDU6E5CubB9UxhprK8qoy4C2
         Lnk7FnDZtnFC8gYgEFtfpx2s6pZtB/fgx+khqP+Tk83FT9RKbvhUzK8Jis83J7tQaZep
         ouUUf1580MCCP/8Ro5ZvgAwXEc+LBzkF+0MuTue8TuxCfWQeJkkGmk3p7li1wg3CkKW6
         PvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tA3HDK0TCXsaY5W6Jb7kk0KxJYXoFW2pt7zKS2PMEac=;
        b=USGImGWhsoxQmKpElY2b3PIEZ7sBNhiryjktHP4ci4Fis49D7cRvtnBzUpx+/s+2Va
         CJ42huFxBo6YYloFUlt4I5NSwU7I/GPqQ5TM3n7NK6PvhYAZWCD5c1LVuBSq0qy8vJyQ
         D79NwDhmz54BajHRVFrZkvxx4eigVlWYMUddGqsv22PBQQQjtFpp7gcibNEFpBdCI2Jm
         xOsj1nw4TqjppRhrY3l+5InL9B23vx2tu15AI089UYvQwFgrMMcURzOlrrGfmfFSSW0i
         8cnzTCDhi3548r7TClIwCDlzeyjyFzXwTW0hjw1dLoDUg1jTgfVUUXoMiEAL/LUctOKQ
         wnPA==
X-Gm-Message-State: AOUpUlHYLySKGdV7/DNMcVy8ruSwaPut1W8/PWQ+77Ol2Bh4K1vvYkMM
        5I/GlgaUozpvh+loJUycocbUVvB+
X-Google-Smtp-Source: AAOMgpem2rxD3vdiNw7mOWl//mESAyNuFRDGBEA0DFuxxogeBv4TSBK9+Dj+a+3RjGa4gDX0AgZcQw==
X-Received: by 2002:aed:258e:: with SMTP id x14-v6mr3001781qtc.308.1531420209842;
        Thu, 12 Jul 2018 11:30:09 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id c93-v6sm25603225qkh.90.2018.07.12.11.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:30:08 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:30:01 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180712183001.GE13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
 <20180712150822.GC13192@cisco.cisco.com>
 <20180712154015.GC13114@kroah.com>
 <20180712181846.GD13192@cisco.cisco.com>
 <20180712182545.GA30099@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712182545.GA30099@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 08:25:45PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 12, 2018 at 12:18:46PM -0600, Tycho Andersen wrote:
> > On Thu, Jul 12, 2018 at 05:40:15PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jul 12, 2018 at 09:08:22AM -0600, Tycho Andersen wrote:
> > > > On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > > > > > +	if (uport)
> > > > > > +		spin_lock_irqsave(&uport->lock, flags);
> > > > > 
> > > > > That's the same thing as just calling uart_port_lock(), why aren't you
> > > > > doing that?
> > > > 
> > > > Because the compiler can't seem to "see" through the macros/ref calls,
> > > > and I get the warning I mentioned here if I use them:
> > > > 
> > > > https://lkml.org/lkml/2018/7/6/840
> > > 
> > > What horrible version of gcc are you using that give you that?  Don't
> > > open-code things just because of a broken compiler.
> > 
> > I've tried with both 7.3.0 and 5.4.0. I think the reason we see this
> > here but not elsewhere in the file is because there's an actual
> > function call (free_page()) in the critical section.
> > 
> > If we move that out, something like the below patch, it all works for
> > me.
> 
> Ick.  Which version of this series had the problem?  Let me test it out
> here...

v3, if you remove the initialization of flags from both functions you
should see it.

Tycho
