Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE55ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543520871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFKvo4Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeGNUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:40:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36661 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeGNUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:40:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so28187178wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AePfjms38TB10R30wpdkI67uoSn3X7gUhjLBSP4FgOg=;
        b=BFKvo4BnM/TGLevX2wbEQ2DOt/6JOrwGqM5HMqwJ0+JzB26hEYbnofY7YfGDLEGEt0
         uFxwEikBHZFLU1u0SJY+exZV96qDjtB77P0SyVcjyCxPpqx7FbCm9h4RrNLxJjf8Dzrl
         Us65n3xfCgrygfHEG5u3EbHMtpl/wX/dRPEJCVLT3CsliOpOVUE569z74f98QkXrG0/k
         mTrg4Jn14x5X/b+XechOQ4yKEFDkGAW47lq1Hd1Zaa230PB1sh2zg5K0ejuTSg3eEmd2
         sZsIE2x6EIq3HIVnlAPuRbhgrDSUv/ZpQ7h0wgW1gpxBjUE8AiYZBjmtpX9uznWJQtQe
         k+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AePfjms38TB10R30wpdkI67uoSn3X7gUhjLBSP4FgOg=;
        b=hRemf+THfAolnwmiwGnE1MHOU4UiH0l/gcOBM9sczWQagrBQwzGaGv6P9VS2qShiva
         tQDVPDjpmQPK+doHo9uIKYiXTj6c+h5DdScvZX/6/CyJy3x98+P0r5Ht7u1jcU8jLTA6
         lbQ5FRdSa1lbGD0uS0wGhSnw5r/jXSc/kEbrSt+Rof6VBfrCCi7L/i/Cp9V7pjzhMOoe
         jy1s6EPUqJgjYbcIW+f6cM0Oyi3cd8Jq6/TXevxz6JJ0oe2iBhKthoYLQvUXNw0+amll
         WKe/45lpIVnqjOwgXV5lTmWVnqnVAiwx8QNGzVYJCe7Ti0v5RCHNt7lh6L7sgc0yX9IS
         ln+w==
X-Gm-Message-State: AOUpUlHvuREPkqN+SZzveJ3PZEsr0anllVwWiClsYAAnYYLRBP+6FrWv
        W1/2oEH0BCxKhRX3NmpRZAE=
X-Google-Smtp-Source: AAOMgpenl3rMSdubaISU21F9O50rWFHN27gOMbu0MkPC1XvrhthCBLqs1ZggCyWkZ44QMMcGM6qLGA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr8655504wrq.156.1531599600151;
        Sat, 14 Jul 2018 13:20:00 -0700 (PDT)
Received: from uranus.localdomain ([79.172.193.241])
        by smtp.gmail.com with ESMTPSA id u4-v6sm28513442wrt.31.2018.07.14.13.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 13:19:59 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 53073460B10; Sat, 14 Jul 2018 23:19:57 +0300 (MSK)
Date:   Sat, 14 Jul 2018 23:19:57 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-ID: <20180714201957.GB8842@uranus>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
 <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
 <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
 <87pnzpvdtd.fsf@xmission.com>
 <20180714191030.GA17877@localhost>
 <871sc5vc7n.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sc5vc7n.fsf@xmission.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:39:24PM -0500, Eric W. Biederman wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Sat, Jul 14, 2018 at 02:04:46PM -0500, Eric W. Biederman wrote:
> >> For a config option that no one has come forward with an actual real
> >> world use case for disabling, that cost seems much too high.
> >
> > The real-world use case is precisely as stated: code size, both storage
> > and RAM.
> 
> That is theoretical.  Which platform will break or feel distressed if we
> make it unconditional.  That is real world.
> 
> > I regularly encounter systems I'd *like* to put Linux in that have
> > around 1MB of storage and 1MB of RAM, or even less.
> 
> Yes.  There is so little code behind CONFIG_CHECKPOINT_RESTART that it
> won't help with that.
> 
> But if minification is the actual requirement for disabling
> CONFIG_CHECKPOINT_RESTART than CONFIG_CHECKPIONT_RESTART is properly
> behind expert and it needs to be default y instead of default n.

I happened to miss this thread, sorry. So as far as I remember it
was me who introduced this option in first place, and initially
I placed it under expert so it won't be enabled by default. Lately
we found that some of functionality introduced for criu sake actually
pretty convenient for other tools (for example vmflags reported in
procfs) so we dropped CONFIG_ option out for such blocks and merged
them into kernel directly. I won't mind if left is merged into the
kernel, there should not be that many places.
