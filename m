Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeCIOoc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeCIOo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:44:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A858B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 9 Mar 2018 14:44:21 +0000
From: James Hogan <jhogan@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 7/8] MIPS: BMIPS: Add PCI bindings for 7425, 7435
Message-ID: <20180309144420.GG24558@saruman>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jan 15, 2018 at 06:28:44PM -0500, Jim Quinlan wrote:
> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> index e4fb9b6..02168d0 100644
> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> @@ -495,4 +495,30 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie@10410000 {
> +		reg = <0x10410000 0x830c>;
> +		compatible = "brcm,bcm7425-pcie";
> +		interrupts = <37>, <37>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 33
> +				 0 0 0 2 &periph_intc 34
> +				 0 0 0 3 &periph_intc 35
> +				 0 0 0 4 &periph_intc 36>;

no status = "disabled" like the other dtsi?

> +	};
> +
>  };
> diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> index 1484e89..84881224 100644
> --- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> @@ -510,4 +510,31 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie@10410000 {
> +		reg = <0x10410000 0x930c>;
> +		interrupts = <0x27>, <0x27>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		compatible = "brcm,bcm7435-pcie";

Might be nice to be consistent in your property ordering between these
two dtsi files. I for one would prefer compatible to be near the top
too, if only for consistency with most other nodes in these files.

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 35
> +				 0 0 0 2 &periph_intc 36
> +				 0 0 0 3 &periph_intc 37
> +				 0 0 0 4 &periph_intc 38>;
> +		status = "disabled";
> +	};
> +
>  };

Cheers
James

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqincQACgkQbAtpk944
dnr2hA/+P6w7+sOSZ5SEM19861JqBmRkXLy5Hd/18PMHGTennR09vEOJv9skH3oS
CojTysqBeNHvupX9gQ48lCeccH2GNv4fExM8QZyKreEwli/gmCxJRTXeZmmO3aqO
RUFpkIauu/whA/e8fxoEhUuX79wyNw+wqT0DHxpafPc66Aq+SBXXz8LINE+DaM+/
i4JGd0fY/1N48CieB1mFgOCkaTJ1F1ei7Jh+f6qeHKv6tNTx+LRnU0oKbGpybEJN
kpY6BvodOgC/YL+tOiyyAASN90a7wS4vj0vxSkxbeKZp1fMF/3F5uA3J1FdJDd5X
Ydqy3jFG3gggm7GhFUOeZPv1KogWt7PddWpoZnpu5GlIaE9Eb7ba0FMhb6+LPrx8
bj/rms88LosucmT5u/QvuGrIArBNyhAQPTFVner+gTfjHDvpB5iAG/RcZCCrRX9d
sOMSmDorbfGs8t0m/k3HScl9d2ZQJPzRjL/YOJSuBpJQPGG+Cz4p0+5lr+zar0qQ
BeZcwGCvv3VjFUg60flzbOBuiQ3KTvKFo52ssk7l/Tuq2cIW/vgVBvcbgFPu+GfT
zeE1no/C1jT8EtJDipihJa1GmsfMs7Czi17nb03dljylkh7eXmKcsuwn4h95wskZ
WzW46Mgkb98ZDrN9b1iH4TUe7IuNhhMFxjnVtfeudkt05TKyplo=
=Z5Mn
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
