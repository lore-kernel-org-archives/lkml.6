Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AB8JxZrXvWW0XDSAyAp+vNZH/ht9YB0JiOhdYf0AN2g/2lQyP/Nwk0GE8Klp9q2lg2BgoRzGYt2K
ARC-Seal: i=1; a=rsa-sha256; t=1525367651; cv=none;
        d=google.com; s=arc-20160816;
        b=mojQ6Zs+/GVPGYNO1WSg98gw4rw3M63BC1eq+LbU0keLyffHXF9eOre5t6ABXCljwY
         DKBDX2V1qurfw4RPsG8X71psa+W++eRw+dBpyTT5H+xyXq2OnfGo32BnhWpFeXnODTpR
         ZwVIztqtDJaOvOc+8nEca7zWGuq5M6YdnSr7Lez9+puVghQuEUrCqmEEUBuh/TrY6eA1
         sEwAHgZNbPx7jgeK4mdysdflSdLdSobSPZS1bAMTML853UWe8PorzQuLVjk4u3AGG6sM
         ZK73xlb94qaYCoCdqkhIpVGQb4lXvoaOcRFvRqI6OnXaVHw7khvUXl09q0OcbiI9j3OP
         M95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=N3/90tXBFD+WxXSm4cj0K7EVMmlFGyjbeym6+9iML2k=;
        b=aG7WSZh+H3yoVEB+O1bcTxQ2nLyunetoE7+xu8Gt5Y58k7VpEz3zfRMGkLtURVFDOw
         ZswW03CWmDwq628R6xFC4yFKwGcAZSprPCpZ84p7K0zPqYSVVzwip/adLlIWnjLUzwc6
         NAXuThqDgntzg6611J6m8Ka4EVrj7TqsZ1H4WwtI5vpxeHwTn6QbOOUKepenPvaBgZIY
         tKhutKF0whSHu1XlPGf8Fbf2s1m6ucrsdFyvfcrzeusm1kZTgEHHIK71QCibdDr5baXO
         H3CsDE//w+4iu3ISzoFNUaLFgp31VS3huRn7NOLXz4ME7npecsDSnWeng1a5SPfwr5+x
         fuXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Thu, 3 May 2018 19:14:10 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yong Deng <yong.deng@magewell.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Todor Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v9 0/2] Initial Allwinner V3s CSI Support
Message-ID: <20180503171410.q52ak27u47gycy6o@flea>
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151284000328035?=
X-GMAIL-MSGID: =?utf-8?q?1599463910716590726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Yong,

On Tue, Mar 06, 2018 at 09:51:10AM +0800, Yong Deng wrote:
> This patchset add initial support for Allwinner V3s CSI.
>=20
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
>=20
> This patchset implement a v4l2 framework driver and add a binding=20
> documentation for it.=20
>=20
> Currently, the driver only support the parallel interface. And has been
> tested with a BT1120 signal which generating from FPGA. The following
> fetures are not support with this patchset:
>   - ISP=20
>   - MIPI-CSI2
>   - Master clock for camera sensor
>   - Power regulator for the front end IC

Do you plan on sending another version some time soon? It would be
awesome to have this in 4.18.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
