Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D678C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBDC21841
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQy87ahJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfBJMqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:46:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39266 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:46:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id o6so9177159qtk.6;
        Sun, 10 Feb 2019 04:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhOXkZX8DvIeXkLgANmgfAGpjEeXnSHUdDX4+pAqzns=;
        b=kQy87ahJhd+XqEg/LjOzjuWmGxcN66zhkubDqtPLwpTkJwuLHTpJboUIwSFCDjpBND
         uzGkvd9kXBN42fl/nnMHJbylWlHm0rc+aiSRRms6W1y63JveNN7lcaozG1vOkojwjQ8K
         4dKbt/5fgY+3tgMv+n4+jHq/8ABN/wI0kwqcDiYGnRm3HozLi5/6CPcC5nk5YaD/Zlgn
         y30UwRGq6H0aRrV0dMT9qIpDZp+Uxa9hiqyrzkU3pFLOFMU/NFKgm1NUO2xISSOMLxoM
         zV1/2POPUFtaihYzsP2dIFylO66Y+z0chtghaCMjK5ccYpCNrMRtIL0ppKpghrc6qCd8
         WDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhOXkZX8DvIeXkLgANmgfAGpjEeXnSHUdDX4+pAqzns=;
        b=WhwYdDWTuK2S2BuRQdZEqZFSpf1pcca5L7d96STTtZXr22FHtnV1kHL+ipEX+9tN2n
         kPxothpoymFdTIuSQ9GoK+ZunfDuanABUFhrn0FV+Um0c1yuXk1/m1bNY34sHltcIVIU
         kjZwwtiZmFbKnorPeVLLQ4TEd31JI5UCKncvqkhqP5UEMUN4xsVrQZC7UJ9tB1vhMCik
         Fzwl9/4gyQlFffqaJLehDBWiuDL5xu7ApHOgCQRYEVOMh9tguGj+2RTxZR4Au8pQx7hU
         YIazHNykj09/KlHGjGyVFP3PXpFlPhQo7fG76drCLfpwgDpHZ8GUhNjseDgMIHL/0T60
         6zDA==
X-Gm-Message-State: AHQUAuYqFXxXIGcJPq0mBOpCZMDAZBGyvK8GsD+HgNnCvnG0v0ZaacJ3
        ibWlOcHSDiLALpO9f3JRd4X5ylfo
X-Google-Smtp-Source: AHgI3Ia38HrWsG1iDe7+t/ybZWa5oVjH9eJGGXTDFFT3pAxMJMUDqmFU4SYuAqXAYKse6RqXMnnVNw==
X-Received: by 2002:ac8:3e1a:: with SMTP id z26mr23799873qtf.180.1549802780985;
        Sun, 10 Feb 2019 04:46:20 -0800 (PST)
Received: from localhost.localdomain ([168.194.160.109])
        by smtp.gmail.com with ESMTPSA id u128sm5333331qkh.66.2019.02.10.04.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 04:46:19 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 056F3180B5B; Sun, 10 Feb 2019 10:46:16 -0200 (-02)
Date:   Sun, 10 Feb 2019 10:46:16 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     julien@arista.com, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190210124616.GG13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <20190209.151217.175627323493244750.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209.151217.175627323493244750.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 03:12:17PM -0800, David Miller wrote:
> From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Date: Wed, 6 Feb 2019 18:37:54 -0200
> 
> > On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
> >> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
> >> structures longer than the current definitions.
> >> 
> >> This should prevent unjustified setsockopt() failures due to struct
> >> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
> >> binaries that should be compatible, but were built with later kernel
> >> uapi headers.
> > 
> > Not sure if we support backwards compatibility like this?
> 
> What a complete mess we have here.
> 
> Use new socket option numbers next time, do not change the size and/or
> layout of existing socket options.

What about reusing the same socket option, but defining a new struct?
Say, MYSOCKOPT supports struct mysockopt, struct mysockopt2, struct
mysockopt3...

That way we have a clear definition of the user's intent.

> 
> This whole thread, if you read it, is basically "if we compatability
> this way, that breaks, and if we do compatability this other way oh
> shit this other thing doesn't work."
> 
> I think we really need to specifically check for the difference sizes
> that existed one by one, clear out the part not given by the user, and
> backport this as far back as possible in a way that in the older kernels
> we see if the user is actually trying to use the new features and if so
> error out.

I'm afraid clearing out may not be enough, though seems it's the best
we can do so far. If the struct is allocated but not fully initialized
via a memset, but by setting its fields one by one, the remaining new
fields will be left uninitinialized.

> 
> Which, btw, is terrible behavior.  Newly compiled apps should work on
> older kernels if they don't try to use the new features, and if they

One use case here is: a given distro is using kernel X and app Foo is
built against it. Then upgrades to X+1, Foo is patched to fix an issue
and is rebuilt against X+1. The user upgrades Foo package but for
whatever reason, doesn't upgrade kernel or reboot the system. Here,
Foo doesn't work anymore until the new kernel is also running.

> can the ones that want to try to use the new features should be able
> to fall back when that feature isn't available in a non-ambiguous
> and precisely defined way.
> 
> The fact that the use of the new feature is hidden in the new
> structure elements is really rotten.
> 
> This patch, at best, needs some work and definitely a longer and more
> detailed commit message.
