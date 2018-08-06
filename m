Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CCD21A54
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSI/KZpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CCD21A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbeHFRo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:44:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34260 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbeHFRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:44:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so5360458eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL8O5tikn45Pv25rK5T7KHEXv5j1NLsiTb/gKepailI=;
        b=mSI/KZpRwX1YubhX+glDlBNP1BAgY3caKwjQ9lEvESxUylUWUQSljXKWEJ9deBzY0p
         H7o7+S3i21tI5sbBk4xBF68NwiTKCBoS55qVWlFp9lIHeXm0uPexS8GNLV9Og/koxQfJ
         8qt3vNWVDh9/gXHat33mH4Lapc2l+aTj8IpqG1XCqQEws4KbC5L8maqpt7RXh7BrHUJ2
         q1JwNl/cgpbKTPjEaew4ij72g4XKyT7ajUSBPf62Sf9Rv8OuALezSw/fBhNGDD2V6Ue/
         ZwQ3EAFTI0hjEMyG9TyZntclXOwHsty04Vqebn7XzCSOdzMeP37Lb99u2AOHf1m8uzQH
         gRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL8O5tikn45Pv25rK5T7KHEXv5j1NLsiTb/gKepailI=;
        b=smiOIMDRcWPmgSWs5WnpcZbF/jtdHPJBZLLLnQX+NbHdf8vGkbm5TvxwAm5vNKzDJE
         9Af8rMV1eVQv0kOtjUAq5PaAmP6KyBZCc2cENFTHJ/gY8z9eP+QYFDxPMdPsGs0cLZpR
         tMsrLSPYg1tT+IhL7i45wLm6o5VPM68wY3tARAyjn/ET0fFfGK/Orgpw7CVGETI/Q8CY
         5a5jwfDfVjMH6ybGiKKhJLmEP1P0em43kb9IETXJwsBiJ0b/RwKXVO5+zqUYA3zYrKOw
         eMWqpsWtJxRr76EgKX7KtgiSydVxE1FoFGX88lEowJm0uZ+d+Pfs1Us6l9K/0bXlhxnJ
         zQ/Q==
X-Gm-Message-State: AOUpUlGtxKP9HmNTNhg0yvVQ3DAxdZI+Q8js7E97NazWpkAoW0Zn0Z6p
        cDeeiIZlhdJyFvGcMXD36B9qEwA49w72wH5i4wg=
X-Google-Smtp-Source: AAOMgpeKkVAmpZrE3WZ6pnw657YHMyl/DeYeu9X/LR0jF2LcZWmVsDHMxcTXzFJw3QL92Y3NBWAMFuH+U2zp49SidJw=
X-Received: by 2002:a50:c292:: with SMTP id o18-v6mr19386042edf.188.1533569718869;
 Mon, 06 Aug 2018 08:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble> <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
From:   Fubo Chen <fubo.chen@gmail.com>
Date:   Mon, 6 Aug 2018 08:35:07 -0700
Message-ID: <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
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

On Thu, Jul 19, 2018 at 2:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -143,6 +143,8 @@ enum perf_event_sample_format {
>         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
>
>         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> +
> +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1UL << 63,
>  };

The above change makes sparse unhappy :-( Sparse reports the following
complaint about __PERF_SAMPLE_CALLCHAIN_EARLY:

./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits
from constant value (8000000000000000 becomes 0)

Is the above change portable? Isn't a compiler allowed to use 'int' to
represent an enumeration type?

Fubo.
