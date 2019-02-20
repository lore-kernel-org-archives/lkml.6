Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FBC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywc+TnJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfBTCYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:24:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47061 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBTCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:24:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id c18so16099594otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+6hijqYPu402zQKk7EroqYgTIOuvbxJ8rrPDvz84Yc=;
        b=Ywc+TnJdRagr+5KkSdvVBkKWB31o+8T2vCbJaTJ+o8owoan9WJ4lOyYM565mv2rM+6
         qjjb/VMayAyKTSB0NejMWlw+D6Rip4Du9dtsIv39aKG2Mw0oxP/zuCjbrJtw5uq7ehw6
         4E3uHLilip57LxyejMpdq4hzr/VQ6EeLPerXhp8d162qu5PxRMau7Jb0DdruyqGbu0SY
         YBYKrXiiXlM86X5IvZTUSFP2dm7ZqCWdbNlTGmZbZvqO/N2jqJpH1x5mczF/7diTmZ9h
         Wvdu6U5K6jlO66E3NbUeBRCf8Pscs5hqm5X/ztJmhJns+3N+kVoJlU1aIBJ+LViFPWnf
         0gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+6hijqYPu402zQKk7EroqYgTIOuvbxJ8rrPDvz84Yc=;
        b=feMOwoLdtOV9brPyDn9u4RBcxmL1kMgH0ER6uPxth+KLldzApDrVjCtERLz5CzTvk0
         iiDcvGJiLR4Knl8mTB+nsGCTgRqo1Aomy5UBJIOF8NGvNRN7r7Bbbc1NURfLV9i/gklD
         kUGFcEVapUg1q7FxcpLOGOx4DQBPdV5JQsumDuh1tybgLWD24fpzY8s9+3gagIMrs1ih
         LA7Te1fT78X5SAN+ZABAFzKoq74JmXu1rVIk0RCgmItmiTGtSflfhSypjOIzQO58et8J
         nI9VzgcwLeFyAN01S2uPkvpQGUoMXtknn24OCA3NjJEP0RGXepaY3tWbbVzgYJEg8xHv
         2lQA==
X-Gm-Message-State: AHQUAub44RiC2BDHlbOCLNoaKbLvLCqW9gpoxllbUqp1tZlI1//JT4Ot
        v3DJofQLt/mNCSLaFPr0pKlAasPVcyo9guX5sQtRtw==
X-Google-Smtp-Source: AHgI3IaI608LbAYup3kGIO3U00pPOGrg5ms7H0H32JPTzxjWvUxBPgSKFQAjWLixoQFLDbRoQsqGhbDN9acMU1ksSgQ=
X-Received: by 2002:aca:c6d5:: with SMTP id w204mr4531258oif.137.1550629451771;
 Tue, 19 Feb 2019 18:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-16-brendanhiggins@google.com> <cda7c8db-a6d0-6a93-5c33-9ccf32dfd29a@gmail.com>
In-Reply-To: <cda7c8db-a6d0-6a93-5c33-9ccf32dfd29a@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 18:24:00 -0800
Message-ID: <CAFd5g44OYSEnX4+d6S-j8mR8=7u8mHjgU10Zy_BPbed0u+56ew@mail.gmail.com>
Subject: Re: [RFC v4 15/17] of: unittest: migrate tests to run on KUnit
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        amir73il@gmail.com, dan.carpenter@oracle.com, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 4:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Migrate tests without any cleanup, or modifying test logic in anyway to
> > run under KUnit using the KUnit expectation and assertion API.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  drivers/of/Kconfig    |    1 +
> >  drivers/of/unittest.c | 1310 +++++++++++++++++++++--------------------
> >  2 files changed, 671 insertions(+), 640 deletions(-)
> >
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index ad3fcad4d75b8..f309399deac20 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -15,6 +15,7 @@ if OF
> >  config OF_UNITTEST
> >       bool "Device Tree runtime unit tests"
> >       depends on !SPARC
> > +     depends on KUNIT
> >       select IRQ_DOMAIN
> >       select OF_EARLY_FLATTREE
> >       select OF_RESOLVE
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>
> These comments are from applying the patches to 5.0-rc3.
>
> The final hunk of this patch fails to apply because it depends upon
>
>    [PATCH v1 0/1] of: unittest: unflatten device tree on UML when testing.
>

Whoops, I probably should have made a note of that in the commit
description or cover letter, sorry.

> If I apply that patch then I can apply patches 15 through 17.
>
> If I apply patches 1 through 14 and boot the uml kernel then the devicetree
> unittest result is:
>
>   ### dt-test ### FAIL of_unittest_overlay_high_level():2372 overlay_base_root not initialized
>   ### dt-test ### end of unittest - 219 passed, 1 failed
>
> This is as expected from your previous reports, and is fixed after
> applying
>
>    [PATCH v1 0/1] of: unittest: unflatten device tree on UML when testing.
>
> with the devicetree unittest result of:
>
>    ### dt-test ### end of unittest - 224 passed, 0 failed
>
> After adding patch 15, there are a lot of "unittest internal error" messages.

Yeah, I meant to ask you about that. I thought it was due to a change
you made, but after further examination, just now, I found it was my
fault. Sorry for not mentioning that anywhere. I will fix it in v5.

Thanks!
