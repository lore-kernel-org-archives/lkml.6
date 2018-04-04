Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDDOdG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:33:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeDDOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:33:04 -0400
Date: Wed, 4 Apr 2018 16:32:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: olpc: fix inconsistent MFD_CS5535 configuration
In-Reply-To: <CAK8P3a0_9BzOCZhZjsvyN6y4yY3mPF8jDVoAR0Wa3j7uUkF-Dg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804041632220.2056@nanos.tec.linutronix.de>
References: <20180404124539.3817101-1-arnd@arndb.de> <alpine.DEB.2.21.1804041608150.2056@nanos.tec.linutronix.de> <CAK8P3a0_9BzOCZhZjsvyN6y4yY3mPF8jDVoAR0Wa3j7uUkF-Dg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018, Arnd Bergmann wrote:

> On Wed, Apr 4, 2018 at 4:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 4 Apr 2018, Arnd Bergmann wrote:
> >
> >> This Kconfig warning appeared after a fix to the Kconfig validation.
> >> The GPIO_CS5535 driver depends on the MFD_CS5535 driver, but the former
> >> is selected in places where the latter is not:
> >
> > And why does GPIO_CS5535 not select MFD_CS5535 if it depends on it?
> 
> I tried that first and ran into circular dependencies: OLPC_XO1_SCI selects
> GPIO_CS5535 but depends on OLPC_XO1_PM, which in turn depends on
> MFD_CS5535.

Ok.

> 
> What we could perhaps do is to make OLPC_XO1_PM select MFD_CS5535
> instead of depending on it, that way it would be forced to be built-in here.
> I can run a few more builds on that version if you prefer it.
> Generally speaking,
> turning 'depends on' into 'select' tends to cause more problems with circular
> dependencies than doing it the other way round.

Fair enough.
