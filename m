Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091C020827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lelDa/4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfAHS2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:28:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45373 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:28:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so2306289pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IgxxlltM/YqbmfuqUTo2lubz3lYM7XgPxxZCMRDDDTU=;
        b=lelDa/4Ms0BXyqG/l2s/e93o5TSTiyMnUw2sE3LCru82utmF6n8E+XPb8rCqZE8Kvz
         XhoUXyUbM7fhOuDp4mc1+5gKSt63upQIamlQeGXAkTAHvm2Tn14ckflT8Xwv9g09s1Cm
         sePXPY1HfTE7TaSH1rEtiw0eYygCbumRtFcyE0+CHOh/pin5jb8ud3NGdCAGHrh1A6Qm
         4/3aUJ8JJwzxeaO8vmy2sJGpn6XCoFWgDSrYdIq5ZsA23e2Aqz4odgL5s4UsaqIr/lHe
         PkcAMpTBMpEEaYc885GTxVihX9sYmD4fqif76YLQ7N5sX5XlkWoVVmcAQ7kpmtUu+e0J
         VDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IgxxlltM/YqbmfuqUTo2lubz3lYM7XgPxxZCMRDDDTU=;
        b=hnayPXtz1SS63H4dsSmaF1R/9byPOtaKEFu01xfAucnkIh1yH5zmo8GMilUkSvK8ec
         TL7DAWVPraahuGDfzgl8hWqNffNOJg4KL3rbQLyJi7ulOMhPrgAE4p2AByZHY8PXQJDW
         E/C2b5Bs29PfoMk4goyqujy3EGQBF9G+tlahPTfM7HXarmMlZ9hWEZD/qwrP6F62m7ia
         MtwFcJF06wgXO+qNa+FZXsZ7TyPMqcQtFP8MaTKnfR8pGh6ByqMAzV4PAvKq6XHPi65b
         wPpR2hXkdFvpatRit2Z6TkmUGUnOsVDr2ASicpPG7zw4ciuMJlpf7kI3/ipKUY/Wn6J9
         enJQ==
X-Gm-Message-State: AJcUukfe/CHWVtnnPScHmNoPFY3qd1G3BHYOYugcJiqjpogEv5GMLO1n
        yhsSJAfTmsMUBFSI+aomQ9A=
X-Google-Smtp-Source: ALg8bN6v2BFvao+7PoyU4QHgK22cx2uNJsSzt0W+QZmhfIp29Lj2dhm7XUEshX4o4fZ1xlLFIMQAew==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr2504152pgi.244.1546972086123;
        Tue, 08 Jan 2019 10:28:06 -0800 (PST)
Received: from [10.2.13.140] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id z62sm119969940pfl.33.2019.01.08.10.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:28:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190108172721.GN6118@tassilo.jf.intel.com>
Date:   Tue, 8 Jan 2019 10:28:02 -0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 8, 2019, at 9:27 AM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> On Tue, Jan 08, 2019 at 11:10:58AM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 08, 2019 at 12:01:11PM +0200, Adrian Hunter wrote:
>>> The problem is that the jitted code gets freed from memory, which is =
why I
>>> suggested the ability to pin it for a while.
>>=20
>> Then what do you tell the guy that keeps PT running for a day and =
runs
>> out of memory because he likes to JIT a lot?
>=20
> It only would need to be saved until the next kcore dump, so they =
would
> need to do regular kcore dumps, after each of which the JIT code could =
be freed.
>=20
> In a sense it would be like RCU for code.
>=20
> You would somehow need to tell the kernel when that happens though
> so it can schedule the frees.
>=20
> It doesn't work when the code is modified in place, like the
> patch in the $SUBJECT.

Excuse my ignorance - can you be more concrete what will break where?

I am looking at perf-with-kcore, and intuitively the main thing that is
required is to take text_mutex while kcore is copied, to get a =
point-in-time
snapshot.

Is it really that important for debugging to get the instructions at the
time of execution? Wouldn=E2=80=99t it be easier to annotate the =
instructions that
might change? After all, it is not as if any instruction can change to =
any
other instruction.

