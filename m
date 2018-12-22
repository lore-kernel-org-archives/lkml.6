Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C84C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F1F21B6A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545497179;
	bh=HJsPQFVo3Ou7SujUeK4Ifa6nLzFyjVlIaz97Wr+V1Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TPgIyJPG6gwV5M1DGsPOLD0P/d4SupJ8mkEDr7SiKa5ZSkpY29rf4GdlKEIxhUowO
	 PKO4Vi7lTVhvNieg21Wzi8LXxfJvb36cwq5W4Ahey50NsvPM3ZIS04e00xLy/RyQvd
	 tESkLD6gVWOpah8w6gqXSzVwk17o7Dlxxcz60RAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLVQqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:46:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbeLVQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:46:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so4024306pfd.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NnO5rCR3Jil4VrqR8U/eJemrm9UuQVXJ89etNlg3q2g=;
        b=EK7VXu/C6gWMjx63k971LB6YXm47eaEaTN9kba7Y8TyQ6TVRIHkWSC+wrShgZzvreP
         n0MGNjLr1HcEHPaHJZL9isrcDTyK2iZe6FDAqF4D+Vc+qCtOBk7yeuZe6T8DEYhcV5fP
         K+qqM4YAmB9+lWWvjT6qfTD6kMEOYpR70IGcMzLtIFoaFjWAXQ+YMcjoSN9mVAN2i80P
         IOLUHRn7WNU9zPUfrCbMGdJqQecxDCL9ZKInmHIopCIJuEBn1Qj6L1PmCpoEW9DeNbeB
         g8V2cuGm1nZssVEQJHJiQ64yYvdNYNx0/55jjEvhhHrMXZMxtWoscOZmvZrb2CI6dcUA
         Oeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnO5rCR3Jil4VrqR8U/eJemrm9UuQVXJ89etNlg3q2g=;
        b=QzivS1Np4+S/J3GrLQfLKMbtLKgYMvTKBflamH5wt+Z525rJdtloy9ETmiXevp6mWc
         hNB4naefKWtsgvryiCwUb5khtJ5YoNjvhPGIiNBDf9FYaNHCDVc34utRGT93uhYV8gUe
         hWzqMUlSbM5nsey4SLpiy9wvcNtkwWZU41j2HPdYRj0MgDT5LZEMYYOHhvljwFOrUkjt
         woK4RDTb9IHr38at11XIo1w/lNpdVTXwLkFFsgjzRLtC4KVcsxh7Qkt1xGdLyYiqfhUt
         jWFYSDETkzVYWHBoKIrjO3FgaglvUHA16Asu0G7z4zqq4tldfW7Q5VNyeR5WVbrYbXhG
         Gh4g==
X-Gm-Message-State: AJcUukf+CEPUgPhl0zrQy9blEC+En2WKb58Gcvkt75bYomQtPhW5NJTf
        qLi1UXHV/jbjrwqpJuHswRM=
X-Google-Smtp-Source: AFSGD/XhrfJLIj5lBZF0+1u6jUnzkvczLpv0cBwmCivqFH0wSUBQnIlF4276ucueUTzaBvRnlQhuhQ==
X-Received: by 2002:a62:7892:: with SMTP id t140mr7034809pfc.237.1545497173763;
        Sat, 22 Dec 2018 08:46:13 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id n22sm50977820pfh.166.2018.12.22.08.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 08:46:13 -0800 (PST)
Date:   Sun, 23 Dec 2018 01:46:05 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181222164605.GA10792@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
 <20181222093346.GB7610@danjae.aot.lge.com>
 <20181222072404.27a7e9a3@vmware.local.home>
 <20181222142411.GA10058@danjae.aot.lge.com>
 <20181222101244.7da017c9@vmware.local.home>
 <20181222111630.24a4444a@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222111630.24a4444a@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:16:30AM -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 10:12:44 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 22 Dec 2018 23:24:11 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> > > > No, because we don't know the length of str.
> > > > 
> > > > 
> > > > 	[ str = "h\0[bad memory]" ]
> 
> 
> > > 
> > > I don't know what's the bad memory causing memory fault but anyway
> 
> What I meant by that is if a string is allocated at a end of a page,
> and the next page is marked as not present. A read into that page will
> cause a page fault, and since memcmp() does not stop at the '\0' it
> will read into that not-present memory and trigger a fault, and that
> read wont be in the exception table, and it will then BUG.

Why it doesn't stop at the '\0' if one has it and the other doesn't?
It's not because it's '\0', it's because they are different.  The '\0'
should be in the prev page (otherwise it's already a BUG) so it should
be detected and stopped before going to next page IMHO.


> 
> > > memcpy() should stop at the NUL character first as it's different, no?  
> > 
> > No, that's the difference between memcpy() and strncpy(), memcpy()
> > doesn't care about nul characters. It's copying memory not strings.
> 
> I think we both meant s/cpy/cmp/ ;-)

Sure..  sorry about that.

I know the difference between memcpy() and strcpy().  But this is
comparing so it should stop.

Thanks,
Namhyung
