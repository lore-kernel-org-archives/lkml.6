Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4897C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B19208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K9KWD8FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbfBSAaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:30:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34451 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBSAaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:30:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so12484087lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zKkxq7u9soSKx977a2TN2khMo8GljzoTf2CcQJBrew=;
        b=K9KWD8FMFZ3Iohm9XcQwvNm0TlzOyLhGMMfHG9LmvM6vXr7HmmUPHrwvB7yGDfzfXO
         wzuvgA/2RFz3rktcQUCGWn83g3CSYbYigjsJ40BQpTBTbYb4NxCULqfs0iYrQ4+TJrP8
         yo0MjD3NVUVr+ganHwajFzdazuEYrtmGWDjGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zKkxq7u9soSKx977a2TN2khMo8GljzoTf2CcQJBrew=;
        b=p3W0lLqxwGuxXRIluSXR5dDJ58dsxqGrV6uNMy04OFSSiUpkQgpaD3AQI7WketLoeU
         I/dE/edR0zVGzSYKKM9jAxMkP9yWK+2tYNNNw/eaSiPKW+qxixkPCQQs12uuiuBhun9L
         GdhFEieso9RQrcXe+geMc/NKmDwxyiJ/5N7wRHmB6axuuZgwjgauvkVWJRE3wTUfdgxz
         QKBqLjnN4fMxvP8HLMlufpIMxwdbN/gxojcVbvplfSXznnn9fCRHlMdPsAE9sH/rITlC
         sWiB+6/B20VgPbDudyKI8gI8zQX04l3NZ71lfJ6AuAaSRdqOb7OW8I4Lcq+Thdr5qyN5
         TFSw==
X-Gm-Message-State: AHQUAuYUVulTjiCRGo4UdM1RAnpSrb8Y0ahHsfYyEPU0J90rFnkqds1Z
        ngA+405pl6CjdZA2Jjsao8Px0SkS93U=
X-Google-Smtp-Source: AHgI3IZm4Lm5CySqtGsrf6d+RiyjrXSx+qdnTaNVFWKs2r+3vsgCU+ifw6IoYiE9rLxo5MwQz+qWWA==
X-Received: by 2002:a2e:9983:: with SMTP id w3mr14702268lji.71.1550536216643;
        Mon, 18 Feb 2019 16:30:16 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u15-v6sm4374778lja.63.2019.02.18.16.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:30:13 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id q11so13590671lfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:30:13 -0800 (PST)
X-Received: by 2002:a19:4847:: with SMTP id v68mr14958607lfa.136.1550536212763;
 Mon, 18 Feb 2019 16:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190218204020.GV32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190218204020.GV32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 16:29:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVrNomWXRmCjnBJkosiwiGXz5pYb63aXy=nSPGjvc-1g@mail.gmail.com>
Message-ID: <CAHk-=whVrNomWXRmCjnBJkosiwiGXz5pYb63aXy=nSPGjvc-1g@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> If there were close to no VMEXITs, it beat smt=off, if there were lots
> of VMEXITs it was far far worse. Supposedly hosting people try their
> very bestest to have no VMEXITs so it mostly works for them (with the
> obvious exception of single VCPU guests).
>
> It's just that people have been bugging me for this crap; and I figure
> I'd post it now that it's not exploding anymore and let others have at.

The patches didn't look disgusting to me, but I admittedly just
scanned through them quickly.

Are there downsides (maintenance and/or performance) when core
scheduling _isn't_ enabled? I guess if it's not a maintenance or
performance nightmare when off, it's ok to just give people the
option.

That all assumes that it works at all for the people who are clamoring
for this feature, but I guess they can run some loads on it
eventually. It's a holiday in the US right now ("Presidents' Day"),
but maybe we can get some numebrs this week?

                Linus
