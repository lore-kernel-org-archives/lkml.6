Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523653570; cv=none;
        d=google.com; s=arc-20160816;
        b=zNpgk30Foa9ODfiCQuyNq8xvHpO165EJF8g0zCXDENVuWOl5HdmXcz+AX/HEiihQI6
         K2Ppqp89Tr6I924RH90lpIVz1ErwDNqxaeAyGV4tXPLtcw+U6E9hs+lscOMa0sxgZfbo
         78B7Zcw1bhExrMdmIkb8gAWElEwcHMClHhBpo+IFl2oUz2tRgzWOniyu0B/4vjwg3Otg
         3/iHHUPe+0SvZoTpYkDHPfXVsfSwtFIz3r/vRIMpFvDRTiU0HW8ZnwgvlHIAbzRrYCia
         Bad46BgcmOtHykP6rQ7t2YaHJsN8yFvvnSa8M6ys9FjdaMaq7kBd6B4gkp0sCAw853OI
         eWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=qzW60CuhNXR31uBOgb5I/q0rZ/xillG28VuP/wKsIow=;
        b=zvlMPhvAXe+VhPXFdO7tUhcR4nxbKgcx2AeI1/6IIu/sVflvugrnid3Ao2UNjW99y5
         y+oWOve6oUxLWaM5ggzqbjXakmBUJb9DVtq5M5QWjOWubefx27hz+X4ie5jE7MXPLycG
         IKdxBpNd2Vr/jil5MDs7FJ8cu2HBlEtveTdTn3S9jh8BzNf8atlx+Ed+nRc5WE40MX7M
         Cel11yWxgj7W7MZW6j1jqdA+BmehIgd4bmFEEftVs2Dtavap7DCtl0EysjJD8clOGXtB
         PvcdYrVDp1tBkoUdtLn06K9gjGtiJv16m6GyH3yHWP/w7s+LF4RQvA/PaL7G2gng5urJ
         QbzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/4mqmxxVI97YxCU8OJHqyu1UmKZ1c36/RExbIkBm6yldsqNoij/YWOPFhSaP+idMv91Wnveg==
Date: Fri, 13 Apr 2018 16:06:09 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: sre@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
	mchehab@kernel.org, gregkh@linuxfoundation.org,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	rdunlap@infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings:power:supply: Add docs for ADP5061
 battery charger
Message-ID: <20180413210609.hhysieyzjl777bei@rob-hp-laptop>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
 <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597462996502603045?=
X-GMAIL-MSGID: =?utf-8?q?1597666566712564266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 06:10:15PM +0300, Stefan Popa wrote:
> Document adi,adp5061 properties.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v3:
> 	- Split devicetree bindings into a separate patch.
> 
>  .../devicetree/bindings/power/supply/adp5061.txt        | 17 +++++++++++++++++
>  MAINTAINERS                                             |  1 +
>  2 files changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> new file mode 100644
> index 0000000..7447446
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> @@ -0,0 +1,17 @@
> +Analog Devices ADP5061 Programmable Linear Battery Charger Driver
> +
> +Required properties:
> +  - compatible:		should be "adi,adp5061"
> +  - reg:		i2c address of the device
> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties described in
> +Documentation/devicetree/bindings/i2c/i2c.txt
> +must be specified.
> +
> +Example:
> +
> +	adp5061@14 {
> +		    compatible = "adi,adp5061";
> +		    reg = <0x14>;

Same question as the last version. This seems awfully simple for a 
charger. Don't you need to know and describe battery parameters.

Rob
