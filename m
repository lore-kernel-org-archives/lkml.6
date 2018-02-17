Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeBQTvQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:51:16 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:44286 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBQTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:51:15 -0500
X-Google-Smtp-Source: AH8x226BADgZVm5dhlPee7w1tuqSbFTESYaNqAYtj5YJ1X8Wt/nr4nSlwx73LE9Lj1UyHu1pvON08PIa2geYwAXpfNg=
MIME-Version: 1.0
In-Reply-To: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
References: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 17 Feb 2018 20:51:14 +0100
X-Google-Sender-Auth: UguJLcHgw-k-JXOX8CxsYEyf80g
Message-ID: <CAK8P3a25wQiCreFB3qBuyE86GvwmjpZmqyTszF-ZBJRDPwHotQ@mail.gmail.com>
Subject: Re: syscon regmap for disabled node?
To: Suman Anna <s-anna@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 2:40 AM, Suman Anna <s-anna@ti.com> wrote:
> Hi Pankaj, Arnd, Lee,
>
> I am testing some code to use a syscon/regmap interface and I find that
> the syscon/regmap is initialized even on a disabled device node using a
> "syscon" compatible property when I have expected it to fail. Prior to
> commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
> platform devices"), the driver would have never probed, and the
> of_syscon_register() only checks for the compatible, but not if the
> device node is available. Is this intentional or a bug?

My guess would be that nothing relies on the current behavior and that
it could be changed if it causes problems, but it's hard to tell for the general
case.

Can you describe why you have a disabled syscon node? Most uses of the
status property are for on-chip devices that we disable because nothing is
connected to them, but that seems unlikely for a syscon.

        Arnd
