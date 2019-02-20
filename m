Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54AC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ju7lP/D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBTX6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:58:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33428 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTX6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:58:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id u13so14179711vsk.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wz04FV2kwhYk5xS4aWkQBHCDHJmpCOsHunSaUB5KTxQ=;
        b=ju7lP/D0nE+t4rmmmqmRzOokAz/Gxis3EAPI8bG094vV86cAeB0xj+R++7U5/36d2b
         AKiowfFT5/bwwCoePhVdQcjH+hQ56kCnXP4n0AiIurjcd6prchOMFVUgEaa/oB3QjCMP
         L4oIqmuapWmEV/fojXXRb1FXbANxzEUdUzFJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz04FV2kwhYk5xS4aWkQBHCDHJmpCOsHunSaUB5KTxQ=;
        b=XqbDC+s9tGbwdVFm7TZP2gM0CSsySRexT6/4QZ/M/Ravyopj50Npjm1aMa0L9D4y/L
         o+8VUbAzwCYSprytifcQvRRXmKkmrbmxBPxTHGCBAe+D+JJ0x9guzSvbTtw6XbKfMkJW
         ZZjoywHICgSFzGR60nYrZn89ng+CPeqePCWzspKu9iXUyu3+p8fPlPbXx2K+sXdY5q2R
         p+zr2X1f3cmytoqoaULI5X01T2RJS+wOH78pdVR85vFHGtygcdm8AMTbzuqpCmUPfXrA
         X0VJnFWx2h9uF1ZTvA8e1U0syLCv6LBSCRM1jS3RMEcvFQdq0m6/HZORE7qeDffD4J/G
         e6KA==
X-Gm-Message-State: AHQUAuYLfalZQwh5TYMZX8tpA0Ia7sLKG3q/stHoDI7psWbTnAqphXWm
        e9AB1UqT7S9PQLCcqdMHiSe05su1dVU=
X-Google-Smtp-Source: AHgI3Ibe0e1c1WVga5kl2jz8bnlRxE7fwAYBcJZqYm4CrQ/0aLJ489PeqiH7w+GUc4wLz87+60TrEg==
X-Received: by 2002:a67:8355:: with SMTP id f82mr18794784vsd.89.1550707101459;
        Wed, 20 Feb 2019 15:58:21 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j92sm11884180uad.6.2019.02.20.15.58.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 15:58:20 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id h132so3323205vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:58:20 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr3408443vsq.48.1550707099912;
 Wed, 20 Feb 2019 15:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-2-tobin@kernel.org>
 <CAHp75VfP_gyx_+8XKhyJMShooPubpR2KJ7gvzu0Mbv3+TaFTxg@mail.gmail.com> <20190219215526.GC16094@eros.localdomain>
In-Reply-To: <20190219215526.GC16094@eros.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 15:58:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKLjuZ3Kpmh41C7rEvBc2JFT_UM3LcooeJimA9zZvBM2A@mail.gmail.com>
Message-ID: <CAGXu5jKLjuZ3Kpmh41C7rEvBc2JFT_UM3LcooeJimA9zZvBM2A@mail.gmail.com>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 1:55 PM Tobin C. Harding <me@tobin.cc> wrote:
>
> On Tue, Feb 19, 2019 at 12:55:09PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 19, 2019 at 4:44 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > > +       If unsure, say N.
>
> Does that mean that this is redundant too?

I've started leaving this off Kconfigs more and more lately. I don't
think it's needed here.

-- 
Kees Cook
