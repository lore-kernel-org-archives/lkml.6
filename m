Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C48C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F32080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="alJGZSXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309F32080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeKRAjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 19:39:32 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF092080D;
        Sat, 17 Nov 2018 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542464563;
        bh=Bhx8tIObvjVtsVTUkZcqw+lB17tFoYn7VRVvtsuqH4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alJGZSXO0MPDbPQP5fnqG4cAOkIwo6P/ZiFgZh7Eaf2O4Pgm0U9AANA3cxjGFwVZR
         9XsE/o7QYUJhnby2WwufO+aeQXYq4uw5Uw4vlThCoqxnF2jD0g/pdXLInfTPRlP55D
         n1jb3KZn7F5NnRSyRqL2RD1hquQP2rSqzyVvWwxI=
Received: by mail-qk1-f182.google.com with SMTP id m5so42063861qka.9;
        Sat, 17 Nov 2018 06:22:42 -0800 (PST)
X-Gm-Message-State: AGRZ1gIIMwA3E5/ssSj/+fue14wWXbnt8ctkvfAB/CzDjOCf7GwiB20e
        cV+9w9/mR+Inp0WuDL9zL++dLjXhd32HWOaJSA==
X-Google-Smtp-Source: AJdET5cPTH5yX1353T4n7RDC+bKHcJqETfVcSWp6zDmNYlqVdaE/UPQymyeFfSsv1/joGge6N3KmajxWlqNalRmFkw0=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr13530636qkg.184.1542464562061;
 Sat, 17 Nov 2018 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20181114125432.16044-1-tom@aussec.com> <20181114125432.16044-2-tom@aussec.com>
 <20181116224919.GA18008@bogus> <20181117213522.12672utznrvpbn56@www.aussec.com>
In-Reply-To: <20181117213522.12672utznrvpbn56@www.aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 17 Nov 2018 08:22:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com>
Message-ID: <CAL_JsqKZHg5_8ghMmU4qO4CVZibcHOvtVJH669zod_6GLGakRg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pps: descriptor-based gpio,
 capture-clear addition
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 4:35 AM tom burkart <tom@aussec.com> wrote:
>
> Quoting Rob Herring <robh@kernel.org>:
>
> > On Wed, Nov 14, 2018 at 11:54:29PM +1100, Tom Burkart wrote:
> >> This patch changes the devicetree bindings for the pps-gpio driver
> >> from the integer based ABI to the descriptor based ABI.
> > ? That has nothing to do with DT.
>
> I believe it does, as the change in ABI forces a rename in the DT
> naming convention.
> This is due to the descriptor based ABI appending "-gpio" or "-gpios" (see
> Documentation/gpio/base.txt.)
> Admittedly, I may have called it by the wrong name due to ignorance,
> my apologies.

If what you say is correct, then you can't change this driver. You'll
break compatibility with any existing DT.

Changing the binding reasoning should purely be that this is the
preferred form. Bindings must be independent from changing kernel
APIs.

>
> >>  It also adds
> >> documentation for the device tree capture-clear option.  The legacy
> >> device tree entry for the GPIO pin is supported.
> >>
> >> Signed-off-by: Tom Burkart <tom@aussec.com>
> >> ---
> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> index 3683874832ae..6c9fc0998d94 100644
> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> @@ -5,19 +5,23 @@ a GPIO pin.
> >>
> >>  Required properties:
> >>  - compatible: should be "pps-gpio"
> >> -- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> +- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> +Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
> >> +- gpios: one PPS GPIO as above
> >>
> >>  Optional properties:
> >>  - assert-falling-edge: when present, assert is indicated by a falling edge
> >>                         (instead of by a rising edge)
> >> +- capture-clear: when present, also capture the PPS clear event
> >
> > Is this a h/w thing? or driver configuration?
>
> Driver configuration.  Most of the code was present in the driver, yet
> it was not documented, or usable due to a two line (code) omission
> (the value was not being fetched from DT).

So what determines how you want to configure this? If the user will
want to change it, then it should be a sysfs attr and exposed to
userspace. If it depends on h/w config for a board then it can be in
DT.

Rob
