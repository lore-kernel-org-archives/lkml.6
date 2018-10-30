Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C1ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfcODBMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeJaD2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:28:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36054 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeJaD2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:28:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so12280580wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OOfrHVgDjv/JfbdwxeZaEJWG8Qs4VjChVVwAjVxQZ04=;
        b=hfcODBMgRtdmmqvCSNzcr2ol/eL2CQdTSSCc8i2b0NBsbZ8QdLKYW2o0+n1dDVcw1t
         8sHi60DtxBB5IQfvQJbxj8doKNh1Ox8J0c1HEizAGwEo7E4GCQxfWtlIeV3uKwk3gsEr
         lGyfYh7UVEGZH4ZuS9LarWBuDpAzK57iLKpI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OOfrHVgDjv/JfbdwxeZaEJWG8Qs4VjChVVwAjVxQZ04=;
        b=GdcUoJR478w7getOmaBwzrPdla2viAvdk+tw2fQ3lqnbp7JAzQ9V6JOmQtlRLuNm+W
         wefLpgMMonmsxHQXU6iBAI5ED4fqd2Ae0IvJAvEtUqJuVRkjwfWHoWykf+7srJHpsCxZ
         xcHG8RmKiopfUOnBfuSrqowcJuvgDltfa5kdN1gKmsQAJAtht7Daaok3hcR+9VUAkA94
         BWBCiJIdQM39xDAjuk3ToPMB5WZUqCKyzGtcVOOqUVUys155g+koKwaq6VjYPBFqfk4a
         LljanWoODwNabuXqQLCXUJICAszqm9oEUkZoDTGH8m2BvmGtT5AYPdTAE1+794WA2Q2h
         zMPw==
X-Gm-Message-State: AGRZ1gKd+9SfdkZTH5tS+QI9giCXxCHX1oSIC3BDJnCm7VIcudktHcQq
        iPbDNhj/Q+TcZtM3AqcqgWCBFHROdQcVJoGeR2YIig==
X-Google-Smtp-Source: AJdET5ehxwVnjwtgjQFROMAc41A9iliFCWCbDd3Lr5UKQnOYAbS0lbc24WnKc/FHpbAxTC9F4iM0JtPe+DcxD36RHmE=
X-Received: by 2002:a1c:8c8c:: with SMTP id o134-v6mr669wmd.35.1540924409303;
 Tue, 30 Oct 2018 11:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9f03:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 11:33:28
 -0700 (PDT)
In-Reply-To: <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu>
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
 <20181030063408.GA26627@kroah.com> <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
 <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 30 Oct 2018 20:33:28 +0200
Message-ID: <CAKaJLVvXUTB5hyoRPZpfnzFKiLrCfLmras_37B5JxSYs4438Tg@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-scsi@vger.kernel.org,
        Praneeth Bajjuri <praneeth@ti.com>,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 3:04 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Tue, Oct 30, 2018 at 02:01:04PM +0200, Sam Protsenko wrote:
>> On Tue, Oct 30, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
>> >> Hi Greg,
>> >>
>> >> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
>> >> <semen.protsenko@linaro.org> wrote:
>> >> > The kernel is self-contained project and can be built with bare-metal
>> >> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
>> >> > this u_quad_t type is not defined when using bare-metal toolchain and
>> >> > codafs build fails. This patch fixes it by defining u_quad_t type
>> >> > unconditionally.
>> >> >
>> >> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> >> > ---
>> >>
>> >> Can you please pull this one, if this applicable? I sent it a while
>> >> ago, but I guess it got lost in mailing list. It might be also
>> >> applicable to stable branch (as it fixes allmodconfig build for ARM
>> >> with bare-metal toolchain).
>> >
>> > Why are you asking me?  I'm not the maintainer of this file :(
>> >
>> > confused,
>> >
>>
>> Sorry to bother you. I just thought you might be interested in this
>> one, as it fixes build for "allmodconfig" configuration, hence it can
>> be related to stable branch. Also, maintainers didn't respond to that
>> patch, so I'm kinda dead in the water.
>>
>> Anyway, will try to ping maintainers one more time.
>
> I thought I had responded, I didn't see a reason why one would want to
> compile non-userspace kernel headers outside of the context of the
> kernel and if you do have to do that why not just add -D__linux__.
>
> However, I can also see the point that anything not in uapi/ pretty much
> by definition will be compiled with __linux__ defined so it actually
> doesn't make a discernable difference to just drop the ifdef and I'm
> fine with a patch like this.
>
> These trivial patches typically get picked up through kernel janitors,
> or maybe an akpm linux-next patch queue. In fact, I'm not even sure if
> there is a designated person I would be passing updates to, I've sent
> patches to akpm, viro, hellwig, linus, and gregkh at various times.
>
> Jan


Hi Jan,

Thank you for the reply. Good point, I will try to re-send this one to
Andrew Morton and kernel-janitors.

P.S. We need this patch for fixing LKFT/ci-loops build.

Thanks!
