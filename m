Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525727610-2-707720580052234638
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
    1525727609; b=gaCGEUnLyjVW9iKPLdt25JllYsdySD/MERXlK4x87k9ZvElWwg
    YHpJ97qfCZvs2v8gSy8J8QxlDdWIcRtzqEaaW0u6KAD7aQWSH1ddTj0TY+kbty8v
    AV9p3XkTQHbdi8TFADmUPlzUbWIpsYeBRLKbK9XLjftJQYN0zLLvmwsOl4Cr/bkg
    NZVSpHiTQLd+wy6zsSPyeruoWDgJgc8lzELzLV+QYhZoxtfOLu9mLAhgmN+zWDjJ
    wcTtAUVLbYIgQ5eGEFg7SMzkpEomZSOjxnPbF1TOuZChKd7e3zWBvpQAuf2Y9r4e
    VMfIWhjxzPSWxYJj+yRl2pm/Xv9o5RxHg+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525727609; bh=8d/d8j0ASf7J+1uvNtGt1ReVvoA6u8R4DjwBP7l6bH
    A=; b=isa2AtKDnIUHHEGKqB9RSE5SgC1wbeNv8+NHYpGRwcuW6Mkpq81Dz3O0fH
    nKabUXSY2Po+E+vvGaJRVa4AdlNqxb29A7hoSFKcxQsgnS8B9vEVS3JKg7O74f3t
    xVxKLb3yAcPu7poiZ3idcmFYsSmGrzzxgB63UForsw1fIHAT2owQMYHpTbwa/9TX
    58PqV1g1YcC9XxNNU2t4g/tT3njxqVS+oxBLfodMwTeJRqy16eDz2FR4Al1bAw2V
    5GalG1SX/ozLG3FWvrFLCMNLDMx0gMzTCA4SRBrfk6rt+kMpnIS8Xyla0vs9ieiI
    NRuodr+6klujgW9qZc53McOKu3nA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=SxVAOyaA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=E2SiGkXm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=SxVAOyaA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=E2SiGkXm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEDXxsKYeg3+YmV8LciZuMTTXPvSf6tQSkF6p+/nio3s3/GbUbKhL4SQKVpmMhI6HV9jr0PUzSxkSLkyrXW45uqA1TmZQpU3ZT8Ip2aRrz5DFqGQiGJD
    A2q2Bk0zJ0dm6cvl8k0lZjsEYAV0xfiSIfZ2pXBJftKNbJhy5+7nAbp+6egJcsyzKbptPyMXil3GON5FndJqzFLFUT5qdw1xVRsRMZYOhD0VTMyAvro7a1Vd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=0YOGI5u02exf5xxwX_QA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeEGVN2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:13:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41390 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeEGVN1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 17:13:27 -0400
X-Google-Smtp-Source: AB8JxZpr23BvUlyufMdjqakYr4iCHGszR/n2kB2ZLLiPnGCxQRIbON9/Y89baM7eREImyGt4AFbl8SkWoOpYQ8ia9bM=
MIME-Version: 1.0
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
References: <20180504132731.14574-1-brgl@bgdev.pl> <20180504132731.14574-3-brgl@bgdev.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 May 2018 17:13:25 -0400
X-Google-Sender-Auth: P5dx5JvGfOhjTJa2wvGEmmGyuYI
Message-ID: <CAK8P3a2Fn-QK6SzFTJCmrToSG2vyO2fZt47Bomqjq-sAe8s4-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support
 to arch/sh
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
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
>
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I had not gotten around to look at this in enough detail so far, but
looking now, it seems all good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
