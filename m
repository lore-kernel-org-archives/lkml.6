Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87703C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DA21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAoKscpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5DA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeK1B5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbeK1B5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:57:31 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5683E20873;
        Tue, 27 Nov 2018 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543330760;
        bh=NUwdL+icchZXG6LdqWX9QFBpOC+OqsMzfp27wK1LX0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAoKscpufzAisAhY0Huc6h4fJY/jQOj2jlQJKjt91Rp0GCDs1Wfp8xlFTXf/Rrp/6
         7kf1iSjr1adn+byhciH8IUwxzm4Tw2kKCsICi3KZ6rx7jLOzpJ/NwL4FIBjKrSWn1I
         FURRmVbP939IGFWdLfAQ6DDoQyYFB/Et1rPbpcH8=
Date:   Tue, 27 Nov 2018 20:29:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
Message-ID: <20181127145911.GC3175@vkoul-mobl.Dlink>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
 <20181124141616.GH3175@vkoul-mobl.Dlink>
 <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-18, 22:53, Masahiro Yamada wrote:
> On Sat, Nov 24, 2018 at 11:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 12-10-18, 01:41, Masahiro Yamada wrote:
> > > 1/2: DT-binding
> > > 2/2: driver
> >
> > Applied this series, thanks
> 
> 
> Thanks.
> 
> 
> > While building I noticed that we get few warns when compiling with
> > C=1, I would prefer you fix them. Please send fixes on top of the
> > applied patches.
> 
> My code is fine.

Lets see..

> If you are talking about the following, your sparse is too old.
> Upgrade your sparse.

Not really!!

$ sparse --version
0.5.2

.. is the last released version!

Do you use from git?

> ./include/linux/overflow.h:285:13: error: undefined identifier
> '__builtin_mul_overflow'
> ./include/linux/overflow.h:285:13: error: incorrect type in conditional
> ./include/linux/overflow.h:285:13:    got void
> ./include/linux/overflow.h:287:13: error: undefined identifier
> '__builtin_add_overflow'
> ./include/linux/overflow.h:287:13: error: incorrect type in conditional
> ./include/linux/overflow.h:287:13:    got void
> ./include/linux/overflow.h:285:13: warning: call with no type!
> ./include/linux/overflow.h:287:13: warning: call with no type!

and I was also talking about:

arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
include/linux/slab.h:332:43: warning: dubious: x & !y

-- 
~Vinod
