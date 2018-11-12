Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F202175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF+10YmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F202175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeKLPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:43:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbeKLPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:43:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id w14-v6so2410057wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mu8ESHFAz7MUsS0mhqccBVt98lKOl0d4/a0SwXZ0z8s=;
        b=ZF+10YmKlH30SYHMrCTNyouPIVmu2kEFgStMC6au6VLLLw2ZenL4UBMPw3GRSXGgT8
         2I/ozZz0pe0PiKDFGzkR/L9ObSLVqMlxeXnGAbMSBbI7qxNtNwDXuLUpgkDv5mBYAYo5
         E0P301d380Uitq8YPwuPD4fjICBlbzkTO+hRzvpuU3ysTN/ChF/j+gm3AIRgAteLjcvJ
         WwRw/isRnbUY+fGeF2R0aQWJ/J7QQrkM5dw43iloSCPj+wNhzX3Uzq0uES4RQ2Km9cJK
         ZWkhWvrU0ThzTmc17NTHDFqI8XL2MMtCCqGkCNZiYDOAMupwiV/9UqbT/IgbnSjTayEN
         xkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mu8ESHFAz7MUsS0mhqccBVt98lKOl0d4/a0SwXZ0z8s=;
        b=RdGqVbLs7go+vobuOF3fDLFoxLMqCUk0HmclCMsqCWAitGHMuTHLsCCTx33+tGhRBl
         kTscet6TNosidp1siNAi/9QGLb9YSqarKG9SuV84ljHNcRIOq2np0IUbNGqv8VGQ0roq
         pmr16IIcK4ytO5YM9qjL8OmeGvkjbPCRApaYUMCBVAjZKogOX4l1hoAmRxk4YeqUiQ67
         g3RWGuK+8nFEBawN7MA8eD+cBjix7njwe95Knc/uV7Cxvpy0wyT54N5HhaaqOlEXlT/8
         zdPIAbjOd9ndcLoiui7OXtr6e95Yof/4g+oazQm0+SVcggqskLPdVjRQ8iLEg7iSA9hL
         9rYQ==
X-Gm-Message-State: AGRZ1gKEcYY0ifyFm+2+iPiZV0ScRo3v7ML8BEZZ6/bnEa8QZusojJ9x
        8YaX+TWXwaDHhDgJrT6yaoQwr9zD
X-Google-Smtp-Source: AJdET5fgMCIjjUL7MMZlcTXvZ5MHP3f0YMlrF/ZqzqwdYhNtDImxpKoAuKbWsjpNq56isc7pPpVvmQ==
X-Received: by 2002:adf:ff10:: with SMTP id k16-v6mr16810890wrr.159.1542001936454;
        Sun, 11 Nov 2018 21:52:16 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 4-v6sm4330226wmd.18.2018.11.11.21.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:52:15 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:52:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181112055213.GA124272@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108074920.4c601ee3@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jonathan Corbet <corbet@lwn.net> wrote:

> > Even after a decade of introducing Git I still see Signed-off-by used as 
> > an Acked-by or Reviewed-by substitutes, so I'd suggest adding this small 
> > explanation as well:
> > 
> >   +   SOB chains should reflect the *real* route a patch took as it was 
> >   +   propagated to us, with the first SOB entry signalling primary
> >   +   authorship of a single author. Acks should be given as Acked-by 
> >   +   lines and review approvals as Reviewed-by lines.
> 
> If SOB means anything like what it's supposed to mean, this *can't* be a
> "local quirk" - we have to agree on it globally.

Yeah, I didn't intend this paragraph to be a local quirk - more like a 
reiteration of what the global rule already is (regardless of enforcement 
...), given the context.

I presume the cross section of readers of *both* the global documents and 
the -tip documents will be even smaller than just the readers of the -tip 
document - so some redundancy is beneficial. ;-)

In that sense the 'local' rules can also be indicators about which parts 
of the myriads of global rules the maintainers feel most strongly about, 
and are also a list of the most common problems we see in practice. Just 
repeating the very large set of global rules is counter-productive in 
that fashion. Maybe we should re-phrase and re-structure it into such a 
format, with references back to the original rules where we are just 
reiterating global rules? That would also allow the eventual inclusion of 
any clarification into the global rule.

Another aspect is that in -tip we are pretty strict about certain 
stylistic and not so stylistic details - this is partly a personal 
preference of the maintainers, and partly a maintainer workload reduction 
measure.

But level of enforcement matters and I think other trees can legitimately 
be more relaxed: when there's a lack of contributors then you *really* 
don't want to be the maintainer-from-hell who wants all i's dotted and 
all t's crossed, and you might not have the bandwidth to do it all 
yourself ...

Also I think there are and should be a lot of shades of grey when it 
comes to accepting patches, to find the right balance between pushing 
back on patches to improve quality and pulling in patches to move the 
kernel forward.

> If you want to push this into the tree in something like its current 
> form, I'm not going to resist too hard - far be it from me to say we 
> don't want more documentation!  But allow me to complain a little.
> 
> Suppose I came along with my nifty new architecture, and it dragged in 
> a whole new set of timer and interrupt subsystems that duplicated a lot 
> of what's in the kernel now, but buried a few "local quirks" deep in 
> the middle.  "Don't worry", I say, "we'll factor out the common stuff 
> later once we figure out what it is; I'd rather not deal with the 
> bikeshedding now". Correct me if I'm wrong, but I suspect I might just 
> get a response back from you.  That's not how we normally do things.
> 
> This proposal takes a similar approach to the documentation.  Changelog 
> rules, your comment rules (other than tail comments), brace rules, line 
> breaks, etc. are common stuff; if they are not well-enough documented 
> in the global docs, the fix should really be applied there.  If it 
> lands in the current form, you know as well as I do that it will almost 
> certainly stay there for years, if not indefinitely.
>
> IMO, the subsystem-specific documentation should be something that an
> existing kernel developer can use to quickly learn how to avoid surprises
> when wandering into a different subsystem.  So it should be concise and
> strongly focused on the local customs.  If we don't start that way, I'm
> afraid we'll never have that.  Then developers will miss the important
> information, and we'll reinforce the image of the kernel project as a
> collection of little fiefdoms that one wanders into at one's own risk.
> And Documentation/ will continue to be a painful mess.
> 
> </soapbox>

Yeah, so in -tip we don't do "local customs": we genuinely believe that 
*all* our rules where they go beyond the current development process 
would improve the generic kernel as well. (In fact if anyone can give 
reasons for why a particular rule is not an absolute advantage to the 
kernel we'd reconsider changing the rule.)

So your complaint is legitimate - how would you propose we handle this?

Thanks,

	Ingo
