Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759197AbeD0UQz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:16:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35560 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759034AbeD0UQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:16:54 -0400
X-Google-Smtp-Source: AB8JxZoOHhVOWEL8CCAj4nCb/kiVuaOHqKb3LPTfnA2XMb8CTzMF6wblxKiTDSlUOeX03iHYzbwRZt26o82H7Zc5cco=
MIME-Version: 1.0
In-Reply-To: <20180427134016.2525989-2-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de> <20180427134016.2525989-2-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 22:16:53 +0200
X-Google-Sender-Auth: Ln5LCDVzhZfqY15-nf9OCTeiBJM
Message-ID: <CAK8P3a2Z+=DcNMOA-rZLKemzG60a0d3b0kq32Y8-YoX7tjcx9A@mail.gmail.com>
Subject: Re: [PATCH 1/5] timekeeping: Remove timespec64 hack
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 3:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The main upside of removing the hack is that printing the tv_sec
> field of a timespec64 structure can now use the %lld format
> string on all architectures without a cast to time64_t. Without
> this patch, the field is a 'long' type and would have to be printed
> using %ld on 64-bit architectures.

As mentioned in another thread, this patch is now also a
prerequisite for the cleaned up patch "[v3] x86: Convert
x86_platform_ops to timespec64", which used to rely
on an ugly hack to avoid a forward-declaration of
'struct timespec64', which is now allowed on 64-bit
architectures after timespec64 is a structure rather than
a macro now.

      Arnd
