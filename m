Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3DB20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlUhukNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3DB20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeH1Q4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:56:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51859 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Q4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:56:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so1855271wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kz4l8l10Juq9thOJIzd6rmX5hC8JoHn6ye3Xqh7rxGc=;
        b=NlUhukNa7y8smMBASwE5l4cVYjTIdm8wbiUw96hRMQWt7XeKE0Gx6BwkcmLZUbWot8
         csOJE2GXh8IEmOwQXtbmTNLfGNMLkl1yeq1CNuf999hVxq2ruLRVqHXehH55L920hbat
         eaPTDi0CKC14TmJKp1O2nf27UuiqJcdpQBaam1NiB6BxoTXxfJ7n2qWDzImuTJT4M22r
         cYSjcESX3Z2uRIpU3/GP4P0ftk/aVCbEzP5FjrpVZWPVp8z3Z/ZNwyvCoH6KS/ZnMjCo
         Rhul9M037WQt1W6QtMsp7EbSZ1a4W5nWyqEnUJmFEc+EYDx1Or1VJKxkifel43oB0gSo
         DMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kz4l8l10Juq9thOJIzd6rmX5hC8JoHn6ye3Xqh7rxGc=;
        b=c76DxUP6I9GuD83FDygggOIc1Jp5i2a2ScjG4Z7+vdVys3DgZmsrZMP7q2AhxfjGYl
         ay23Fndy7h8r3DJ8OBPOPPEDJcTC+ozovwFUSI/wJOvzjVXM1Sry7nmaVElO+7YWIwYq
         9DIpetlH6GzCt5Lm8Nt7zYftMVy5L1Zh3mOR2g/dL/qn8HCNmalYRXF8dCVyPLR8R8Se
         Zwi/HLRx00l4wICFkIUoynnC8VHLMYBBGBxHpErGCK6oXTyOC3z2GS/BMlsguy3qhsLW
         M4TP4T+WkR/3mV72VjD5goO6kSB/YO4NzQd2OZqavY4LgFyPopdvNyjcRH1hHzbIe7bh
         CkUg==
X-Gm-Message-State: APzg51Dz9/ZvkRM2zFVaAYGDDaA+9dQaPCpmE3vHu+9yjQODanenYjUL
        7dLsOAHtPFu4i7kewIz2N9E=
X-Google-Smtp-Source: ANB0VdZnudAZN0zyw/jNimZw8IQCobtGO/6E/NASa1HfhW+ZWa6It7ERV8sDSceG4DwWGvNCeDnVag==
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr1286643wme.159.1535461485968;
        Tue, 28 Aug 2018 06:04:45 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id j6-v6sm1714331wrq.25.2018.08.28.06.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:04:44 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:04:40 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-ID: <20180828130440.GA6464@darwi-kernel>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-11-adobriyan@gmail.com>
 <20180828123622.GA2087@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828123622.GA2087@darwi-kernel>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:36:22PM +0000, Ahmed S. Darwish wrote:
> On Tue, Aug 28, 2018 at 02:15:01AM +0300, Alexey Dobriyan wrote:
> > ---
> >  fs/proc/base.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> 
> Missing description and S-o-b. Further comments below..
> 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 33f444721965..668e465c86b3 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3549,11 +3549,11 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> >  	     task;
> >  	     task = next_tid(task), ctx->pos++) {
> > -		char name[10 + 1];
> > -		unsigned int len;
> > +		char name[10], *p = name + sizeof(name);
> > +
> 
> Multiple issues:
> 
> - len should be 11, as was in the original code
>   (0xffffffff = 4294967295, 10 letters)
> 
> - while we're at it, let's use a constant for the '11' instead of
>   mysterious magic numbers
> 
> - 'p' is clearly overflowing the stack here
>

See below:

> >  		tid = task_pid_nr_ns(task, ns);
> > -		len = snprintf(name, sizeof(name), "%u", tid);
> > -		if (!proc_fill_cache(file, ctx, name, len,
> > +		p = _print_integer_u32(p, tid);
> > +		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,
> 
> You're replacing snprintf() code __that did proper len checking__
> with code that does not. That's not good.
> 
> I can't see how the fourth proc_fill_cache() parameter, ``name +
> sizeof(name)'' safely ever replace the original 'len' parameter.
> It's a pointer value .. (!)
>

Ok, there's a "- p" in the end, so the length looks to be Ok.

Nonetheless, the whole patch series is introducing funny code
like:

+/*
+ * Print an integer in decimal.
+ * "p" initially points PAST THE END OF THE BUFFER!
+ *
+ * DO NOT USE THESE FUNCTIONS!
+ *
+ * Do not copy these functions.
+ * Do not document these functions.
+ * Do not move these functions to lib/ or elsewhere.
+ * Do not export these functions to modules.
+ * Do not tell anyone about these functions.
+ */
+noinline
+char *_print_integer_u32(char *p, u32 x)
+{
+       do {
+               *--p = '0' + (x % 10);
+               x /= 10;
+       } while (x != 0);
+       return p;
+}

And thus the code using these functions is throwing invalid
past-the-stack pointers and strings with no NULL terminators
like there's no tomorrow...

IMHO It's an accident waiting to happen to sprinkle pointers
like that everywhere. Are we really in a super hot path to
justify all that?

/me confused

-- 
Darwish
http://darwish.chasingpointers.com
