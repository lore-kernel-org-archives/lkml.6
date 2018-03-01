Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162610AbeCAW2v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:28:51 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:50268 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162556AbeCAW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:28:47 -0500
X-Google-Smtp-Source: AG47ELsPjnBd31e+QyjwHS5ChbW5FYi6Rd8DB4fhvCnm5l0QSQit6Rgb03ppTlQREHrqhyjyw7EDtbJEVrFzXrI3zAA=
MIME-Version: 1.0
In-Reply-To: <276d5f97-55c2-406e-92c7-0d03c7f7a49d@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZYnQC5BusLyK5aAcA2q0NmvHu=TaLhFCfu2M0bgBcjrQ@mail.gmail.com> <276d5f97-55c2-406e-92c7-0d03c7f7a49d@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 23:28:46 +0100
Message-ID: <CACRpkdbd=n=6g+20_sn+_Q_xNpQowa_40o1uzCnRm8vnEnantQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 4:13 PM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:

> ST MFX is different from STMPE as far as the HW is completely different.
> IDD is a new feature.
> TS management is completely different.
> GPIO management looks like but is also rather different.
> ST MFX counts a first level of 8 interrupts (acked by writing in the ACK
> register), then a second level of 24 interrupts for GPIOs. GPIO IRQ can
> be triggered on low level, falling edge, high level, rising edge. GPIO
> IRQ have to be acked by writing in the GPI_ACK register, GPIO can be
> output open-drain with/without internal pull-up, output push-pull, input
> with pull-up/down, input floating or analog.

Okay I am convinced that we need to model this as its own
driver if it is as different as you say.

But let's keep an eye on STMPE's approaches and what it does
right and wrong.

If I rewrote the STMPE driver today, the major changes would be
to use regmap to pass around to subdrivers, and implement a
combined pin control and GPIO driver, so I think those things should
be nice to have for the next iteration.

Yours,
Linus Walleij
