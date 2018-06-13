Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4745C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98227208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C0FRbCkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98227208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935792AbeFMQDa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:03:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52641 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935404AbeFMQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:03:28 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so4412668itg.2;
        Wed, 13 Jun 2018 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8uZvCnyeRehb046SnvrKRFHALHzqmbEad+VtvusU3s=;
        b=C0FRbCkgnOKREOvF17rK5f2zdmfZI/jsd5NoaTREnIAn04DVyYfkueXw4awB0YIUif
         SQE2eKeJIDtZ7XUApwt1njjkHUPQR9I4RWPzrVtQ/KFPOCVcCmrLTHbgdxKXNxFoOck3
         fUmCBYOLNeTQz0lmHF8CYOaEq6mnLucXKH/gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8uZvCnyeRehb046SnvrKRFHALHzqmbEad+VtvusU3s=;
        b=IHM0ML6ks9RXIr8akTLK/Kkq3Qj6PPi5yFrROhv61I6k9Y3bXvaFxixt8ESsQn9ntN
         BK8msX/+iUAmKY735laUmXjkav1ME9qJ0GyMX0yUZ5zM60+LPOYIxtqvyA+xezhVv4aF
         /6T9QsHp8E1o8jH7VSxVwzIwgUjQOIx2FnybdGNky+mRpnzjlsSBMrbqzJegq71ZrWye
         AKbr937/VClxjI31xkDBAOO4+7m0zkYIxg2FrcEmoIfUJ1WGhGPUS2tlcZT6RKGj8SB/
         cJ4fhEV3Q5UT/30wphZtrQb4zukHPNzJkDOjK5JXry2HgRepryJhLiF2Wn13hZdgDDbz
         0blw==
X-Gm-Message-State: APt69E23OlHJOaLK8gCxWvrEC117y3IOb13fVIJOrsLNyFB3df24y7I5
        aQWQK1lFvo6SMg/pAGr9jcY9iG6Pz2PTqPFGvss=
X-Google-Smtp-Source: ADUXVKLCBmQm1U2khy/+VcoaLckrzVm9LgS46LBIVqRSz/vD6hqpnUSnheIb72BV2QUFxSkondrOtsUnXyh8piWv2ZA=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr5129345itd.16.1528905807516;
 Wed, 13 Jun 2018 09:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
In-Reply-To: <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jun 2018 09:03:16 -0700
Message-ID: <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jun 13, 2018 at 7:47 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Please pull more Kbuild updates.
>
> Pulled. However, I notice a few oddities.

Oh, and one actual bug: "make oldconfig" doesn't work right.

I used to have

  CONFIG_HAVE_CC_STACKPROTECTOR=y
  # CONFIG_CC_STACKPROTECTOR_NONE is not set
  # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
  # CONFIG_CC_STACKPROTECTOR_STRONG is not set
  CONFIG_CC_STACKPROTECTOR_AUTO=y

which means that since my compiler supports -fstack-protector-strong,
I should get CONFIG_CC_STACKPROTECTOR_STRONG.

But that's not at all what I get. I get

  CONFIG_HAVE_CC_STACKPROTECTOR=y
  CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
  CONFIG_CC_STACKPROTECTOR=y
  # CONFIG_CC_STACKPROTECTOR_STRONG is not set
  CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

ie CONFIG_CC_STACKPROTECTOR_STRONG basically went away.

The reason for that is that it takes the *old* value of
CONFIG_CC_STACKPROTECTOR_STRONG, which was "no", but that's wrong.

The meaning of the config option has changed, but it took the default
from the old meaning, and decided that I shouldn't get strong stack
protection any more.

This is a pretty dangerous silent change.

               Linus
