Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9415C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB1B214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0PzBxk9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB1B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHBO0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:21 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36561 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbeHBO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:20 -0400
Received: by mail-qk0-f193.google.com with SMTP id x192-v6so1403988qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ww2pzuKtFDKODo5ZENXYe4CkMdcQjkPC4MbTGXtAZ7M=;
        b=0PzBxk9k/YOO8ruxcsVMLaCTLjWlOZR7eAT3rBqCYvtO4hdI42yHj50FFE+dUt6R0K
         DlnyOIsdsnTYxViyPZ9pVGI032zWiXAK0h3c83rKOkQwxAWWSw+0n+XOgooAFriBF2zR
         u4mh978kjDsIb8Jb0xwH5FkEcny6Q/ARiYKLh56pFrtRA8tnUmV9FaUPJbOcYO++C7BR
         w03Kh95ZjTSe7G81X1aF9npuFl1eHfRMXuy+H7TM+Y9Kd5JEXb0aAGVfPleckX05+8Nj
         gqYNME6BKxphrKbBmq+hde8SWbuaiXx/Guo24FpNRaTgTVHvJXCix7Whq7HGAdPIZ5vs
         EzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ww2pzuKtFDKODo5ZENXYe4CkMdcQjkPC4MbTGXtAZ7M=;
        b=j+4gWCk2m5M8WJwbSSei3AVUo/U1F+RSuiFJAqWn3gWzXLPw+bXryceSrII0q082HB
         QpmWMyybe7x3o5hiNwYUUSptZ0mjVui2D4jCNtcV6Wsk9CKK1t01RZsildYlTWdT/v0u
         tzhDDPZeAO0HipF+y4VnuKblYnuPdumpuX+vSC8pZ7xPpfxCraTjPH/vEfyROU1r/Al3
         TjeavCmU9FrzXp+mxUDGMTmHutsVrwLLTg4gQ6LDZrXYC34uYBbyQJq3eOJaGpdB9Mnq
         mzOSyC8ava1khyU9mXax/c67iwJB6dpCw8DaZR9yjsWqHj07dvFC7kRb5fv5v3EqKPOl
         n9fQ==
X-Gm-Message-State: AOUpUlGw3rEpUTDPh28F5nxSEhQQ5l/HneCTiJZyctMaUzWOHjCqhWcY
        UUQiRlvdXxEoTemAbC1HI1LSEQ==
X-Google-Smtp-Source: AAOMgpfDbZuBbNDaoU2RWLjbvheiufi/ORy0IZvFm4EBT7uTR6NA5+NiCdOjC2L7F9qCgTtcmr7okw==
X-Received: by 2002:a37:7185:: with SMTP id m127-v6mr2216627qkc.10.1533213318007;
        Thu, 02 Aug 2018 05:35:18 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id a17-v6sm1002460qkb.62.2018.08.02.05.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 05:35:16 -0700 (PDT)
Date:   Thu, 2 Aug 2018 08:38:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/9] mm: workingset: tell cache transitions from
 workingset thrashing
Message-ID: <20180802123813.GB17974@cmpxchg.org>
References: <20180801151308.32234-1-hannes@cmpxchg.org>
 <20180801151308.32234-3-hannes@cmpxchg.org>
 <c0480401-fb38-0b46-6dee-a20093dff065@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0480401-fb38-0b46-6dee-a20093dff065@sony.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 08:57:31AM +0200, peter enderborg wrote:
> On 08/01/2018 05:13 PM, Johannes Weiner wrote:
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index e34a27727b9a..7af1c3c15d8e 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -69,13 +69,14 @@
> >   */
> >  enum pageflags {
> >  	PG_locked,		/* Page is locked. Don't touch. */
> > -	PG_error,
> >  	PG_referenced,
> >  	PG_uptodate,
> >  	PG_dirty,
> >  	PG_lru,
> >  	PG_active,
> > +	PG_workingset,
> >  	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
> > +	PG_error,
> >  	PG_slab,
> >  	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
> >  	PG_arch_1,
> > @@ -280,6 +281,8 @@ PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
> Any reason why the PG_error was moved? And dont you need to do some handling of this flag in proc/fs/page.c ?
> Some KFP_WORKINGSET ?

I wanted PG_workingset next to PG_active as they both describe how hot
the page is, but PG_waiters needs to remain with the same bit number.

As far as fs/proc/page.c and include/uapi/linux/kernel-page-flags.h
go, that's a good point and we'll probably want to make that available
to userspace eventually. But I'm not super eager to make a brandnew
page flag user ABI right away. Let's give the code that uses it some
wider exposure first and maybe publish it a few release cycles later.

Thanks
