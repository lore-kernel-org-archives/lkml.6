Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4CAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4916720652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n09WrJ5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeH2XFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:05:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2XFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:05:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so2738917pgo.3;
        Wed, 29 Aug 2018 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyglwo1MnkUjmvttEh+meRF/V1woEjruCdTcLUwO5bA=;
        b=n09WrJ5jTcQ/mnKRW+t3qRAJDnT3QwPw3hI45IEq08CFD9STKuQuqAZSofdSLVqI7C
         fElOlGXW5aBRs+KtdX2G3Fk2OHEzXL1zQqpuqtIA4WXahheM39B76wXMOyQv+tsA720/
         WKfJ9ovLSzelj0rNot7Sx3LdL5UhcH58jUdaXc9IFhCmzCzD7jQMF0qUmyHZYUDgx4aS
         gVqxiRSUmi22otLxCNAXpyZ3Zq8rgOacPIr7F5ga9q7JLfXoLyKWn6NJ0lXG/vrysCBW
         XfFTprru8qna3JG0PFKkfUna9cNigFiHzfjdLLrBC2RCohTZf4jccuryWnFPqbA/ruTh
         ID7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyglwo1MnkUjmvttEh+meRF/V1woEjruCdTcLUwO5bA=;
        b=s1JZWdHYu/DaYSL2v356EzR7Bq0tQVwFgcDFJh7zGwsXbTmLTAJXlEIVLmoRvm2DGZ
         5zxZxwsHyp9xKoSb9n/u0sjZo5O9V9q3xv+nKIxpz/FYpSGeboSgjUkPPWzTXQimUpdl
         Ia2e8aGIKQASVstDJVK/m1TdBozDbI+C35FJ3sBavh0TY41rDY4FnWEsTsRGhJqku5/E
         YPi2+Nain4DdpuD2+q31+wbIo0OAN+QXNkYGZ88o/aX5fETSfEjJZWBAONHd//FxmEiM
         65UupA1jBFYwn5QJ5OwlgtV4CXLjGwGzrE12fEnF4PYRtrxlLWJNRvfRH7rgE8fNk8WT
         OCeA==
X-Gm-Message-State: APzg51BJmRNrgM4dt5v1orO08fHyMRktEkpKMNATafsiUU7CAkagruqH
        FPsaDe/Ce+DTk5dz78ts6LIIBg/ZBorfv/UtnxdDxGU8
X-Google-Smtp-Source: ANB0VdZJju5l4zyBePjan/Tb65IHN7QkWecTOv/T8Zd9TSM2KaPHGojC51aYhxlhDn6H/xsQ/Ek4u3W9P/Px28N6YAQ=
X-Received: by 2002:a63:4909:: with SMTP id w9-v6mr6773991pga.123.1535569641817;
 Wed, 29 Aug 2018 12:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk> <20180826225749.GY6515@ZenIV.linux.org.uk>
 <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com> <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
 <20180828000310.GE6515@ZenIV.linux.org.uk>
In-Reply-To: <20180828000310.GE6515@ZenIV.linux.org.uk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 29 Aug 2018 12:07:09 -0700
Message-ID: <CAM_iQpXk48ip4dAKpc-HMwxf+wC6eYAK-atpsCSv7T7u7sLFMw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 5:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Aug 27, 2018 at 02:31:41PM -0700, Cong Wang wrote:
> > > I cant think of any challenges. Cong/Jiri? Would it require development
> > > time classifiers/actions/qdiscs to sit in that directory (I suspect you
> > > dont want them in include/net).
> > > BTW, the idea of improving grep-ability of the code by prefixing the
> > > ops appropriately makes sense. i.e we should have ops->cls_init,
> > > ops->act_init etc.
> >
> > Hmm? Isn't struct tcf_proto_ops used and must be provided
> > by each tc filter module? How does it work if you move it into
> > net/sched/* for out-of-tree modules? Are they supposed to
> > include "..../net/sched/tcf_proto.h"?? Or something else?
>
> If you care about out-of-tree modules, that could easily live in
> include/net/tcf_proto.h, provided that it's not pulled by indirect
> includes into hell knows how many places.  Try
> make allmodconfig
> make >/dev/null 2>&1
> find -name '.*.cmd'|xargs grep sch_generic.h
>
> That finds 2977 files here, most of them having nothing to do with
> net/sched.


Moving it to include/net/tcf_proto.h is fine, as out-of-tree modules
can still compile by modifying the included header path.

include/net/pkt_cls.h might be a choice here too.
