Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-856742-1525478555-2-5730030739070283233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525478554; b=CNDTNkXwS2zc6ur0vf2hNw1sVzP/aYH0qCkVG8IcSOn8WiSaWg
    e3yvPSPQ7Ql4HpTIsoY52B7673sZD9PCY7iPKbM3F8eObABu9OEsGLrSfOge+XtA
    aF2LqUT/iQRSBDbHbtOvS/2Fr9JKiA8BCO6Ld9BT7eCc4x3kIt/Kxh3cGdfjwZlg
    izvLtWmiYQ1EhcgiBq+YIfke8Z7KhR5E7kufMwCMkJZFitybCrX2RLRLMVXV1H5y
    zPhMYwxiOM30uJHD+q06djhQkLH9sVBMNMM7BDAwJfi3+6m8rGQXcWqbBmxdhCAj
    wV/WJBwh9PaA4Gsj79dcNBbk1Iv8S00ILBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525478554; bh=U105heIDhXlH6wZIz43KanBZ6bdibaWoEdrHstZyMG
    s=; b=k2Ph7O6A9TMaDTuvtt/v4/0ozOMCg6q7Wh6KnDD95OefQ8mHNfp9xazaDx
    4VxAs/3qfTDDnJucXMWkd5Ctc7cynK6d531quWDEkQRm4cVmgpOsKisF4+qSCeH/
    u0qWgDftoW0az1zeZh2sHxH9hAu8E1j9X19BUT3Nrpg1br1BCFsQ5ev0bktA8rI2
    yZHvr0SvjKqcwHdYFvkf/utIFqsiczLpmx19DOAorsE2qrfexTs7tTw+84ldmpWQ
    t4nAi/5RfStteJjrAiXp2OarOwy8+iwad1cB7mGezVxXdWzB6YQpxpMxbMz8N3y1
    zQCuHW+mW3HBaSDshKyksRNeArnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=KQbYsqAM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=e/T03ldg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=KQbYsqAM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=e/T03ldg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK95aqaaWeFz/l7ZvaU14mFU/x5xdqYV1IvNEY/Kq+2rjZC+h9Y5NnIIWGKa6HZ57N+zNSdGomB/p+PXJElIA9/sCe+6cOiHxa0KjT16oyKk5FqJeqvK
    wywUU1Xi7mcFB4MaA/ZXJCxecJsfKY2F4Xxr3JYgtQKH75hNpMn5TY/qK7fy7iKHChZibx1JVLbjQ8q0nvJRJIllYor1uSoGoTbXJd+fpfvUKVx2gvCv/Ao6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeEEACW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 20:02:22 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34085 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEEACV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 20:02:21 -0400
X-Google-Smtp-Source: AB8JxZoSKD0OKY+VydkBO/YZgM/yLWKrtptdO8l75VThDx6RgR2Ao5PjP2KSl3ApLPMwBVfVIHfVaMAL4sXXgWhU1RA=
MIME-Version: 1.0
In-Reply-To: <20180504132731.14574-2-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-2-brgl@bgdev.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 4 May 2018 20:02:20 -0400
X-Google-Sender-Auth: GBJsOjC_JGfMjxjFqvA1_FhFxHk
Message-ID: <CAK8P3a3hVxZe8vb82aRzu7=VMJP_yL+CskndLo2HQ58cZ5Q+FA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clocksource: timer-ti-dm: remove the early
 platform driver registration
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 4, 2018 at 9:27 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This driver is no longer used as an early platform driver. Remove the
> registration macro.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
