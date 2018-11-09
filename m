Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74276C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FEC20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Pjr28Fn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FEC20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeKJErr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:47:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44781 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbeKJErr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:47:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so1218610pgs.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LqUOZkxahT2we8U88Q+WPC6iRMFZcMRyYwEEgRdSPZY=;
        b=Pjr28Fn8Sg5vE0YeLxZwWZW4syL6DFCbnm2QY4FuYVD9pdb6b3Qj6f9/x/t49hzv7Z
         4clYpxWjWqOA62CiPP2BbEMAzByHEwGJW4M8/8Zh7jWJXVizeFhBAz430BBZT/zL0A9O
         D1ZEAUzdYQUkjf7bqp8nlA4IlWkKUrhsuHCECXIrjyzS11qreHgOfIqXa2ArwqH6I01r
         kOlns0zdpVjmrcORFDXt6mtO0LsLjCki8rzMjKFVSb/algeG6T4dy8ZsiR03l8oxLovH
         n585XDc6PEAJivWCsE+hNrTut299133P4BZmNN8ginQ3M1s37pqaIYv4MC3coHq+0sLs
         SNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LqUOZkxahT2we8U88Q+WPC6iRMFZcMRyYwEEgRdSPZY=;
        b=J9ez7HefameFjdv2HRNwRMc355cpPU5R+mC9UsudxhfIUzUXOT2gDZcV4OAMzKWr4A
         pW3v7OHqq+URmWAd+GSf6vQrvHjGRzEj0E7g+ajGpzsB0isKIufTi0uAGr8eJ/XgPxyb
         I/SHgkdGlOEijpWBx9/kJhe9At1s3mM4MFgmzjPkZKbhakInt+zj6eXVHLRWFXqfX/3w
         K7KyCPLpHOMDXXdPgr8igk0ulQjKz6G8jLayeZfIm2XlP9TkAu0ErXoRJkvcb6Xcj1A5
         6oQMPEx3oA61iUcwYIKp6Ow8DAqOdE4E4RiOsNQKGqQA6UwTMvFM/zz3xAnLfJzLqDtD
         EApQ==
X-Gm-Message-State: AGRZ1gJLdO3MgCPtqhzkixfbWI/HdT2fhyeWO1Ynl8hiI+qiATTCQ7U1
        dJ9Ig/dmD1yLnq+5fiLW7bLnQQ==
X-Google-Smtp-Source: AJdET5fo1KrEwKisYNG9ClqbFxFZL30CdD1zGdpl1GfoQ0u93Xlnu57OwGBqb/6fbgvTn2wL0DHxOA==
X-Received: by 2002:a62:de06:: with SMTP id h6-v6mr10231237pfg.36.1541790353575;
        Fri, 09 Nov 2018 11:05:53 -0800 (PST)
Received: from [100.121.81.84] (188.sub-174-214-11.myvzw.com. [174.214.11.188])
        by smtp.gmail.com with ESMTPSA id x123-v6sm9193901pfb.124.2018.11.09.11.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:05:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 0/3] Static calls
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181109134241.5f4ce3be@gandalf.local.home>
Date:   Fri, 9 Nov 2018 11:05:51 -0800
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com> <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com> <20181109152139.zig45f6gp24btfbc@treble> <20181109164137.5cngbfrkm4ihj4ra@treble> <20181109134241.5f4ce3be@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 10:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 9 Nov 2018 10:41:37 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
>>> On Fri, Nov 09, 2018 at 09:21:39AM -0600, Josh Poimboeuf wrote:
>>>> On Fri, Nov 09, 2018 at 07:16:17AM -0800, Andy Lutomirski wrote: =20
>>>>> On Thu, Nov 8, 2018 at 11:28 PM Ingo Molnar <mingo@kernel.org> wrote: =
=20
>>>>>=20
>>>>>=20
>>>>> All other usecases are bonus, but it would certainly be interesting to=

>>>>> investigate the impact of using these APIs for tracing: that too is a
>>>>> feature enabled everywhere but utilized only by a small fraction of Li=
nux
>>>>> users - so literally every single cycle or instruction saved or hot-pa=
th
>>>>> shortened is a major win. =20
>>>>=20
>>>> For tracing, we'd want static_call_set_to_nop() or something like that,=
 right? =20
>>>=20
>>> Are we talking about tracepoints?  Or ftrace? =20
>>=20
>> Since ftrace changes calls to nops, and vice versa, I assume you meant
>> ftrace.  I don't think ftrace is a good candidate for this, as it's
>> inherently more flexible than this API would reasonably allow.
>>=20
>=20
> Not sure what Andy was talking about, but I'm currently implementing
> tracepoints to use this, as tracepoints use indirect calls, and are a
> prime candidate for static calls, as I showed in my original RFC of
> this feature.
>=20
>=20

Indeed.

Although I had assumed that tracepoints already had appropriate jump label m=
agic.=
