Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-899735-1525478697-2-4834754045903753084
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
    1525478696; b=KnBQQffsGi6TfkfQTnMr8FdC56V7gDBRM5Z2zPxpGhhM528Ucn
    SlX3ydJyntmfONdHZY9qakD5WvN8q970laJn5mc1htNkh8swVNwxKGsAF91IIrZx
    8Tx6tGOUkf43OhBRT3dsbOVwse7Uy87Fxep/I+FTwLfTgn8C44yOLr4Xz1/sD3oE
    6bpJYG0YPmM7uUf5Yvlw0f20LXAKkDsznumU7/ivscquxo2mPSAHUyY4L4bb2Ctg
    CKYXu+CnNW/S1v7f+2p+OHGpVN5R1KR+wjSgAu3BuaxZrKGqcDPdCZwIy7NE2Dtp
    GwtlG4YO6RZxPCOb381Sdt4AsO/WHwbxrWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525478696; bh=HCZpwrV4WKt7uxNaw0MOgVXfPss+sx5RBN3gpieNqu
    o=; b=KzM3FXrtbvyYDxYBymd5XdDcfqM4Y50Bs3yz7y2jNtGT+ZqdAGTHWSAnBe
    4amfcAt+c+hpkTyYu791yHlWymhh1ph4WBiavy+fZX/7IiliRXrc4kJuizQmEbke
    Fah4n5em41VGO6uvUXEfZPlDAfG2cyrQTqSMAH/p4AfXxrFRMqhtMBysF1BYRLAx
    oHXzJxlLOlvxnalWxpOr1tXqQnKaQTv3+O58jvAyuErd46eyH3E0tVx0cXhZI0IC
    Y7/db+WupF4tEpJ9WR/Xq5lGu6pKSJdtq/45Cq74G3/n0c797lc6ss8KC3b/IGnF
    K6U0R2qcUOiEwW7uhHLR+bTz8Yjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=A8wZd4QO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=UUwmp+md;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=A8wZd4QO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=UUwmp+md;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF5MhPe6VhO74V393WT1mu5schd9Y7jOb75VJp5L85teqTwnUrN9ckZlcaXVR50/hZD5sZj9zPYomp/4Tr6PnMb4obcQXBtids+raQbssEZYviKSClXV
    0a9AKT9q6h+r8Vntd2JwJzdKZ6U6I/ae3FQ/A/AQ7aiRyyKD2Cv+fKGsqliISJ4W/oR1KS5PmmjF8366YaQsL5118PM23Vbng0oKsLKM8OW0CxiLxL87hEdI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=egY_P89lDLUMRGDEWWcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeEEAEz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 20:04:55 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34991 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEEAEy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 20:04:54 -0400
X-Google-Smtp-Source: AB8JxZrGgVv3WnQnrtJwgadlxpX0lWnaWjuAGeluYpgl6FUUtVqniMrir6IPlOCAmW6yvYe/I0CgekdxSq3E0Om7wKY=
MIME-Version: 1.0
In-Reply-To: <20180504132731.14574-4-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-4-brgl@bgdev.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 4 May 2018 20:04:52 -0400
X-Google-Sender-Auth: BZfv5-9hrdqBBM4VrdxZeOC04mA
Message-ID: <CAK8P3a3-2jyajsN+p0X_VEVG3B3GJ5fL0T90FV5_Sraz+Lzp4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
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
> Old early platform device support is now sh-specific. Before moving on
> to implementing new early platform framework based on real platform
> devices, prefix all early platform symbols with 'sh_'.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks good. I was thinking of something shorter as the new namespace,
but actually using a longer name like you do seems appropriate since
we don't want anyone to actually use it. ;-)

        Arnd
