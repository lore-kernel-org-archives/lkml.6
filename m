Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C1420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQuiJlyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C1420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeLMH3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:29:20 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35462 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLMH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:29:20 -0500
Received: by mail-io1-f68.google.com with SMTP id o13so854015ioh.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EOdrHiOWxYQdlpEG21k4ONStXGY4p2qWeE2RcGhYm8=;
        b=RQuiJlyFYRGZNvWZbffX0gdj2i3TcapbbFAoXKvDetUDTUXSlRCOHINqiKEnQT1RWi
         kPrYHa51BOvpICSgzAb7MBoHs4NWmvxKSJSHCLLRjxMzGbZggvbrTfrUZu14gbTStySF
         xenwpJzLcN6pBZjDx9aXTvXD0yjA2fao87tnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EOdrHiOWxYQdlpEG21k4ONStXGY4p2qWeE2RcGhYm8=;
        b=UA2wXY+a25WRPD7DbgHYQZhPS4joXpjV7EPMOMGAubxYHA9lL0XlKA0z92MvYFv1sV
         AKOJuwFgVmNCTuhDebgtsloSk43HmxMmxjj2s4ZzB9mEDOVOkCx6VqSW7H/Nmu87cq43
         OJ28v7xAgqm/iMhOtSfFr3XU91vPUPSqQarvHbVW2cpXcUz1dddQb8SgIIdRZTQqS56S
         +O2DT+8pSMUIkH9QXKKm39xpMamP4sbPZR4pSutze/10ZXnAuvXJhoE8Hy14tfTHKeCl
         VjH5hufELCOYP9It7IO0cA8CZ0YvGgeG/+0y5S6SUHFOsX+7M/oAoBc/GQiqFqoGvzAI
         fUAw==
X-Gm-Message-State: AA+aEWZcyHEud6FQoElOD1GXP8XwUZKZmnJ5ifm/pxe+/L9Gy9qgFXDI
        U+VPIxUQjW7i7ETywVoX+3xuWBgE9VTX/sze0AvvOQ==
X-Google-Smtp-Source: AFSGD/VkmYFEClYWVaEc2S2tCHenmseVkl+jzyvmps+0WDujcDZT33bVXbjvh8aSVGqPG+hooU6Xir4KD0PHbtFao6w=
X-Received: by 2002:a5e:c303:: with SMTP id a3mr18523435iok.53.1544686159250;
 Wed, 12 Dec 2018 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20181212122800.GA29450@jax.ideon.se> <20181212213617.mltwlxfcbap4prlj@localhost>
In-Reply-To: <20181212213617.mltwlxfcbap4prlj@localhost>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 13 Dec 2018 08:29:06 +0100
Message-ID: <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
Subject: Re: [GIT PULL] tee driver fix for v4.21
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this tee driver fix for a possible double list_del() in the
> > OP-TEE driver while uninitializing.
> >
> > Thanks,
> > Jens
> >
> > The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> >
> >   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> >
> > are available in the Git repository at:
> >
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> >
> > for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> >
> >   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> >
> > ----------------------------------------------------------------
> > Avoid possible double list_del in supplicant comms
> >
> > A fix for the OP-TEE driver to avoid possible double list_del during
> > tee-supplicant communication while the system is shutting down.
>
> Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
> name is 4.21.

It's just that we're so late in the 4.20 cycle. If you're OK with
taking it now I'm happy with that.

Thanks,
Jens
