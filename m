Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E3C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DAA21A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvWizv+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DAA21A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbeHFXj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:39:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44956 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbeHFXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:39:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so5874855edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikR6TP7282ERP0kUUFX5W1c8IsMF7VGrOOPyP0KjutM=;
        b=HvWizv+A5LVRnlBy30Iokzia7fMCVzxiUxONtXxalDiYhi8iNWEk0d1WyE9cXrcPp3
         dC+gl7sHVDQKimZtnWdjHb/M7KaRSuFw4/sMslYq5D19VpoYjEnwLtBHL8SOzfIDU+3R
         CufDyt9+qy/Y089TGkuoFCU3qC0AoWwJ37VBZdQxwFlpyNO5rOv5zECTag/+j9oPPs1u
         XPpguKbBwTlvny8H2ejRV1qUoRd5kRmpKDepxcewQn18L4orZxzHL5BJRdXTvP52snWh
         9ES3Svxt/xCKucQEJ1T5y6+FadQiZSzQwwn1ZXzJj7MTj6HTYmbG8PFiIGHPwsB+QyVo
         uDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikR6TP7282ERP0kUUFX5W1c8IsMF7VGrOOPyP0KjutM=;
        b=f4tL08yTRRdL4V5REhUaInOGkuvE/vo7k2sqft5mb1EGiUVisFath6QpFs9lC37UaM
         LtE/azTYUoe4aZsloRGbNKYwf/05D/FI/vI6zPFlGj9jm1ZYUdEegF+TKXEy4o5ZJ8Wn
         Yc+lvlYjei3UzFXRkZR+VxLaTGHvT1TyXCZ7HEc1lmjb7hRwMDsdqd+u5jZ4ZHvIcbLp
         SkxvUclGZTkwKD02kaSRlln+rJxrVoda879XLyUmy+WlaQ7tKZ8b2v5yPFpUgVWl363p
         Ha2IMn4ixGOfRf0S/BO2TkFx6gNBpjxUuFse/CqTNBEIlPzhLFeQlcILEVg3r4Q9+Lou
         pG6g==
X-Gm-Message-State: AOUpUlHzyG69mDeSTgTT6eqU33Ezz/glk7rBuUuhFygWyEYLuAym1Cz8
        IYEZA/8hDUGjAmkmTl0nOoFxQS0O5fbNx6Y6NT2ufp6C
X-Google-Smtp-Source: AAOMgpdPWNNl5qOoZ5J3WBLQUoGa+MowGofNEfY8RM0J0eYdpQhRdyXFvkoNdMTAi3pmIpcl843slxMvp+Do7aqYQTk=
X-Received: by 2002:a50:97fc:: with SMTP id f57-v6mr19285489edb.21.1533590909212;
 Mon, 06 Aug 2018 14:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble> <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net> <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net> <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
 <20180806180423.GC2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180806180423.GC2476@hirez.programming.kicks-ass.net>
From:   Fubo Chen <fubo.chen@gmail.com>
Date:   Mon, 6 Aug 2018 14:28:18 -0700
Message-ID: <CAJAFBLA2WigOMxuWXxZvHVwuGtvYr3_b4gpNbdGzry-=AVxjqA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Aug 06, 2018 at 09:54:23AM -0700, Fubo Chen wrote:
> > On Mon, Aug 6, 2018 at 8:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Aug 06, 2018 at 08:35:07AM -0700, Fubo Chen wrote:
> > > > On Thu, Jul 19, 2018 at 2:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > --- a/include/uapi/linux/perf_event.h
> > > > > +++ b/include/uapi/linux/perf_event.h
> > > > > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> > > > >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> > > > >
> > > > >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > > > > +
> > > > > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1UL << 63,
> > > > >  };
> > > >
> > > > The above change makes sparse unhappy :-( Sparse reports the following
> > > > complaint about __PERF_SAMPLE_CALLCHAIN_EARLY:
> > >
> > > I thought I changed that to 1ULL before commit.
> >
> > The sparse complaint was reported for code with the "1ULL << 63".
>
> Ah ok.. and I think I see what you mean. The C standard says that enums
> shall be 'int'. However C++ standard says any integer type that fits the
> largest value.
>
> I suppose GCC uses the C++ definition and I suspect many other compilers
> will too.

Do you think the patch below is sufficient to suppress the sparse warning?

---
 include/uapi/linux/perf_event.h       | 2 +-
 tools/include/uapi/linux/perf_event.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index eeb787b1c53c..0f0f43599b74 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -144,8 +144,8 @@ enum perf_event_sample_format {

  PERF_SAMPLE_MAX = 1U << 20, /* non-ABI */

- __PERF_SAMPLE_CALLCHAIN_EARLY = 1ULL << 63,
 };
+#define __PERF_SAMPLE_CALLCHAIN_EARLY (1ULL << 63)

 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
diff --git a/tools/include/uapi/linux/perf_event.h
b/tools/include/uapi/linux/perf_event.h
index eeb787b1c53c..3db800bc8d2e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,9 +143,8 @@ enum perf_event_sample_format {
  PERF_SAMPLE_PHYS_ADDR = 1U << 19,

  PERF_SAMPLE_MAX = 1U << 20, /* non-ABI */
-
- __PERF_SAMPLE_CALLCHAIN_EARLY = 1ULL << 63,
 };
+#define __PERF_SAMPLE_CALLCHAIN_EARLY (1ULL << 63)

 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set





-- 
Fubo.
