Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4A42077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQO3n7T7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4A42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeIDPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:10:39 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32968 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeIDPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:10:39 -0400
Received: by mail-oi0-f53.google.com with SMTP id 8-v6so5844566oip.0;
        Tue, 04 Sep 2018 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f6NbJvvMPr7hm3DLYs+rN0f7QhdTzq4mmEPYt7M55EU=;
        b=UQO3n7T7fAnpdbRRGjaKoGO43oUwBeZ4KTidAeTXgFc6MOsba6YjqpCxHlOsMj0kot
         p4WqVQZdnk5CWvdRV0PF1s2cQv4o77iG5WL9ajAgIoZ5JQ5vG+kh7ZIieshmzzAYDiLS
         uQfaUgmEWXqlZfBsUkGB5xGw2P3R612yLf/dd0YUb2h7xET7vKELTFgvg7TSRLg5TIlT
         DhaxdtboxDGBwdIFLQSDodLXBxSNAski43bdZzKAIbUUippU7ezQuivixAXZBKrPOSbd
         szeAWpobROB19Qmeq4QoEjPnc3hkp32U+3q5JJW/9nprRTD3XEfab3Besvea1xp4VaaK
         eRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6NbJvvMPr7hm3DLYs+rN0f7QhdTzq4mmEPYt7M55EU=;
        b=lnhBQdsgOx9yna4dWNixEJtUbYk8gvvS1Mtgn1NEPMYP4232xDSyo/Wvyn8UHppV+p
         +K9//vUf3HfDbzetBXIxSjw0/y5nh4gHA53mo6L/TphggChEO5sbjvDtA1jl00YWkZ6o
         WwBCQuoVm1R2XgoZ3mVV0NwTbLqbdElL4B5POSCgQIE5W2hqerxToZkbSMP32EnDkinV
         C2lYXxEAz5eLHKB/R/15Yu4ddoCzMZ5iD6dtmcsCQEYZSOcG1mkH87vgB/FhLlZ7Xlut
         vsoIUSFKXO3GkVtEPvEozwk+wVNTiS1IgAfuULjK/Yd2aMaNEM9ibWSMQ0TA5YUnDv3G
         K4Gw==
X-Gm-Message-State: APzg51C7p1g+WCxVtLekmdNndnLdC9a9eadg6WmFmXEEGrhQEiN5IRhM
        ZStsgnMbBxq6u65Gfn1u2s2OPgQIrnoZkXyGDM4=
X-Google-Smtp-Source: ANB0VdaM11L6neQJDGwRISlxtl22rGVTyeZiJqdPhdlbedoi8Mv9IrpWjph4nBLPo/Lt/QWzItOUzxhIkq2xSlrHUSw=
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr22025769oif.22.1536057965469;
 Tue, 04 Sep 2018 03:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl> <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <20180904092938.GJ11854@BitWizard.nl>
In-Reply-To: <20180904092938.GJ11854@BitWizard.nl>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Tue, 4 Sep 2018 18:45:54 +0800
Message-ID: <CAJDTihyhA7Q_O=DhdPxLquReY1CO=3y3XgZtZ5pA5kY+DTAvMg@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     R.E.Wolff@bitwizard.nl
Cc:     jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 5:29 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
>
> On Tue, Sep 04, 2018 at 04:58:59PM +0800, =E7=84=A6=E6=99=93=E5=86=AC wro=
te:
>
> > As for suggestion, maybe the error flag of inode/mapping, or the entire=
 inode
> > should not be evicted if there was an error. That hopefully won't take =
much
> > memory. On extreme conditions, where too much error inode requires stay=
ing
> > in memory, maybe we should panic rather then spread the error.
>
> Again you are hoping it will fit in memory. In an extreme case it
> won't fit in memory. Tyring to come up with heuristics about when to
> remember and when to forget such things from the past is very
> difficult.

The key point is to report errors, not to hide it from user space to
prevent further errors/damage,
and that is also what POSIX wants.

And, storing inode/mapping/error_flag in memory is quite different
from storing the data itself.
They are tiny and only increase per inode rather than per error page.
>
> Think of my comments as: "it's harder than you think", not as "can't
> be done".
>
>         Roger.
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 *=
*
> **    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    *=
*
> *-- BitWizard writes Linux device drivers for any device you may have! --=
*
> The plan was simple, like my brother-in-law Phil. But unlike
> Phil, this plan just might work.
