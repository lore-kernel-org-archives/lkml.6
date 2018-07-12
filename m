Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="W84RQa+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E858720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeGLPSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:18:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44523 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGLPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:18:23 -0400
Received: by mail-qk0-f196.google.com with SMTP id v17-v6so13119842qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t05ji+T8+r7zlNZm5ihRJ1Vkm1svMZCyDSvXn/7tgXs=;
        b=W84RQa+KZqVvZRtq5dMnJ2mNjPHekdv2rP7XBheQ3NISiR3xKdB7T1zV7uigI0zq3L
         8C/uUvr0H4+EE9npDesxadR99UEoy5bISKYSLnJGMoFXikux9HjXty7KjCrzE14N0uax
         6tQFFLYTIlebDWO3qbTdUifvyH++euAgWlIlHgsQ8rVsKN37cNjWXD85n5FqPaGA3kfF
         gKh7IaFCpm84aZYxHX5YKin8xsnfi781fbRDnw1pee8Hf2O042egDzEgYSZpSGlW0GdR
         1zgNInJr08FFNG8OUNxbfqqDkRU4dfB2S3YFf4xIsWVfa8HMbFTMTEH9R3stxanLSIU7
         jfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t05ji+T8+r7zlNZm5ihRJ1Vkm1svMZCyDSvXn/7tgXs=;
        b=hlV9ZuUz/hxhLC/j0foccSFCK4tmB+X2B/L2dUAS3/i3Or7Oh19dGiYtfcqgwrZUCe
         x/2X9Hiqd/voYsJmuVYVhAUfOanP8RBJRZqd7v3tSABQfvjl0JgfDseP4OQlFjAPZyMk
         NRKqcJAuEyXge+QFsc6ujdYjxGSZuaCbxXBZyYNhQGXCJzGmOW0P1uDfSJ1womZdP3Hw
         Pof5Xs06LTXbG3kGFgVdBasitVf/WcDQhYf2/6HzQfbJUF5+0V3tbrwwW3diItHkkZB/
         JpUBDoJssat3zA5rI5NfnZwfeK3VBXPsk+C5mT4Kvro0oqeMvXiBNSdKUKS+6y3do+fe
         4k5Q==
X-Gm-Message-State: AOUpUlE5Lm5gSMEOjD3ugUywv7mbFsCrhTqOTWvOximOEHNXGEOTbcCL
        wla+ATR6yLJ3oqKcv2LPoXT9wg==
X-Google-Smtp-Source: AAOMgpd1SWu430vLlFxeZ1y97TUk6LYRm8Bd5tm3Gp/P82G4swP4aaSx02+QwQLbyxjDZYNO8omKaA==
X-Received: by 2002:a37:83c6:: with SMTP id f189-v6mr2062590qkd.47.1531408105221;
        Thu, 12 Jul 2018 08:08:25 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id d202-v6sm3279687qkb.38.2018.07.12.08.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 08:08:24 -0700 (PDT)
Date:   Thu, 12 Jul 2018 09:08:22 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180712150822.GC13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712150438.GF22502@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > +	if (uport)
> > +		spin_lock_irqsave(&uport->lock, flags);
> 
> That's the same thing as just calling uart_port_lock(), why aren't you
> doing that?

Because the compiler can't seem to "see" through the macros/ref calls,
and I get the warning I mentioned here if I use them:

https://lkml.org/lkml/2018/7/6/840

Tycho
