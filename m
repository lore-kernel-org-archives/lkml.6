Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9A8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8MJCjgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9A8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeH3JBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:01:08 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37015 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeH3JBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:01:08 -0400
Received: by mail-wr1-f53.google.com with SMTP id u12-v6so6741825wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3uoUtLLgl0X3dQ39bvq4M6NJmP+9aOoScrmE9rM+8A=;
        b=Y8MJCjgdGlX99+qXn9PVB8GxquEa9LLfORkEXJR8glItteYKlDZfJQrLifl58cyaA5
         uoHToh0bp3X2WforY2aGCeIGxkZz+ZQFUfVHXIc1qVTrfQo0yceiIBTkj/2x9xCMSXCt
         l55BI4ZvrDor4qYckD8ioixYqbZXDygUhLbcKUQc21bqIxK+sLPg4yPZf+WAFw6Ebmk0
         EYtW898ENMDgKlWOn82z6scuSZEgMP4zpaddE+2ueTvmMYPB/u5kiXPT4T+GobfZARLw
         s5C93xf1Wvla1h4m7dYkyd43JSivp+JE7qp7luGD4TRhgUTAdAG7ABPN11f6K/XrzLPL
         2yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3uoUtLLgl0X3dQ39bvq4M6NJmP+9aOoScrmE9rM+8A=;
        b=ayn5mZ73L9br/YIn3RlTK6Nel+MvaYavOMjYR6BLk6eNkCdNSD7+F+rLAEOnQajEgq
         YUsBxkCQBAblndwkrkqoGff7+7dqLptsf+INm0Zf2bpixA03EG9pL5LoBv3KLYZYNbEX
         /AzRZw2cmh2j0yoMj2qaS1qCnxE7VXwFvDms4MB4F0OClqrherg3bD+qBgfrm9U8Dp1D
         tbYFreTpaJmNLIxz2UDSzBYjObYEGx8GZbxhIP2T573kuMhQwSATMgEglxEYCv2elJVe
         gI45177zFhaoc45ahia2uBRLWdc0BKSlrCJTufJ94cvbbOoYsIT/pusHKed6n6BaTjPB
         8qYw==
X-Gm-Message-State: APzg51BVdNU1IZWgd6wlz+HnzBYWCTu4qUcFDzR7cp88fX/a4oVq1oIy
        giDSQGcoc+K1JxBLsC4JM/ofkZsUEdPckqccGd+W9A==
X-Google-Smtp-Source: ANB0VdaF67fV0ulShGOtfuuCn9/wns1uzW7hMTBXIY9SNQgsaBgZ+n4blvWy0FlPP14I5d1q8zsbU0bG5qXiyn7doCk=
X-Received: by 2002:a5d:45cb:: with SMTP id b11-v6mr6239104wrs.122.1535605248349;
 Wed, 29 Aug 2018 22:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
 <20180829135440.GA25381@kernel.org> <CABPqkBQ1iTg3bkovUykg86r0kj6jaVbb_f=BCVHrLN+=S5jVZQ@mail.gmail.com>
 <20180830003327.GA3164@sejong>
In-Reply-To: <20180830003327.GA3164@sejong>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 29 Aug 2018 22:01:17 -0700
Message-ID: <CABPqkBTH+F==+kBGv07+kcXK5EMaHmqQVvSbr8ho=99wncHMnA@mail.gmail.com>
Subject: Re: [RFC] perf script: callchain handling is not useful
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 5:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi,
>
> On Wed, Aug 29, 2018 at 08:14:12AM -0700, Stephane Eranian wrote:
> > On Wed, Aug 29, 2018 at 6:54 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Aug 28, 2018 at 07:41:31PM -0700, Stephane Eranian escreveu:
> > > > Hi,
> > > >
> > > > I am doing the following simple collection with callchain and load profiling:
> > > >
> > > > $ perf record -g -d -e cpu/event=0xd0,umask=0x81/pp  my_test_program
> > > >
> > > > But when I type:
> > > > $ perf script -F ip,addr
> > > > ffff9d4821346878
> > > >         ffffffff9d58df25
> > > >         ffffffff9d58e054
> > > >         ffffffff9d5965bb
> > > >         ffffffff9d640650
> > > >         ffffffff9d697d06
> > > >         ffffffff9d63ec60
> > > >         ffffffff9d640322
> > > >         ffffffff9d64070c
> > > >         ffffffff9d455a60
> > > >                   7030c7
> > > >
> > > > ffff9d4638ba84a0
> > > >         ffffffff9d5df447
> > > >         ffffffff9d5eaf4a
> > > >         ffffffff9d63e165
> > > >         ffffffff9d63e439
> > > >         ffffffff9d697d98
> > > >         ffffffff9d63ec60
> > > >         ffffffff9d640322
> > > >         ffffffff9d64070c
> > > >         ffffffff9d455a60
> > > >                   7030c7
> > > > I also see the callchain and it is not clear which is the IP. Further
> > > > more parsing becomes more difficult because of multiple lines per
> > > > sample. I understand that multiline is likely because of
> > > > symbolization. But if I don't want symbolization, it should be
> > > > possible to print all in one line.
> > >
> > > Humm, to have this not break possibly existing scripts, perhaps we can
> > > have something like:
> > >
> > >   $ perf script -F ip,-callchain,addr
> > >
> > > ?
> > >
> > > And if asked explicitely for the callchain, then it gets added in the
> > > same line?
> > >
> > Yeah, that should do it.
> > Thanks.
>
> I found this:
>
>   $ perf script -h |& grep -A1 hide
>       -G, --hide-call-graph
>                             When printing symbols do not display call chain
>
Yes, I had found it too.  But my problem is twofold:
   - ip should not include the callchain
   - callchain should be printed in a single line
That would make things easier to parse.

> Thanks,
> Namhyung
