Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48802C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1188F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0EhPMje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfBNBLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:11:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42015 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBNBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:11:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so3258992lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuTUjqS+23Xv41CJf9KZ9MXusUyMQt6T6CNLaiAiQzU=;
        b=Y0EhPMjerV7GyDW8g0Zj204ppoDEMi4gwMlJ/CWrY07TiiVuEyWbkig0G4sz23hhj0
         RkPYnGgxnSS2FSV0p86EPKSyWUKhVFDP3ypHT7ZL46ADlBPzEpvcutyWYVjWgERdN237
         wF7K71Vfhn05A3rIMCDlrdDdQF84hWV4LSwZojEPqzp79i1Ne4ZU+biLMUYR7h+gyD8L
         wSlkGxQ2yKWT/k9WzWxvqJhGJ4UI8Yra5DNABYo3cQZl41MNalI/F/SSpKJrEc/bEbiO
         kftKbpvoEI4urt6oHr23tTiDiTT6yVA/rUkm87Rreeo6c4AzHY8hJ9ef/FXFEwgcsxu3
         JXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuTUjqS+23Xv41CJf9KZ9MXusUyMQt6T6CNLaiAiQzU=;
        b=myNQvkvJNauZh0S2TZzgq7n2yGqpb+lnvPDr0jOJBM033fw73yJdubPBA+4vCn/3Gm
         vLFTaplmDvxVvdcppv6ybya705sa5oD16UExK1h9HkHoTMunbPAp8GMmN7shW5GkLA3r
         4kxlpcBp+IDij0SGsyKDEDvIloo4lPIZAPJ0wxFlcoBx3V2I0qN4TpAj+Us6gL+Oni8P
         KKkAl0mx7htsMOvAN21EZ/+DtOOf7OfE1OvBgEr70/4ENyBr/BbJzFbUt6zjbUsHT+lU
         gc9nZjzYxrjdbimza4x1T4nYFDFr7BxLzAg7FSWqttULdHWrvK3k8UoLQaKXPLv9lYgL
         IYvg==
X-Gm-Message-State: AHQUAuZoPwr9bFcG34IetHYR70SagTzFYmDmDOcKcZ4l/hbqpcBwUa3s
        rqWIkCIS80owa7Z9vDXJFKyyyKE3infWJz35ONE=
X-Google-Smtp-Source: AHgI3Iaoz9VQHIhUlpyYK3QRCIbqxehyAg3CvBtLacW1nECBSpmH26lMLndsX/MZ23Vj2eM4YWy2ToZUdzfvuRX78Fo=
X-Received: by 2002:a19:24d5:: with SMTP id k204mr585386lfk.88.1550106680112;
 Wed, 13 Feb 2019 17:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com>
 <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
 <CANiq72kw1=XhGhy8Ac2R9y3ws_jjo0YogoQ5D=tO+7oat=8swA@mail.gmail.com> <CAGngYiUwaWPp7=TTAN3tqPz+D+1GsPDM7uFNYY1XSTYMMm+=aA@mail.gmail.com>
In-Reply-To: <CAGngYiUwaWPp7=TTAN3tqPz+D+1GsPDM7uFNYY1XSTYMMm+=aA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Feb 2019 02:11:09 +0100
Message-ID: <CANiq72=1f7NtehzbzL0G-qHSvORAfeyYXYHjzfBkBQX46VBxsQ@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Sven Van Asbroeck <thesven73@gmail.com>
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

Hi Sven,

On Sun, Feb 10, 2019 at 7:05 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> For relatively straightforward problems, I'd say yes.
>
> However, the problems flagged by this script are not trivial at all.
> In many cases, the missing _sync is just a symptom of general
> synchronization issues on disconnect(), and simply adding it
> will not fix the problem. Sometimes, it's just a false positive.

Indeed! Note that I didn't mean to say they are trivial issues or that
the solution is simply to replace cancel_delayed_work() with the
_sync() version in all cases -- only that it might be a good idea to
suggest its existence (instead of only suggesting devm_, because in
cases like drivers/auxdisplay/ht16k33.c it may be the simplest fix).

Cheers,
Miguel
