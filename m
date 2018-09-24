Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E900ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF392145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhcbo7pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF392145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeIXP4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:56:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:56:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id r1-v6so9436353wmh.0;
        Mon, 24 Sep 2018 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLnuHJ83Ln4vXWH/P6WmaEzSp858TmJTQeI2AN1LrHI=;
        b=Nhcbo7pU6cR+e1H+AXy19MSwxdzGl1Rq3jHlvxLGoO+APo62+QECDLoYyuG4/G70np
         evh/4WXtSVyvVICHPLiqnFwcAnfEVTpx7boFGNCnUwbHqKJ5Q+BGmTqnHq+YjvpXcNbh
         ICkY9wkUoDKxyeLQlXXK79lhjChOs3edGucnfBSO7j7dwNB19Fa9RUrGST13ekFFUAyA
         qE9itDVfJz7O7CfBYl3V/BazCULfs7MsfaJwaKXDVIo7F4JomJpcC4OQEPWDSCQAuCr2
         zvn07p+J6hoGtAqbwVsA17UAOMY5UAH/NYLhx6lhFSQeyFe+pxNm6MRaq5zvP2RqW8F8
         2DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLnuHJ83Ln4vXWH/P6WmaEzSp858TmJTQeI2AN1LrHI=;
        b=iXbQ64xp9EhvUS8IKfhuZjIHZR60822Pzj06tUmrm3JGeb6aXnIkLxg+zOhayiNmpO
         EiXr7lbwb8AodgWpLkpsw1DiwXVA3JRG1C84QqYyctzdmKm94oT+9jy6hq7bOrkp3M2N
         UgyFhR7jgeIf1XtIj/HPjEQ+E1iKWryLgkCdMniGk2r+lQ4dDtpEfCRDl+UtfNdrvsuC
         wOMdCKJcA8ulB50uXnowiw6kOB80Fla99ND0iRQ+UZZ4HbeX7KGKO2nsCGXmPeG9WDAW
         dmfTSNvju9nHZi8XHeJvzI9mhg4m2Q32IA3pLtEc+HKO8XiYqH32WLkeZh6EwLmZLiTn
         M39Q==
X-Gm-Message-State: ABuFfohHrvwERaARkYCrI3D5Lu80FJTggr6QzOmOxZcJJ8mTXUFeMx0X
        vwf9ymyh4DcUaAHL2k+87gI=
X-Google-Smtp-Source: ANB0VdaSBjPu2gjfR3kZmH225PEBTp3KAKFFyMrdUy1OG1Loe/PurhPZr/KkZTHakENeHrDv9vyp2g==
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr6567548wmf.52.1537782931800;
        Mon, 24 Sep 2018 02:55:31 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id p9-v6sm3618453wmc.37.2018.09.24.02.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 02:55:31 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:55:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20180924095530.GA21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:39AM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver wasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. As a result
> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT and not to break older kernels using
> newer DT, that is done by changing the 'compatible' of the node to
> 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> property also puts the tegra20-mc binding in line with the bindings of the
> later Tegra generations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
>  2 files changed, 19 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra2=
0-gart.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.=
txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> deleted file mode 100644
> index 099d9362ebc1..000000000000
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -NVIDIA Tegra 20 GART
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-gart"
> -- reg: Two pairs of cells specifying the physical address and size of
> -  the memory controller registers and the GART aperture respectively.
> -
> -Example:
> -
> -	gart {
> -		compatible =3D "nvidia,tegra20-gart";
> -		reg =3D <0x7000f024 0x00000018	/* controller registers */
> -		       0x58000000 0x02000000>;	/* GART aperture */
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra20-mc.txt
> index 7d60a50a4fa1..e55328237df4 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-mc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-mc.txt
> @@ -1,26 +1,37 @@
>  NVIDIA Tegra20 MC(Memory Controller)
> =20
>  Required properties:
> -- compatible : "nvidia,tegra20-mc"
> -- reg : Should contain 2 register ranges(address and length); see the
> -  example below. Note that the MC registers are interleaved with the
> -  GART registers, and hence must be represented as multiple ranges.
> +- compatible : "nvidia,tegra20-mc-gart"
> +- reg : Should contain 2 register ranges: physical base address and leng=
th of
> +  the controller's registers and the GART aperture respectively.

Couldn't we have achieved the same thing by adding a reg-names property
instead of using a different compatible string? After all we only change
what information the DT provides, but the device is still a "tegra20-mc"
device.

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotI8ACgkQ3SOs138+
s6EI3A/+MrOSQlcTPEzyOBIMaNpmEc3SIOPvJY5xDEGmqJikhg1/SRSnkn2pb+S4
YFLRE1fMd/Fq50lRvvSsWqkzMMUAYTcuPugw5xJf0LIFoOar3XcEB4O3qgvHO/2h
xJgfnCsno58K1rLKre3NknJnrjsNjRuDZuoKSwuqWRauxWPm1Bf9Q40KzdX/Zhcc
zSWpi9oJNXRep25zdmTJaZIzgAJuxXaLuR9HOorHGaDnCue2sw9CHdvDrxl13wD6
rXNOolsnYlRURWvyojLzDTfeY87VGRePPud5sksyA744h61lzqDTJndQw5Nw+Wm9
IiPnXuUwIB1/szMqMF29I1SWGayNCVah0T3q1n+BZoUD7t8a5darIgXL4wzzus/z
c1tN/MU7wbKRCFN6Ix3IVyqvcSvr1kW9mZNT1CHCsWexOI8szKh59Kyy+tzuk6LL
qS6cNC0wx4AMe38ptzaCe8B5ZY0esAOf2v2z9mWM4UAJSfHNOZzf/Nw5Z++5iFXe
/Ss94F1vEo0o+WTskXBzRpnHj0/U21C22ww32NH0h4yrzIud3HSphhg0V+Xb/s5r
yWynLOWXJ8uLT2ig4pSarpMhW/N7qUircP1VwyCCmsxUuJCs70PN/Eca4FD2ilqr
VyPLbxYsGzOveMHzSsHGD99NJW1WYpXDB27DfH+6G4gCPNX/MXU=
=dkO7
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
