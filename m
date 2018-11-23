Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3F0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A61A20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkLbIQVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A61A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409955AbeKWXbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:31:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38219 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390787AbeKWXbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:31:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so10179599ede.5;
        Fri, 23 Nov 2018 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K8TEbX5OIZaSbspx7xQQO+BZECzzlMZN9fOc3RjrOzg=;
        b=PkLbIQVYj9/xx7euruhyAXSqDJpCJyUA8aht/Fafi/5RA4Pd56uM87+1V5dD56smlk
         HJnBa3misve2BNHYMIKKB4tRgwt3VDTWb8MgeZXCMDrBqjvbVZQV8XDq9QjIWWn4NhrI
         oewRUURFZMIjnMTYHxNPeWsz1AACrPhB2ZChHRsDmtwuaaWBDO6VsiDCIx4Whftjt+zw
         fNJcac1KnOIdzAVBIQg28cBhELnztwI0LdLTAKu4/V9Hdsi4kJIc04PY0M30jKwjew/Z
         K6akKAABsxy94irN/1mU++oyA8SQFZdbbNyJ58Ou855Os1ENE7/XgeFXpAs2+Ab7qcnP
         VHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8TEbX5OIZaSbspx7xQQO+BZECzzlMZN9fOc3RjrOzg=;
        b=RYsknU3fzlwyA3vp96X2mMC9AslaSGFhgHrzRxvVnSwskd0FDoBquGH25UQ4p7WbP2
         yeJC4QwaVVAHVjURPXSYPgvVXpcpm57U7Nyd3/5n2IY2KqqROfkDF6yuJSkmoV11eiQg
         p6wmx6ntPg7XRKrqu9CBUR1HGoSudOc/o1vx9oY0tWH9XLhZ9+Rp5z++bTiaV60bvwxz
         bnjQvDa25qTORSpwAUMzEb4Rh+nx5FwuLVSG6ijmsmbKpcSAwgkYsZD4kKIdGOP4cTlC
         baKBafnEn9jZmOrjVyGf4YwSFBiVgKdQVG+l7uPZIR0QU/bdaDGdSUsIkNl+fMll/H5g
         PrCQ==
X-Gm-Message-State: AGRZ1gKDROW0Q+vGtkb8DSHV9gKK9/gBGV5Fp9xB0nP1z/6uqz1ljxd1
        3onEQuBzJjxtPL+xEUUV3IA=
X-Google-Smtp-Source: AJdET5eUzf03szQM+mEX9l6GYqhendRF2hixWB1AFjyND4/dTGZKEIhTgUrWf6cu5J7DGgIliVOmPA==
X-Received: by 2002:a17:906:5a84:: with SMTP id l4-v6mr11475135ejq.229.1542977251863;
        Fri, 23 Nov 2018 04:47:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z50sm10908706edz.1.2018.11.23.04.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:47:31 -0800 (PST)
Date:   Fri, 23 Nov 2018 13:47:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Rob Herring <robh+dt@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: Use correct vendor prefix for Atmel
Message-ID: <20181123124730.GA21651@ulmo>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <374af1fb-54bc-ee13-b4fd-616c2fe0746f@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <374af1fb-54bc-ee13-b4fd-616c2fe0746f@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:40:19PM +0000, Peter Rosin wrote:
> On 2018-11-23 13:10, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
>=20
> Fully agreed. However, given that atmel,24c08 is documented in .../eeprom=
/at24.txt
> I think it would be better to remove at,24c08 from trivial-devices.txt

Good point, will respin.

Thanks,
Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv39t8ACgkQ3SOs138+
s6GgpA/9HMnlBtqOGEZIOhZDI70tCul3alKe0py84MhZlf4lCr5PH3+znwzR+uVX
86VYxrs5iDM2oXz4lbXZ6O4zebMbnEIozyni7p2CqxgJ5Mk8z79ZkuovjIqhc5QM
9bbjuPbIiCh/TZflkm+1ujRA/iQCR7waRxBMEC5KIcWfwfA3Ddax/9TGGSGqvZAn
J3K9OhjvFIHl25lnEFCFKCj2HDx7jQp1+fZBwHtkMtRdYRT6toLedEsCOHXc45y0
W3vhp6OQiKVAlr+4UdcSuL53t6LYQ2l08IhC7B6ERY0XwvK5QOP8Ky8nj+mEZNjM
l9vHwiCoCYip/mHGHJuCFUdVXRz0RhRt3yLjl3fG/nMojapj7XUGVoMoT0s+4nxH
pvpATELxaevAsqEorvI99km2OYvOOw7Nlljq97ag3YjBn/cirbuwI1Lc5p+tigPA
TB9E6CFZp3gXtDg8MRa4yNphZeHvJPbyCKeAVMKUKksV1BfLqWVbGD6sJG59AjDu
g8t/B5H7335E0QzVtHjNntAnh1XSiwirJjm30nv9T/o5Oai6irurf+8Ap63C4hoN
T43ZGUDy5h9aNxk6G5P1Rsi9akmm+1Y6bb2dAyi6wA/miqfljqNgfBbISJUpRcEr
fi30H0uZnWySPb6eR3kwRX5i+tENLvLuD1sGGmejIpOFGTfRSec=
=63b1
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
