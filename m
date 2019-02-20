Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B599C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F7421738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJbCgyA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfBTDEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:04:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36518 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfBTDEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:04:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id q11so16407590lfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 19:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhxZlFeYUb4G5lDIEjealo23e9D8ONoUZ/+0YBaV8hs=;
        b=DJbCgyA4qwnINIHE60zPRs789mbwnwkxLqw1GrDKuGGcvjMa4rc6Y5gWU91hEfGdwE
         fWhon3sqNdt+bQ1aa4DayVcOUbS1Sw1WTSnUcUaj+eSald6InzkAOC275XXULbUp2GjT
         tmvmVbzfDOqBNX9AIdhEmZQDEpmsdE+mFCVJUcS1RYdxbNv6Wgy1AMlXSDLPD+f3H0zp
         vv5zpwiMs1NBeLr0bS5XioLkdOxc7hs30dF4/+d7tvXzUCen1YfS2idjSLV/jb6ffJY/
         uL0Ue1V88gJNKOVuZ/XHNbDsc88D+SilY6O4GHNkoM8j9WyJ/7/u0RJx5GEaDV+2UHmE
         ZjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhxZlFeYUb4G5lDIEjealo23e9D8ONoUZ/+0YBaV8hs=;
        b=KcuCB3T/sXyd1JUyJTkRx5e2XNE1pllWz4wiFggCupIHho+km0SAZpzOtHTvEBOONX
         G/K+h/G5v27qhwqlOj6NGADACXGkFIQDqBczfxFuGLNDv6IngHr5LDvBHVdfOS4dpCKG
         N72F4xaLhQcP6T8MDka0jVjv8H/X9TxtXqMcL6uBay3rFOo73uKcv9xfZVM04+v6aN1y
         jpM13+E+YMA47pmDhFgeUdYPnEJYil/cILHSdCwvUneU4uUg0ehZH5RiKU+WWQugCOnw
         rslqsHageHsPtq7sKyriUqlOZyQY31Op5jrPATgoV2fwU6iBvYib3esturMnMd0Y0aaJ
         TTOA==
X-Gm-Message-State: AHQUAuZSkav0k2kWOWBHJBt7D4jI3Al+qVqKxe7nuc87BiRBpsl/MxFs
        nDoUtRRJrG4NjkYerHqnWUN/WJ34IuHWaVIIsLMaHw==
X-Google-Smtp-Source: AHgI3IYrGdWA86kVugXeDWK64GRWScHPiQuFtJnmjRK8eEhl686kGwxlScIdEOYxZBGPTPh4ShWcf8QcCAZbgQ64qE8=
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr4084417lfc.124.1550631843464;
 Tue, 19 Feb 2019 19:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20190220113729.49f28f73@canb.auug.org.au> <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
 <791e9e85-411e-385b-302f-4a4224f76286@iogearbox.net>
In-Reply-To: <791e9e85-411e-385b-302f-4a4224f76286@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Feb 2019 19:03:51 -0800
Message-ID: <CAKH8qBtqcx+qXKpq-xNq6_MeciJghppszSF-vHfp0UKsESkcOA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 5:07 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 02/20/2019 01:41 AM, Alexei Starovoitov wrote:
> > On Tue, Feb 19, 2019 at 4:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> Hi all,
> >>
> >> Today's linux-next merge of the net-next tree got a conflict in:
> >>
> >>   tools/testing/selftests/bpf/test_progs.c
> >>
> >> between commit:
> >>
> >>   f6be4d16039b ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")
> >
> > Ouch. Thanks for the heads up.
> >
> > Daniel,
> > should we drop this one from bpf tree ?
> > I don't think it's strictly necessary.
>
> Yeah no objections, lets move the selftest one over to bpf-next and
> have it properly integrated. I think test_progs might potentially need
> further topic-split aside from kernel progs like we did in test_verifier.
Do you want me to follow up with a clean rebased bpf-next sefltest patch?
Or you'll take care of it yourself?

> >> from the bpf tree and commits:
> >>
> >>   bf0f0fd93945 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
> >>   ab963beb9f5d ("selftests/bpf: add bpf_spin_lock C test")
> >>   ba72a7b4badb ("selftests/bpf: test for BPF_F_LOCK")
