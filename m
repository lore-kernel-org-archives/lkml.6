Return-Path: <heiko@sntech.de>
X-Google-Smtp-Source: AH8x2260pKsS6i3nHF5iKOApbDRLzKNa4rplvEGyX3BwSp+a3duVqTHCXzQdjvWsKNXt6Wz9906H
ARC-Seal: i=1; a=rsa-sha256; t=1519658165; cv=none;
        d=google.com; s=arc-20160816;
        b=idKVLIkdaS8vk/DjqP/TnCc6+syc6KBo13ump7yJouMPMFhucdiRCMTHMhsMvj1gG1
         Dt5jKyHnLBYyr54Ih9/hVR2M+OdEuj8FefrvFOJTYbzgcMhnPpZQ46S1Gbyf1agbV9D1
         ymFT8bapRuuzc2iMcaE3llPKrihcE3ph1pBAW42I2Xcp4df+ZFQXtJ7Dk5uxmsHz1P7M
         0P77BlbInerv1Zq2p3+w0908UlFSEOP2GCCkHkSi0lypiSIy4WiU9V04FRxbd2hiFlHw
         Qa/ZCRn0CHXttbTcs2xsvqteAsnnTxXlBp8M4kXWuCAsT4POpdtU8pMzWXGB/SL9QNHg
         PNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=zVPgh1m6SFBJ4kq74vMDrCTak/tugkB/fEMLzReQAq0=;
        b=QUiWHEZXNo6VjxHDpr6vz+fN9KP7RyzFujCAtzBiiCuwl1EwoxBwFitqEDbjjFjP3Y
         i5/hQAOThZ5GCh8Z1WwpC0iDbcDv2S6oBUd0+6QfynINSO3/uGTsB+5iZvFZwqyPRHCC
         6kphPgOaPVt2vBCMp86HCsrgJxhyLwW4oumdarF0UHyZ1uCikp6Cxv/NKQ4jBSvRuTor
         hEs41tSQ7reWfztoI+BIyujVnqs4RkOV16zM146dsc8LZE6OpXxmaEv9VE8wO5V1o2yt
         sstVfXG89Vf6pcYxKo33mTH7W9tlHR1/zRP4VeprJeWtCmZdcnHzA6g7lwu5vFdUyBns
         nymw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
From: Heiko Stuebner <heiko@sntech.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wen Nuan <leo.wen@rock-chips.com>, David Wu <david.wu@rock-chips.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, jacob2.chen@rock-chips.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, Eddie Cai <eddie.cai@rock-chips.com>
Subject: Re: [PATCH V2 1/2] [media] Add Rockchip RK1608 driver
Date: Mon, 26 Feb 2018 16:15:44 +0100
Message-ID: <3613277.0XuNfbW5nk@phil>
In-Reply-To: <CACRpkdZDWvqrpop9FaJUidJjR8jB=Db-WztePrqKSg5Yp5gvCA@mail.gmail.com>
References: <1519632964-64257-1-git-send-email-leo.wen@rock-chips.com> <1519632964-64257-2-git-send-email-leo.wen@rock-chips.com> <CACRpkdZDWvqrpop9FaJUidJjR8jB=Db-WztePrqKSg5Yp5gvCA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593450825351606714?=
X-GMAIL-MSGID: =?utf-8?q?1593477080789609366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

thanks for catching these things :-) .

Am Montag, 26. Februar 2018, 11:12:30 CET schrieb Linus Walleij:
> On Mon, Feb 26, 2018 at 9:16 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:
> > +               pdata->grf_gpio2b_iomux = ioremap((resource_size_t)
> > +                                                 (GRF_BASE_ADDR +
> > +                                                  GRF_GPIO2B_IOMUX), 4);
> > +               grf_val = __raw_readl(pdata->grf_gpio2b_iomux);
> > +               __raw_writel(((grf_val) | (1 << 6) | (1 << (6 + 16))),
> > +                            pdata->grf_gpio2b_iomux);
> > +
> > +               pdata->grf_io_vsel = ioremap((resource_size_t)
> > +                                             (GRF_BASE_ADDR + GRF_IO_VSEL), 4);
> > +               grf_val = __raw_readl(pdata->grf_io_vsel);
> > +               __raw_writel(((grf_val) | (1 << 1) | (1 << (1 + 16))),
> > +                            pdata->grf_io_vsel);
> 
> You are doing pin control on the side of the pin control subsystem
> it looks like?
> 
> I think David Wu and Heiko Stubner needs to have a look at what you
> are doing here to suggest other solutions.

Especially as the rk1608 seems to be some a spi-connected peripheral.
So it should definitly not touch _any_ soc-specific registers at all.

I just looked up the patch in patchwork and apart from the one Linus
quoted above, I found quite a bit more open-coded pinctrl settings
as well as direct writes to the clock controller and even io-voltage
selections.

All these things are highly soc-specific so vary with each soc this
ic gets connected to and the kernel does provide abstractions for
all of them. For clock-rates there are the clock-apis and also
the assigned-clock* properties for the devicetree, pinctrl supports
multiple states and io-vsel selections normally should just monitor
the supply-regulator via the io-domain driver we already have
[See vqmmc handling in for sd-cards for example].

So this driver should not touch anything of that sort and therefore
should _not_ contain any iomem-based read or write at all.


Heiko
