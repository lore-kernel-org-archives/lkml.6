Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E34C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511722084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lYedVqQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511722084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLKWJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:09:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35831 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:09:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so13402078oif.2;
        Tue, 11 Dec 2018 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eI5IGdZLbihoM1JpOCBJmDZFFsM5cSSnLSPPgCxAhxk=;
        b=lYedVqQZ3hqB7908uJavjK0ActWFskQNhfRu/+U8sFPEicionz+F4zXfkoBWB7MTMv
         nrpTV249UI8OByccj+DNfZJ5xnMuEXGYE4F36ZwtOALheYYEtd8ornGZyAwNvsXKw6nB
         OI0ufxjbfmFQ2JDHaFLSAK/hmv7+senKJrKhyeNvWpWXDUKkiGwVzJTxaRz3wdVjD4hp
         NmDDJmKtN2Azl/2TUzYP8vVcdYr2sm4kq5PLlO/n+p+KBi5IIn4sybbYSwuDiUNimUMq
         4W1erBZT5etP3t4ANa42ek3Q6kczPK65Xkl1UxFHoN7f7V6QWiugpOfFGoudCfCkNS82
         WdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eI5IGdZLbihoM1JpOCBJmDZFFsM5cSSnLSPPgCxAhxk=;
        b=ARmmPSxRvxzBkL/vy5QPvXquF95UAMRz1ODsTgY3JWZODXHNzdMMJ+dgzCoB71A2FE
         ifHzwD68xP754z0Ifunq//bkQ4wZ8HS9M+r+65ZV0/hep07eqZ5k82z7o6clwSsf/6WS
         gzgWRsvcbouDP/06DKjtmKSkUU9M7YO5+ZWQi1eELiM0tvOXS+AHbROal9u8uRS4mfgW
         pPUS78CUFqTjlMcqiNLiFVJ+nGwsvP+EBLf6pH8uoNbUwj4Ga75qkOkXgvUbV2tqKKoW
         kVGxccUi9Fek0EYQ4/5jftq6M5ecNGwInwzS0A68g3Z+smQRpX0zEba4/8P4LYBAvoLr
         CL9w==
X-Gm-Message-State: AA+aEWYng5QBPLasXs+SrLw6pe3NuJNEHrc0XHUixDkXHkpRsBeTIXp7
        gasa7Svc4U1DCBe4ZntX6GEwMdbYElxt6pLskMo=
X-Google-Smtp-Source: AFSGD/Wd/Z4vd02AtSBwuc1xmWjmPFLv8kqXsfTFz7+LnpbfgEAjbmcFHJYvFjMlfJ1RZphs6yginarIxzFkIPWxYhY=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr2461612oia.129.1544566181810;
 Tue, 11 Dec 2018 14:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com> <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
In-Reply-To: <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Dec 2018 23:09:30 +0100
Message-ID: <CAFBinCBYBAqtKp_edgs6b44MpOhc-iN_FwR425bkU4xirGQKvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Dec 11, 2018 at 10:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/12/2018 17:50, Martin Blumenstingl wrote:
> > This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
> > Meson6. This is preparation work for adding the Mali GPU which is
> > located on theses busses.
> >
> > Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
> > region at 0xd0000000 is called APB2 or A9_APB and it has a different
> > size (256k) compared to Meson8 and Meson8b (2M).
> >
> > Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
> > - Meson6: [0]
> > - Meson8: [1]
> > - Meson8b: [2]
> >
> >
> > Changes since v1 at [3]:
> > - re-send the patches but this time don't include the old patches
> >   which still had a typo in the patch description (ABP vs APB)
> >
> >
> > [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
> > [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
> > [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
> > [3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html
> >
> >
> > Martin Blumenstingl (3):
> >   ARM: dts: meson6: add the APB2 bus
> >   ARM: dts: meson8: add the APB bus
> >   ARM: dts: meson8b: add the APB bus
> >
> >  arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
> >  arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
> >  arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
> >  3 files changed, 24 insertions(+)
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
thank you for taking the time to review this!

> But frankly I'll squash the meson8/meson8b patches with the mali node patches !
I didn't do this because I realized that there are different busses
between Meson6 and Meson8/Meson8b. so I wanted to have a commit
message which describes this.
if you prefer I can still squash the Meson8 and Meson8b patches into
their corresponding GPU .dts patch but I would like to keep the Meson6
patch (as I'm not planning to add the Mali GPU until someone can
actually test it on that SoC)


Regards
Martin
