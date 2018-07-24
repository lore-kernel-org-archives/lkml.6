Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210CA20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uvsHUZYr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vf+e+Qs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210CA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGXS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:59:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35921 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388463AbeGXS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:59:05 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so1854671ywg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rhXdS0JlrmQPOo8uGulR2+QL5OPOPxsKAh847CNTQ/4=;
        b=uvsHUZYrS3sBKeM0HtbKbZ3xPXdcwuJ8AhYPxgqfiCY5Pat3ehrX28d96unQlycbNa
         i0LeqtVa/LJbw4O3lVzzmVJeImEXsJ1JsooXgp4xv0qVfCa0DvKzh4AUzipkxq8jLyvw
         SOxuhfnuezIk7S8EGpuTb01X6k3vrO1uwbg5cvbxH14G7YT4l22+T2I3ggwCxhFKyyNU
         wh/PyC2iYVj2XthzcUe+HHsRZZzn2lbM0xTdry5noPPBOxJnHop+lvwbSOFQrGM0r9D5
         vCLLhj4hp6hlAOxhKS1bZBGkd7L2Wv2/dGN9DMIS8a99bb7gfpHC19Ojci/Lv07H9WbN
         QSvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rhXdS0JlrmQPOo8uGulR2+QL5OPOPxsKAh847CNTQ/4=;
        b=Vf+e+Qs+KsB5jzqdQpCFCQsCot8FuZYZaZ4TjtBuLthOrSs/RFLnobhdEb5KI16WX+
         3xzF6qmPGEKT/mB+rjd0tr4zTYU2Gwq+HTC53imQS+bZNxoH6jTMo5SMBCz5PU18uyx5
         5bO07SsBlJ2wTLa2dufLbt9zEkIsO7YX7Qfzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rhXdS0JlrmQPOo8uGulR2+QL5OPOPxsKAh847CNTQ/4=;
        b=ZDo0bfSL+3W9cSaS2wIKlgaPF1brGt2U6j2FmjQSSXkQtbqwz5FH8tox1XYe1hPf9/
         AtfQWZmRBTTluxG1+y5WXFrruj9vaiiWi75ZQNoh3NbWFqOuShKSeg4HjsBb8d9nZgg4
         Fr/oRG9SW3a1OS14DG089z3YmLF0U15znA7HhdZk1FbcE73hOND3qsTdf7rexfcG4Ojk
         B65ELPZtSkYzwZSvbHRBO3pTMhYMTkx51agKPQr1nXBH63xmrAaG6w7Db0if3FwBoN9C
         BNPPZRHxM900m1u573e8l+fxerMBG/NudDgUBE4uLv5Udg2xKOm5nOo0xf1IftrcEzUV
         tvjg==
X-Gm-Message-State: AOUpUlHi9Q5O2a17UCkIRMC4IxdydkxLL9RAtQpflS+3GmMynGKECUiz
        A4QNn10ajZkd9EbiHlPiwKIqWlpTKA9v6Yr6Tr+7xg==
X-Google-Smtp-Source: AAOMgpc+GAINOnUwMKq/lHhSSOoM2XLkkbbm/qbKw+zjPYKdnZv/G7B+QjRCMh1ccTfd2j7GJ7gFU5y5pBiWljSLJks=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr9750845ywf.53.1532454688449;
 Tue, 24 Jul 2018 10:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 10:51:27
 -0700 (PDT)
In-Reply-To: <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-18-keescook@chromium.org>
 <CAKv+Gu-D9FrOrFU0EmkPA52vrywCGZkFP9vUsyEovdby9dLj0g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 24 Jul 2018 10:51:27 -0700
X-Google-Sender-Auth: Y-WRmfgZIwyg4O9ztQxJjmQvpZQ
Message-ID: <CAGXu5j+-AwHdGZ7Be854WyEQoK2p57JPuTgSXcFq7GOzUtJGEA@mail.gmail.com>
Subject: Re: [PATCH v6 17/18] crypto: ccm: Remove VLA usage
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>, qat-linux@intel.com,
        linux-ppp@vger.kernel.org,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-afs@lists.infradead.org,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:57 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 24 July 2018 at 18:49, Kees Cook <keescook@chromium.org> wrote:
>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> drops AHASH_REQUEST_ON_STACK by preallocated the ahash request area
>> with the skcipher area (which are not used at the same time).
>>
>
> -EGRAMMAR

Whoops. Will fix my poor sentence merging. :)

-Kees

-- 
Kees Cook
Pixel Security
