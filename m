Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCZIbo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:31:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39053 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeCZIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:31:42 -0400
X-Google-Smtp-Source: AIpwx4+c6Dp/DgysWE/gr6KTzFN1NDuaBM6hxsD4NjShryGjEc1D6BC5dlKqn5pqkZ/ySrKEgV6HX0awQvHNXpCJyTk=
MIME-Version: 1.0
In-Reply-To: <cover.1521723192.git.vilhelm.gray@gmail.com>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:31:41 +0200
Message-ID: <CACRpkdaGO_ThdgDWGrBygO8o=EoKahZj+-NpRfZCOx49GWd87g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Implement get_multiple for ACCES and PC/104 drivers
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 1:59 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> Changes in v4:

I applied the v4 patch set so we get some rotation in linux-next before
the merge window.

If reviewers still find smallish issues they can certainly be fixed in follow-up
patches.

> This patchset implements get_multiple callbacks for the PC104 GPIO
> drivers as well as the PCI-IDIO-16 and PCIe-IDIO-24 GPIO drivers. These
> devices all acquire the multiple input lines with a single read, so
> utilizing the get_multiple callback can provide improvement for those
> users who regularly access multiple input lines.

Did you use the userspace chardev for some interesting experiments
with your set-ups?

I tend to think of your applications as pretty interesting for industry
peers, and a good proof-of-concept for the userspace API.

> While developing this patchset I noticed many of these devices make use
> of Intel 8255 compatible interfaces for their I/O. I may write a generic
> 8255 GPIO driver in the future to reduce some of the redundant code I
> see pop among the drivers for these devices.

Oh!
This guy?
https://en.wikipedia.org/wiki/Intel_8255

Yeah that makes all kind of sense. We are living with the legacy
of the first PCs every day when it comes own to EISA & friends...

Yours,
Linus Walleij
