Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68888C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8082087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IinMVC6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8082087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH1X2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:28:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45206 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1X2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:28:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so2205380eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AeeABSgOQZA+mcEvaLBu4nLj5jhPDAhkaHbFkjDsJdQ=;
        b=IinMVC6HCi0U/Lm10MBYofmHBGn99Q+POtI0I6bcW01HizawPIQg+olJZwacxGKCtY
         363F+cJEctPxItS4czOR3snPeRp4mJo9/HGMDCpdu68oxnbd1cNb6H209+D70j3IseYp
         /KACzDbj67J4YGXTAQyomcaVyXaV5sXXq8/oMoch1dfEu7R25NDgiJzoHs7A8MDvwYLV
         BdjR+sN+SWotg7IEYQ+yrGHupdzaHVeb+u4tK4jryfdBdUp5Kx+wRy4/qYRU5E15CO4m
         SpLOLgoVPqJymysdTa++FP2ssc3Q5T9NwVqhK6+isw/4ImQ6UXMbFA8QBlQ7XfzxW8yQ
         4s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AeeABSgOQZA+mcEvaLBu4nLj5jhPDAhkaHbFkjDsJdQ=;
        b=az2pWAEnxpDyVZ0cm0kA5xZUUzD5CTjolgYm7YfI4IZxytiC8ScAZYlbQclEG19hSK
         TmcJkhhEK2+uYv+6hA1hK1OaecIsPtlq+YK8mLe4tGtciT5hLGsw2ZAKR6mf7Ktc8v8K
         b94sbFnkOmfaFizFihl0ypHGzJUn2bu+mRRbr1cydu+gAnNh9of+Qpwb2dTc33qZBNfg
         gn/2jZiNjDoiqead9dashtlEAbr1xbmPkcusVuSoOlJOmJW17PPc/ioeDU6dpBje12FB
         LnvstGTAZg2vOoMFP3iet0qYe/LeJse4BrNeV5G2mMTIjQ1n6gTVKgTAD6+25EeCMWaO
         Equw==
X-Gm-Message-State: APzg51Bg809cwGmMkkyQfSqPEikX2LdEsmCBR2Q+MLCeIWRPFICVDtRb
        CF8cabDNc0mvhM1e+ZsaclZ6FV0=
X-Google-Smtp-Source: ANB0VdYf77Ts+79JTQW4Y0HbnjgvI3lyMiNDzwwQ3A6P90Es1XzNAfy+Fdl7D9ui2YXbUX07gbwP+Q==
X-Received: by 2002:a50:f69b:: with SMTP id d27-v6mr4073652edn.103.1535484904904;
        Tue, 28 Aug 2018 12:35:04 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id b9-v6sm1005249edk.62.2018.08.28.12.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:35:04 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:35:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-ID: <20180828193502.GB4847@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-11-adobriyan@gmail.com>
 <20180828123622.GA2087@darwi-kernel>
 <20180828130440.GA6464@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828130440.GA6464@darwi-kernel>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:04:40PM +0000, Ahmed S. Darwish wrote:
> On Tue, Aug 28, 2018 at 12:36:22PM +0000, Ahmed S. Darwish wrote:
> > On Tue, Aug 28, 2018 at 02:15:01AM +0300, Alexey Dobriyan wrote:
> > > ---
> > >  fs/proc/base.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > 
> > Missing description and S-o-b. Further comments below..
> > 
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index 33f444721965..668e465c86b3 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -3549,11 +3549,11 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> > >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> > >  	     task;
> > >  	     task = next_tid(task), ctx->pos++) {
> > > -		char name[10 + 1];
> > > -		unsigned int len;
> > > +		char name[10], *p = name + sizeof(name);
> > > +
> > 
> > Multiple issues:
> > 
> > - len should be 11, as was in the original code
> >   (0xffffffff = 4294967295, 10 letters)
> > 
> > - while we're at it, let's use a constant for the '11' instead of
> >   mysterious magic numbers
> > 
> > - 'p' is clearly overflowing the stack here
> >
> 
> See below:
> 
> > >  		tid = task_pid_nr_ns(task, ns);
> > > -		len = snprintf(name, sizeof(name), "%u", tid);
> > > -		if (!proc_fill_cache(file, ctx, name, len,
> > > +		p = _print_integer_u32(p, tid);
> > > +		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,
> > 
> > You're replacing snprintf() code __that did proper len checking__
> > with code that does not. That's not good.
> > 
> > I can't see how the fourth proc_fill_cache() parameter, ``name +
> > sizeof(name)'' safely ever replace the original 'len' parameter.
> > It's a pointer value .. (!)
> >
> 
> Ok, there's a "- p" in the end, so the length looks to be Ok.
> 
> Nonetheless, the whole patch series is introducing funny code
> like:
> 
> +/*
> + * Print an integer in decimal.
> + * "p" initially points PAST THE END OF THE BUFFER!
> + *
> + * DO NOT USE THESE FUNCTIONS!
> + *
> + * Do not copy these functions.
> + * Do not document these functions.
> + * Do not move these functions to lib/ or elsewhere.
> + * Do not export these functions to modules.
> + * Do not tell anyone about these functions.
> + */
> +noinline
> +char *_print_integer_u32(char *p, u32 x)
> +{
> +       do {
> +               *--p = '0' + (x % 10);
> +               x /= 10;
> +       } while (x != 0);
> +       return p;
> +}
> 
> And thus the code using these functions is throwing invalid
> past-the-stack pointers and strings with no NULL terminators
> like there's no tomorrow...
> 
> IMHO It's an accident waiting to happen to sprinkle pointers
> like that everywhere.

It is not if people will be prohibited from moving this code to lib/ and
"improving" it by adding more parameters.

> Are we really in a super hot path to justify all that?

/proc is very slow, try profiling just about anything involving /proc.
