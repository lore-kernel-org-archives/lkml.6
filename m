Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F25C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FBB214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyJjhfft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FBB214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeKVGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:12:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44546 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbeKVGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:12:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so2620365wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ayAX5yROzFHa0W15ZIyP8hS/ArZSAo7yB9oVrA+i4KA=;
        b=JyJjhfftf0AJT9rLfDS98HgGhuZHyO2X/HVA/q7LebH+qvYaeOJm40Xwf9mG+kL3L7
         unVmtyvb1i2ZVW8AP0O88M2ODHBVSm1kz8bKrU4qGOlj3nBgUCbCiJyTLJmQyzQifwPp
         inW9UeOqUDDN9PHeKemlF2kKjulSn/7ElXQss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ayAX5yROzFHa0W15ZIyP8hS/ArZSAo7yB9oVrA+i4KA=;
        b=nZF/qMj5pC3D+oaA0z9eHBhHO61D3i+CgJ2vvX6TY7/VxBtgXSFkoUratyP6oaz5Hn
         o3ba67FHq+HhRy1kY8ARCvb3QG/83Wtydc1AwVsF8BH7Ep9oAM/KZhHbNtg5GihrJHEs
         VGzNuX9+LmF2BTGH8bhagYgF54O4Bu33jiYBHmV2o4qnt2iIiZeA2OPfrVTpEAGsOEJz
         yxyR+riuUPU1DX3V3F5YnGEdp5MqWgKXLQ/9HD1gGaB5qt9xT5lWH0PIEqcDmhqLGIWP
         kmF+v4cP/nZBIDSV9sp1Z/bJSZ0WOCeK4GHp6EyhRkZme8J8NsIE0YudknG+49wzUrYX
         nMNQ==
X-Gm-Message-State: AA+aEWZiGdPCw4P8pLgTCSE0H2d4zkMk0NpqdPeqXW4U1D2XdwtopXjq
        9rikEiB8hrxtNMAp38QBIfnu8QzanThIiC9I5Js3Ew==
X-Google-Smtp-Source: AFSGD/UX21WRoSxShJGNSp3CAr2KD7O4gROmuI2ap2A5Xnh7ArYrjK4/2y8cPtpav6NoD/DwclN0gBNpn7NM+0N0IJc=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr7474044wrr.67.1542829020273;
 Wed, 21 Nov 2018 11:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
 <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
 <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com> <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu>
In-Reply-To: <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 21 Nov 2018 21:36:48 +0200
Message-ID: <CAKaJLVs4MUws7sPPdDk7hnjZ+Z1V0V6bGt=eWn=gsF_B+yULeg@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Andy Shevchenko <andy.shevchenko@gmail.com>, hch@lst.de,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:10 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>
> On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> > I'm not sure how you managed to miss people in this list (perhaps by
> > default you have suppress all Cc in your Git configuration), but I
> > guess we may gently ask Christoph to apply this in case Jan will not
> > appear.
>
> You have got to give me a little more than 10 minutes to respond before
> assuming that I would not appear... I don't think I've ignored any
> previous emails on this subject and the only issues has been some people
> not receiving my responses for unknown reasons (agressive spam filter?).
>
> I have no problem with this patch, have it sitting with some other
> non-urgent patches and in case it doesn't appear upstream it should
> piggyback with whatever I have to send.
>

Thanks, Jan, really appreciate it. We need this patch to fix our tests
with allmodconfig configuration (in Linaro CI loops).

> I still don't know why the bare-metal toolchain couldn't just add a
> -D__linux__.  I understand that this define is expected to be always
> present while compiling kernel headers so that there is no good reason
> to even bother testing for it, which is why I have no issue with the
> patch. But it seems it would make your life a lot easier if you had it
> defined.
>

As I understand it, from toolchain's point of view, if __linux__ is
defined then it means that the program is being built *for* Linux
(i.e. we can use Linux specific features, ABI, like syscalls).
Checking this definition can make sense in uapi headers, but in kernel
code we shouldn't use it (as kernel is baremetal program and not
compiled for some OS). I presume that's why __linux__ is not defined
in bare-metal toolchains (as those don't provide Linux specific
features, libc, etc).

> Jan
>
