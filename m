Return-Path: <wens213@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526015155; cv=none;
        d=google.com; s=arc-20160816;
        b=PiYXy5hqJEFX4NmXcSU9BNDPU9HkKbKaYJ5KyEvaP9o5rrnTa4M+Nj3NtG+laqoJK9
         YzVCx3QTXQgUfFONJ3Q9gkQMe8CtLjTTRQaGhh00MOJBxWvbFaRKkzjETnwBhkaIr9lj
         QpUtxN51tkAoSm0rrS+/AinXNGfmKEz9fYCX7JMK+/dnsxKB4wbp4+Rtl7CuSQX3Q37C
         J7f1fVSdoJRf9AWPKa9el+tHk/QMgJ1suQEkRe/FtmbbmUfNHWqi88xke0M05cNlm+ZT
         yPGFGUahC/vdlg/QAwAFy8enHUOCh+yMZHvn2GM3qHUe9DKviZplWV2tbQMRQ0hGaMgt
         BfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=ZSLm3QE8IB5j3rjPkN53qZgVmUUvaMx28Dnc0M+pGxU=;
        b=XSQEYGzmWMll0XlVbkHoAzGQN4ut7LdAvYFXNXARZInjN8b8o6YbeztTw3WGdx3y6x
         7AOb8oXcbnxoz11BXp/F/aKpt21kgsK7EPjxGGdyUKagPWVHYCqaHvTcTpo1gOB4Ds9l
         RV5wFH/1iWZQcX07XggP6+4ZJeREZs9kePxcLERpk72THipv/Ng1B5y5kO1L8fFfLBGi
         2iNk4a5bZahLaJyAKAiSBt1BybQByu8ZMaKWf6h2rObAC0t3l34I2eInQTGhy8iUXrki
         MAAoZeSlHgB8zynMxoO0gJf1i67s6jb3hcvgixmIMFbNvjnY+jaLCcS9LXmHjdZbK3e+
         0afw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wens213@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wens213@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wens213@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wens213@gmail.com
X-Google-Smtp-Source: AB8JxZohD8+0794QsG/HMyTweFKCqUGNX/hPcocH2zLjK24Ny882Ss3yKn5xPjciO95oufVk2DUKFw==
MIME-Version: 1.0
In-Reply-To: <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com> <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 10 May 2018 22:05:33 -0700
X-Gmail-Original-Message-ID: <CAGb2v67An8RSCKEDSgW_jY7m8iw22K4rRHb02q67decmCBcjhg@mail.gmail.com>
Message-ID: <CAGb2v67An8RSCKEDSgW_jY7m8iw22K4rRHb02q67decmCBcjhg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] drivers: soc: sunxi: Add dedicated compatibles
 for the A13, A20 and A33
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>, Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hugues Fruchet <hugues.fruchet@st.com>, Alexandre Courbot <gnurou@gmail.com>,
	Florent Revest <florent.revest@free-electrons.com>, Tomasz Figa <tfiga@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Smitha T Murthy <smitha.t@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Randy Li <ayaka@soulik.info>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809521273033296?=
X-GMAIL-MSGID: =?utf-8?q?1600142868429539413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 5:44 AM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This introduces platform-specific compatibles for the A13, A20 and A33
> SRAM driver. No particular adaptation for these platforms is required at
> this point, although this might become the case in the future.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 74cb81f37bd6..43ebc3bd33f2 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -315,6 +315,9 @@ static int sunxi_sram_probe(struct platform_device *pdev)
>
>  static const struct of_device_id sunxi_sram_dt_match[] = {
>         { .compatible = "allwinner,sun4i-a10-sram-controller" },
> +       { .compatible = "allwinner,sun5i-a13-sram-controller" },
> +       { .compatible = "allwinner,sun7i-a20-sram-controller" },
> +       { .compatible = "allwinner,sun8i-a33-sram-controller" },

We should probably name these "system-controller". Maxime?

ChenYu

>         { .compatible = "allwinner,sun50i-a64-sram-controller" },
>         { },
>  };
> --
> 2.16.3
>
