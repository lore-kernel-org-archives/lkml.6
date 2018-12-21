Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA12190C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChL6Ewhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeLUKhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:37:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46810 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389512AbeLUKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:37:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so3545273lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2MACnkfwThM+VEngIUnBmJJs8UuyfjN3oe6QwxvXbXs=;
        b=ChL6EwhfgiREMaBiiRU2JKeAkwdU4Siq1/bnEiwi4j5ud5ZpW8iFFU8+NAysACuD1b
         VFrO2KfgPpRDZwY1Vy37Qd/EhCuGN10OhLN3BvBOwCPEBjCTo2Gzaqqur4LPTFw1QiDe
         n6+xmv/QUEAUWteubolReorW/rje6OxUbLYJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2MACnkfwThM+VEngIUnBmJJs8UuyfjN3oe6QwxvXbXs=;
        b=G83qakkfOHj+vPwAEFO3FwlIkMIMogz3I66+XsMH7JJUGLVObfTReSxrQeehK8N2zt
         jKZd7LTtUWOWcrutFy0H6gkIwru3SGV1a8JBA0QI/gkRHbJ0hRA+dzDb91lykJ4/ecxK
         dP9NrsyhiWuNVkhLPt0HsTmhoyn782qs+X86jjNsGGq4K5UVBn6vG4BhHmeGiFRbobID
         m1bcWbMhw07GNTaFsfFnwO8vW28aCdvzsUnmnFpc2vkjUeHxEY2MBkARJbyTuQmsB8Dj
         qP8Khivrm8GGeabKsSNO8RCeL4k71DJNz0qRogCZwazvezDiE08DPVWnbZmgHq4J+ozA
         m56Q==
X-Gm-Message-State: AA+aEWY8BDyhazW75CzMDc/CJNAhvdSJkHCjPkJqNjWkV98/cmPROTcQ
        dFvXkeLpovCD3jUBpXEzo4iEq3lQrzJmoDkjtQ0uMA==
X-Google-Smtp-Source: AFSGD/VteVOq17pGJ+vIsgXJIga49hsOHO1MFHM0yozBLkuSZokBLGbkopV7Fo1uMlh4OXkJb/pk+KDHSRjhg7+POsg=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1132965lfa.32.1545388636210;
 Fri, 21 Dec 2018 02:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
 <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
 <CACRpkdYq5Eg2DrwdED-yTZ4kMoCxew+0rdU-b4zuinOf7BEr6Q@mail.gmail.com>
 <CAMpxmJUnfnHmopyOfHRZrN1KoqZx_Bsra1BTiGud6UVmzz1ryA@mail.gmail.com>
 <220ECBA7-CD30-4221-8878-0DA93390DDCC@global.cadence.com> <CAMpxmJX5ScpYCL0DhM99U=sbhU4VOxaA+gPzBJ698gs0-UFMxQ@mail.gmail.com>
In-Reply-To: <CAMpxmJX5ScpYCL0DhM99U=sbhU4VOxaA+gPzBJ698gs0-UFMxQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:37:04 +0100
Message-ID: <CACRpkdZJoPKacABqSbxKOZnt7vUar_1_H7q7Brxxo6e2oBnfRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Janek Kotas <jank@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 3:06 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 18 gru 2018 o 14:54 Janek Kotas <jank@cadence.com> napisa=C5=82(a):

> > I can reimplement the driver using regmap, but It seems in such case
> > I won=E2=80=99t be able to use the Generic GPIO Infrastructure, would I=
?
> > So I would need to provide functions for setting direction, etc.
> > I think it would make the driver code bigger.
>
> Indeed. If anything: gpio-mmio would need to be converted to using regmap=
.

Ouch, let's go with this for now.

I think for gpio-mmio we have two new cases we really need to cover:
- port-mapped I/O (x86)
- regmap I/O

Augmenting gpio-mmio for these could probably strip out quite a
bunch of code from several drivers.

Yours,
Linus Walleij
