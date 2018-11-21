Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E1214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pjs64yeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879E1214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbeKVHCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:02:13 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34207 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbeKVHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:02:13 -0500
Received: by mail-lf1-f53.google.com with SMTP id p6so4967760lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqDu4gwP8655npZa/cqlakcvh6bMCygUsn8OrMVzFN8=;
        b=Pjs64yebblJ+EUkYjhTL+1mnEBADEFbhObrWimCR72gaySPkGQq/LL5I56Ru8O5meS
         7eTCbpLgvXCjj4rYSME7kX3QSd7dy1SWhERXCL/5dNHzcAOG1SC7ducKJ3pkcPsH6eOt
         20jItiDsBSDSouqWKKooCdgkUVopl2twqzMKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqDu4gwP8655npZa/cqlakcvh6bMCygUsn8OrMVzFN8=;
        b=Z2OsoZs/uf37sxKoCfa0zzIODALw72AEBjvV7v65s1RUjWkGVxTaO4o46lR7tGx+uH
         1LOLgiXqNk8RPfQh2uc7MkkWeAZGM3B5PpGlvBxEziFlfI/Dk1FumuDVRSPqqyQSu8ji
         XRzRoObFpv9KtSD5RzGEufFlGjk09CH+hdn4KgZcR//XhtrOgp8+ImUQAleMGyawFMim
         9z1g0Kqzh5+iwXMPA9kB4U8J5xBwdc/2uUC/VqbOYFwB5JlvhGfqppzEfnLP4ZDA1rMX
         ZcBnTx/j3TfDygWx+2MlGH3N2AQE2TQR9u76f2utWAzLk0/y6Ur6PW2Hrrq7lGD72dgw
         LhJQ==
X-Gm-Message-State: AGRZ1gKUomFnoF7nHV5fnPJL2mh33U0M3f38iQTi0wU5FROljzDWrqZe
        tQoguAf8tY9WSHh6G6cGaoD6Kop3JI5tUA==
X-Google-Smtp-Source: AJdET5fv0Al6zNmMHONVgQWfttAc3lq24hcw+Nm6+Q1x/lV+daZqyiokzNsbiWHNeJ8nKo4KrvjcqA==
X-Received: by 2002:a19:a086:: with SMTP id j128mr4443984lfe.93.1542831980993;
        Wed, 21 Nov 2018 12:26:20 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u65sm7167557lff.54.2018.11.21.12.26.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 12:26:18 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id p6so4967663lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:26:18 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr4523531lfj.138.1542831977627;
 Wed, 21 Nov 2018 12:26:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
 <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com>
 <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com> <ffa050d4-551b-714f-5a9f-c61167e40fb0@intel.com>
In-Reply-To: <ffa050d4-551b-714f-5a9f-c61167e40fb0@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 12:26:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0T95H8e290pJ0xUboyjsj-abePin6sO1vLhGE1JPyfQ@mail.gmail.com>
Message-ID: <CAHk-=wi0T95H8e290pJ0xUboyjsj-abePin6sO1vLhGE1JPyfQ@mail.gmail.com>
Subject: Re: [Patch v6 14/16] x86/speculation: Use STIBP to restrict
 speculation on non-dumpable task
To:     dave.hansen@intel.com
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:07 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> Repurposing dumpable is really screwy and surely imprecise, but it
> really is the closest thing that we have without the new ABI.

But we *have* a new ABI.

So that's not a valid argument.

It's more like "this other thing that some other users use for
something *entirely* different has in _one_ case the semantics you'd
want, but in most cases not at all".

Because gpg really is the odd man out.

And it's not at all obvious that you can attack gpg using the hole
that STIBP opens, when there are other timing attacks that are likely
as good or better, and when we know that people who really care about
the issue are already just disabling SMT entirely.

That's really the basic issue here: STIBP has horrible overhead, _and_
it's not even targeting the people who really want it, so we'd better
be very targeted in how it's used.

Because we already know how badly things messed up when the use of
STIBP wasn't targeted.

The _only_ very real and direct advantage "dumpable" has is that it
hides the problem from benchmarks. Because benchmarks don't test
non-dumpable processes.

But honestly, that sounds like a disadvantage to me. It smells like
"let's hide the overhead dishonestly".

                 Linus
