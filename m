Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWRIa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbeCWRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:08:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8162921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bartosz Golaszewski <brgl@bgdev.pl>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>, devicetree <devicetree@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
Message-ID: <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the reset
 framework
Date: Fri, 23 Mar 2018 10:08:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2018-03-23 09:55:47)
> 2018-03-23 17:49 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
> > Quoting Bartosz Golaszewski (2018-03-23 06:04:47)
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> This series converts the only user of the handcoded, mach-specific reset
> >> routines in the davinci platform to using the reset framework.
> >>
> >> Patch 1 modifies the way lookup entries are registered with the reset
> >> framework.
> >>
> >> Patches 2-4 add necessary lookups/DT-properties.
> >>
> >> Patches 5-7 convert the davinci-rproc driver to the reset framework.
> >>
> >> Patch 8 removes now dead code.
> >>
> >> Philipp: it turned out that it's indeed better to use the reset
> >> controller's device name for the entry lookup.
> >>
> >> Tested both in DT and legacy modes by booting the examples from
> >> ti-ipc-rtos recipe in meta-ti.
> >>
> >> This series applies on top of David Lechner's common-clk-v9 branch[1]
> >> with Philipp Zabel's reset/next branch[2] pulled in.
> >>
> >> It can be found in my github tree as well[3].
> >>
> >
> > What's the merge strategy for the rest of the patches? I should apply
> > the clk ones after the next -rc1?
> 
> Or maybe Philipp can provide us with an immutable branch with the reset patches?
> 
> The you could apply the driver patches and let Sekhar take all the
> platform code?
> 

Ok that could work too.
