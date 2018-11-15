Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406E5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF953223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDu6NCer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF953223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbeKPBEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:04:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42621 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKPBEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:04:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so10716237lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nWEnZDL6HI1UJFWwp+PQuh7bxOEmKQuWj1Ii+Ad74k=;
        b=ZDu6NCerX8nxETOOnaZ6XJ97NBCEHml7OkhPLuywXDSwonCqi1MbfwPQx7ZFxS2XUd
         qPe8V105R+8efRySpgZbXlJD4sxSn/AG9dB2QIatJPaRH4ePdGRHRS/W7IZl/ZxeN8RU
         yAC9QE38qkXEZPRvy5sgWLtU9w/O6SCyxzO9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nWEnZDL6HI1UJFWwp+PQuh7bxOEmKQuWj1Ii+Ad74k=;
        b=lUCmR1K/B0/hYNe4GECpv0vUrQF+gbbhtrSpquGhe/AXaYnGQsKijmeYADeC3mVLH0
         TJ9KMzJPHCv1/tXtpXDr7bCRFVm30L79BkOGdEWOWwxwWC05M5oIInKbNPoswuJfK9YT
         P0PhZUg8t3HR6Xpxzm7rayIn0q5+YwNbbHSGGaoBeavC1wZ9z3Wki6cMN9pq54bqmR+f
         bgfWgTR1hdP0F1FxgKwnot4o8gdhAh02r+L2LBLuSwdJNvxwyuCrmnQjlX+C5l9WUM7T
         xTIJFBKuTMmAlFLNPTLfWiSPa67emGREm9//8BnalioUv+UCu/xhuWNzRMzTLAjZAah7
         AvhQ==
X-Gm-Message-State: AGRZ1gJUXh+Ry8+9qoL/X+wwc4624j8/Irll5TFi+emwnrrBJ50+tj4a
        hEOzLqHzuZvd97Vaw0zAE7lyl9UPGDvECuw3+UglIA==
X-Google-Smtp-Source: AJdET5f2B7MNDl8lu4dfNDekW852/02f3XfAlBQ/ucmH99yxHt3BMTTwr+/j8WZicgE9tmAzILu4i+8iLr14SDGk03w=
X-Received: by 2002:a19:f813:: with SMTP id a19mr3488070lff.67.1542293799328;
 Thu, 15 Nov 2018 06:56:39 -0800 (PST)
MIME-Version: 1.0
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com> <1541018689-20625-2-git-send-email-dan@emutex.com>
 <20181111112944.GA27666@amd>
In-Reply-To: <20181111112944.GA27666@amd>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 15:56:27 +0100
Message-ID: <CACRpkda=xz=6sVuM1r81krR+09gOTaxBkab3_Xj0qMEB5AdVtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Dan O'Donovan" <dan@emutex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-leds@vger.kernel.org, carlos.iglesias@emutex.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:29 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> > +static void __reg_io_start(const struct upboard_ddata * const ddata)
> > +{
> > +     /*
> > +      * CLEAR signal must be pulsed low before any register access.
> > +      * This resets internal counters in the controller and marks
> > +      * the start of a new register access.
> > +      */
> > +     set_clear(ddata, 0);
> > +     set_clear(ddata, 1);
> > +}
>
> We normally reserve __ prefix for different stuff. This is not using
> it appropriately.

+1

I actively dislike __underscore_notation as it seems to be
completely arbitrary and ambiguous. I think even
do_the_stuff_reg_io_start() is better.

But please come up with something to the point and
descriptive! :)

Yours,
Linus Walleij
