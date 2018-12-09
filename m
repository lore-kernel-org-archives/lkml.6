Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C30E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ZEhtSkiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C30E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLIV5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:57:06 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38316 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeLIV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:57:01 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so15055482ith.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/cnaM220S28BS2KbGZCXC1k1x5flclpFTmyoOR7ZIs=;
        b=ZEhtSkiXIFJ7B9+CT1JGwXwrrFhMMV1vH/w6af0khL1UB8ONozOo3ReizRsAre44A8
         Fmoz0p2q4WV1pg3WgU0U/AY2/wgfsdABgEgHCvUGOKgZ5dGV5NzY60ir107pIUjv4x6Z
         8nxWkDHbbFE/UKAzAfH5G7Luyc56RCaV6TMuzlSFoZ2caZ8JKA0ibf5GMCVBYcOygqFC
         hY1jYOpNAELy8E2IDofVpoaWBLkWK0bG7R8rfu88NRWgNY+SeWT0prFBtQTdYJ6OzzMZ
         iCfrznjp/T+QmvV4p8DnWsrxkeHyOXx32ZwiiXfa4wIM4p7RVLBPhU6bCn2x+bbsJaui
         +DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/cnaM220S28BS2KbGZCXC1k1x5flclpFTmyoOR7ZIs=;
        b=fjiicAvUI8mCpYqYlS9ljNbkmWZkoB5eBGTCw9C322EJ/7jmdwEYSDhh4x5S1p2IwN
         fzDzJ3nWmZZwUzXgZRNR4YQJ761YRbpReYZoHB9SA+jFMOHpBxklpR3Aajzv9QbDky3e
         fpfqwUN7dgkZTuDqI/nEpAsk/nF9DkWnH6DRE/k1M4QNOJmIQEgpvU0WpOrQlSr4XuFT
         yUH77fB90tRg8AS/WOO6+9wygQ1mkKulycgUGJiu4Hupi3k0VctwzQEKHNWdNoof9W7p
         B2rPVjMKrTR9NbNzVXXEcu2v3JWdFuQHjMpdcCcd660CTE6Uj3XTw2MIJBbtLcvitaMk
         CmGA==
X-Gm-Message-State: AA+aEWaqF/UaL0BpBEqTdz/xVT3yEYgmDfxcnDb0NjAL6+ezscupqfYa
        wou5OPT1VWuXlPsx2TFiFz/Q4g==
X-Google-Smtp-Source: AFSGD/UB1uWJSCyMzUdh0t9RcXO/TcSTq+dOz/wnUZrgy7jyY9BJwUcFRot9Pwpfl4HmNYpF0SI4dg==
X-Received: by 2002:a24:2e94:: with SMTP id i142mr8628721ita.157.1544392620217;
        Sun, 09 Dec 2018 13:57:00 -0800 (PST)
Received: from cisco (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id m11sm5225375itb.24.2018.12.09.13.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 13:56:59 -0800 (PST)
Date:   Sun, 9 Dec 2018 14:56:58 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209215658.GG30796@cisco>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
 <20181209214600.GC2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209214600.GC2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 09:46:00PM +0000, Al Viro wrote:
> On Sun, Dec 09, 2018 at 02:25:23PM -0700, Tycho Andersen wrote:
> 
> > > Which sparse checks do not trigger?  Explain, please - as it is, I had been
> > > unable to guess what could "specifically looks for a call instruction" refer
> > > to.
> > 
> > In sparse.c there's check_call_instruction(), which is triggered when
> > there's an instruction of OP_CALL type in the basic block. This simply
> > compares against the name of the call target to determine whether or
> > not to call check_ctu().
> 
> Oh, that Linus' experiment with "look for huge constant size argument
> to memcpy() et.al."?  Frankly, it's not only the wrong place to put the
> checks, but breaking inlining loses the _real_ "known constant size"
> checks in there.
> 
> I don't know if the check_ctu thing has ever caught a bug...  What kind of
> checks do you want to add?  Because this place is almost certainly wrong
> for anything useful...

Yeah, agreed that the static size check doesn't seem particularly
useful. I linked to these in the other mail, but the top two patches
here are what I was playing with:

https://github.com/tych0/sparse/commits/check-as-infoleaks

> If anything, I would suggest simulating this behaviour with something like
> 	if (__builtin_constant_p(size) && size > something)
> 		/* something that would trigger a warning */
> _inside_ copy_from_user()/copy_to_user() and to hell with name-recognizing
> magic...

Hmm. I wonder if we couldn't do some size checking with the argument
like this instead. Thanks for the idea, I'll play around with it.

Tycho
