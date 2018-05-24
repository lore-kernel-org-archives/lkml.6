Return-Path: <sean.wang@mediatek.com>
X-Google-Smtp-Source: AB8JxZp86yOqOpCgOQ7VeI/1Ls4Funnz35Au3nMBNl118joCs5pAInNTZOx8in9uWhQNDl4PwUZL
ARC-Seal: i=1; a=rsa-sha256; t=1527130347; cv=none;
        d=google.com; s=arc-20160816;
        b=YHFZLQO9kW42rkXSmdM8oq3220iPdFylEOePPfnJyJQ1zh8y71J+wYT32+sLyUSaUq
         33fVtS79z6V20DPh3ThFY2D0/njhzNVvE8Eaa4QferWM136mI0oSD/r5HP7Txpeqixvg
         s877zzbe+66jWj5nqywxOk2mEf3U6o5qN+jfgcVbF+RKPnazGi6ZuiGOtcC01CYoGAAU
         aiPYflbT1I/Y03FgjKjBujPKVjSPNQ7bInivVID6yIe1R754F8H8ApyVfyWAdnQeJFxs
         SDsSmunA3D52plCueHH8BoFEjOJCy1/NseTudP6Aw54klM+rhZLdWUD0pnrVTSPxu83O
         xO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=rZuK/c0OIaqC8KH6Tdkk02snkyhmkBOuNYdBWecwC7c=;
        b=daQz637irKakwSHcoB3VljZ12ilnwZYK+hVikps3M4v7icMK59iXN8X9SLJcZzcaeJ
         tb+6aDGnH7D6P6AQaAfh4LwseywE7fKDWuIB00c5swAD8/2XH6mzmOZKHu2cFhIbl4qt
         59mcoOKRk2Z8F+TeGcgIbr9HH/Cgv1a/csOp3rM4Oy/omLmyiVUvqiH3+fLhy5/DcUYj
         IBzSeBNdpobEEaSAkdh4a3beF+boLQKxWjWiiCOIF/dP50llLruL5jRd7UT5e+Z0Lben
         Yhbx/UOxVFzK/UEgYlu56E1Gcsz4dq+JvAF9oXEqb9wx0QHWVooxIRZzNr+VWW1BnCb7
         2iWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
X-UUID: 755ebc2ac05d4fd29b14fd7394ba41d4-20180524
Message-ID: <1527130342.4607.27.camel@mtkswgap22>
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
From: Sean Wang <sean.wang@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>
CC: <matthias.bgg@kernel.org>, <ulrich.hecht+renesas@gmail.com>,
	<laurent.pinchart@ideasonboard.com>, <ck.hu@mediatek.com>,
	<p.zabel@pengutronix.de>, <airlied@linux.ie>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<davem@davemloft.net>, <gregkh@linuxfoundation.org>, <mchehab@kernel.org>,
	<rdunlap@infradead.org>, <linux-clk@vger.kernel.org>,
	<linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Matthias Brugger <mbrugger@suse.com>
Date: Thu, 24 May 2018 10:52:22 +0800
In-Reply-To: <20180430101826.GC5147@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
	 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
	 <20180430101826.GC5147@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890783825363754?=
X-GMAIL-MSGID: =?utf-8?q?1601312231605267243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-04-30 at 11:18 +0100, Lee Jones wrote:
> On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> 
> > From: Matthias Brugger <mbrugger@suse.com>
> > 
> > The MMSYS subsystem includes clocks and drm components.
> > This patch adds a MFD device to probe both drivers from the same
> > device tree compatible.
> > 
> > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> >  drivers/mfd/Kconfig     |  9 ++++++
> >  drivers/mfd/Makefile    |  2 ++
> >  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++

[ ... ]

> > +};
> 
> This driver is pretty pointless.  It doesn't actually do anything.
> 
> I think you just want to use "simple-mfd" instead.
> 


Hi, Matthias

Why not embedded a platform_device_register_data call into existent
MMSYS driver ?

It looks elegant and makes sense that mmsys device is being as parent
device for all its DRM components device and no need to create an
additional node representing the same device with mmsys simply in order
to probe its DRM components.

I'm planing to send a bunch of HDMI, MIPI related to MMSYS nodes for
MT7623 SoC when 4.18 rc1 comes out, so we should want to solve the
dt-binding violation issue first.

Though there are two same mmsys-compatible strings involving in dts
though, it seems that hdmi still can work fine in my setup.

	Sean


> > +static const struct of_device_id of_match_mmsys[] = {
> > +	{ .compatible = "mediatek,mt2701-mmsys",
> > +	  .data = (void *) MMSYS_MT2701,
> > +	},
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static struct platform_driver mmsys_drv = {
> > +	.probe = mmsys_probe,
> > +	.driver = {
> > +		.name = "mediatek-mmysys",
> > +		.of_match_table = of_match_ptr(of_match_mmsys),
> > +	},
> > +};
> > +
> > +builtin_platform_driver(mmsys_drv);
> > +
> > +MODULE_DESCRIPTION("Mediatek MMSYS multi-function driver");
> > +MODULE_LICENSE("GPL");
> 
