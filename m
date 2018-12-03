Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A859C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcQNnK5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4B020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLCTSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:18:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35378 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeLCTSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:18:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so8072939qka.2;
        Mon, 03 Dec 2018 11:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsRbbGB/fl7GJhHwUcP5q4qmQVzUtr9Qd5jQwvIYSUs=;
        b=NcQNnK5L83XU+tmt2co55HQvopyIXVtS1ho+726JIm0LJdcsw0kAUZT187T91bG2/F
         RHbnnrSLNWN7xnFhwMjzf/Yw+9cqVp0VW1xjW8rxWXE5oFNXtwNB8J9QKWMZgnskXc+G
         f0WCUvSgbbfH/aB+X/OgbUbeiTebMckvOk4u2w1pC0NIc5OY40x5Xw0f8qz80mbkov8D
         Xes7fMaTPmsCt3sQSKGLp26K5zxU6PGw19v48TdPENjr8Upr4PCV4q2GMju6DNnQr9Wh
         02FycqrSDnVJCiG4mGwyM/ljKuK6sskSQmHnrhKoFeLU6Ei+R1F8L9dnRxYDuDGtbNns
         nlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsRbbGB/fl7GJhHwUcP5q4qmQVzUtr9Qd5jQwvIYSUs=;
        b=Zp1GR7OdW3CEA9KaisPbXLtHdbhytgC72NgGDFrsn5R6eG3OVg1Ei2oXZmm6LYND4V
         kg3GbZTPMkWU+i8HjrBD2u39gqUTwjMjpZjBUD/M8bPmL1UTcQs6XCx1JO6gNZzexuTk
         sZMOVn00qoB7zDjEZqvEyofnf6qt0RMx8il3wFkwcAq4jVdz7wY4CxRHtD5JHRZUh30l
         c1oGB3aL/0eLli2EJQzkJXgBQJI8wIEl5ehathwnilo9otQqZJlYv7UYATurZmQZUzeD
         tCf1f16GOctLqFf0BNQPeihMyBzmn8TNiyPS/Uxa0/OeUI/81uKik/zjvIcXwK51/jpk
         fbcw==
X-Gm-Message-State: AA+aEWb9cdHbBx082cI+3OfPqIHJh8JD4MCDsnIQpu7B78l0Gnw/RVcy
        l9MV6/3nwd0QsEH98ndZEaMNyXBNtsOEo3SiVFw=
X-Google-Smtp-Source: AFSGD/X3X3pl3dVIV8Tf3GcEVZeUUCSa0sPSpcvcReclpmmlnTrVEKpDYBdfHefB9CgxJgs6s6yDpRLaPVVnM4fnx2w=
X-Received: by 2002:a37:6005:: with SMTP id u5mr15161795qkb.219.1543864680740;
 Mon, 03 Dec 2018 11:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
 <20181203185344.3521-3-ayman.bagabas@gmail.com> <s5h8t16jut7.wl-tiwai@suse.de>
In-Reply-To: <s5h8t16jut7.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 21:17:49 +0200
Message-ID: <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:04 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 03 Dec 2018 19:53:39 +0100,
> Ayman Bagabas wrote:
> > +     if (code == 0x80) {
> > +             acpi_status status;
> > +             acpi_handle handle;
> > +             unsigned long long result;
> > +             union acpi_object args[1];
> > +             struct acpi_object_list arg_list = {
> > +                     .pointer = args,
> > +                     .count = ARRAY_SIZE(args),
> > +             };
> > +
> > +             args[0].type = ACPI_TYPE_INTEGER;
> > +             args[0].integer.value = 0;
> > +
> > +             status = acpi_get_handle(NULL, "\\WMI0", &handle);
> > +             if (ACPI_FAILURE(status)) {
> > +                     dev_err(&wdev->dev, "Unable to get ACPI handle\n");
> > +                     return;
> > +             }
> > +
> > +             status = acpi_evaluate_integer(NULL, "WQ00", &arg_list, &result);
>
> I guess you need to pass handle here?  In the earlier version, you
> passed \\WMI0.WQ00, so it worked with NULL handle.  But now it's no
> longer so...

I think in this case we don't need to have a separate call to get
handle and try to get integer directly. In either we will have an
error case if method  / namespace / etc is not found.

> Other than that, it looks OK to me.
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>
>
> But, you don't need to rush too much.  Instead, better to test your
> own patches and make sure that they really work before submitting the
> final version.

Yes, I will wait couple of days for v10 in hope it will be tested carefully.

-- 
With Best Regards,
Andy Shevchenko
