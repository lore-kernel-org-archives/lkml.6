Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeCWMzO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:55:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40648 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751983AbeCWMzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:55:12 -0400
Date: Fri, 23 Mar 2018 12:54:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] staging: iio: ad7746: Add devicetree bindings
 documentation
Message-ID: <20180323135455.00007341@huawei.com>
In-Reply-To: <1521642539-4845-10-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-10-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:57 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Device tree bindings must be cc'd to the device tree binding maintainers
and the devicetree binding list.

Comments inline but don't forget to cc them on v2.

Jonathan

> ---
>  .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> new file mode 100644
> index 0000000..13d0056
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> @@ -0,0 +1,32 @@
> +Analog Devices AD7746/5/7 capacitive sensor driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,ad7745": When using the AD7745 device
> +		* "adi,ad7746": When using the AD7746 device
> +		* "adi,ad7747": When using the AD7747 device
The when using bit is kind of obvious.  Probably no need to state.

> +	- reg: The 7-bits long I2c address of the device
> +
> +Optional properties:
> +	- adi,exclvl: 0 = +-VDD/8
> +                1 = +-VDD/4
> +                2 = +-VDD * 3/8
> +                3 = +-VDD/2 (Default)
That needs a comment to explain what exactly it is rather than
just documenting the enum values.

> +	- adi,nexca_en: Invert excitation output A.
> +	- adi,nexcb_en:	Invert excitation output B.
> +
> +Example:
> +Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> +Excitation pin B would NOT be inverted.
> +
> +i2c2 {
> +
> +      < . . . >
> +
> +      ad7746: ad7746@60 {
> +              compatible = "ad7746";
> +              reg = <0x60>;
> +              adi,exclvl = <1>;
> +              adi,nexca_en;
> +      };
> +};
