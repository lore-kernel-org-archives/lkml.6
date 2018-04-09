Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523305468; cv=none;
        d=google.com; s=arc-20160816;
        b=eP3O1a121xRlf/9EJ6bnKcnTWU/f0kg6hvUEf2TEEqYM4XalKgEmGLNdvGOqCZ4YTD
         iofQuu8cQHoWG7maF6bXMr9HmCHqESiltlkD33odnMJyeUBzWMsg+wjV5iFp7Qbd+53e
         DR8Qr8zLQ0hGUy9+8na4/v+UeY+bo8wO7mbt/vrdCG1PDzVvNoKP6NE+z0cY1pPa5zKk
         DSLFDIoy1kb8doYF75Kiei4311WQPLRgOVJ0QlnydRVUXWlHSXnPLe/DiASA/xgCsfKT
         4kFPRdpZgX6wEWVm0p2KDSn1VTZ0lK27GNR3vBV0oPrpb0NyaLu+LDbuPPVEAwIM3bNs
         diyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nD9lyAXOzwIy9aA8xzn/IhttWXwLhCwGD1MqNbmEHpA=;
        b=0by+NGI8V4f1TDPKH2hMPrQAaJdiC5cij2Rj0NTr4NeaGcRhbev4sq4RuA1yJqBVaW
         QX/kj89QAEjmEh0eSATv603U1hgV0tc+XlwSNtUXi9pyUXklXHghRMWIv1TsHi52osiD
         kZooYTerA8838rvVbPexA2ff8savIfOdrk3NltSatvCAldruzKErr2gRirqJSM5Yh0Qc
         UfTzP0p/pfayubhYJ1xa4w6XWnn19WWLtYrCJ6ipOHzq2YlMbq9LI6gixQBIwITX5+g/
         0Ei74kwCwUG221r5LFMe1o8OANGjXavNmn6SjRq1xaHwuN9mTIjq4uTunBvsusMWzg+S
         7cLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+oueKdVErriKAf4VRM8xWNmbFB8VBhqanPb5QW9xnQJ2yJidSyz/S4sx0yiQLuMa4wQ37p4Q==
Date: Mon, 9 Apr 2018 15:24:26 -0500
From: Rob Herring <robh@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 04/10] dt-bindings: i3c: Document core bindings
Message-ID: <20180409202426.grl62ydysfse27ly@rob-hp-laptop>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-5-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-5-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347989623961595?=
X-GMAIL-MSGID: =?utf-8?q?1597301554741817965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:47:45AM +0200, Boris Brezillon wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
> 
> Document this generic representation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Clarify the fact that static address == I3C address and dynamic
>   address == I3C address
> - Use i2c-scl-hz in the example
> 
> Changes in v3:
> - Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
> - Rework the way we expose the provisional ID and LVR information
> - Rename dynamic-address into assigned-address
> - Enforce the I3C master node name
> 
> Changes in v2:
> - Define how to describe I3C devices in the DT and when it should be
>   used. Note that the parsing of I3C devices is not yet implemented in
>   the framework. Will be added when someone really needs it.
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 140 ++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt

Reviewed-by: Rob Herring <robh@kernel.org>
