Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBPTaJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:30:09 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:44207 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeBPTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:30:05 -0500
X-Google-Smtp-Source: AH8x226xOJXC9ZAjqBpwbV8Iw0IQOXBrUzfAERVTdhTwUC/US97TMCV/Rz/KMTF6Jq9K16s1siUy0FmfODA+XvdOKNo=
MIME-Version: 1.0
In-Reply-To: <829ccf8330b7418a976205665e0ab4bd@AcuMS.aculab.com>
References: <20180216154024.389-1-andriy.shevchenko@linux.intel.com> <829ccf8330b7418a976205665e0ab4bd@AcuMS.aculab.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 21:30:03 +0200
Message-ID: <CAHp75VcjpZy75_t6z-9nN8hP=g0qb-skjOU4QtkUZxL7YRFUHQ@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: wmi: Replace kmalloc + sprintf() with kasprintf()
To: David Laight <David.Laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 5:55 PM, David Laight <David.Laight@aculab.com> wrote:

>> kasprintf() does the job of two: kmalloc() and sprintf().
>> Replace two calls with one.
> ...
>> -             buf = kmalloc(strlen(wdriver->driver.name) + 5, GFP_KERNEL);
>> +             buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
> ...
>
> Except that kasprintf() has no idea how long a buffer is needed.

Hmm...

> It might even do the printf twice just to get the length.

It does exactly that. So what?

-- 
With Best Regards,
Andy Shevchenko
