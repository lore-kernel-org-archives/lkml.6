Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523909287; cv=none;
        d=google.com; s=arc-20160816;
        b=xBqU0DEy8UF6ofuJEClQvYlRlph6DfSiZcvEWtti5XOYhxOFjuQfqMtcLj0Ie1BC6W
         8/GJ4zoItBAC44gy+TMBwJTvemqgNUYcxAzxRN0/xzpL4naV6xO25YnmT9hltbOY2byg
         5IOJIQRR27cyj5Wyg60/x2B6VE9USi0vTs82tPgNUWzMQKMqilAg5EuyDt4roTAOLtHL
         kBdW4ejObzs+OKhBI2N3T1KcTSo3mujnFlw/adjDTb5vvXqS4Q0op3l8WBJsb7iQAmti
         3jD/VJQWXBUZwzntaDW9Zd89HH5HUHwABnMxtUapp31wJv5eCp3Jmnkg5ztTRGTnpUU7
         u5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Nr4jeu7yimzwsnMut3ry7eSf8QOa34c+p2HHnHyikIg=;
        b=mkEa4mcQYonQBrZ6OA1WbevoG7BvW1WF8j8LUrYeAoyoqcVgzeVSTgooRtEHbCrwsr
         zyJ3y+/LLO6TVSFyhslus08wzZC7GwaOT2rt1EvZ/nrMw/4bvE57FfjRRIKC4WJhWtNH
         d5wvGZJqRgca6o0fxDdD3xGLU3ywgIuIWa1Fz6wX3D9OcxndTwu7BFNdXy9sWqvNaiKO
         8j3w1GHL5nznR9tGo/8YpwKk07lc0dHdWk07sCWHumx/lTnOcXFxQKuEA3MKomaRW70S
         PoZ8qwchXwxObOC/oEOsOgGS3dWdIIKlvbLI71sr10IwgjoYFWqmytBbZLGXxOLkbG3j
         JXGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx49zMka6XCbIEV6taiaXfp6E7AG6pTPuqLuZ4ColfJMyO8DQEybX8m2bQHQMJIoYDV26ApsKUA==
Date: Mon, 16 Apr 2018 15:08:05 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/14] staging: iio: ad7746: Add devicetree bindings
 documentation
Message-ID: <20180416200805.nybyyrribqvnigh3@rob-hp-laptop>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649752365907922?=
X-GMAIL-MSGID: =?utf-8?q?1597934705377112788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 01:36:48PM -0300, Hernán Gonzalez wrote:

Commit msg?

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> new file mode 100644
> index 0000000..7740f05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> @@ -0,0 +1,34 @@
> +Analog Devices AD7746/5/7 capacitive sensor driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,ad7745"
> +		* "adi,ad7746"
> +	  * "adi,ad7747"

Alignment.

> +	- reg: The 7-bits long I2c address of the device
> +
> +Optional properties:
> +	- adi,exclvl: This property defines the excitation voltage level for the
> +    capacitance to be measured. Possible values are:
> +      * 0 = +-VDD/8
> +      * 1 = +-VDD/4
> +      * 2 = +-VDD * 3/8
> +      * 3 = +-VDD/2 (Default)
> +	- adi,nexca_en: Invert excitation output A.
> +	- adi,nexcb_en:	Invert excitation output B.

s/_/-/

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
> -- 
> 2.7.4
> 
