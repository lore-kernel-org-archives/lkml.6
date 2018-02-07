Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBGVrI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:47:08 -0500
Received: from vern.gendns.com ([206.190.152.46]:38927 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeBGVrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:47:06 -0500
Subject: Re: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-2-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <36aebdca-2a7d-07a3-8632-95992d74cae6@lechnology.com>
Date: Wed, 7 Feb 2018 15:47:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180207134553.13510-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a simple document for the DaVinci genpd driver. We use clock pm
> exclusively hence no reg property.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
> new file mode 100644
> index 000000000000..935d063c7b35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
> @@ -0,0 +1,13 @@
> +Device tree bindings for the genpd driver for Texas Instruments DaVinci SoCs
> +
> +Required properties:
> +
> +- compatible:           must be "ti,davinci-pm-domains"
> +- #power-domain-cells:  must be 0
> +
> +Example:
> +
> +pwc1: power-controller@227000 {
> +	compatible = "ti,davinci-pm-domains";
> +	#power-domain-cells = <0>;
> +};
> 


We already have the PSC @227000. Why not just add
#power-domain-cells = <0>; to that node instead of creating
a new "device" when this is really the same device?
