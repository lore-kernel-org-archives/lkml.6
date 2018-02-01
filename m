Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AH8x227Oq92aH6oeOUdjCijT1XMfypQPuDpGfsepxLpT8v8bYoZvl6HHgTY+F258wV47Kr9V8kx1
ARC-Seal: i=1; a=rsa-sha256; t=1517471452; cv=none;
        d=google.com; s=arc-20160816;
        b=CfgHWVrd1EdU0KVGWvxlKAOq22ddEjAFJVW50IMs2yx7XxvJPT/Ka/tsxha0I7yeSj
         sF864maE6X9q879Zb6ApovDkuk7V8sd9zu8sCqZDd3hxxw9i3xqgbgVOQK3FetFxxLLc
         Xh4N58FB7cMS5zcCMfEpmCuJKruxo2bSfqXXdd5WeyilC+yPfEIzsuTuFu6rRbZrbk7r
         WpVpVLZat6oKjuk29hIgpuQw7gLVSwCSRjBFDgtiCOSSg2ttLUWoPVtASyTHwLxuGZKt
         fldeLwvJOdOT5r3xsU2YepeFQ2kfuQnuACvoupROBDVFeEHlrB+9aRpLLGU3HnLHu2af
         iBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=9B3qwuFQTiLDB7CHtkcEBfGJw+4dxOi/5+dgSIjsGFQ=;
        b=wHB5JrmvV6+qNCger+a5YqD+MbX2kHh81ZPLC6/BEU9pXxmm6hESixPBXrFvwsDpF6
         g1Sf0ToiMWWZuOj0JB39n2aNv+6BfHLJwM9pmv/vEzXy1jkiVanR7d8rlGLWOE78p2EQ
         IWlDeUyIh9sKEpQ8q5ZqN1fvV5lLXB/VF9UkTrAeJ5SZQ6OeN+Q0R7LCMpWLhPL5XYy8
         aagCRQzhubwVIb0nRBLj4ktKwJN9Dev2BuiFuamHk03aznpXIWOP2p6ow/uk6pg79i7r
         +rj7pR8rvbP+M8nVHA9+uskmY9BB79nZiBc+Md6xesy0mCZ0sJxqJ8OvbCR1QC0wEVHN
         AvqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064CC2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180131155718.5237-3-a.hajda@samsung.com>
References: <CGME20180131155734eucas1p1c7988ce46f3164329a39d2358d9fada9@eucas1p1.samsung.com>
 <20180131155718.5237-1-a.hajda@samsung.com> <20180131155718.5237-3-a.hajda@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 1 Feb 2018 08:50:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPewrA38bxiCKa=pjhVKXys2KRstV2w=+MP3TVi9kkN1kw@mail.gmail.com>
Message-ID: <CAJKOXPewrA38bxiCKa=pjhVKXys2KRstV2w=+MP3TVi9kkN1kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: add OF graph between USB-PHY and MUIC
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591124177095890222?=
X-GMAIL-MSGID: =?utf-8?q?1591184145886838064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 4:57 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes USB data lanes between USB-PHY and respective MUIC.
> Since graph is present and DWC driver can use it to get extcon, obsolete
> extcon property can be removed.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index 427ff861b441..b20b42659206 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -828,6 +828,17 @@
>                                         };
>                                 };
>                         };
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +                                       muic_to_usb: endpoint {
> +                                               remote-endpoint = <&usb_to_muic>;
> +                                       };
> +                               };
>                         };
>                 };
>
> @@ -1242,12 +1253,17 @@
>
>  &usbdrd_dwc3 {
>         dr_mode = "otg";
> -       extcon = <&muic>;

Look ok for me.

Does this depend on #1 patch for DWC?

Best regards,
Krzysztof
