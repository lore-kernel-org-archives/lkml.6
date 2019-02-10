Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF3C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE621736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU8epz+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfBJSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:05:16 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33474 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfBJSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:05:15 -0500
Received: by mail-ot1-f49.google.com with SMTP id i20so14003915otl.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSxa0UyDrA9QxYPwTpkiPvl43IP9aW2jI6LsaSxwJ3o=;
        b=oU8epz+tkKJ9q23WKBgkGxHBVkUNYqmIopLX8psRNMDDfgeqndTFb1mVsGKbCV9+Mh
         XrBwsuZwBuOeUqsKijvtnA7FwCa8Gl6YT/KtB4N0ltowvo9iKc3k6X3kXupJHYS3bIxO
         9raLythQIlk2owf1eoqZFxA7Q3TgfKlHiE9LIBZGJpFOUu6NTEkv3Ey2SuWHHNzncLSt
         QbC+WJqitb89+OcbgTN+M8Qlca4VuijGMwAkZrT2oWsBTTAUcCVwx2v8iECOcXJ/nMLG
         KtDx0VGGkNhXdP3+wvGvwn2zjDUW77Dc+ob4czu2Anc8rcU4WQMJRjh8O4uyS0PD4QON
         CdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSxa0UyDrA9QxYPwTpkiPvl43IP9aW2jI6LsaSxwJ3o=;
        b=UdnK1JX1TWNWlzou6sMKA08dmAz4eSw3LH+Rh2pB5aM7GtZXV1K8gee6bRCLiq4Rc1
         jbBcs+T/3pmUh4teEq6nogv36zmk8OpQktFhXRAg777z6FUEnJlJ+HhQlFiBmUwNgrln
         4ava5mzIuEVRiPSo5Plci3SaDyz174xKROiwcmxEdVyfbFlLGChBhvNPEUAKk1soCQw/
         UI0xM1SNAADuNAIc5xm463Vtmh1JWaOSJiRUX5ECNTnElA8Hk+Aqwz2tsLblXosMlAd1
         CDWzj38tqUnZiVyy4ceaE0BROKg8mThEf1rRfTFgDpb/C1J0fRNDtKHgEuIDSzNYMQiq
         c7mQ==
X-Gm-Message-State: AHQUAuY4axMhZ3zp9Ep7i/lB9laOE4y2Kqj9iiwQGWDqBhlRXaOtq5td
        cPUm/2bURZSW7IU/5MRxmJpL59bgOy8OHseEG9U=
X-Google-Smtp-Source: AHgI3IYddzSYYXHDuousDMAdmi2bL7WQfISMES5CPFXziI3UPbsWbeWViTgvUhG9KL5gRX8uA4oS0Elv/whTidltgSg=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr22682791otk.279.1549821915033;
 Sun, 10 Feb 2019 10:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
 <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com> <CANiq72kw1=XhGhy8Ac2R9y3ws_jjo0YogoQ5D=tO+7oat=8swA@mail.gmail.com>
In-Reply-To: <CANiq72kw1=XhGhy8Ac2R9y3ws_jjo0YogoQ5D=tO+7oat=8swA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 10 Feb 2019 13:05:04 -0500
Message-ID: <CAGngYiUwaWPp7=TTAN3tqPz+D+1GsPDM7uFNYY1XSTYMMm+=aA@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Thu, Feb 7, 2019 at 11:30 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Similarly, in drivers/auxdisplay/ht16k33.c, the cancel_delayed_work()
> is there, instead of cancel_delayed_work_sync(). Having the script
> suggest this change would be useful, too (i.e. instead of the devm_
> change, assuming the cancel_delayed_work() is already there).
>

For relatively straightforward problems, I'd say yes.

However, the problems flagged by this script are not trivial at all.
In many cases, the missing _sync is just a symptom of general
synchronization issues on disconnect(), and simply adding it
will not fix the problem. Sometimes, it's just a false positive.
