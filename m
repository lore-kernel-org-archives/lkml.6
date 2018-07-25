Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB82C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF5D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWiMVQcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF5D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGZAik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:38:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbeGZAik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:38:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so6268683pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXrnPbJ6yCC73lILQmFPTI298zDMetHuylA4U932GAY=;
        b=RWiMVQcGvG558cEK/p/jiY0BmVw83zu4O0qeg+paOIMkafxRTtTXosodSP54REERln
         JbLQM2UlrDBW72m+euh3hNZi6VUWB4YECXLbdGzH3uAb1VYTFhPJWxF67Iu0PTaNZ1fh
         dUGtK9Yk0B7YW1URgPaEvILvTgsJ3QWKEj1+5Mk+JjGqMjr/AlU79q2NP2elh0IMhuvW
         oONAIGLypkDOz+pLOmnyaFGAj86LT9P9CFZyCLGxb95s859GYIwKYe7bXHnX4fnmGMVL
         dfQXyDIMkKPidZ/8RHqhKRPlCLW1hNVwMXYPOIv+pJQ4y8SO9jtTn6QmRsJQPIbVB5CL
         LUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXrnPbJ6yCC73lILQmFPTI298zDMetHuylA4U932GAY=;
        b=fC3t5UdzN0iWFo27BMrhPUCjtc8kU9lNbl/vwbitLy58c/8gjS2YV64FvGw2MWUUBN
         Jzn1ssd6k03WFYGcZNaLI/M9uPfvO4zIUUETDAsuN6Txc0IXZe/y8EiC0Z2Mb82/syqW
         uDLSK7uK5zGflBfhhOfdePdN7fUn3RA39SAo87ZZVQkVoRv8wV3hlb7lYzCaiLKgyC/M
         23V8SermBGxqR5rgkP+AyCS8kICzUdwG0YV9kX49WmhPk1z8llxivFTcmysZEckI3F+5
         VskMCM7jIZNKhi37MRmBo968aEtFAS1WDu/KwDrXwFUYa7FMr+1dNQH6m9FsPFdrZ+lq
         /TNw==
X-Gm-Message-State: AOUpUlGQe6F7wRmIWezxpVwgwypUT6O5+qx3pHPs2SOh58NXnG+EEm0M
        gNEKvtQtrssBL8/3TL9N6Hj8lyXQ
X-Google-Smtp-Source: AAOMgpdvecEwkt00osyQ/2jM/v+Tg4RhgapH6MfT/EktfQH7DDg87lembaj13U3fUAr+Rejt3XBFVg==
X-Received: by 2002:a63:a347:: with SMTP id v7-v6mr21743654pgn.182.1532561083077;
        Wed, 25 Jul 2018 16:24:43 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id i6-v6sm22181233pgc.7.2018.07.25.16.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:24:41 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:24:39 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180725232439.GA154010@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
 <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
 <20180723181350.GA58212@ban.mtv.corp.google.com>
 <20180723221002.736e0830@bbrezillon>
 <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
 <87in55po3a.fsf@notabene.neil.brown.name>
 <20180724012226.307f578d@bbrezillon>
 <87fu09pfii.fsf@notabene.neil.brown.name>
 <20180724194110.GA190016@ban.mtv.corp.google.com>
 <877elkpaoq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877elkpaoq.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 25, 2018 at 07:48:21AM +1000, NeilBrown wrote:
> On Tue, Jul 24 2018, Brian Norris wrote:
> > On Tue, Jul 24, 2018 at 11:51:49AM +1000, NeilBrown wrote:
> >> On Tue, Jul 24 2018, Boris Brezillon wrote:
> >> > On Tue, 24 Jul 2018 08:46:33 +1000
> >> > NeilBrown <neilb@suse.com> wrote:
> >> >> One possibility that occurred to me when I was exploring this issue is
> >> >> to revert to 3-byte mode whenever 4-byte was not actively in use.
> >> >> So any access beyond 16Meg is:
> >> >>  switch-to-4-byte ; perform IO ; switch to 3-byte
> >> >> or similar.  On my hardware it would be more efficient to
> >> >> use the 4-byte opcode to perform the IO, then reset the cached
> >> >> 4th address byte that the NOR chip transparently remembered.
> >
> > Do these chips cache the last 4th-byte used? I don't recall reading
> > that, but that would be interesting. It also sounds like that would make
> > things even more difficult to do robustly.
> 
> That is how the Winbond W25Q256FV appears to behave in my experiments.
> Any time you use a 4-byte address, the high byte is saved.  Any time you
> use a 3-byte address, the saved high-byte is used.
> The data sheet seems to support this understanding, as detailed in
> 
> Commit: f134fbbb4ff8 ("mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.")

Thanks for the notes. I never really paid attention to that section of
the datasheet, since I always relied on a hardware reset.

By the way, doesn't this part support the dedicated (non-stateful)
4-byte address commands? Why not use those and avoid the problem
entirely? Although, it's not actually clear to me from the datasheet
whether, e.g., Fast Read with 4-byte Address (0Ch) will set the Extended
Address Register.

> >> >> This adds a little overhead, but should be fairly robust.
> >> >> It doesn't help if something goes terribly wrong while IO is happening,
> >> >> but I don't think any other software solution does either.
> >> >> 
> >> >> How would you see that approach?
> >> >
> >> > I think the problem stands: people that have proper HW mitigation for
> >> > this problem (NOR chip is reset when the Processor is reset) don't want
> >> > to pay the overhead. So, even if we go for this approach, we probably
> >> > want to only do that for broken HW.
> >
> > If it actually saves bytes on the wire to stay in 3-byte mode more
> > often, then that could be helpful to all systems. But otherwise, yes, it
> > doesn't really belong on a properly-designed system.
> 
> I'm not sure exactly what you encompass by the term "properly-designed",

I consider all systems with >16MiB SPI flash that have stateful
addressing modes and don't have a useful HW RESET signal to be
improperly designed. These SPI flash never had a standardized (or
easily-determined) software reset, so it's nearly impossible to write
robust software for them that is compatible with a relatively generic
boot ROM and/or bootloader.

> but with the SOC that I have (mt7621) and the flash chip (Winbond
> W25Q256FV) it is not possible to wire them up in any way that will work
> reliably without software support for leaving 3-byte mode.

> The SOC does not have an out-going reset line that signals a general
> system reset - it only has one that signals watchdog reset.
> The flash chip has an incoming reset line, but it shares a pin with
> "hold", and that is the default use.  So we would need to program the

(BTW, you could probably choose to reprogram the HOLD# line to RESET#
before switching to 4-byte mode. That still doesn't resolve the SoC
reset line issue on its own.)

> flash to listen for reset, and it would only catch a watchdog reset.
> For any other reset, the CPU is (should be) in complete control (even
> after a panic!) and it needs to reprogram the flash chip before
> resetting the system.

"Even after a panic" is a bit dubious. That presumes that the cause of
the panic didn't also corrupt your exception code, driver code, driver
data structures, etc., that would be needed to reset the SPI chip
without double-faulting. And what about a panic in your SPI flash
driver?

Overall, my point is that the existence of such non-hardware-resettable
flash guarantees the possibility of a hard enough crash that you cannot
possibly reset it to 3-byte addressing before system reset.

> But maybe you think either the SOC and/or the flash chip is not
> "properly-designed" - and you may be correct..

Yes, I believe I do. If your watchdog reset pin was routed to the flash
HOLD/RESET pin, then I suppose it would be *possible* to have robust
software. But otherwise, I believe it's impossible.

Brian
