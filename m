Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2643C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8119C21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c3BWfxji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBGWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:53:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45646 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:53:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so1137103lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhSNRD1YNL95zw/7uEGz3G0NGJgHNBHGk+Z0V0EY+OA=;
        b=c3BWfxjiyJH2n+C8OH4ICqaY0qDLGHSdeuEQlHjL2aeJfGi8DOtBUGAc8Cpuw3DQzj
         Iof7dKRRGqRD+SRqieKipjWX18nC4zGnM+ekgTeZeQ/LdGrfHYO5FcOlks5g2LJLKkye
         blHxMCm/xworKcgtne9LjC7hN9yibqtbSodn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhSNRD1YNL95zw/7uEGz3G0NGJgHNBHGk+Z0V0EY+OA=;
        b=KmftMrqnxO5mxa1HzNfMIcPtliLsW8qGqk4C3VYfeSOprI6/hYX/CctMfV4EODaesB
         eWyeCxAI1Rv7kry1/Q4DsZFVQkK78AwrsJLJI+0Jnvz00tHzuKQyYTu3NSnLxaPHGP8o
         cm/jq5nRA8g39+Y2xlqHGAbALIPVdzDwtn8vuKdGPYhCBDCo2I1wM5WCFXP/cMEnIq23
         mFhqnz0GK+L8kWnJu5z2WP8c4CsUIJUZu+zHrLZb1kRH6dvE1sVNcaZ7/uAhsJfhuqqV
         hWSIgdITPM9hc5YvBfzVna0Rq+c0tXXOJUvZ7u1rOdWE0OYSXSU6bgNa1WE8LcTN/gkM
         UW2Q==
X-Gm-Message-State: AHQUAuaVDFIfsbxoXyDS2oK76u4fthfCMrraR2XkLp9pJgAukGvV56W2
        vTY6/eFPOAtcymdVcrRcqHL23HQqmGjBRQ==
X-Google-Smtp-Source: AHgI3IaGI9fXo7Dec10D3l8a0KuTrNsgUZouy1zrEkPtbIMvEY2SShleWQIk6N30FfavMVDiWYvqNw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr11801114lfe.154.1549579999177;
        Thu, 07 Feb 2019 14:53:19 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z17sm53672lfh.9.2019.02.07.14.53.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 14:53:18 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id q2-v6so1327939lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:53:17 -0800 (PST)
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr11084699ljg.87.1549579997436;
 Thu, 07 Feb 2019 14:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20181224231106.GA27438@gmail.com> <20190207001737.GA32096@agluck-desk>
 <20190207101846.GB32511@hirez.programming.kicks-ass.net> <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com>
 <20190207140131.GB32477@hirez.programming.kicks-ass.net> <20190207173600.GA15682@agluck-desk>
 <20190207175720.GE32511@hirez.programming.kicks-ass.net> <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net>
 <20190207184606.GB17049@agluck-desk> <22E08A6D-5180-42F1-B94B-6B6DB832F953@amacapital.net>
In-Reply-To: <22E08A6D-5180-42F1-B94B-6B6DB832F953@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Feb 2019 22:53:01 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiZ3t_YbtRz1tLTEvF0JS1DH07DdDR3FP-FHcZW8wfSAw@mail.gmail.com>
Message-ID: <CAHk-=wiZ3t_YbtRz1tLTEvF0JS1DH07DdDR3FP-FHcZW8wfSAw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v4.21
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 1:24 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> How bad would it be to set CR0.CD while fiddling with the page tables rather than masking the address?

I would suggest against it. When you disable caching, things don't
just go "slightly slower". Everything comes to a screeching halt, with
instruction fetch etc becoming a serious problem.

So disabling caching for a few instructions in a very simple asm
snippet might be reasonable (particularly since you could pre-fetch
the cache and just rely on CR0.CD not fetching *new* lines). But doing
it in C code that might have things like tracing enabled etc? I'd be
very very leery.

                 Linus
