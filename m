Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5609C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E63F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkvCoJCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E63F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeK1MZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:25:13 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:37375 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeK1MZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:25:13 -0500
Received: by mail-vs1-f47.google.com with SMTP id h18so15045121vsj.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ3l0e/ToZm/Cn04hbl18tbNiXzdDX71jwm4HjGu+Yg=;
        b=vkvCoJCK/xaezKMUhIuvSbRMnXdi3w1Mm5oSQSxOh8/pt8vwxtiUF1Ja70TEEzVw8D
         Ldi511p337Wgp2ehTJ0TDVg7irmo6volo8KuGV8g0CeTz/myLkqm1OCVWHZI3sAjq6fh
         m7QeW1eWJXGThBrlQB8hMMz84WKmtJBX8VKMkt02Abb16yOeaU7nBsOlyeuAkPN/0zIj
         VT69EC+riXpArLtFqIFDXE4l5z2BrPpqI3mmlur6Cjb6EPuRPqODeqJIJ1oAxgKc3lQL
         32sMTdMYyecoTE3wiVOsxDfP10l2a1DT6YXgWWcmW2D5oJVDu80aU0mtKEC3Ky7nPkmD
         TJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ3l0e/ToZm/Cn04hbl18tbNiXzdDX71jwm4HjGu+Yg=;
        b=K6jAhoO/5j1ht8ggmRpGnU+leXKHrfrsh8Bbrp24BAJj6Def3H60LDNGQSEvTYhGn6
         uln0RL36legwklXqxDmWX/XI2TYB/p8Hjpkgolc4gnoT5TZKHLgwf2wGHqWthFIYK+1H
         qVmUm5d/z3laGg3mZNgUtx1ESA4fjoaCi4V9RddSrBM2XSYYTx0FNWzw0MxILAhAqX22
         P3dlWpI0PPnSZlHPJ8x23KZpPYs3wIf94B+mi0A9/B5e8iytzKc4FItdOf4B4G+TvTwY
         tnj8QurQJYlaF5Qj+TO1Al2/GfR1Av3cyrF/CifLsyt+3mIsktNCrdf4hFiPb+UC7HPE
         QhgQ==
X-Gm-Message-State: AGRZ1gLEJhR+ey/6/UrYS+IxUIAyTa15qzRsw51NW9Etdv2eGV6Eismm
        o8QAYuVttCf7mp8N4/JsBEzDE7UkAhxj1nh7kuVvNw==
X-Google-Smtp-Source: AJdET5fNLs5M/VYzQkA+LbAvnnJ38TzTaxYuKedCTPGhECLlC5DcSsEsXv6c07bAl1iQt1lgGfQRf7Re1w0NtmU/R18=
X-Received: by 2002:a67:74d1:: with SMTP id p200mr15318949vsc.101.1543368325182;
 Tue, 27 Nov 2018 17:25:25 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com> <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com> <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net> <20181120223854.GH13936@tassilo.jf.intel.com>
 <20181121081420.GF2131@hirez.programming.kicks-ass.net> <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
 <20181127233615.GY13936@tassilo.jf.intel.com>
In-Reply-To: <20181127233615.GY13936@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 27 Nov 2018 17:25:13 -0800
Message-ID: <CABPqkBQseMq2xnvw71VXT6F=ZR57L+HUAmQ_dZY356Et8NpxQg@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, robert@ocallahan.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:36 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > It does seem that FREEZE_PERFMON_ON_PMI (misnamed as it is) is of
> > rather limited use (or even negative, in our case) to a counter that's
> > already restricted to ring 3.
>
> It's much faster. The PMI cost goes down dramatically.
>
> I still the the right fix is to add an perf event opt-out and let it be
> used by rr.
>
>    V3 is without counter freezing.
>     V4 is with counter freezing.
>     The value is the average cost of the PMI handler.
>     (lower is better)
>
>     perf options    `           V3(ns) V4(ns)  delta
>     -c 100000                   1088   894     -18%
>     -g -c 100000                1862   1646    -12%
>     --call-graph lbr -c 100000  3649   3367    -8%
>     --c.g. dwarf -c 100000      2248   1982    -12%
>
Is that measured on the same machine, i.e., do you force V3 on Skylake?
All it does, I think, is save one wrmsr(GLOBAL_CTLR) on entry to the
PMU interrupt handler or am I missing something?
Or does it save two? The wrmsr(GLOBAL_CTRL) at the end to reactivate.

>
> -Andi
>
