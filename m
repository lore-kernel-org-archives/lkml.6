Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF3A217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+fiwqNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfAVWmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:42:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfAVWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:42:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so135236ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZaokQwl9SY/X/XqBGguubg/MHwgfemvv46E+U/pJUI=;
        b=H+fiwqNoOcvcNZWQWfbjd2N4Yos2Y8HjtIZy3o+6FtirENKQocPD78+HRLOEAOUApV
         bfzWgpniV9kUYsJ11BItK/AgMIpEw4WnBRsYoR+zZve3KAudED8YCCPWwZYVgAzDIprP
         9jfVKCphA2N3H22CJ3N1y/0tJNHCjwuTrPtXi6dxchNdR5ybLZhH2PyBo75dXyWyESph
         +27k5+J6bMX8GJu/smRLbB/996eJHOK1/kle8thHvfG2IhwEvLx7Go1aLZObnbBGwnUZ
         GlY8wixosxoigmxUHmQui7XLdR8idqjqvZjNslwb7wxqngJ+VO5d8plYtki656sN5/+C
         CWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZaokQwl9SY/X/XqBGguubg/MHwgfemvv46E+U/pJUI=;
        b=kUYcOctsIysvE6xG7lcZLw9LiqCXA33iQwx0O1WGABpu44ALiABoQFNwT40iL8EdWj
         6xs0spbWgnj4sm1jq9TOEtcStQhnELYVQOLbA1RrA3GIvnrmN+I/HsYQ0YR64Mre2Uod
         cYLn7JWctJbabT3YCRYYz2nOsJ9l7gQpmNjJFrTDcbzaoCYNEpJLsV8MRB322sXcKWHy
         LwU0xfBgtqy382wu/pmqF0lspzZVmSuAyX+oYtqrry4bSS/7aUtaUWNNaR7HIZkvChzf
         9gR+KyMe/sOOlthQQyb/MlbbTWXC2YzebaFt/70xlnAjTzkEKSX9uteufCGV9VXwP3m6
         mFig==
X-Gm-Message-State: AJcUukcSQehabBZ8LqxhytyL+cCShBCVTfLXTZbXcucOqb4rhDtbTcYn
        BLGrauLRjkBm9rGII8yWRLRskWJJth89vVnqRoX58A==
X-Google-Smtp-Source: ALg8bN6wNCeiq6QpNe1OxJCB4vWA6uOSfhQBrIf5buaEctVVr8rj1u5HofMhBcQG+Mma/7YCYq9Mjk5ycvR29mP9aL4=
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr15318213ljh.36.1548196958207;
 Tue, 22 Jan 2019 14:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <C103ADA0-68A0-4571-AE47-1744E64E0D7E@holtmann.org> <CACK8Z6FzWTZ_SYCBqGsOcf2xzSp3+W9HD-1inyRtJ=Wqsww8Pw@mail.gmail.com>
In-Reply-To: <CACK8Z6FzWTZ_SYCBqGsOcf2xzSp3+W9HD-1inyRtJ=Wqsww8Pw@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Tue, 22 Jan 2019 14:42:26 -0800
Message-ID: <CAE_wzQ8C4KTpLWVvw4J-YhjzrUDOW4c+4bJmGStTR=BEdidkWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] usb: split code locating ACPI companion into port
 and device
To:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 2:29 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Marcel,
>
> On Sat, Jan 19, 2019 at 11:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Rajat,
> >
> > > In preparation for handling embedded USB devices let's split
> > > usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> > > usb_acpi_find_companion_for_port().
> > >
> > > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > > ---
> > > v4: Add Acked-by and Tested-by in signatures.
> > > v3: same as v1
> > > v2: same as v1
> > >
> > > drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
> > > 1 file changed, 72 insertions(+), 61 deletions(-)
> >
> > what is the plan here? I take this via bluetooth-next tree?
>
> Yes, I'd think that would be the best plan. Dmitry / Greg - do you
> have any objections / suggestions?

That's up to Greg, but since he'd acked the patches I'd assume he's OK
with taking it through bluetooth. As an option Marcel could cut an
immutable branch off 4.20 with the first 2 patches so that he and Greg
can both pull it into their main branches and then git will do the
right thing when Linus pulls from them. Lee uses quite a bit of them
in MFD and other maintainers are known to occasionally make them for
work that needs to be shared between trees.

Thanks.

-- 
Dmitry
