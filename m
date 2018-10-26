Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A1ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4310A2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFLqGmqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4310A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeJ0Hfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:35:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39523 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeJ0Hfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:35:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so2803305wrv.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydYQIbR1asUPae4hW+soJCu8ie5aNmZQJu3Xr7vUY2U=;
        b=uFLqGmqQNHllT+h9VdQYY+ynVhGigh5gVDP3RmQOAo2tkSEX9l6TYCmoRqDDofOzlr
         xASVbyIx3fk2C8DDWIoORHJ3QjnWRkV9Fd4JXd5xZ9MORHCvv3/fTaKFmZynakPTDvHg
         Rrl5lEidHiBb4NVG7Czlc1P8fMvjt44W8j/gzxt/6u0iBfqbIh/p4gfCPG67KtHySp/5
         zJGDcyCAt+tGeVnqsbkqh4LTmwsb9wITcw43+4YAqB7MVXXb0LLYRBb1S/JzJfjavU6R
         KoOIXgDYvkw3zoWZlXDycgLoJulfptRB3NpDK9gPwd43U0UsCRdGARSQcpYK9PvKPm+C
         HDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydYQIbR1asUPae4hW+soJCu8ie5aNmZQJu3Xr7vUY2U=;
        b=Zak/sEgU6xi2TtFl1Uy0p2+ZnEOea6LMweHbCFR86ugPadNVFdxSOPXKRFaWKEkLZb
         rNiL6vbA8m8kVbfEdfM8Ws4GrfMioLZbT1xbkN+kq1x4q5vAXJPhCl5CUblx31gp4jV/
         xPL2hkeSCHF2MapTeou1v9FQHkyxxkceviEaW3XHsqh4tVlWsuO5WTodgyQjuRHRWu7M
         Iqk+O7NJMMGcGczrD2Nph7zrQgntpceg3xgByJJtRM5anqPftwXxx0nSzhKosiTH2tQS
         xg9DGwl24ECWQzsYD7LXWt33kncel9F0BbkJDoOE5jqNRzsV1MktTblDbEymvxOQ8gnz
         4CCQ==
X-Gm-Message-State: AGRZ1gJgVed0rt3c+PqKNqVO3axWKh0hI/KBLnlKL9SkWbE0vMzVz3ak
        dC23FIWjcxLcmV2YgI2s3ZNo5TAY25taI832ClQ=
X-Google-Smtp-Source: AJdET5caOeiba2wlOkKVpOhCqMSBWa2m22NmlB38y/olmGcEFSwrt4jU4rGM5g1Ea7TdVh/St5pVpFhMddR71Oniozo=
X-Received: by 2002:adf:d181:: with SMTP id h1-v6mr7215146wri.138.1540594607746;
 Fri, 26 Oct 2018 15:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
 <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com> <FA6429E0-C480-47AA-AAF0-95E615D8265B@amacapital.net>
In-Reply-To: <FA6429E0-C480-47AA-AAF0-95E615D8265B@amacapital.net>
From:   Daniel Micay <danielmicay@gmail.com>
Date:   Fri, 26 Oct 2018 18:56:21 -0400
Message-ID: <CA+DvKQJYmWm6uP6k4HYdkuTdMX7=rSu34W2j-Vk8YcnWZVA-3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 at 18:12, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Oct 26, 2018, at 2:39 PM, Daniel Micay <danielmicay@gmail.com> wrote=
:
> >
> > I ended up working around this with a pthread_atfork handler disabling
> > my usage of the feature in the child process for the time being. I
> > don't have an easy way to detect if the bug is present within a
> > library so
>
> Can you not just make sure that the fix is backported to all relevant ker=
nels?

There are too many different distribution kernels and I won't be in
control of where the software is used.

> I suppose we could add a new flag for pkey_get() or something.

That would work, since I can apply the workaround (disabling the
feature in child processes) if I get EINVAL. The flag wouldn't need to
do anything, just existing and being tied to this patch so I have a
way to detect that I can safely use MPK after fork.

> > I'm going to need a kernel version check with a table of
> > kernel releases fixing the problem for each stable branch.
>
> That won=E2=80=99t work right on district kernels. Please don=E2=80=99t g=
o there.

If it's backported to an earlier version, it will just mean missing a
chance to use it. I'm not going to assume that it behaves a certain
way based on having an old kernel, but rather I just won't use it in a
forked child on an older kernel version if I don't have a way to
detect the problem. It's for a few different uses in library code so
I can't have a runtime test trying to detect it with clone(...). I'd
definitely prefer a proper way to detect that I can use it after fork. I re=
ally
don't want to have a hack like that which is why I'm bringing it up.
