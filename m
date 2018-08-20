Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EB820BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EB820BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTOlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:41:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:54746 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:41:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7KBPOYx031995;
        Mon, 20 Aug 2018 06:25:26 -0500
Message-ID: <fed6012f3438f996cd2e7cb62e8eee58964fa36c.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <pmac@au1.ibm.com>
Date:   Mon, 20 Aug 2018 21:25:24 +1000
In-Reply-To: <20180820080629.i7y4cx4wewmcyqpk@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
         <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
         <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
         <20180820080629.i7y4cx4wewmcyqpk@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 10:06 +0200, Wolfram Sang wrote:
> 
> > Some people still use those old machines, I'll give a try at fixing the
> > driver.
> 
> I did this here a while ago [1] ("macintosh: therm_windtunnel: drop
> using attach adapter")...
> 
> > Paul: Do you still have one of these machines ?
> 
> ... but this was the main problem. I couldn't find anyone to test this.
> Even asked on PPC lists of various distributions.

Yeah this one is annoying because it's only used by one specific
machine model..

> Note that we did apply the same approach of patch [1] already in commit
> ac397c80de89 ("ALSA: ppc: keywest: drop using attach adapter"). This has
> been tested on HW. I also have a hack to make this driver probe on one
> of my ARM boards. Of course, no real HW present there, but shows that
> the new probing works at least there.
> 
> This is very interesting timing, too. Because I wanted to use the
> tentative version jump to 5.0 to finally get rid of this deprecated
> feature independently of the discussion here. Which would have meant
> resending the patch and arguing we have enough indications that the
> patch [1] is sane. And then I could finally remove this callback.
> 
> Thanks,
> 
>    Wolfram
> 
> [1] http://patchwork.ozlabs.org/patch/461759/

Ok, worst case we can remove the driver and re-instate it back later if
somebody complains, but I'll try to chase a machine first.

Cheers,
Ben.


