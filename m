Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AEFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034EE2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej3C47gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034EE2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeI0PSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:18:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38457 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeI0PSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:18:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id z13-v6so1904436qts.5;
        Thu, 27 Sep 2018 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGkdaQT3oEcnuObkT1yONSIiR8AzG60Xob7OQrGzoFk=;
        b=ej3C47gBA+31UjDm0zduvN4Owm7lxUJ1pxjhzR5aaMFba7aEw7p/6c1qVUv6YgxTq4
         KSnbrjXFq/MpOV2NUW7b1q4d5llmxjaYBpllahDJpyHpbKjds7KcXqe9bztB1EwGUvLC
         Q/DoyBkUuT6dSj91+Rr6Moki7C0pJ+T9kYxmwhuroeMM5sxXJWdtjIY1ilJNiJVONWjt
         tjWyelS/CSA6Hmfuknsak0e5NkPyiDfY99x9Kg9PKY0aGup8GuFPsocY7uccdeO61zuI
         dcEMlQM30v8RFQ4Y2/9pIj+mF/yWQy0Ajz7kYf+LLWp8yqQiyyXDfY8ETbtV6o/hKW0+
         itxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGkdaQT3oEcnuObkT1yONSIiR8AzG60Xob7OQrGzoFk=;
        b=fq+O1m6Jv9eeHJB5iyIbkXrCBBUbUVRfWFh3PJJatyivBRPN1R0sSBaxsHANYDhP8u
         sGCZQ3lAqS824AAxzrVCWy+opaDh93+9ia6t7LVHsjYWjx/xwPZ6QSVHKN38XsatWp8C
         41X4ccCLTyV/6FPUwYHbwJ3fv9p7Ut6c8DuOW4sxDjw1F6v/BCc3No7O15XKouvcYwa5
         2LHUUDXeDhMfgd4jU+ugSUWiL5ayKV1ytmOfclU/WVwsl04O3DW1AcwwxEnP8h/YyoKu
         ssuyrdSo9iH6t7BJMxSCoelLpGK6mTg8tzFF74lTXhdX4GlLpQber3JeJEDWFrG7hN9V
         qIDg==
X-Gm-Message-State: ABuFfog73/ZLNpB2zftpWaCJFMaYSL92iNKFWr59xWs8e9fztKhIeiT4
        6kVNRfT1n49I2UkbG7p0xCeNpK8frRSuW7gT3Ys=
X-Google-Smtp-Source: ACcGV63UNTki+/jWzwtqXRqg3pseV15Om+pkCeBaCiDV0egp2uMDUuDhY1VlvBJjOBIoirAA+TBj28a1vQey4gA18Fo=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr7719717qtk.187.1538038890037;
 Thu, 27 Sep 2018 02:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Sep 2018 12:01:18 +0300
Message-ID: <CAHp75VeuGUmGGaUSQ2ebYsAZRtJWrFmERQGvzZ5qdn=rpwTqWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Update and move Dell drivers dell_rbu and dcdbas
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Doug Warzecha <Douglas_Warzecha@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:50 AM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> The dell_rbu and dcdbas drivers need some changes, and should be moved to
> drivers/platform/x86.  Additionally, dell_rbu needs a maintainer, and the
> listed maintainer for dcdbas is inactive and needs to be changed.
>

Pushed to my review and testing queue, thanks!

> v2 changes:
>  - add commit messages to patches that move dcdbas and dell_rbu
>  - remove extra whitespace in MAINTAINERS
>  - add acked-by from (previous) maintainer of dcdbas
>
> Stuart Hayes (5):
>   firmware: dell_rbu: Make payload memory uncachable
>   firmware: dcdbas: Add support for WSMT ACPI table
>   firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
>   firmware: dcdbas: Move dcdbas to drivers/platform/x86
>   MAINTAINERS: Update maintainer for dcdbas and dell_rbu
>
>  MAINTAINERS                                   |  11 +-
>  drivers/firmware/Kconfig                      |  28 ----
>  drivers/firmware/Makefile                     |   2 -
>  drivers/platform/x86/Kconfig                  |  28 ++++
>  drivers/platform/x86/Makefile                 |   2 +
>  drivers/{firmware => platform/x86}/dcdbas.c   | 123 +++++++++++++++++-
>  drivers/{firmware => platform/x86}/dcdbas.h   |  10 ++
>  drivers/platform/x86/dell-smbios-smm.c        |   2 +-
>  drivers/{firmware => platform/x86}/dell_rbu.c |   8 ++
>  9 files changed, 175 insertions(+), 39 deletions(-)
>  rename drivers/{firmware => platform/x86}/dcdbas.c (82%)
>  rename drivers/{firmware => platform/x86}/dcdbas.h (93%)
>  rename drivers/{firmware => platform/x86}/dell_rbu.c (98%)
>
> --
> 2.19.0.221.g150f307af
>


-- 
With Best Regards,
Andy Shevchenko
