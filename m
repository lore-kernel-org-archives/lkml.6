Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A679C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D2E20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLKxfAbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D2E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJ3UyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:54:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeJ3UyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:54:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so12275842wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+GL2sUHHEGgreMiH4z8weRH4cbA778bev1J+TebjaPY=;
        b=iLKxfAbbDnyhGJGL/DQ7A1hRHDM2DW+894sVA0w+HdyEfcmiGXB09aDqgykn/qfuai
         P8XIeH7QyPjP93VFsSoXycX/Yk21gEV9ljTvWyNG4AWNCbUE+LvHAqJHefdslq3M06wH
         jIufnnCfuQwx3Man40FOYLdDd5MyMecUFFgtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+GL2sUHHEGgreMiH4z8weRH4cbA778bev1J+TebjaPY=;
        b=Pr3g4gx0wgsZkbE3PrghU1kwbj5n6W+/KSjlTnQu4OHhyDvDtV4gHGg1DSLtAP8SXa
         g5850Dws8MO3MwjR2ewCTx5yrxiP+G+NjmDGjgPZx8vwpUS1MQIshyleuxt9bls+F+l1
         sZMD0ruCn+ml96IZkUU8TSM4jfpkWIjA7jCrRTLOm9SU6TQ6lHO94GAQIsvqQyR/142z
         S+KMDMMVA1vUoUjPS3/SykowGe2OCiMo3ypPLVNDTag2MIMhMyxOA4YXNpEnNydSVe2l
         2gGVkYqArYHtflu69a08eDygMdniRSozFjZbtqJVlq8pK342xTIjRJQTHViANbQKYQAw
         sE5Q==
X-Gm-Message-State: AGRZ1gL6INyXJQ1AtDI3z1Ut9ekmat1nKA1+Lbd5U2tcOmFgNmQ5teJx
        uUwtyp4i+pla3c4BJy51LcZML6/F62DXuzPFmmdohw==
X-Google-Smtp-Source: AJdET5dDRf8VzRgVXSU6235m2mGmTh3L5Rp5n6kTpi4GIe5vmyEARXtUD/NxBoZ/DLgDm+MyzOI6cNKOEM3FRoalWGg=
X-Received: by 2002:adf:e2c1:: with SMTP id d1-v6mr18378198wrj.26.1540900865341;
 Tue, 30 Oct 2018 05:01:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9f03:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 05:01:04
 -0700 (PDT)
In-Reply-To: <20181030063408.GA26627@kroah.com>
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com> <20181030063408.GA26627@kroah.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 30 Oct 2018 14:01:04 +0200
Message-ID: <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
>> Hi Greg,
>>
>> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
>> <semen.protsenko@linaro.org> wrote:
>> > The kernel is self-contained project and can be built with bare-metal
>> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
>> > this u_quad_t type is not defined when using bare-metal toolchain and
>> > codafs build fails. This patch fixes it by defining u_quad_t type
>> > unconditionally.
>> >
>> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> > ---
>>
>> Can you please pull this one, if this applicable? I sent it a while
>> ago, but I guess it got lost in mailing list. It might be also
>> applicable to stable branch (as it fixes allmodconfig build for ARM
>> with bare-metal toolchain).
>
> Why are you asking me?  I'm not the maintainer of this file :(
>
> confused,
>

Sorry to bother you. I just thought you might be interested in this
one, as it fixes build for "allmodconfig" configuration, hence it can
be related to stable branch. Also, maintainers didn't respond to that
patch, so I'm kinda dead in the water.

Anyway, will try to ping maintainers one more time.

> greg k-h
