Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBC220859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Rxxq7Ua9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfAQWBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:01:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41272 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfAQWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:01:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so7419669oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtLJ4I/FwlqrLLjq78H2PTu6xyGelPhrqMXBqV7TTxo=;
        b=Rxxq7Ua9ieNso3+5hNghfxgX/hhj2TUWo0Zq+dVhyku1eqq9nrKV+kaLUml99YZJ/0
         6MBGUvR/dHhG3VLCQzJworqtvluD9jRuhJPR8OYqtB+Ivuuhi33Hqd0GFhU8gpFe8ZmY
         P/5SUTkvCoyYUwrIDnNsUa7NpZmjqS0zjXktAs12k6D1SIoQXW6b8PtmCcJtOf1oEaFZ
         YHK+/D5ro6uE8IJpnQwGXXYxgw/8climNYHqhqRWjlzC2wYp+wNcmz326uRBaZDZYglQ
         hq9/R1Nznw2o2KpjF5Xg6gA7ZtVbU420I70t+1juNPmoYWiwZPwdmT9wSLoyXskQOqBO
         JY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtLJ4I/FwlqrLLjq78H2PTu6xyGelPhrqMXBqV7TTxo=;
        b=oUVpCUr+IfYKDkLfLN3/FXCUN+VEr39jDkq4c7VRVbZf4a6w/wmH19qqQFKTrvgkZ5
         cwdAwO5QyMGZ/g4sS2WRTZhAKY3eRLQEMl3/PmFAxBF8MXtk53BQFdVLwCPHyL7eL3k3
         pGXljOYQmbW21p5r0KFIwZac5x6QQonY28PtI4cymJvNWhoilr3XeAilITY2OQ2A0mMg
         KqPGmzWNysPAYGZ8gIRuLAoUo47o5HEQ+d0lu1baespgRQxvQzKojAJbSiKN6l+UxJfd
         sX5/yYVWwnjM9kRSUEJcMyruhx44XvQ0nwyAx1zkMXs9TbXzp45MnvRVlVGc5C5dJcBg
         VpqQ==
X-Gm-Message-State: AJcUukdFmi/QDz13PWJx1jtYPAZoMxo8EmeFk+BmRC0N9LeRqBu+hPt4
        PFKGPrN1mJTO3FY19HKVWQ2V+Bz21UJgx5rBisCHdA==
X-Google-Smtp-Source: ALg8bN6ksW6ITAadjCRpf4OByVx+Wac0vuYSGDTjVRfCpqtUtYypemhM+1YCaFW0Co5kJ0aogt6tpcUN3Hgv4DQfPfo=
X-Received: by 2002:aca:5ec5:: with SMTP id s188mr2223804oib.340.1547762512303;
 Thu, 17 Jan 2019 14:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20190115183643.120619-1-trong@google.com> <65bb2ab8-4929-db7c-9d54-491d87ec23ae@linux.ibm.com>
 <CAKwvOdnkmnuNNVRx4cTUca7J7aFwzqH---+vmP8Cr3j55qaC6g@mail.gmail.com>
In-Reply-To: <CAKwvOdnkmnuNNVRx4cTUca7J7aFwzqH---+vmP8Cr3j55qaC6g@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 17 Jan 2019 14:01:41 -0800
Message-ID: <CANA+-vBReJnUMJE4H-BcNo92dgtd9XKafAc6PKFJe21c+3DmrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gcov: add Clang support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 1:30 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jan 16, 2019 at 7:17 AM Peter Oberparleiter
> <oberpar@linux.ibm.com> wrote:
> >
> > On 15.01.2019 19:36, Tri Vo wrote:
> > > From: Tri Vo <trong@android.com>
> > >
> > > This patch series adds Clang supoprt for gcov.
> > >
> > > Patch 1 refactors existing code in preparation for Clang support. Patches
> > > 2-3 implement necessary LLVM runtime hooks and gcov kernel interfaces.
> > > Patch 4 simplifies config selection.
> > >
> > > Greg Hackmann (2):
> > >   gcov: clang: move common gcc code into gcc_base.c
> > >   gcov: clang support
> > >
> > > Nick Desaulniers (1):
> > >   gcov: clang: link/unlink profiling data set.
> > >
> > > Tri Vo (1):
> > >   gcov: clang: pick GCC vs Clang format depending on compiler
> >
> > Overall this patch set looks good to me. It introduces a clean way for
> > GCC and Clang specific implementation details to coexist.
> >
> > A quick test compile using GCC on s390 with the patch set applied was
> > successful, so it seems like the existing support is unaffected.
> >
> > There are some detail suggestions on patch improvements that I'll post
> > in separate e-mails.
>
> Peter,
> Thank you so much for the valuable code review and feedback.  We'll prep a v3.
>
> Tri,
> I think you should change the authorship for the patches to yourself,
> and add a "Co-authored-by: " tag to the commit messages.  Can probably
> squash this series into 2 patches; the one that separates out the
> shared code; and the new llvm additions.  WDYT?

Squashing into 2 patches sounds good. I'll leave Greg's authorship in
there though.
