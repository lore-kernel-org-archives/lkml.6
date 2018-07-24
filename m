Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F26ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA1C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Q03xXZR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA1C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbeGXPq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:46:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33580 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388482AbeGXPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:46:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so3062459pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M7tYNFeGc2SNxNgzs5Sh/vs4M214DPBR/3bVbs9kSrc=;
        b=Q03xXZR6CXUqJ5uvQ9kQ693tXWIAx8MYOZB/dONKt/NDG/F5z1PB6wv8UrlFFfKxq7
         UQ3SLKikKTkglwW6a8xlXNhxmEZ4FqJmNOZAxCf9OQKB/OQQmtBDDShkGAFizRHS81Ny
         J10zASWSayrXXLgHhEy9urrpqCBshlG0WEPaxfWvDDCiUEB6PN2z9Z7FDM+6LwrB1cOL
         vdUzNynx692r+Cq/QJ1bStGhGeX/k2VSi0kFOwUsmgIZONFmjwOjNFvnmdvx/osl/ODE
         w1/pCRLRw0dCzinD9iJ5ndn/3xdulF424gnVHh7e5msJJOuVYUuToJWSjQKQmyI5c6RQ
         u6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M7tYNFeGc2SNxNgzs5Sh/vs4M214DPBR/3bVbs9kSrc=;
        b=dKdkeiusQ4mCqDnOxOMQzQXPr5lr/Iltt8OJTNSguQyw0F6za9OacAYpep1QM4sVCv
         sKYC/z7rOvAEhsKplFt50PU1qROL42VuSJEjcX+RopReFfM95Mf2HxMufd2uPgLPR1FJ
         RwNYGUrv18lAKm8qCUTji1upLY8QAlGL1TSJaLWwveKe7Rc6GssDck9JpdVzmeBrojE9
         JJx2BTiCjebjhgvpBa2gIrIAiRuPwaZUG8rllgMc6tWpSUC/1HUr3yJ03eWfPJBe/afz
         F3KCv1so9Hc5XiE8EWsghWvdBzCHHSkruu9deuvV93nw1THRycnV/qSNEqoaZCOmQqOX
         gRng==
X-Gm-Message-State: AOUpUlGYwbDElkb5jU5LSjiN1vh0gjSvDU1MriJGhFADvdALpRxzICqe
        KfvsldwjE6Q8wjXL0c+CUIdfjQ==
X-Google-Smtp-Source: AAOMgpcbOq7HokHdP4TNgCHOc3Bo3oHBTYXhDX2nxT8xcKlZedqZ3dblPSER+opEW3p3tV4Ya4bB5Q==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr17950654pfd.231.1532443180464;
        Tue, 24 Jul 2018 07:39:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:1c8a:b8aa:9094:f2d2? ([2601:646:c200:7429:1c8a:b8aa:9094:f2d2])
        by smtp.gmail.com with ESMTPSA id b192-v6sm17659961pga.2.2018.07.24.07.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 07:39:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] PTI for x86-32 Fixes and Updates
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180724133935.GA30797@amd>
Date:   Tue, 24 Jul 2018 07:39:38 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17482884-2DC3-4A09-8AAC-01AC4D8DE293@amacapital.net>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <20180723140925.GA4285@amd> <CA+55aFynT9Sp7CbnB=GqLbns7GFZbv3pDSQm_h0jFvJpz3ES+g@mail.gmail.com> <20180724133935.GA30797@amd>
To:     Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2018, at 6:39 AM, Pavel Machek <pavel@ucw.cz> wrote:
>=20
>> On Mon 2018-07-23 12:00:08, Linus Torvalds wrote:
>>> On Mon, Jul 23, 2018 at 7:09 AM Pavel Machek <pavel@ucw.cz> wrote:
>>>=20
>>> Meanwhile... it looks like gcc is not slowed down significantly, but
>>> other stuff sees 30% .. 40% slowdowns... which is rather
>>> significant.
>>=20
>> That is more or less expected.
>=20
> Ok, so I was wrong. bzip2 showed 30% slowdown, but running test in a
> loop, I get (on v4.18) that, too.
>=20
>=20

...

The obvious cause would be thermal issues, which are increasingly common in l=
aptops.  You could get cycle counts from perf stat, perhaps.
