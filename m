Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6021CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF362070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550654964;
	bh=kahsr8IBcly43JZlDzIZALpv+IbZmVCewfSaA5nJss4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xSBvqljL4+m4J7yDLrhMGt2gBQWeL3RsDbGi1gQorB3I95Jd1CB0uMEpooY5CCN+R
	 DT83eseiO4k/EZrmnc0DRo8jq2WDtsDfC6ty2WaYXD9qMuIEonrfQdpx3oS5pV3JJT
	 f1sA5gP/kZhg1ad9cKa5Lwy146qSJr4siD9knpps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBTJ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:29:23 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:32806 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:29:21 -0500
Received: by mail-lf1-f44.google.com with SMTP id q12so17073398lfm.0;
        Wed, 20 Feb 2019 01:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTeV/4Bhs4Y0f5TSIyTFpQ8Xjuo6UVkqTkGPAs/hl+s=;
        b=TkhpXMtjdUOXrS3W9Bw/JcV2sTVEjVhh9pWM3eiay0S78yqogb7zcPhEzdaOB7DbJN
         Bjhgf0r9cTCidyJBb/09f7J/vx317W8Vi/G04oQ9v1Dt+ZpQaZuAFZH2rXoDw/hQ0O+v
         /MnKIsA4lsS1EQCOY2a4oasrhpZcU1LPWAdzq9UA0jBOZrGZaxJjr9PRd0/Q6hDPrMt9
         hK5ECXVyFkW3FDEii9vW9T7sAy/MUotwx5QNsz3/zbk570PgeTCM4M3/7HtvyUe6/bcI
         fZz8Zfu31tWhuyxUN2Q/ZSNlwkYSd9yJasiiQhu9yr5lRSWomTg/Bf6tnFsSy91eyuHz
         36bg==
X-Gm-Message-State: AHQUAuY1V+QpCVkMYQT/mWRoz1OYtYr8S3qu92GTqVn3WjjQy06P8IQh
        gG9HWih/f1/49ZgN8FRSWUI=
X-Google-Smtp-Source: AHgI3IZbEr6E0+bA4QJGzY2PdtZ9Yaps/ZWsYMrJZae/XNOnRh2bHRGcDBjrkzD79j57aUHZhkkjaw==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr20034703lfk.31.1550654958684;
        Wed, 20 Feb 2019 01:29:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c5sm3060712lja.90.2019.02.20.01.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 01:29:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gwOBs-0003lO-3y; Wed, 20 Feb 2019 10:29:20 +0100
Date:   Wed, 20 Feb 2019 10:29:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nix <nix@esperi.org.uk>
Cc:     Johan Hovold <johan@kernel.org>, Greg KH <greg@kroah.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 4.20.7: pl2303 not working (post-4.19 regression) (limited info
 so far, not yet bisected)
Message-ID: <20190220092920.GH4072@localhost>
References: <87o97bu2bt.fsf@esperi.org.uk>
 <20190216194758.GA10756@kroah.com>
 <877edytehb.fsf@esperi.org.uk>
 <20190218075851.GA4072@localhost>
 <87sgwls7xi.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgwls7xi.fsf@esperi.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:32:57AM +0000, Nix wrote:
> On 18 Feb 2019, Johan Hovold stated:
> 
> > On Sun, Feb 17, 2019 at 07:13:52PM +0000, Nix wrote:
> >> I'm still fairly sure this is a regression -- my machines are often up
> >> for a lot longer than that and I've never seen this before I upgraded to
> >> 4.20.x -- but I don't think I'm going to identify it by mindless
> >> bisection. I might have to actually *think* about it.
> >
> > I doubt it's a regression in usb-serial as essentially nothing changed
> > with respect to pl2303 or core since 4.19.
> 
> Yeah, I came to that conclusion as well.
> 
> > The -ENOSPC you're seeing is returned by the host controller to
> > indicate:
> >
> > 	This request would overcommit the usb bandwidth reserved for
> > 	periodic transfers (interrupt, isochronous).
> 
> Side note: probably not related to *this* -ENOSPC, which I've been
> seeing for a few releases now and which appears to break Chromium's U2F
> negotiation when the USB bus has sufficiently weird devices on it (like,
> uh, my wireless mouse):
> 
> <https://bugs.chromium.org/p/chromium/issues/detail?id=932699>
> 
> (I say "probably not related" because it's much older and long predates
> the pl2303 trouble.)

Yeah, hard to tell from a quick look.

> > but if you're saying you can reproduce this on "every box" it may not be
> > related to any particular host-controller driver (or USB topology).
> 
> They are all xhci, at least. The pl2303 is USB 2. One machine, a
> two-year-old Broadwell server, says:

> So the quirks are all totally different, and the controllers are quite
> different as well...

Yeah, but they are all xhci as you point out so theoretically it could
be an xhci driver regression.

Johan
