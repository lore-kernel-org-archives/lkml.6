Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF873218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofglrUkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfAXTQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:16:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44421 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfAXTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:16:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so3059034pgr.11;
        Thu, 24 Jan 2019 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bZg36YsPw/a31jcKnrhFpNEcXz5ZaXQgJXFzFAb6dM=;
        b=ofglrUkdPrjp7LsriPDVZi/QHUrr5FwePcvTrhWmpMtRPGsfZ7NZXrh9Ioq1mQsVLL
         90PSgu2KxoDcwpfWEK8hkBKxECQO9dhNFUPH+9cbaLqjpaPa+zIy7jtZuo7OQz7tunBW
         BSecuF7M5+GseSnJs+duwryiOOaKEM16zsnAt+mWjqhBEXU0BeRDti5OGTqzDbLQ0fSC
         RQa2Fiwka01eyWV5yG6OwOi1ptE3bE++emCy4upxWuRy0A5loEfMlRFVqM+vtwlKZivz
         bEyeqNpCZHhGlLQGIWo2Dn7z5EBP7Fn4X+NCg/oE3wMu/RnHgIDTEsaDdMYd9gO5kq8J
         eG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bZg36YsPw/a31jcKnrhFpNEcXz5ZaXQgJXFzFAb6dM=;
        b=eube7fGNs9+fcwUphP0cm0RI6zhueJrX18iQg64+lvOxFUsbhgFiXxgblz6VXbPpKg
         pLM6IYREsVA3rCGqBBRykxRxYZYqLKc1G/ZQGqxfsxCA7B1Vn3oG8HY/5XYsmgTPGbYI
         sCF4Rh+dk6Yw2fmzWj2SZo2GnQ/acTZvx8e+iUIqUcSVkBrhUwF5qYCk6TJx3TiNzCQ1
         UjpiApU0kCcoGcjeDcRVJ5TUCM402EU7WeugQ/woY92HXrIXuM9z+NGkfXr3Foq5JsEM
         nQPEKPT3Q62kUenv5HsOtrT3JIakypP68CsWPW0oUWtdImVprmlJcq1lDhSNNGg7g7tp
         YIlg==
X-Gm-Message-State: AJcUukc9nsOuMMdRtRjbO0rbHTho7ZA9ch7nKr99PNUtbgm6TCY60vJl
        u7ijaxvbBCjvxjTH1oHjnaeX5LOnBl1FBygT2/E=
X-Google-Smtp-Source: ALg8bN5rAZo2r6++z7vjJn03JRxJNdK5ajjgK5aR8Px8LM1wMragJwO0SZpBCRcHQDOMguxaIQslXudT9alB7VguLRs=
X-Received: by 2002:a63:d450:: with SMTP id i16mr7013581pgj.246.1548357418458;
 Thu, 24 Jan 2019 11:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20190121224644.26903-1-okaya@kernel.org> <3681650.SPxszaOeRQ@aspire.rjw.lan>
In-Reply-To: <3681650.SPxszaOeRQ@aspire.rjw.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 21:16:47 +0200
Message-ID: <CAHp75VdJLQ-J_VruUmou9-PafScqNHGzu8+52ZTy-HtG98gbmg@mail.gmail.com>
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning
 for ACPI_CMPC
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:54 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 21, 2019 11:46:43 PM CET Sinan Kaya wrote:
> > Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> > warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
> >
> > ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
> > depends on BACKLIGHT_LCD_SUPPORT.
> >
> > Copy this dependency into ACPI_CMPC.

> Andy/Darren, these two seem to be for you, but I can take them too as
> related to ACPI tagentially, so please let me know.

Answered to v2. One comment still to be addressed, otherwise feel free
to take them.

-- 
With Best Regards,
Andy Shevchenko
