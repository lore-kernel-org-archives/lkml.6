Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CFA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlDxTZ5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfA3PCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:02:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45741 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfA3PCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:02:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so26363956wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sB/R9A+G+1Bml2j6jV9rxRkbOGpZb2kYG6xIswMoOV4=;
        b=HlDxTZ5t3ywYhp9mzWTd4LZa+loyIRRQw/8Ev6pWD6Azy4v+ahkp4Kk0ibJmpz9FoH
         YdaG8Aobh3NqGxssUTKARnBwch4MaiA96hcYKIFqno+/1bh237kAuDIdIoKprhTLnp7D
         9LH3AaAYt8gyzXc7y6ryD8gB5gOjV6bQbZ+DybDNorFlrP8wto1FGrYUzOXwNH9mMtet
         tpcxPsI3Bq3IREviG5R20PzQSD4TymiCBq2ts+rrNhRNQsQzPuo0LDf8siJxtmVwF56G
         YYZqFnxuzq128CLk3UpvgyPlV/+ognoN/iu8gwmm28Zv5TsSPLQFC7EMGQVr1CxW2LwN
         ljQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sB/R9A+G+1Bml2j6jV9rxRkbOGpZb2kYG6xIswMoOV4=;
        b=bmgg8OtMTouArUdnUR21CoRKTHiPwnwtqGbIVhyDgXMu8opGjbBzaRH9B+FYot71TF
         RQzYcDYa5s92aHlkG78gWciJgRPUvpaaijQTn92GRCqT1qbFki7YSiMTzIaiQlTy0XPD
         RqrFhTLdJUG/bU3kH9Su1arELbHzRL4K8CfSdXzGmARJZBJAawFojgEV2Iny3LgSYZpU
         RwE+nTRN/iWjTvABOq/6lMsqnAMbAY4uVLY4TwguaRTAqk5CuemMPQPGsK2vUsCZ9Xc2
         UQkZnenSo7LcffBheUQdQCIvYdShvqyiAzJo1jSfWrzCUQHbOW4nO6WVFMJSQ1N0DH6I
         RAvQ==
X-Gm-Message-State: AJcUukcG3UigkYxMshSIcc1iAxb4yAU7xyCytJBTyBQCQdqZiAlmw9cM
        hZr/IN56d+TrxaAY75XIt3R1jWCfaIMW423F9IQ8LlE3
X-Google-Smtp-Source: ALg8bN5taZJSaqaoFh3J7m1uerq9WZmGt5UTv68yaGqIINNbIFAz0INqpOLZiRvZaDGW6qotQ+29en/GgflZFP9zrSU=
X-Received: by 2002:adf:9d08:: with SMTP id k8mr32264971wre.203.1548860568662;
 Wed, 30 Jan 2019 07:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20190128084959.13060-1-vincent.whitchurch@axis.com>
 <20190128100545.b62193aa8f49e1de8d6ea8b7@linux-foundation.org> <20190130144851.GK11489@garbanzo.do-not-panic.com>
In-Reply-To: <20190130144851.GK11489@garbanzo.do-not-panic.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 30 Jan 2019 16:02:36 +0100
Message-ID: <CAFLxGvyUpWRE3SWD2eX+M-TGKv7+6At0zsYYTTWw0y6gs3M4iw@mail.gmail.com>
Subject: Re: [PATCH v2] sysctl: Add panic-fatal-signals
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 3:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jan 28, 2019 at 10:05:45AM -0800, Andrew Morton wrote:
> > On Mon, 28 Jan 2019 09:49:59 +0100 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1242,6 +1242,20 @@ config SYSCTL_SYSCALL
> > >
> > >       If unsure say N here.
> > >
> > > +config SYSCTL_PANIC_FATAL_SIGNALS
> > > +   bool "panic-fatal-signals sysctl" if EXPERT
> > > +   depends on PROC_SYSCTL
> > > +   help
> > > +     If you say Y here, a kernel.panic-fatal-signals sysctl will be
> > > +     offered.  If this sysctl is turned on, the kernel will panic if any
> > > +     userspace process receives a fatal signal which would trigger a core
> > > +     dump.
> > > +
> > > +     When used together with kernel core dumps, this can be useful for
> > > +     debugging some system-wide problems, primarily on embedded systems.
> > > +
> > > +     If unsure, say N.
> >
> > I suggest that the Kconfig help and the forthcoming documentation
> > should clearly explain the dangers of enabling this!
>
> And so, should default to n.
>
>   Luis

Hmm, why can't this be a core dump helper?
Such as:

#!/bin/sh
# Usage:
# echo "|/root/crash.sh %p %e %s" > /proc/sys/kernel/core_pattern

PID="$1"
COMM="$2"
SIGNAL="$3"

echo "$COMM ($PID) died by signal $SIGNAL, killing kernel" > /dev/kmsg
echo c > /proc/sysrq-trigger

-- 
Thanks,
//richard
