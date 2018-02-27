Return-Path: <heiko@sntech.de>
X-Google-Smtp-Source: AH8x225ibUZht1Rt/louZ3azd4OP6Nw7lUcI+BVrNG0mLMFIEx6nmNYv2ek5azEdv55MJyNVmhpf
ARC-Seal: i=1; a=rsa-sha256; t=1519744343; cv=none;
        d=google.com; s=arc-20160816;
        b=rjgQeZOYcucLS6qFDxbDhaah7vlH04RgtAgiNV391+B+HS0cn1Gdv/p+jLj192zMWq
         FN8dIGwfvTvSVPuZ7IYXsXhn5QPZAifQOJs174oEgJ+bjCQDgBbXwuQXEWCqtSoKUJDV
         8NtnboE+ZbhXNEgQTfQMBHMqSgZITMMTb757omF2A06Fmadewkyon39BZN5HiDe/R98H
         q6CibbsKNt9AQptfP02DAlIDDFNHDK+vAqTKkgrs3c6T1DI3S93KY3Y7Vd7K++cQER+r
         JNQaEx/xep+CK+4FDedIWl9CtWTdPo4gm2Zy3iFFeJsLOqLPCElLqOPNCyHjvsNGnx6t
         UCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Hzw58M3MGupjwMG4AhIqL1PB1a75xKn4/MKONyfM7hE=;
        b=jPTdsbHWNq8toH4xaNx5GrnByyMa34ztjgnP2UwLP2LcHryelDxNScygjhYpdGozBE
         AH2YUXXIQeu28HJL9AZRqNsF4UWK12AsZd4iMyZezNLdtOHOGInTm6vc4uvGRJZx+Cw5
         K7qcCdMHAm3aP2j4oQGbt7hBsp49k4c/5UCPSuXDTzbQUUIpEcX5wYKvo4FrtD0qPHPn
         6SSRkgg38+YCCLCiZzV9EHDG7lBAQTrPsEzDVv68rMoosvTghJLf+ii9MxRXGkfSPjbN
         66WHHW8zkPDjGueRXPYlBWKJUxhDOonlVHb/YGBNfR3MOtyuM3eQ4oV0QZ4ywhl18Hx7
         r4xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
From: Heiko Stuebner <heiko@sntech.de>
To: =?utf-8?B?5rip5pqW?= <leo.wen@rock-chips.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Wu <david.wu@rock-chips.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "jacob2.chen@rock-chips.com" <jacob2.chen@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Eddie Cai <eddie.cai@rock-chips.com>
Subject: Re: [PATCH V2 1/2] [media] Add Rockchip RK1608 driver
Date: Tue, 27 Feb 2018 16:12:04 +0100
Message-ID: <14366388.KYv6Y7EbEA@phil>
In-Reply-To: <06296C1C-0ACB-4BB2-86DF-EBDBE3265DA4@rock-chips.com>
References: <1519632964-64257-1-git-send-email-leo.wen@rock-chips.com> <CACRpkdZDWvqrpop9FaJUidJjR8jB=Db-WztePrqKSg5Yp5gvCA@mail.gmail.com> <06296C1C-0ACB-4BB2-86DF-EBDBE3265DA4@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593450825351606714?=
X-GMAIL-MSGID: =?utf-8?q?1593567445139386075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Leo,

Am Dienstag, 27. Februar 2018, 04:15:46 CET schrieb =E6=B8=A9=E6=9A=96:
> Thank you for your advice! I will revise it according to your suggestion.

please also keep an eye on my reply to Linus' mail pointing out some
other issues where the driver should not tie into soc-specific areas
like the clock controller etc.


Thanks
Heiko

Am Dienstag, 27. Februar 2018, 04:15:46 CET schrieb =E6=B8=A9=E6=9A=96:
> On 2/26/2018 18:12=EF=BC=8CLinus Walleij<linus.walleij@linaro.org>  wrote=
=EF=BC=9A
> On Mon, Feb 26, 2018 at 9:16 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:
> +               pdata->grf_gpio2b_iomux =3D ioremap((resource_size_t)
>  +                                                 (GRF_BASE_ADDR +
>  +                                                  GRF_GPIO2B_IOMUX), 4);
>  +               grf_val =3D __raw_readl(pdata->grf_gpio2b_iomux);
>  +               __raw_writel(((grf_val) | (1 << 6) | (1 << (6 + 16))),
>  +                            pdata->grf_gpio2b_iomux);
>  +
>  +               pdata->grf_io_vsel =3D ioremap((resource_size_t)
>  +                                             (GRF_BASE_ADDR + GRF_IO_VS=
EL), 4);
>  +               grf_val =3D __raw_readl(pdata->grf_io_vsel);
>  +               __raw_writel(((grf_val) | (1 << 1) | (1 << (1 + 16))),
>  +                            pdata->grf_io_vsel);
>=20
> You are doing pin control on the side of the pin control subsystem
> it looks like?
>=20
> I think David Wu and Heiko Stubner needs to have a look at what you
> are doing here to suggest other solutions.
>=20
> Apart from that, why use __raw_writel instead of just writel()?
>=20
> This pin is iomux, default GPIO, need to be changed to CLK.=20
> This CLK is provided to external sensor for use.
> I'll use writel().

As stated, please don't directly access soc blocks like the clock
controller or iomuxes, there are standard APIs like the general
clock API and also assigned-clock* devicetree properties.

Similarly for pinctrl access.

So there should not be any writel (or ioremap) at all in this spi driver
I'd think.


Thanks
Heiko
