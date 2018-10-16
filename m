Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A25C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B71F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jay/3zTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B71F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeJPPvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:51:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:51:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so21249549wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDUVmeEQiqqxdme6fOBk8uoBFCRSa0ohT4Z+HJ5SZNc=;
        b=Jay/3zTmKr086Wc3YWoiJylnOWwv4wVCf/giA/8IV+lUUlSG44ODfItBRNUBvsqD21
         sZPEoRIQGc8sQB8P7GaDcle90U3R+/BEGN3f2w18DaJIN5Uf+zcTDt2LVQsLnWQ38fV+
         PyPzSfamclhqx8yFaLCK+aUKp59MrDzgv7fwU/C+KLUaGyJztP0trYcr+wQ9BUkdIY7P
         2DcJhmc/Q/ZkOX557dd3wqgXbzOk7Q1LoWAHYTfJBaP1Sq75Bt7yz3scNIdLHHq6IeSH
         JvPnB7PK0wH77JCl5KtPO7z6XFbepfSmE0PUO9fTPkjS1lLOyGNoCugFhdCimd5ggxAi
         41zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDUVmeEQiqqxdme6fOBk8uoBFCRSa0ohT4Z+HJ5SZNc=;
        b=n9tEkoKL24NxOiEfOtddPjV5g1YIGVRLyRA8WeOhFRGIHECrd8ignfHa37d4hv2+vw
         jE8vxh65obfWw27G/0FSzJaCOi/45p9DT9Y7hflWDin6az1mLR2FSWqYoP0nJasLZMzZ
         kHmdzf5xkHMqhy0cudFyF8DyiDWqX3YyNviQ/fTGJ1l5OZ2EUVr/ZU+WSa1UbKgbMg8/
         Zkoq5jCB6bFqotQj+4KluXwfL6BPscLGKQztaQJNJvS7iJYmQWGnBgbhLp7uCaWll482
         tPu0DyB9GE//YfQZt+EjiPVJA8HQ9vZmLFWgxXZHodm2MeA8lNpctqnIN7sizlYnLp2R
         JUaw==
X-Gm-Message-State: ABuFfoiQKDGo47nYOV4pNggmcReA+K45qdmIdeMW4NMaK7qOVus4yTXb
        Coi8szu3V7vyM/nUx62337g=
X-Google-Smtp-Source: ACcGV61q0Hd3UQncYmQ+MAP6kXC1Q7rDYpDzNNRydfS3g2+RO3mZpJM2U/pPiK5P7Zo36WWw+vyiAw==
X-Received: by 2002:a1c:c64c:: with SMTP id w73-v6mr14903915wmf.21.1539676913207;
        Tue, 16 Oct 2018 01:01:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x16-v6sm9750096wro.28.2018.10.16.01.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 01:01:52 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:01:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH] x86: modify inline asm constraints in __cmpxchg_double()
Message-ID: <20181016080150.GB41162@gmail.com>
References: <20181015084802.30934-1-jgross@suse.com>
 <20181016062556.GA56841@gmail.com>
 <e43d18fd-22c0-5c59-5cb6-3d7c8da71d8e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43d18fd-22c0-5c59-5cb6-3d7c8da71d8e@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 16/10/2018 08:25, Ingo Molnar wrote:
> > 
> > * Juergen Gross <jgross@suse.com> wrote:
> > 
> >> Some gcc versions seem to have problems with the constraints in
> >> __cmpxchg_double() as they suddenly issue a build error when random
> >> parts of sources calling __cmpxchg_double() are modified, like e.g.
> >> slub.c. This has been observed on Debian systems only so far.
> >>
> >> Using "0" instead of "a" in the input constraints has the same
> >> semantics while avoiding that build error.
> >>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> ---
> >> I should note that I have observed gcc hangs instead sometimes. Not
> >> taking any patches modifying users of __cmpxchg_double() due to a gcc
> >> bug which seems to be distro-specific is a bad move IMO.
> >>
> >> I'd rather make it clear from build behavior that this is a bug in gcc
> >> by letting the build hang instead of throwing error warnings not in any
> >> way related to changes in the code.
> >>
> >> The gcc bug is filed under:
> >>
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908154
> >> ---
> >>  arch/x86/include/asm/cmpxchg.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
> >> index a55d79b233d3..b3b4d61a8969 100644
> >> --- a/arch/x86/include/asm/cmpxchg.h
> >> +++ b/arch/x86/include/asm/cmpxchg.h
> >> @@ -245,7 +245,7 @@ extern void __add_wrong_size(void)
> >>  	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
> >>  		     : "=a" (__ret), "+d" (__old2),			\
> >>  		       "+m" (*(p1)), "+m" (*(p2))			\
> >> -		     : "i" (2 * sizeof(long)), "a" (__old1),		\
> >> +		     : "i" (2 * sizeof(long)), "0" (__old1),		\
> >>  		       "b" (__new1), "c" (__new2));			\
> > 
> > This got changed to +a in -tip:
> > 
> >   c808c09b527c: x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()
> > 
> > Mind sending a patch on top of -tip?
> 
> No, I think you can drop my patch.
> 
> c808c09b527c: x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()
> has the same effect as my patch: the build failure is replaced by
> gcc hanging instead in the critical configuration.

Ok. No sane workaround we can do to avoid the hang I suspect, right?

Should we propagate the fix/enhancement to x86/urgent? It's currently in 
x86/asm for a v4.20 merge.

Thanks,

	Ingo
