Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeCMMAV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:00:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32944 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeCMMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:00:20 -0400
X-Google-Smtp-Source: AG47ELsnf9Fe3I50pbAOb2p1BmPW1HeklbCay08g+m9Sw++4qFZSkPAW+MHmhgc/0R7BVsskOInm0ITaNHL5XTQyUlo=
MIME-Version: 1.0
In-Reply-To: <20180312155753.9478-2-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com> <20180312155753.9478-2-codekipper@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 13 Mar 2018 22:59:58 +1100
Message-ID: <CAGRGNgURstWzK9vgSTxHiKfu4=wKEt67geKn407ahh_vnqniLw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/6] ASoC: sun4i-i2s: Add slot width override
To: Code Kipper <codekipper@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

On Tue, Mar 13, 2018 at 2:57 AM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Some codecs require a different amount of a bit clocks per frame
> than what is calculated by using the sample width. Use a slot
> width override property to provide this mechanism.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-i2s.txt |  5 +++++
>  sound/soc/sunxi/sun4i-i2s.c                           | 15 ++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index b9d50d6cdef3..48addef65b8f 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -28,6 +28,11 @@ Required properties for the following compatibles:
>         - "allwinner,sun8i-h3-i2s"
>  - resets: phandle to the reset line for this codec
>
> +Optional properties:
> +- allwinner,slot-width-override:if this property is present then the dai is
> +                               configured to extend the slot width to the
> +                               value specified. Min 8, Max 32.
> +

This sounds like something that would be useful for other I2S controllers.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
