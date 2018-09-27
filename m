Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBF820833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmnvb5M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBF820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI0SRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:17:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37269 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeI0SRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:17:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id y26-v6so5086030wma.2;
        Thu, 27 Sep 2018 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VS2A+WwK+nTDdBfI+ofIK7N5bI3YX3n+I3zFa712lGQ=;
        b=gmnvb5M71wZSDD73Gqr/gAom17R8AnXEZqwhmeUQZlQa4tHZn1YmRxQLev8ccVN1Gl
         5C0I3PuATqH0A7v1vRtEjXfDvdXrLON7oTFk4gqbyju5+JGjwn7xvBxmJ2931ezd6LIp
         LgXGXAP7/Zi/V4JSwK6kp1rRQ71VXisAzSapaRrv0dmPUs5s49MVt1Om0BHtxgxxCwZ1
         8tuOwLjjXM71IWjTnFkE6pKInid1O6gz49vwAOsiiD6Vt5rf64LNEVrmWmiG6hvau57B
         aQVN8hu3wdvcsU3Dpg64YSG14Bg6o7/dVkEdOaWNmovvYThSrdAVX+PyPvm9kF8NSFn4
         +aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VS2A+WwK+nTDdBfI+ofIK7N5bI3YX3n+I3zFa712lGQ=;
        b=B5WFWsDyJLRrXUTny2YMg0HWnPxXYQLrYdiA3TDvOOoKlsXBM987i9IbbJCjjVSo+A
         kQN576vqRx8QVT6cQRy02YYX4niifWHyYqOBUT24O6WAgWtZIAOqhBsRY0p857WztlcD
         3nl1KBVRMr/MfaVh0CIozdD7lltPJJkEs57LhCBKX+KYAKj3m5EP022hjsrDM7stDUJw
         qrKgc16oDbk7tIgjWVlwYNyPE8zJleE5MG7EoT0U/QiEdmpCUWGmdHkRoGkQcey+Yre0
         B74PXNwWj9q8z9jQ9vQk2ikvxp1Uh/WOZDwrooCvsV2F/QsKGXhO811mrrTX2ZXgTEin
         U6NA==
X-Gm-Message-State: ABuFfogQPuV1v19IdBJxGYr/jdAnIgUDAn1bTNqifLSzQXNVSCj+kuZK
        npwt2wOcyAGyPxZr6gWZjH4=
X-Google-Smtp-Source: ACcGV63kNufo1biMACJr3kIYQrppWAhvtPCLoscW969Q83LR+AMEmmEKQ11pitkfAVPZnJ104Qz0MA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr8001336wmd.100.1538049581026;
        Thu, 27 Sep 2018 04:59:41 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id h206-v6sm2573227wmf.25.2018.09.27.04.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 04:59:39 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:59:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add CDTech 4.3" and 7" to panel-simple
Message-ID: <20180927115938.GD29102@ulmo>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 01:11:12AM +0200, Giulio Benetti wrote:
> Add CDTech 4.3" S043WQ26H-CT7 support
> Add CDTech 7" S070WV95-CT16 support
>=20
> Giulio Benetti (5):
>   dt-bindings: Add vendor prefix for CDTech(H.K.) Electronics Limited
>   drm/panel: add panel CDTech S070WV95-CT16 to panel-simple
>   dt-bindings: Add CDTech S070WV95-CT16 panel bindings
>   drm/panel: add panel CDTech S043WQ26H-CT7 to panel-simple
>   dt-bindings: Add CDTech S043WQ26H-CT7 panel bindings
>=20
>  .../display/panel/cdtech,s043wq26h-ct7.txt    | 12 ++++
>  .../display/panel/cdtech,s070wv95-ct16.txt    | 12 ++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  drivers/gpu/drm/panel/panel-simple.c          | 55 +++++++++++++++++++
>  4 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtec=
h,s043wq26h-ct7.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtec=
h,s070wv95-ct16.txt

All applied, thanks. One small note, though: in the future please send
DT bindings patches before the driver patches. This is important because
checkpatch, which is run as pre-commit script, warns about undocumented
compatible strings if you send driver changes before the bindings.

Thierry

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlusxioACgkQ3SOs138+
s6G+3A//Rv1xogsu+FndDFsCZnsmRV87aTiT4UtqNC3Ms+u+7dmEsGAsyzo/SE6r
zz4iLR4zuxVC4v7I++AEQYjRC2TFyn00AiE0cnXIxmimr89IfZ4VDD6r/Z4Urqgm
eQwWKnjLsmf2/zswtJjha8ir73HC+JFUotSHs6JP3cUdtYFk+Dj8PNdFS7j4yPXt
qtNG6YCwVvhYl7hCEUTKEIHxsNsifKilYQEUyuN4YIu16/cfUiXzWorJ8eOV0D17
NoZepmaBIJfwgUdi/veaFuOMJJAmYHiUVVyFQFYaE9ZGsormcUG/0PMdOuikgUtI
gK6I0uNxOmS9kGoS9qNFvby1rS6FB/ovOymMj3oGOp2b79q+62nZdQHGzQqgiW16
JuVH+/qtBTxMc7CkS1wtdOqw0GEhN5JCF+vE6we9Fhi2YQTw2flANYC5S9UpVDYB
oG5iDyMARg0LbHK+oTe/JD5SbQi53ANRFPHHKz/KheR3fiev6OcNHvDChl4mClfX
jnmCuhcziQOAilrRDqG1DbwRteIHuva5ey8o3dNAn76V4tYkxZJFd7HZVJHKYAeL
KD6kmAqOt8UilFtdz5U08VlEHYT897koBp5iDVm0J//ko+g+W1a1HA9zOgBFL2yZ
TVtXcHq0EiNsxahpvi9WwuteRt9GQZqBLtik8ugxYRm6wq7FGIo=
=zW8W
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
