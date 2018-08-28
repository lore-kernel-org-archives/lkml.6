Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE57C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE56D2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqycH65M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE56D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeH1XZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:25:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41001 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:25:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so2205479edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2QaO0uIgbLsrFdfJ2kZm/STVp1yxqwRwLt4j60URw+8=;
        b=AqycH65MohoeO3aU6lLx15ixIkNpEp1PJvSWX3wiUq3BSnzuJVx0/VuP0qkmEUAP0E
         qJXhvAdt4dZYAXSvAKc4GV0VkZ62khpQi9Kwr3+oMpg0GorTxzRNA7aD61NZgWYflmaH
         HhJ5RS0fWLbLB+RS2UUnbs4iDAUfYSAClvFeKSkkwdaVXXEhLZRwjWbx4Ovl7QQ9Mwpy
         jr+zQm62zP+1mR+Vb1/etkU2zP01fGHLr88FtBJUszkx0dAGuGO+vo6dShqvPlcfUkBH
         zjMZLDDqc+8Us4izAI+ROHAj5nrQU+wiDWL3g6qd9ae93FIFww+nBQ9gUAKx1MJm35Ne
         jqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QaO0uIgbLsrFdfJ2kZm/STVp1yxqwRwLt4j60URw+8=;
        b=SEGkBRmwlBaaMjnixZEDWd7PjstIMW4GlbCnV8Csj7dM2e32gkkKDpMhBaPHUXniG6
         Hqu8XvJJExCxhFnDYfjuGzzD+jyuG5uw/ek3M3UmMp2+PoyEBxzS+qVfebhoIRlIRulK
         WaKBPVsTIFdV3XNvXCzHm/ISR4vtN4ncSMUTdqXBoqBoUMPay4FcEZ2B552H6fduJdFV
         8lctfbjbAUmwfOFarxMP1M7Ik62Vet8E0i8DCAJbX3fq6u+qCRW8XS0GNxb2LDMr0t+q
         Kpjgc/nJxYgiuNbQzPDvFvXsZKbL9NfzK6b/XzPneHDceJFsqUTpX29fSq1LUWI4CHUR
         sNAQ==
X-Gm-Message-State: APzg51A1Ee37AtSs0T+atKSQbQfaz3ze4WslaHYi/OH5fRM76UHSOA1s
        N0rH+YrLESdkcX3Rd6SVKA==
X-Google-Smtp-Source: ANB0VdYC5g5mr8TRMUfPE73fHUpRB+S+LRiD83W1GD0ARUcKmXsb0NTweBvvPF0TS6gpkA845+Hfyg==
X-Received: by 2002:a50:e40d:: with SMTP id d13-v6mr4065459edm.263.1535484717658;
        Tue, 28 Aug 2018 12:31:57 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id p28-v6sm2156936eda.85.2018.08.28.12.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:31:56 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:31:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-ID: <20180828193154.GA4847@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-11-adobriyan@gmail.com>
 <20180828123622.GA2087@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828123622.GA2087@darwi-kernel>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

len should be 10.

> - while we're at it, let's use a constant for the '11' instead of
>   mysterious magic numbers
> 
> - 'p' is clearly overflowing the stack here
> 
> >  		tid = task_pid_nr_ns(task, ns);
> > -		len = snprintf(name, sizeof(name), "%u", tid);
> > -		if (!proc_fill_cache(file, ctx, name, len,
> > +		p = _print_integer_u32(p, tid);
> > +		if (!proc_fill_cache(file, ctx, p, name + sizeof(name) - p,
> 
> You're replacing snprintf() code __that did proper len checking__
> with code that does not. That's not good.

Yes, the whole point of the patch is to skip length checking.

> I can't see how the fourth proc_fill_cache() parameter, ``name +
> sizeof(name)'' safely ever replace the original 'len' parameter.
> It's a pointer value .. (!)
> 
> Overall this looks like a broken patch submitted by mistake.
