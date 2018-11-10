Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA73C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36020858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LG1QN4MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36020858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeKJVlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:41:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38982 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbeKJVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:41:21 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so7187765itl.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7SaUmRtTl9bZ2cU9Pmc4hM+LKKnfHM4Uw6+uYvfmdmA=;
        b=LG1QN4MSXUHSY4hHSthogoE/y0JIAY4wTpSkoiRoxHWgyoSDDkyxRjnsPTu7pLG14t
         epLML84mppHkik+XQOqKBn7X9Lpa/ADzqw8Lq273aqR8oHa0ox7D2xmEtrBQWriyi/Pm
         kI0QaWjaDpHaCVM69pr0FLqPkhjjcQBFAM+Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7SaUmRtTl9bZ2cU9Pmc4hM+LKKnfHM4Uw6+uYvfmdmA=;
        b=GCFAMGAJS6+XgXhgcecKnP3UGc/fWaEQX7VFQ3uLECGaZYihwIU0zxAiWuKdAfExan
         lRM57lD5DY2EdMKclv5Ua2TqnvkhnBVYy1uNkQo8nY4gxlPZCpjjdcdXgiGYV7EyTR0r
         rxe3Fmv4oMBU9rGlMpQwVryvwFKb+EzHyaTbI8I5chzURNAgoiuXXZBDnO14b75vL61n
         w2djV1biJ4w3EJ0xXi3nnfUexTw6tt1Q2PXKFArMibBNLt3iUZyyIJogkPNcshrn/ruK
         w3ooEpgAQUvConC6QAHT8oo0guMYmtRUfduv0PDZejkjcOIGp98z7HDTCqmvdl99HiEo
         xXKg==
X-Gm-Message-State: AGRZ1gIsLevQU/pHIOGp5W/xrRcGRuxeEK9RrKIAdc4M2/zrqlGENNbA
        rpo+LSDEzHKM8N6zjBUsAiiZrbUbVA7dxobDd5LJ2yGl
X-Google-Smtp-Source: AJdET5cc7egBl0skkB6bWF8nljNNzmdqDAc5oxuhYST3FEd/Y0ztg4aAn1Qxwb7MY9SIPt85j/I4gjpLeKpVcUH8PXc=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr5924827ite.158.1541850994202;
 Sat, 10 Nov 2018 03:56:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 03:56:33
 -0800 (PST)
In-Reply-To: <20181109203459.wbftlkxcvfnwo2bm@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <20181109133337.63487e3a@gandalf.local.home> <20181109193505.5p5iddrtgpk2cpb4@treble>
 <20181109145746.0037da3f@gandalf.local.home> <20181109203459.wbftlkxcvfnwo2bm@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 10 Nov 2018 12:56:33 +0100
Message-ID: <CAKv+Gu8Aip+KWTyC-i0wPC7YTrd2QXDjUFPpRtbzBfc6HVCktw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 21:34, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Nov 09, 2018 at 02:57:46PM -0500, Steven Rostedt wrote:
>> On Fri, 9 Nov 2018 13:35:05 -0600
>> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>
..
>> > > So what's the reason for skipping init calls?
>> >
>> > This is the runtime changing code (static_call_update).  Presumably the
>> > init sections no longer exist and we shouldn't write to any (former)
>> > call sites there.
>> >
>> > That's probably a dangerous assumption though...  If
>> > static_call_update() were called early, some init code might not get
>> > patched and then call into the wrong function.
>> >
>> > I'm thinking we should just disallow static call sites in init sections.
>> > I can't think of a good reason why they would be needed in init code.
>> > We can WARN when detecting them during boot / module init.
>> >
>>
>> What I would do is to allow init (like ftrace now does). I have
>> ftrace_free_init_mem() that removes all the mcount references for init
>> calls from its list. You could add a static_call_free_init() to
>> kernel_init() in init/main.c too.
>
> That makes sense for ftrace, but I don't see much point in allowing it
> for static calls.  Maybe we could just add support for it later if it
> turns out to be useful.
>

I don't see how you can prevent that. Some arch may use a static call
in its version of some library code which could be used anywhere,
including in .init code.
