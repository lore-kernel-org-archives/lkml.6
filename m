Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeC0NgF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:36:05 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35189 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeC0NgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:36:01 -0400
X-Google-Smtp-Source: AG47ELtZURicv5Il2mhzDrAxMFQAW+Sz4Mjrc4KVZyHiXHieX6x4kpcj14pLh2bjJBrftassO2ZyPkhgt5iI+WSstr4=
MIME-Version: 1.0
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:35:59 +0200
Message-ID: <CACRpkdbqVNT9bchB+dFwBCuvnKaZE41YYO8Y7zyr=0-ysv5iWg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Support qcom pinctrl protected pins
To: Stephen Boyd <swboyd@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 5:34 PM, Stephen Boyd <swboyd@chromium.org> wrote:

> This patchset proposes a solution to describing the valid
> pins for a pin controller in a generic way so that qcom
> platforms can expose the pins that are really available.
>
> Typically, this has been done by having drivers and firmware
> descriptions only use pins they know they have access to, and that
> still works now because we no longer read the pin direction at
> boot. But there are still some userspace drivers and debugfs facilities
> that don't know what pins are available and attempt to read everything
> they can. On qcom platforms, this may lead to a system hang, which isn't
> very nice behavior, even if root is the only user that can trigger it.
>
> The proposal is to describe the valid pins and then not allow things to
> cause problems by using the invalid pins. Obviously, the firmware may
> mess this up, so this is mostly a nice to have feature or a safety net
> so that things don't blow up easily.
>
> Changes from v3:
>  * Split out allocation of mask into subroutine
>  * Moved that allocation to kmalloc_array()
>  * Updated qcom driver to simplifiy ACPI logic and fix mem leak

As both Timur and Andy are happy with this I applied these five
patches for v4.17 and pushed to the test farm. Let's see what
happens!

Yours,
Linus Walleij
