Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29091ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74FC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XJgKN2C4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpJ85PMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGROnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:43:03 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45639 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeGROnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:43:03 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so1860708ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U79FpdumweQiMrF6riph6zIi5Efas9Ebp7IPIgE3Wew=;
        b=XJgKN2C4rTY9xF5BjY/iLYYUmaUZ5oCUf4ssKEuxisbtxPs1Husn5q1MSJ1oGUGept
         tTrDV7ZaB6HBfNEIIq6Fhudv80u0Wwb9jYtxRooPu2V+afbEczYcBh+1VnfsxMsj/fJY
         eAai2SLCovL7v7mXo1zAbRvd1g533OwDYpFKkAZmOoCC4F5YAVPSitnBLQZJWDKFrQiR
         TeIfKrP6b10j1DGpt78CFMsYt8ZKTPJJesaKp2aqvjUPAdEtwEj9T/TIXj+H2UrhmxAZ
         83Psd8tv/Shw5+EjvYiXwXMwcpL8bMKWiwrT4SSt7td5ezwg64N9j6ZJ2kIZKwnDfu5r
         dhsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U79FpdumweQiMrF6riph6zIi5Efas9Ebp7IPIgE3Wew=;
        b=FpJ85PMnHphtC8L44697N1/+GVEFhK6s4Srb+ICsQm6aD+awHly7gFvK28lslw6CPP
         4usT7HxmDXcRTx+KSBFLEtJiF6mevaL6D1BmhZavPN9LSd7pRSOyqLqGyb3phQPTEs2c
         bgVdUP+Xi1Ihwii2JVK4ORzXhhq9EVAHJpZp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U79FpdumweQiMrF6riph6zIi5Efas9Ebp7IPIgE3Wew=;
        b=PHA8BWmdk8J9lICwF77GpqELr9AlKOELcPE4kB2Zj+fhEkHT8IT/Q5LL/bJ2nAfCry
         6zR/68l6vfgBgZjLkd36PP5cwcfkQPYYwt8cAxZExWbT8Gtt+oCF4U+DqKlXtE8DOC5/
         TE+2yXH3xsAQbiD0bdjwIb5Q8kRh5HSNTqliF/+KhFMuI0w9wBvsXbUXdHIJmtcuPTLD
         /IQ7ULe1/3JvrDr1tb9IfZaXHrr6hdW1CzTvmEhcBVnUgbL2nZHlsVqXlKp+Xlqbu/qv
         xXwf2bsg/hA6f/rzJLN5qBfapyGEtJX7xLT8dars6YqOA9vflLEhWVOHTcB3FRcvq+Gf
         J9Rw==
X-Gm-Message-State: AOUpUlEAqdlvpUYrhosjlbrq5I27C30GBYMA9P+bpbvc/0QIRO9557Jj
        zWZVzm0czP68FVOfXNpmBYCsZGlSRptxCbsGjfPpQS1C
X-Google-Smtp-Source: AAOMgpctoC3FwETW+VmJxUDNAAmIOhe29QjUgK1LsTEt6uSdjAVPPHSBi8ei4hK6en3qGgIH6+ODj78VCHVnjUOhmJU=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr3175643ybe.118.1531922697160;
 Wed, 18 Jul 2018 07:04:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:04:56
 -0700 (PDT)
In-Reply-To: <20180718010242.5254-1-nicolas.pitre@linaro.org>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 07:04:56 -0700
X-Google-Sender-Auth: b1BbkDexLbkJWYkTa0lqPJ2zeK4
Message-ID: <CAGXu5jLkgA2gLPM3cMwvTgGcBR3MBRHtJjO-EsTgpz5uqgHsaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] follow-up to the unicode vt console series
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Tue, Jul 17, 2018 at 6:02 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> This is a follow-up series with 3 patches in response to the following
> messages respectively:
>
> http://lkml.kernel.org/r/20180628123803.GA22045@kroah.com
>
> http://lkml.kernel.org/r/CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com
>
> http://lkml.kernel.org/r/CAMuHMdUmC+uiKTEMotB83A86E1wEYrNF2qPf3kDACaW27D_NbA@mail.gmail.com
>
> Those patches were tested on top of previous patches already in tty-next.
> Please include in tty-next before next merge window.
>
> Patch #1 was posted before. Only difference is that it now uses rate
> limited printing.
>
> Patch #2 is new, however it has been tested with the validation code
> provided by patch #1. This also fixes a security issue.
>
> Patch #3 is new and trivial.
>
> Diffstat:
>
>  Documentation/admin-guide/devices.txt | 16 +++++---
>  drivers/tty/vt/vt.c                   | 57 +++++++++++++++++++++++++----
>  2 files changed, 59 insertions(+), 14 deletions(-)

Thanks for fixing the VLA! :)

-Kees

-- 
Kees Cook
Pixel Security
