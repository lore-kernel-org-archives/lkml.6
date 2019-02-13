Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18332C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB138222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdpmAB8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfBME4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:56:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36453 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfBME4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:56:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so1906276otk.3;
        Tue, 12 Feb 2019 20:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsojJDebKL4+PIbFs9LdsgSPxlE1AAjP5YynMjNHYXw=;
        b=sdpmAB8GHSOHdC6Id9bhgumn6xKE6VKPu523Y5ZrdfwyK9dharMyYbnkjrZrffD0R1
         t+d3LlKRvK6whTlQ+aUAvJ/nlhQXTWnnDCLPmq8bHD9NXVplr3Fx4+bStwGB5Rpuiodp
         EbNWeKp+xzHkhpOuLRx4uQ7qLyf+tch1t3gOyDps/UZ+A+n24TpdxTmCsZosjCjqSjm7
         Qzb+PzUHkFc7lEw0qz0zJJTX5O8dUZp5GhkyMOwYMt01oCUv/JzJI6TD+/vJ7RNFPTz7
         GwwnnCk+FR7zr0xdzC4zWxW7vbqIIoTZOnF3Xk/hdeKPWGKIfZpUIUL4zwo5YbX/w+rW
         PNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsojJDebKL4+PIbFs9LdsgSPxlE1AAjP5YynMjNHYXw=;
        b=J27F0fwwUTnCrAq1G71aNmWVRVVuRxIwakgXjEfmjD99mUXi2sFiQS18XtNGpWEOyw
         7wSo9HvDlR/es0zsw7aArkPfnXrUBWRUnbRYTsrzPCewOM3v/457w8vrdduem3Fcq7QL
         7is7Il4y+ATZ9i8cNWDjz1lZ4ZlDEzwc+aRE4zzFQjwOclzB5LRTXuM/CUz01Ls3hnJM
         jEWyJ7F/PQ48eX17w7bKEOnF2+OBTmKg55MEAfpo4b6D5egP9SsmAzfMuC8mDPyxlNzk
         NE+PkfTEjjv1WdBAEJ/bsJD6rHR47askup0/uBTtyyL8tTMLds6D2B8LBJ7vz+UTrd+V
         7KnQ==
X-Gm-Message-State: AHQUAuYREWon053LhnLzGZ7kF7L/RWgWJ2kTQ5yiFzzqYhj72TzPIYtG
        Sr3F4uKMVt+Y+1PHNE9yZFUawsXQjvulQ2heKPE=
X-Google-Smtp-Source: AHgI3IYgV481Tj52eKH2DVIeTuDav/AiikR273uzffEHbET+WoyJAl6eLHAz6OXl9oAZkPGY1rguMA0Ej5GVs6QPPfc=
X-Received: by 2002:a05:6808:693:: with SMTP id k19mr129992oig.77.1550033790360;
 Tue, 12 Feb 2019 20:56:30 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
 <20190211212734.01909e62@archlinux> <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
 <20190212204730.16864802@archlinux> <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
In-Reply-To: <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 12 Feb 2019 23:56:19 -0500
Message-ID: <CAGngYiVDOTaqD3p4ZskdM0RjUZUqubXR6KsDOcVMEO5mBi2rBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:40 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Next, read ALS and PS _exclusively_ in the irq handler, guard it with
> a mutex:
>

Wait a second, that wouldn't work, because we don't get an interrupt
on every ALS/PS
conversion, correct ?

In that case, don't cache the als/ps value in the irq handler, but
read it from the hardware in
ap3216c_read_raw, while holding the mutex.

That would still guard against:
- _LO and _HI getting interleaved
- userspace reading the value in between sending the event, and
clearing the int bit
- the int handler not immediately seeing _thresh_en

Apologies for the confusion :)
