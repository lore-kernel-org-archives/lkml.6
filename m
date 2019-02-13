Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA070C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885AF222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od8ehpkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbfBMIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:12:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:12:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so318506wrw.6;
        Wed, 13 Feb 2019 00:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YYxSMDFsWWh5owzRZcsnaAFoznwAOs8flQV7rzfd9GQ=;
        b=Od8ehpkKltPXiMaFo7WwyOKKVdiX5FtcyLtkbMM5AvqYuwNOHN2KrmIHHsxBReyPyV
         MKS47DIIBWvbI5d/ZN64LO6D+aAfUIo1KqXkLOhSsIpU5t86OlT1Pw4WpgEuAhdFy+2y
         ZIyYyMfQQiAyuvw13nCQchMbdDJ4q1ZCPQODdBcImj2Toj4+DFgXlxLQe5QiWxTNWXLX
         QZEoYsqfmpe9tRUC7SRycIaV5rOW4kHJ3Wk28vnvHWGKnxifxnu8o7BM9IfKWXXiZs6X
         dUMWlvDdGOlSIhT+fcxu1mnNhiD0Mcq/4sSAFy9KNZwsYpbXjKZR6Zi5empMehZN2cav
         6HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYxSMDFsWWh5owzRZcsnaAFoznwAOs8flQV7rzfd9GQ=;
        b=Pp0L97yNg42t5PkB3rcnbgGKF7Lio20sRoTIl5SC/t6vBkMpYGKaIKmHZ2RkuEy73y
         GQUydno/DLvtyFzxs+6PhN72Jc/OPIkt5JLqDc1D7E2Yi1Vd3+N3a4dlAcPPl48U6ZSC
         BFbfXAtzcd3zLntNQpNqKluqyv1XDk0Pmv73y51MFElPEQVgYwwieaw3Xpv2IP5DaYM1
         uDNBnqi+Rhz3kBU7/cm8TQ1F1rIeiSVOMmwd0XNEIKKA7MtsshnRnqvWXIiJO17HlD6+
         VuWcPT+Z6f44qSfHoccrgCuNhEGMNr6g0/IgMs4Q7hzsrKK38u0+Bs5fAwQRLDWigczP
         NO1w==
X-Gm-Message-State: AHQUAub2N9AJP1glCsql298b2XZFW1YtbGRsMlnUwW65EL1FiPIuPSpn
        zmwdDIHxd6dJHNw/CEjGwpo=
X-Google-Smtp-Source: AHgI3IYIJxlnQk2yGrBWxMUcgUxXwaRiNKJuZF0awIwWpgwxkQwnY3YEeGqNtJugqLb/+Hzq6Cn+IQ==
X-Received: by 2002:adf:822d:: with SMTP id 42mr5817796wrb.63.1550045574391;
        Wed, 13 Feb 2019 00:12:54 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a4sm4723792wmm.22.2019.02.13.00.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:12:53 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:12:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bo Yan <byan@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: tegra: add topology data for Tegra194 cpu
Message-ID: <20190213081252.GA647@ulmo>
References: <20190131222517.GB13156@mithrandir>
 <1549928827-14006-1-git-send-email-byan@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <1549928827-14006-1-git-send-email-byan@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 03:47:07PM -0800, Bo Yan wrote:
> The xavier CPU architecture includes 8 CPU cores organized in
> 4 clusters. Add cpu-map data for topology initialization, this
> fixes the topology information in
> /sys/devices/system/cpu/cpu[n]/topology
>=20
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
> V2: remove cache nodes, add topology data only
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 58 ++++++++++++++++++++++++++=
+-----
>  1 file changed, 50 insertions(+), 8 deletions(-)

This mostly looks good to me. One minor comment below.

>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 6dfa1ca..35e6e76 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -870,56 +870,98 @@
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> -		cpu@0 {
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&cl0_0>;

I wonder if perhaps in this case it would be better to use the full path
to refer to the phandle here. That way we can avoid the labels, which
are somewhat cumbersome to write and the hierarchy, in my opinion, is a
much more natural way to reference these.

What I'm suggesting would look roughly like this:

		cpu-map {
			cluster0 {
				core0 {
					cpu =3D <&{/cpus/cpu@0}>;
				};

				core1 {
					cpu =3D <&{/cpus/cpu@1}>;
				};
			};

			cluster1 {
				core0 {
					cpu =3D <&{/cpus/cpu@2}>;
				};

				core1 {
					cpu =3D <&{/cpus/cpu@3}>;
				};
			};

			...
		};

That's slightly more characters, but I think it's much easier to read
than the labels.

I don't feel very strongly about it, though, so feel free to keep this
as-is if you prefer.

Thierry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxj0YEACgkQ3SOs138+
s6EIjg//bkjxCg3sURndiknYkGF8P4aeDrmQDiRteucN73TGcbWJYCUEB7mZUa33
0+l0a/zUOapNqSZaHVSgXXiavEAyznJOqQNjpHaaUXieFvsfZRTFPyNenTYwWVq8
yn+MyGyKO69B32NECuBAbqby7kVU2AOyiN58AEFOVD7LF4H33UBFp7PG8PfJOuzB
MIDtZ2oW/VIdJft+044ZQ0LnBcWabrT1K3b/DHm9oBLQFLT3R3DiJz06cSsQs3Bo
ckjxuH0rZ9zql2UV/aivmtwSirw3g6kOrBs0S37nKDna5RQdLLM879k48LeaSXkn
kvo/FdMUWsafb+HGHeV2fmDhw1FS4ta97qNU5Siak72l21E8imIr/fBMr94j+c3P
ANMoBD5HZdQwcPnnsW4dVIT0DoZRzrkpJVG46rduOGpLaBzqXtp53KOkUkoH1X4P
0gJJ0SFw4pF8fzxmGTnqG7cWDViVBacA4Xpo1v1FTFOkbDn7NRzndneoqN+h+TdE
6+ow1/eDq3zZ6LzKk9K3nlkhtaSWdU83/DSIwP/0lyJJcUIW7vxgs9t1tZKl/JK0
sIGHMc9MIZC76lGeuplqo/HZMMMmHceJYNXNVTIA8B31Baooz+JhSIRr7lJkIoal
gd9Z6EEj9/aYPNf1LO4Wz2hONQXdLvakzqnA1TcrMVzM/mKZlKw=
=FQak
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
