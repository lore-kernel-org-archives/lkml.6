Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6AB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bOlglBQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6AB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeK2Drc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:47:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35025 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeK2Drc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:47:32 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so5244086itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPRo2giHP4PVZbO1Y3GfZGPDjsvYwG4K+xfD8lmZWVQ=;
        b=bOlglBQTDVaIhSgeJkJ2RPsaQLda/yqvUGtnHrvoE8gJEhyFlWENiAUCBEzJGpWQDJ
         G9uvsVAnzg2dMKSwwDhWU9ekP67D6cO7dzXSFbg0j27Y0YEDzTtJ0teK2AEMZOC5VvzI
         8Q2djNw6EgoRxq/zTzOh3EetIz6Ij3EJwUk/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPRo2giHP4PVZbO1Y3GfZGPDjsvYwG4K+xfD8lmZWVQ=;
        b=t1juXjto4aLkNmAJn7QESQZwgQLN09oj5SNrCyQjpGuZkzpl3NjsWYH5JdzWPuaiSG
         DAGlWrEfVc0vpuMz6t4OuMm1o67urIfnpsENhTY6l2neUE9a68sE/DrZ7v1id1y+meAg
         BXrXcH3/xswxegRxEhLzxm1pi81qfPtu+2Eu0tH0Fvc7cnlH80OVETaY95jFrH6SMUJo
         +rXHh1Yr39mgbfzaO7saZ3uNiSuwnWfkAg08NXMnohYtpVgMLTRbeCX752Hg9Qi9VQbZ
         x5NGZVypk8zdXpnt24AzAPhpxwv5t6W44o1Rnrxbgrtv6sHzd4uJwh7iUdsmjtv3zqrq
         HnDg==
X-Gm-Message-State: AGRZ1gJVZHy/drSrTuxMYMKKsy8WLNc5lAOfBL5k/QfujsEV0If4kqhp
        cm8MWnJX63ndXTZmZY+z60O2b64tA3uv8/pVKHQ05g==
X-Google-Smtp-Source: AJdET5e/pVcFtz27DSoFcTMyIeGvK5YFAX1iKPV4rw5diADYE6nCR9OM9PYzepqeEAzrK2OIQV9h2kpmOuyqQWZfwuE=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr33757210jah.130.1543423516345;
 Wed, 28 Nov 2018 08:45:16 -0800 (PST)
MIME-Version: 1.0
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <1543347902-21170-3-git-send-email-will.deacon@arm.com> <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
 <20181128164058.GB2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181128164058.GB2131@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 28 Nov 2018 17:45:04 +0100
Message-ID: <CAKv+Gu_RC6mRqZXfm7Zyhn6KTh-svAZP0bNKa+xQdMa8LOf7PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: preempt: Provide our own implementation of asm/preempt.h
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, rml@tech9.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 17:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 28, 2018 at 04:35:42PM +0100, Ard Biesheuvel wrote:
> > On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > The asm-generic/preempt.h implementation doesn't make use of the
> > > PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> > > architectures which rely on the preempt_count word being unchanged across
> > > an interrupt.
> > >
> > > However, since we're a 64-bit architecture and the preempt count is
> > > only 32 bits wide, we can simply pack it next to the resched flag and
> > > load the whole thing in one go, so that a dec-and-test operation doesn't
> > > need to load twice.
> > >
> >
> > Since the actual preempt count is a lot narrower than 32 bits, x86
> > just uses bit 31.
> >
> > So what is the reason for using two different words?
>
> See commit:
>
>   ba1f14fbe709 ("sched: Remove PREEMPT_NEED_RESCHED from generic code")

Yup, that clears it up - thanks.
