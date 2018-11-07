Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E645C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036A62081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnG1o+Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036A62081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeKGOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:30:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38153 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbeKGOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:30:27 -0500
Received: by mail-it1-f194.google.com with SMTP id k141-v6so19303598itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 21:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VFd1Ham5ps1cgnEa17qUQDFkXORViCewWzqfqZDRjs=;
        b=OnG1o+UzRoQyxm7q26EmS3u1ly6k8aq0Um9CgYUgVWtbtn/mfk2/9JasWxhcii4ajx
         wLaB18xF3jQ88Qzm+ZZQNFk3S7PCi71sD1epuoPHZ9CzDdFnkhV4ft6ld37yA3BZkwdf
         LVo7rNoaavvB6ARameej6msFEpRfTBKUXwMx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VFd1Ham5ps1cgnEa17qUQDFkXORViCewWzqfqZDRjs=;
        b=PPabONliWemzujskf8K5WJfA6j2CCkMp29Br9GK5dpBZ+UCj6GvbcSvik4XK+L9i59
         fQUi5Yyfky9nYIVtoPei34MitF2jIvuQcBSQzj1J5yX8bbWntKiGhThY/cjGfb854cz6
         f96mnWOC1GNLgruaMzX4c3m8vgXZ7WstQJqhcvWEXAE9yFQjijD9UyhHzNW3enB6gvgN
         h7tdQ6f5R7szeKY1RnNF7W6Jgrx0gpL7YDrGPTBeHHUh6aigryJRKt2heeCC5FubNPdH
         TO4zjLR9ZXs5M70BTVqcHWvibEGVK1Ve5hI7pMpC9r1VozgxAVpLGvl36dSao/qWO8NQ
         q9gg==
X-Gm-Message-State: AGRZ1gIxwQb2Lt1AsCOrxfOFwIw9UKFVa6gKGZRQRW2C2/Mkyn1NQ3Ih
        4s6g60zSTpepPJ/2bevf5easG1Bws6jNl6O4uAou8A==
X-Google-Smtp-Source: AJdET5dZ5XwnCG/5UVce4D714wR3mFslnbBpHekK/DtLz7b1iMaaUI2YeaMrKntSsYzYAb1RUGhwfiPTVyD/aXoaQlA=
X-Received: by 2002:a24:1c85:: with SMTP id c127-v6mr637092itc.148.1541566903459;
 Tue, 06 Nov 2018 21:01:43 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
 <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
 <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com> <CAMo8BfJcUuC1tcrZNf+6_iRA0esj5QrGFViMMeR3NPw6G5GbFA@mail.gmail.com>
In-Reply-To: <CAMo8BfJcUuC1tcrZNf+6_iRA0esj5QrGFViMMeR3NPw6G5GbFA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 7 Nov 2018 10:31:32 +0530
Message-ID: <CALxhOngnAHO16CTiqseAJD8q3TDX6Js6M+ZLwTLudT5RvTcLDQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Wed, 7 Nov 2018 at 01:54, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Firoz,
>
> On Tue, Nov 6, 2018 at 7:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > My initial patches does have generated-y += unistd_32.h instead of
> > generic-y += unistd_32.h.
> > If I remember someone pointed out that this implementation doesn't
> > look good. So I
> > replaced to generic-y += unistd_32.h.
>
> I've only found the following case, where you did the replacement:
>   https://lkml.org/lkml/2018/8/9/177
> and I'm pretty sure that Michal meant that only the missing newline
> didn't look good.
>
> > Sure, I'll change to generated-y += unistd_32.h instead of generic-y
> > += unistd_32.h.
> >
> > Max, this looks ok. right?
>
> Yes, generated-y looks goodto me.
> Could you also please move the line
>   generated-y += syscall_table.h
> up, so that alphabetical order of the header names is preserved?

Sure, will do.

Thanks
Firoz

>
> --
> Thanks.
> -- Max
