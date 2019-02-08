Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D8BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B9206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BuJgVxzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfBHQ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:27:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:27:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so6706721otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4MrPTQfL+aqliH6C1atcII6SPJlu1ysjr91YRTpgFmE=;
        b=BuJgVxzHyi1y7uQnhs6w7HKPQs4iM0vxEbQNuSuFbEd/7biWtL3H2C7hZKGjafvTvQ
         sUkJpTsgqUQcaiaFVi5Z4F9pbKQkiFpj1nhw/JIfDE34PPDVkbH+Xw+enEf618vXwGoB
         VRFwqtHcEdPJ40vNsDFf/MrzMphsCeSGhSVDMtqKpDYtDwDCXGDTyFVVk4lu7lbd5E/6
         45xyEBFBF/mwHEIl++wXacjcPSZ6N24LMdI3gy5SjJdKUqKmMl053LSgxMsghLwTEogA
         RwesFZP6ZKerisv+1tXyhSUi8kTmvbajckU4O+8LIkIvBc3fNv8YndyqeML5VvkDmZhf
         8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4MrPTQfL+aqliH6C1atcII6SPJlu1ysjr91YRTpgFmE=;
        b=r50qiuyDMDwdsjpcRWmKCjJS0VGpiwagBCW91A7cYMzvh4KB1Ysg3hrAr/gYntz6WU
         3KawH7wZrgpA8pzhiO3NEfxyAwdU83HUZPL9GPtcSQQhtzDOYxpEWYlWeo3PEb1/dnDO
         bqNV9wzKfr94bcYRyqd59BVTvDIGd69SoWtLoKgc6TgVZ6k2lLQb90RaDMv4rtoW01u5
         lkLzJes8P9qHoMaO3L+MF2OW0m0gEax13zwHEZcggLKqDn6M6zNfbGUaq/cEEBoMRFpx
         sZ2Q7Ys8TebrsGLKKVtHI8n2vySEy1hWNXnNvSDPD9FVKMxB6hISk6xmcqfo9a2LrK9b
         e1zQ==
X-Gm-Message-State: AHQUAuYJpQipzHqR3p1SF3qJ/TpT6Vsw9prrh/rm1BZePJkzaCC3XD4/
        JHQZX+/BSxp/e707owrIIm6r36K/dq74uhEMMwyODehG
X-Google-Smtp-Source: AHgI3Ia6gpOAthSEpzLP+vPzXW0Qx9oCEdIIRnwkCqfklMtUWvLhhBJKVFu9r+KSGST9fwgMqUCG89i4gvDUEnBsN3k=
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr13458873otl.108.1549643252459;
 Fri, 08 Feb 2019 08:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <20190131133928.17985-26-brgl@bgdev.pl>
 <55b5797c-ee0b-c2d8-9eb9-0d681da08018@lechnology.com>
In-Reply-To: <55b5797c-ee0b-c2d8-9eb9-0d681da08018@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 8 Feb 2019 17:27:21 +0100
Message-ID: <CAMpxmJWSJQyb+36ZEurULT+Bh306kiqXxkwUg_Yg-Jzu4GEpFQ@mail.gmail.com>
Subject: Re: [PATCH 25/35] ARM: davinci: cp-intc: use the new-style config structure
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 5 lut 2019 o 01:29 David Lechner <david@lechnology.com> napisa=C5=82(a=
):
>
> On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Modify the cp-intc driver to take all its configuration from the new
> > config structure. Stop referencing davinci_soc_info in any way.
> > Move the declaration for davinci_cp_intc_init() to
> > irq-davinci-cp-intc.h and make it take the new config structure as
> > parameter. Convert all users to the new version.
> >
> > Also: since the two da8xx SoCs default all irq priorities to 7, just
> > drop the priority configuration at all and hardcode the channels to 7.
>
> As mentioned in a comment on a different patch, this isn't strictly
> true (although in practice, it probably is).
>
> This patch deletes a code path with the comment "Default everything
> to channel 15 if priority not specified.", so it is possible (although
> unlikely) that this patch could change a priority of some IRQ that is
> being used.
>

This only happens if no priorities are specified. Otherwise we just
iterate over the provided array and set priorities for all interrupts.

Bart

> >
> > It will simplify the driver code and make our lives easier when it
> > comes to device-tree support.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
