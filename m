Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECEF21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7bNZ6ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfBZPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:09:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:09:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so6386660pfn.1;
        Tue, 26 Feb 2019 07:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EX8Tb2qZjAuXogAbVQcMHbnJVBhMl1AW8AghBUbtDYM=;
        b=I7bNZ6jiDm+7HVLjRpeXunY3fJSfVoNI75N+LVrt5/aCySaFcXlgmdNrxMKdBu0bWS
         9OrBxj3QRQcyvYVHpDX6Zb0radh6roiZ3SqLhkZ0CS+LH7BI5G0RZ79tmL3Vj1UJcUp8
         MaLuMF6PgwY5AsW1i0q7ibVeTXiccafbimWerEd7+xKd01Qd3PLT0RHCj6rgdWPTg4RE
         RlLSKMta/jN7OO2j+cJTu8+zjhjQMsfbt/bbJv7JXyD0349r8cEUvrxPaqGEiNsbWGIJ
         0caEhvSoyDfNqxrWmMlc+P2UhBipZ9Ouru5paxVwDn9rAOthRg9S4/GcOHjtTrP5C77z
         2CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EX8Tb2qZjAuXogAbVQcMHbnJVBhMl1AW8AghBUbtDYM=;
        b=C8exzEzC13sHTN3ymbAImP8oUSEW4ymFlx3/jtFPecfTHasSGdCpI58+uUY/BLLZNv
         NmFqbmMNVAM7x/H+RlyPGMYYY47KjGHwfDrwtePpoQbNy+Gfq+F8Ne1Kp/4uL2lmxT0O
         XIboUmBe1IWS4I2rOmaKT8BUhhGLez58sliTItMNbe4d1BtmtOqkEtJjdWLI6Xof2XZm
         ECIjuXmdbgISpBlc9nMbAuso29hEP6SOMYO6MRscfnB3t0a4GOSMfE+Xk9MZ/2rfi9In
         aGT4jHvYMpJ239vKuGxJv9T1qd0yCy68UizDC+S40rztHR7lLBZ/Zhd2+LN6CNvQjBYM
         PEgQ==
X-Gm-Message-State: AHQUAuZ9jVgcXcJu+T47q6jrkHDpjNaVWwojMEtb3HOagCZdg9YOqrOb
        YRFc0qAKSdZAu4YDINgSGko=
X-Google-Smtp-Source: AHgI3IYjRsT4BHjGeyiJLrhB8J8ZVUkPNVEKoEGwUbqELjDYDBU3smZrboGLdhIYKpThqPC4T8e+/g==
X-Received: by 2002:a62:fc10:: with SMTP id e16mr26725122pfh.83.1551193760935;
        Tue, 26 Feb 2019 07:09:20 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z15sm19095368pgc.25.2019.02.26.07.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:09:20 -0800 (PST)
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
References: <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
 <20190226150427.GM4072@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0d7275f1-4ed1-f13d-baab-27de8a061aa0@gmail.com>
Date:   Wed, 27 Feb 2019 00:09:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226150427.GM4072@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 07:04:27 -0800, Paul E. McKenney wrote:
> On Tue, Feb 26, 2019 at 11:56:57PM +0900, Akira Yokosawa wrote:
>> Hi Paul,
>>
>> On Tue, 26 Feb 2019 06:28:45 -0800, Paul E. McKenney wrote:
>>> On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
>>>> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
>>>>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
>>>>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
>>>>>> still broken.
>>>>>
>>>>> As requested on IRC:
>>>>
>>>> What I asked was if you could get your GCC developer friends to have a
>>>> look at this :-)
>>>
>>> Yes, this all is a bit on the insane side from a kernel viewpoint.
>>> But the paper you found does not impose this; it has instead been there
>>> for about 20 years, back before C and C++ admitted to the existence
>>> of concurrency.
>>
>> By "it", do you mean the concept of "pointer provenance"?
>>
>> I'm asking because the paper's header reads:
>>
>>         "ISO/IEC JTC1/SC22/WG14 N2311, 2018-11-09"
>>
>> Just wanted to make sure.
> 
> This paper introduces neither pointer provenance nor indeterminate-on-free,
> but rather proposes modification.  These things have been around for a
> few decades.

Got it!

        Thank, Akira
> 
> 							Thanx, Paul
> 
>>         Thanks, Akira
>>
>>>                  But of course compilers are getting more aggressive,
>>> and yes, some of the problems show up in single-threaded code.
>>>
>>> The usual response is "then cast the pointers to intptr_t!" but of
>>> course that breaks type checking.
>>>
>>> There is an effort to claw back the concurrency pieces, and I would
>>> be happy to run the resulting paper past you guys.
>>>
>>> I must confess to not being all that sympathetic to code that takes
>>> advantage of happenstance stack-frame layout.  Is there some reason
>>> we need that?
>>>
>>> 							Thanx, Paul
>>>
>>
> 

