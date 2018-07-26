Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D99B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRs+J4b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D99B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbeGZRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:49:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35220 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:49:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1056745plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oe4vrc/P43KVf8Hg1AcoCPYjxvh9zVIbduGWRymWadw=;
        b=jRs+J4b2IzYXM1SHDx5fM+6xxLaKv2h7NPMb0I7aFy14tcYwRqCGxHtpUrgg8gR8xq
         BY0Ev1cWVUQ65BXRlJSQoMi/XVg8zbtrHup8tPAPjCgCmLZDAfUb0NVChtGW+PaQas/T
         s9SbCTtggUgBONO9nJ2oIXOkmBVcDCtouqvkGVzVD88OltlOcTi6LBgrlHpB8qM62VaA
         h/mPyLxccyg8RldKtKDmJddA8v//WOwc6oboZNK+m1q0JCw7o/MZwigIIB3ySEbOHNpb
         xDyrJ77VxK+sh9fzjwwe3Zl9/zGXu9sPur/Y/XX96QX9s0uvGpFzygYj/dFs7u12ED3p
         b8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oe4vrc/P43KVf8Hg1AcoCPYjxvh9zVIbduGWRymWadw=;
        b=axtnuUbMme3LCbjVBsIj92WK0jzQntvjMjZhN9pASUMiJUNR9TeHgE8qQnhigkMR5f
         +X8cL1ti6ZDQGmThVBblS18JB+wuWqgok23esK8WIPUWu/PelsmYSnFEccrrqnT2mTH5
         MYIreuEYrOJYyS40m/V2yWo9Hejuz/Ay5OS4Yo8krkRSDXw6WLqE3W44boLpG0fg4N9S
         8QXj81ClO0MBa0KSlAC+DC2jXgg+FMd1nB9glGht4aBEeVKau2VRAKHAfecOTZvFaj39
         C18Q6JCFDv1LEIER3CXdQTSu18afWqG5NDVjWdRmqbVyhmdnDhV09MGSH6Xlf/s0ugjO
         KBKA==
X-Gm-Message-State: AOUpUlGNsxd5pcpzlbNOkFtBPsQvK3L2Y4gokcPF2wwyuktOrbzJySoW
        WdoVSp2J30yehAB42zUBCnMjMba5q6juzrtpDDXgKw==
X-Google-Smtp-Source: AAOMgpeYLmlxCb9+MfCfStOJmkmTuN2WL/ijeDIOQl61BOXYwpOeTlHgsjnBejG3m88whcnZJQo5yYxt7TKM1Ud/uLk=
X-Received: by 2002:a17:902:64d7:: with SMTP id y23-v6mr2592533pli.53.1532622738464;
 Thu, 26 Jul 2018 09:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726112245.3c1bf91d@gandalf.local.home>
In-Reply-To: <20180726112245.3c1bf91d@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Jul 2018 09:32:07 -0700
Message-ID: <CAKwvOdknFPpyQx17EbixnydJukuX4kH8=xVTS_9qnsERKCoPkQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     rostedt@goodmis.org
Cc:     salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 8:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 26 Jul 2018 08:14:08 -0700
> Mark Salyzyn <salyzyn@android.com> wrote:
>
> > Thank you Steve, much appreciated feedback, I have asked the security
> > developers to keep this in mind and come up with a correct fix.
> >
> > The correct fix that meets your guidelines would _not_ be suitable for
> > stable due to the invasiveness it sounds, only for the latest will such
> > a rework make sense. As such, the fix proposed in this patch is the only
> > one that meets the bar for stable patch simplicity, and merely(!) needs
> > to state that if the fix is taken, perf and trace are broken.
> >
> > Posting this patch publicly on the lists, that may never be applied, may
> > be the limit of our responsibility for a fix to stable kernel releases,
> > to be optionally applied by vendors concerned with this CVE criteria?
> >
>
> The patch breaks the code it touches. It makes it useless.

Doesn't that depend on kptr_restrict, or would it be broken if
kptr_restrict was set to 0?

> If you want
> something for stable, add a command line parameter that just disables
> the creation of that file. Otherwise you will break usespace and that
> will be a definitely NAK from Linus, and for stable itself. This is a
> very minor security issue, and does not justify breaking userspace
> applications. I would be very upset if a new stable release broke both
> perf and trace-cmd's ability to read certain trace events.

I don't disagree.

-- 
Thanks,
~Nick Desaulniers
