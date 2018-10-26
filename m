Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC1CECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604152082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="id4xYm99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604152082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeJ0Fkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:40:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34870 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeJ0Fkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:40:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so1088011pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2v49H4PXzvnQzFzstL378Q9bQJ1v/h7kxuP4KYuMic=;
        b=id4xYm99Sb01QD3CzYGCwExnrnA1/LmGoYe8lUVVLzG2IPegk1BjGxy8CrYP9hEvGe
         +Vf3faCkRCr5v0y3zdeAcLbAe7YTVpV0bT1CicORIHXz3K93xTTaO845EdQFP+yUIoyI
         urSbB1QtZGHcbDAqPx3xb0mvPt4hq/Y8iIh+5k0h4rhtEHqAh/pAvX2K/ZaqvhZYMRv5
         hs0BzHTDKxbq3hLPptLgKIpExv5Nfwt+HZmf/mLA8Fm7okmPoeDg0/wdhTm4g0GleRSK
         osF9C+F+Btvmdy9ZeBZA21XtKox+Q6MpO1J4fYNj7uiB5PJsKRBM9LC3hisLSG6u1mgf
         Zjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2v49H4PXzvnQzFzstL378Q9bQJ1v/h7kxuP4KYuMic=;
        b=Z1JLV7ynogwJWpOfr3STF7lb50GNj1N8D0w+2upFOU3iabh64ZB8YvOa0fD62TMtlU
         o+ElJz+jU52ucg9+7cjrN/WzZ+YUzoimdqY3/1UBswSeTB9jxbuDUw/MtZn+fEH2isfO
         yofNPWl9CX7BGO2k+WjeAzLJ7PFrFitBd7hqoly4tzxeg/b2IjMmLKUrDL3AKWCSlmGX
         Yw5xY8dwI86ZkMXgjMU0I4GDDainM3g2p0IG0dHFMwE3okPt5nxa8o6M5RMMBeNwjDfm
         42D98xsZH3Ug/r/bnaX7pQl7ei0B2W+tQn3YRS+vfY2iPNdZBTJoXRFYsBrzvgWeHpC8
         i2mA==
X-Gm-Message-State: AGRZ1gJxkHiNcXgwtSghes7TfwXar8Po6WB7+N3fNxWqtW20CBdc3Hr3
        bN9zB/E1L4N1AvhBtLAkasPDoQ/24q1mJsIw/2JrbA==
X-Google-Smtp-Source: AJdET5d2Ezhdsn3anwvDkmoHY+6fxwDgHcbV88Sx1jBcqwQNIOVQn0BVC0yHyh0/xYd535Tj0k0On5nmAcRcWeExVB0=
X-Received: by 2002:a63:a064:: with SMTP id u36mr4979648pgn.145.1540587737926;
 Fri, 26 Oct 2018 14:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <20181026180515.GA12129@flashbox>
 <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com>
 <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com>
 <CAKwvOd=c9RG2s3f-PgM1T84sHc5N9zcjrVpG5is+mGbTOxvtrQ@mail.gmail.com> <CAHk-=whazvE2VnJiSFeQ_BzU2iUUt=v8BxhgJyq92ecDayJ14g@mail.gmail.com>
In-Reply-To: <CAHk-=whazvE2VnJiSFeQ_BzU2iUUt=v8BxhgJyq92ecDayJ14g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 14:02:06 -0700
Message-ID: <CAKwvOdknFO8h0q2zekThPiwije6_LYMjAktrX___Oc76o=Qhdg@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bvanassche@acm.org, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        hch@infradead.org, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 26, 2018 at 1:06 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Is removing a filesystem considered a userspace breakage?
>
> Yes - if a user notices.
>
> The key word is *USER*.
>
> Note that it's not "user space". It's not about _programs_ noticing,
> it's literally about users and their workflows.
>
> If some change breaks a real user workflow, it needs to be reverted.
>
> So this is not about ABI or anything like that. We've had cases where
> the ABI stayed the same, but the order of device probing changed, and
> that broke peoples setups (because now /dev/sdb and /dev/sda switched
> places), and we had to revert.
>
> It's literally about "if a user upgrades a kernel, and something no
> longer works, it's a regression".
>
> In general, a good idea is "if you have to wonder about it, just don't
> do it".  Because it turns out that users are odd, and often do odd
> things much after you'd have thought they'd have long since switched
> to more modern hardware or filesystems.
>
>                       Linus

Makes sense and is a consistent stance.  Thanks for clarifying.  Will
pursue the smaller fix in the other subthread.
https://lkml.org/lkml/2018/10/27/55

-- 
Thanks,
~Nick Desaulniers
