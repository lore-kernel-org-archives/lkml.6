Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FAEC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D789217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D789217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeHDXy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:54:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38271 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeHDXy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:54:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D621880680; Sat,  4 Aug 2018 23:52:20 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:52:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yann Droneaud <ydroneaud@opteya.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
Message-ID: <20180804215209.GA3201@localhost>
References: <20180718014344.1309-1-tytso@mit.edu>
 <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
 <20180718142625.GA5942@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718142625.GA5942@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed 2018-07-18 10:26:25, Theodore Y. Ts'o wrote:
> On Wed, Jul 18, 2018 at 09:22:13AM +0200, Yann Droneaud wrote:
> > 
> > The text message should explain this is only relevant during
> > initialization / early boot.
> > 
> > The config option name should state this.
> 
> There are other workarounds for hangs that happen after initialization
> / early boot, yes.  They are of varying levels of quality / safely,
> but that's neither here nor there.
> 
> However, enabling config option means that the CRNG will be
> initialized with potentially information available to the CPU
> manufacturer and/or Nation States, and this persists *after*
> initialization / early boot.  So to say, "we're perfectly safe after
> we leave initialization / early boot" is not true.

This should really be explained in the help text.

I assume that after 10 seconds of moving mouse, user is safe even when
rdrand is backoored?

(Plus, I'd say this should be kernel command line optiom, not config
option...?)

Best regards,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
