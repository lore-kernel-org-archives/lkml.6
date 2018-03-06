Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520304040; cv=none;
        d=google.com; s=arc-20160816;
        b=r+eA1BnYy/aFdPnICCVpMpV5ToSzIBM4ED0/u7NgIVzyX1l7JC7Y63mw5Oqu6x31Ba
         L985qhHy1+8oxA/0tsqaWQYoyf8m72NtHa1TdN/dgcQXL251KFnRybMc7xOPWZCrScbm
         stRwC4FqcaISEREKz7NdlcDARvDdOBdithf9jShOeV9m9bWQxWOsjCKJ73GhYvbO3OqV
         yBJopgao8gJ1w+VCL+sicXC2cy2+udfu3B50ZM4jnyyx6B+TQ3Eeh3m8+7P7SbClLCd6
         C4NDYtG5s967c6i0MKkCnzlLEyRyzGXAZmLb3AsZxtqE9i+xICx1wuDJ+F0qQUSd3NId
         3Now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=v4KtQsANTNoyoi+vz8vmBa9pM6p81NNPqfc7jcpZzVg=;
        b=u4/NzmmmJsE0wbHTjCsX3qU3AWjaGzPhO9z1346/sfrJZqcyrEL+iChAFhoA2iz+Z1
         GIC3nN2n2GxTmFwqil/9zc2mIXozJA/FT4uo2lCwhRDMVqcqlPpyqR4KeJbZtbPOmSbb
         fmhllwnpAq+A3nrNMJRfVqE63D9Rs1LFlh3JajPonBvyVmacjrqwxHqBoLEPtYfFH8hu
         inLiwbY1HSqAqF+sNXJptekHOEg0aAcYTABGK2KmAsNliA8FMxjtbSgi9vZJjhTOT1I0
         5DkDlMzO+pMqUytocGbRUqmftOU9hSDL0MsMQEPuyUuVFYrHhemqU5UsEgy7AZDK6ggM
         eSsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELt0JdIfuWsDQNkxHaxwSB0cSpveUj8BNvxXbQUL+Xrju9GwHbdJtDZT8Cs3rVeNMXvhebKarA==
Date: Mon, 5 Mar 2018 20:40:38 -0600
From: Rob Herring <robh@kernel.org>
To: Vitaly Andrianov <vitalya@ti.com>
Cc: mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, t-kristo@ti.com, m-karicheri2@ti.com
Subject: Re: [PATCH 1/2] Documentation: dt: rng: add bindings doc for
 Keystone SA HWRNG driver
Message-ID: <20180306024038.uszf3r4nb4pw6kkf@rob-hp-laptop>
References: <1519908900-10388-1-git-send-email-vitalya@ti.com>
 <1519908900-10388-2-git-send-email-vitalya@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519908900-10388-2-git-send-email-vitalya@ti.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593740131120590051?=
X-GMAIL-MSGID: =?utf-8?q?1594154329541195095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 07:54:59AM -0500, Vitaly Andrianov wrote:
> The Keystone SA module has a hardware random generator module.
> This commit adds binding doc for the KS2 SA HWRNG driver.

Preferred subject prefix is "dt-bindings: rng: ..."

> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  Documentation/devicetree/bindings/rng/ks-sa-rng.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/ks-sa-rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/rng/ks-sa-rng.txt b/Documentation/devicetree/bindings/rng/ks-sa-rng.txt
> new file mode 100644
> index 0000000..cc8ee44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/ks-sa-rng.txt
> @@ -0,0 +1,21 @@
> +Keystone SoC Hardware Random Number Generator(HWRNG) Module
> +
> +On Keystone SoCs HWRNG module is a submodule of the Security Accelerator.
> +
> +- compatible: should be "ti,keystone-rng"
> +- ti,syscon-sa-cfg: phandle to syscon node of the SA configuration registers.
> +		    This registers are shared between hwrng and crypto drivers.
> +- clocks: phandle to the reference clocks for the subsystem
> +- clock-names: functional clock name. Should be set to "fck"
> +- reg: HWRNG module register space
> +
> +Example:
> +/* K2HK */
> +
> +hwrng@0x24000 {

rng@24000

With those,

Reviewed-by: Rob Herring <robh@kernel.org>                                 

> +	compatible = "ti,keystone-rng";
> +	ti,syscon-sa-cfg = <&sa_config>;
> +	clocks = <&clksa>;
> +	clock-names = "fck";
> +	reg = <0x24000 0x1000>;
> +};
> -- 
> 2.7.4
> 
