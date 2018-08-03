Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44946C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C7E21784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phqOH9PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C7E21784
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHCTrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:47:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39312 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeHCTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:47:21 -0400
Received: by mail-io0-f193.google.com with SMTP id o22-v6so5672651ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMO8+EcrM9o+SBp4k6k3wddtkk+1DxpVGbVk0vB3aw0=;
        b=phqOH9PNYKIzWDPHugxOP07ipKZjNAlq+ll0ttfCaL2VxfpgXZbJvGToYEGzMOci2e
         cvn80v3wDSdllt77uYy2+A/FpzIF6QjRslHFgg35efbtDhNW6/APjUNaH7X8PQ8XJGY7
         nMLzzgAsXDDIBJL5YmOdpaUMRIoJTePzpVw/K9yR/mgMo1wWYedYYjGey58WvuzBKpoZ
         T4myELic9+4Ua9SVTukKtw4zAloXKw9o8DUIMulwGzRolgb/GbF8qBX73z27gAdCMrq6
         MXNpLQ0voRWAekFjmsnZlBIqkrC4Doo9wnc78TpaiVHrQBxI1AxSZ6208lyUto+BNI+D
         PE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMO8+EcrM9o+SBp4k6k3wddtkk+1DxpVGbVk0vB3aw0=;
        b=Be7VwGxt9MtZ7wL3IZCIjBe7s0NHJGtj27RTg2bLyEKMVvAzUQZBe1KB8Ke+3D0NSZ
         cdmaIdtiLjHKxjPmzDD0RkWFPkR3mtYUl369bfj8I7LyEJQd1L16UTanYqlwT5RDvA6i
         /GZXnlANpIG+qpzb9SICwISSSnASQUk/TRBc3o9bKs5ykT5BH0dQsWVJzXwwETzBjELu
         URGDHGPAK/KP8dDUE67qGqKUW+WAynzrzrR+KyQsNSLlhbc0tnzyT9SjpXQRJ/hQ6nrt
         jBvbrQUBhA1fqpuw+8x7BtyhB1XbogZAVhOKXJKTlFMwqZnS5II7rzimzhGpYR7o/uRL
         xZhw==
X-Gm-Message-State: AOUpUlFOGZ4NvPls86saYJg/jntYD+1dVK/JaWdhKJryr33hbVi7FH3W
        amcih6jgyfO1mgyE5iVP5mebeUulT2c5UDZZdXebVA==
X-Google-Smtp-Source: AAOMgpfRI69Ma1govObKJ3QSGkpbx/ZW1CSdaiYowajD/kFeUvTBYAc6YYFKpcUG6hvEPxFOdKN6TzreyKjyV6rljJI=
X-Received: by 2002:a6b:ac03:: with SMTP id v3-v6mr6928920ioe.71.1533318602031;
 Fri, 03 Aug 2018 10:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180803151035.238a19d2@endymion> <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
In-Reply-To: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Fri, 3 Aug 2018 10:49:51 -0700
Message-ID: <CANDihLGJ48iQTak-pFH4OYPqKtvFwHtgr9MBrpm7RmLX1Emo=Q@mail.gmail.com>
Subject: Re: native_save_fl() causes a warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jdelvare@suse.de, linux-kernel@vger.kernel.org, mka@chromium.org,
        Arnd Bergmann <arnd@arndb.de>, hpa@zytor.com,
        tstellar@redhat.com, sedat.dilek@gmail.com, jgross@suse.com,
        mingo@kernel.org, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 9:38 AM Nick Desaulniers <ndesaulniers@google.com> w=
rote:
>
> On Fri, Aug 3, 2018 at 6:10 AM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Hi Nick,
> >
> > It seems that this linux kernel commit of yours:
> >
> > commit d0a8d9378d16eb3c69bd8e6d23779fbdbee3a8c7
> > Author: Nick Desaulniers
> > Date:   Thu Jun 21 09:23:24 2018 -0700
> >
> >     x86/paravirt: Make native_save_fl() extern inline
> >
> > introduced a new warning (with W=3D1):
> >
> > ./arch/x86/include/asm/irqflags.h:16:29: warning: no previous prototype=
 for =E2=80=98native_save_fl=E2=80=99 [-Wmissing-prototypes]
> >  extern inline unsigned long native_save_fl(void)
> >                              ^
> >
> > Please fix it.
>
> Hi Jean, thanks for the report.  David Laight also reported this
> warning; he tested a patch I sent him overnight.
>
> Let me guess, you're using a version of GCC < 4.9?  It seems that GCC
> < 4.9 will produce that warning for extern inline functions without
> previous declarations.
>
> I'll add your Reported-By tag to the patch that I will send out in a
> few minutes.
>
> > Secondly, I am quite curious why you changed only native_save_fl() from
> > static inline to extern inline, when native_restore_fl(),
> > native_irq_disable() and native_irq_enable() are equally referenced by
> > address in arch/x86/kernel/paravirt.c and thus should suffer from the
> > same problem. Can you explain?
>
> This is a good point.  With native_save_fl, we were not able to boot
> the kernel at all.  Maybe this was called from the boot sequence
> (maybe Juergen knows more)?  It seems that the other functions aren't
> preventing us from booting, but maybe exercising other paths in
> paravirt would expose such an issue?  Or maybe paravirt doesn't have
> the same calling convention requirements for those functions?

The core issue these patches worked around was the automatic/heuristic
generation of stack guard code by clang, which ended up clobbering
%ecx/%rcx in a way not expected by the contract of the paravirt code.
The only function affected by this problem was native_save_fl(),
because only it has a C stack (and thus, has a stack that requires
guarding).

The other functions could have been converted at the same time, and
they will have to be converted if (down the line) somebody adds C
stack variables to them. But, for now, the patch series seems to
correctly work around this issue.

> Is there a standard testing procedure for paravirt? I'd be happy to
> try it to see if we can expose more things that should have the same
> cleanup.

This bug was so obvious you just enabled CONFIG_PARAVIRT, built with
CC=3Dclang, and booted the x86_64 bzImage on any qemu. The minute the
paravirt alternatives were patched in, it exploded.

> --
> Thanks,
> ~Nick Desaulniers
