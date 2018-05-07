Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeEGVCa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:02:30 -0400
Received: from muru.com ([72.249.23.125]:40964 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbeEGVC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:02:28 -0400
Date: Mon, 7 May 2018 14:02:25 -0700
From: Tony Lindgren <tony@atomide.com>
To: Christina Quast <cquast@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Kokorin <ole2mail@mail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: Replaced register offsets with
 defines
Message-ID: <20180507210225.GS98604@atomide.com>
References: <20180505085921.5513-1-cquast@baylibre.com>
 <20180505085921.5513-3-cquast@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505085921.5513-3-cquast@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for updating these, adding Linus Walleij to Cc too.

* Christina Quast <cquast@baylibre.com> [180505 09:02]:
> The defines are taken from dt-bindings/pinctrl/am335x.h

If we're going to replace all of these, I'd go a step further
where we make pinctrl-single use the newish #pinctrl-cells but
set it to 2 instead of 1. Then set the pull flags as one value
using the generic pinctrl defines and the second value being
the selected mux mode.

Then the offset really should be from the padconf mux area,
not from the control module base. And then we would just have
a new macro for these being:

AM33XX_PINCTRL(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)

Where the PIN_INPUT ideally would be a Linux generic define.

Otherwise we'd be churning these same files over and
over.

Regards,

Tony
