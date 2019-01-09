Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2045BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA0C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuY/z/BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAIFfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:35:50 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:41014 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfAIFfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:35:50 -0500
Received: by mail-io1-f43.google.com with SMTP id s22so5083765ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WVHyTuBrX2Rn5yLapMfjo88L7PXGhBB2wQv9lPJLEU=;
        b=SuY/z/BO2DWvTXym37KH8V9PADURSCmY0mMUoO4f4xmcl63689UWrvJQ8FEUKeg36K
         5NkjRCJpQ4cPfmLojdIX2Y4EZm6oxnxmWU9+GkywRKdI0CTf99R7QiYUskkq48piUr9F
         zZY7l3CUrt+5sB2Rd0G7v60aLi5gw4k6bXcaxbRKA8eFyNF2IaPuGAXocXxfD8eDaMZZ
         gmWQvsVlhxo0rEfjFPSImwOEBMQZRcYrSMYMN6raJSNmJpeIvwTBdQle/KF5ASBlhBK7
         ak0xGRuwPG9va+VCZLdPp4wHAJB8WGKe89ndM+FluFic2ZYPWD05ViviZIvmL+t7TRdO
         j4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WVHyTuBrX2Rn5yLapMfjo88L7PXGhBB2wQv9lPJLEU=;
        b=ijtTNDnan6aed+zwm0hMtpX3NWGS3txEb6tJJY78d168AGr6hWJ3OgIwAaC2nnLRCc
         Ci2pWuGbaQTWQFrYOC7I2rRbY+iGECKSoMhuz5JsbVRie1OQHTMsdUiup7MfJIJ0BWM/
         lc1bxYGmMJV6x9rn84NShGNk2NRWu5yR7xux6FigAuMmhjhbIynedkJN2Gx4YmIVHbxW
         8dh6cDycWcf02W3Rzr3yC1UVpxMWUEKWaX4J4CKIDFridAYFyJS2O3tkXDsZxT9r2dwt
         GVKHrQlyieonWsKo005KyP+JQA2Xq/eF6Y9HVQls4M/tXCeeGy0JsT7qdhxgqg/0k1tW
         Cv/A==
X-Gm-Message-State: AJcUukcwicwmfBZuIV7Vt/v1Q3UVXWeaiTol+qNzk/ZMCzcqeuUJZd+g
        /PnAEJbIKsa73ebkidYM8hMbESGX93miecy82CmXsA==
X-Google-Smtp-Source: ALg8bN6Uai4JR3vMpEO619EBRqHhw+++41b0Xap2GSekLGu8hdb6EOQwp8GsWzIrv4Fk2Yuncsx5DQUqr2+gzMWp6O4=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr2509083ior.282.1547012149087;
 Tue, 08 Jan 2019 21:35:49 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
In-Reply-To: <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Jan 2019 06:35:37 +0100
Message-ID: <CACT4Y+ZaoB7t7DYwrdf6cQ3m_n5=Jz5800zEdpF1oT070bt66A@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Florian Westphal <fw@strlen.de>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:36 AM Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
>
> Hello
>
> On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > Hi Anatol,
> >
> > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > Hello folks,
> > >
> > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > and makes sure it is accessed in a thread-safe manner.
> >
> > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > continued to have some "fun" discussing topics related to "thread-
> > safe memory accesses": I'm sure that they'll be very interested in
> > such work of yours and eager to discuss your results.
>
> Thread Sanitizer is a great tool to find thread-safety issues with
> user-space code. The tool been developed by a team of smart people
> from Google [1].
>
> KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> bunch of work been done there but the project is still at
> proof-of-concept point.
>
> I am not a part of Google's dynamic tools team. But I've decided to
> pick something to do during the New Year holidays so started porting
> KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> fix a few crashes [3].
>
> [1] https://github.com/google/sanitizers
> [2] https://github.com/google/ktsan/wiki
> [3] https://github.com/anatol/linux/tree/ktsan_4.20


For completeness, at the time we also had to add
read_seqcount_cancel() function to dynamically mark all seqcount read
regions. It can be used here too, start read region and immediately
end it. Less clear than raw_read_seqcount_nocritical(), but also less
API surface.

/**
 * read_seqcount_cancel - cancel a seq-read critical section
 * @s: pointer to seqcount_t
 *
 * This is a no-op except for ktsan, it needs to know scopes of seq-read
 * critical sections. The sections are denoted either by begin->retry or
 * by begin->cancel.
 */
static inline void read_seqcount_cancel(const seqcount_t *s)
{
        ktsan_seqcount_end(s);
}

https://github.com/google/ktsan/blob/tsan/include/linux/seqlock.h#L235-L246
