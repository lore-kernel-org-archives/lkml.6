Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A72C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18343215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnnalDaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18343215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHCAXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:23:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeHCAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:23:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so2104469pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnnFiTr+gowHsIMXxEA/2izMmTShehwD0fbhtUXT4qU=;
        b=EnnalDaq8sB+aj3ExwWbhsIu+NnzCOgmRhzRTVGYBwmue9DRgGt8qilpWuh599SHLo
         SHzYSVrcZp3WV5H97EVNPkvLCjdqBjgsJY92SI/EXPQpKbeClHh/jhpOwhqnjv+6WYDc
         ryUfkKeQLs0lYSBHjSGAqL7T/22TR0IbTAHuegvqfNPDDKMsdMTOvFL9HTQVOBUAh433
         yKMtzDVNpLI0npM1awx6uiRJlod4J/S1i1pyiiaUT6xYiAINgg7SHQE4OAvhREenhAkK
         5Iznst0iwk7NeHZ3b554Nxj9sba8amGlmSDY7PMS+U3rr/CWHjZz8AQJ7PhmjMPek1qe
         JFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnnFiTr+gowHsIMXxEA/2izMmTShehwD0fbhtUXT4qU=;
        b=KdxfXzNKo0uNwZLQt/zvNu95ir0kXSx8ixyP644Pw/LJiln6fLMGf9xPm0cPdKGqWc
         kOR5zuAR0ckdDBDoFAKTosHHnVB3MrTbmlpi/HTEvMRAXurlib4aQ543aViV3LE2gTwo
         /MfpNNUeRk8XLCs9iPNT8u6vRTm/RDFdnkyzux8+ervMuvny5EHXGe8SwxDyjxeBiCfB
         04+JJKWxZEhfn5ymfLVGIw3fg+yqtTpDsJgR4S0v7aIlmVWjmtDjIAbruiLOy92izIIf
         Wd6eOv6DbLW7O/N1yL7YE1uHmpBjKH+fNsvXNs+RD6hpAzBIfK9J4AcpWf7VuQLWUOr+
         zKpw==
X-Gm-Message-State: AOUpUlGwazULCe1ntC8CzOaTKhTcg+L7wiWDvQ1zxvf/FALYjoBY2XdS
        smP5OOGEmFFhqgdAqELrM9x6Y9kdD/kG+kZX2/kwOw==
X-Google-Smtp-Source: AAOMgpeFAegnFWPGScM5YsXgzGlpW/8/W80z/fiJn7mM/QKxGlnYKwKsvX6RF+LKNNlm0Xy61s+knBzrMFRBNVXqci8=
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr1190514pgz.192.1533249003476;
 Thu, 02 Aug 2018 15:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180801215759.103758-1-ndesaulniers@google.com>
 <20180802.144234.41564686794492805.davem@davemloft.net> <CAKwvOdnp7R094sbsyKi921ZVB8BD+d-8L37mcPv0UjMMF4QqDg@mail.gmail.com>
 <20180802.151740.166085629835691260.davem@davemloft.net>
In-Reply-To: <20180802.151740.166085629835691260.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Aug 2018 15:29:52 -0700
Message-ID: <CAKwvOdnujUd-3bT2LJEo=4ApnismX7LbQ_PhyzKcY4XxiS+77g@mail.gmail.com>
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to current_text_addr
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 3:17 PM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Thu, 2 Aug 2018 15:10:00 -0700
>
> > On Thu, Aug 2, 2018 at 2:42 PM David Miller <davem@davemloft.net> wrote:
> >>
> >> From: Nick Desaulniers <ndesaulniers@google.com>
> >> Date: Wed,  1 Aug 2018 14:57:59 -0700
> >>
> >> > As part of the effort to reduce the code duplication between _THIS_IP_
> >> > and current_text_addr(), let's consolidate callers of
> >> > current_text_addr() to use _THIS_IP_.
> >> >
> >> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >> I'll ACk this for now:
> >>
> >> Acked-by: David S. Miller <davem@davemloft.net>
> >
> > Thank you David.  Should you take it into the net tree, can you please add:
> >
> > Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> >
> > to the commit message? This will help us as Nathan stated previously
> > in this thread.
>
> Why in the world is this a stable candidate?  It doesn't fix a bug.
>
> My understanding is that you are trying to do a consolidation of code
> and clean things up so that only one interface is used.
>
> That means it should, at best, go to the net-next tree.
>
> Thank you.

+ gkh

We're trying to provide backports for all clang related bugs and
warnings to the stable trees back through 4.4.

-- 
Thanks,
~Nick Desaulniers
