Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E4217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPpLIU95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfBZO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:57:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45932 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfBZO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:57:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so6340125pls.12;
        Tue, 26 Feb 2019 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymQ5hN+f5reLc+lvACc2oaZKjiKlC9faWg71VNEvqt8=;
        b=fPpLIU951q1c5C3RgkVKhaOy+dZb+EjodRUH7eSROHT6jEoEs7NtEvdlOq/XWAdEi1
         GWrAulweF5cZDtpzSkQtY9dr8kGa2oukns7AROLGOBqsbZDu9Gk8F+8CbOOyNqJIXIcn
         uBHfuikmv1ZZ5/fzGc9LvTJFJDomOH4yqtDwFZb6PXcghvot3+dAeXXzbYnYFKDcMIcG
         AzyrYSqHtX4CBjpaOYmxzrx4dBELrLMRFmb6jEhWoWxDmLHZBVp42dmjr+krD1F0fCHi
         c2TwW5UztW3e7aIevUgjaLuml+2OrneTfv/vrb/wskykjXArd1nI3nNj1p64Dj2CFdgE
         MWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymQ5hN+f5reLc+lvACc2oaZKjiKlC9faWg71VNEvqt8=;
        b=s/RaYhZC+P+fNxa1e3f9lHjNsnU16maflE8tmBwf+ifGsn0nv7Eq0U3KVdjb/jcxTW
         mGhM/TTMY0hExBjB1v+Wuy2JyEroHgDqopQ+P5ggT97Yr2Zv4rlUF9tqhDD925LPpLs5
         Ft7O1UgblBPt9rk4PVNUVVmm8okiXSAbgYofiefuWfhgtZ7FHKq0nIzkN1xft36YzK2v
         QZWNfMiguspPs4NcC+EOjc6QPWpk9aA8VMXMEdohLwG/b/rNRRHr09dOWZoS1JM4mVOQ
         oQnWZfRT4Tql4vBASPAbtLcfRiR+5ETfXLpF10PdPgRCjJ/5Jj/zr6Hacj65/0DARyW2
         2U5g==
X-Gm-Message-State: AHQUAubstY75KDZCJoBuYfxymSxQ+nu4EcGZs+OVR1BYDGGIguAFKeVz
        CvCW08XdmWzGZnexg+o25FQ=
X-Google-Smtp-Source: AHgI3Iaph9eOmSuSYhAhQS+ZjKazfvv85obG2jsmnEufVcG8GxhKbChrDQyFhtvESLGja4kQWQ287g==
X-Received: by 2002:a17:902:52c:: with SMTP id 41mr7946457plf.331.1551193023992;
        Tue, 26 Feb 2019 06:57:03 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i79sm762938pfj.28.2019.02.26.06.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:57:03 -0800 (PST)
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
References: <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
Date:   Tue, 26 Feb 2019 23:56:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226142845.GK4072@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 26 Feb 2019 06:28:45 -0800, Paul E. McKenney wrote:
> On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
>> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
>>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
>>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
>>>> still broken.
>>>
>>> As requested on IRC:
>>
>> What I asked was if you could get your GCC developer friends to have a
>> look at this :-)
> 
> Yes, this all is a bit on the insane side from a kernel viewpoint.
> But the paper you found does not impose this; it has instead been there
> for about 20 years, back before C and C++ admitted to the existence
> of concurrency.

By "it", do you mean the concept of "pointer provenance"?

I'm asking because the paper's header reads:

        "ISO/IEC JTC1/SC22/WG14 N2311, 2018-11-09"

Just wanted to make sure.

        Thanks, Akira

>                  But of course compilers are getting more aggressive,
> and yes, some of the problems show up in single-threaded code.
> 
> The usual response is "then cast the pointers to intptr_t!" but of
> course that breaks type checking.
> 
> There is an effort to claw back the concurrency pieces, and I would
> be happy to run the resulting paper past you guys.
> 
> I must confess to not being all that sympathetic to code that takes
> advantage of happenstance stack-frame layout.  Is there some reason
> we need that?
> 
> 							Thanx, Paul
> 

