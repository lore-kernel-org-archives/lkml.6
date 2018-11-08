Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF5C20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxNOFn0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF5C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeKIHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeKIHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so9445568pgq.5;
        Thu, 08 Nov 2018 14:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xoPEBd/1Iqte6IzbZztfZ+anhXVKqhqN6nk4t1Ptvk0=;
        b=GxNOFn0FaTs5aefbW9QKt87Ddkq1569OxJkT0QH/PQe0eqrJjRE7WhzTwdz5HDcaMN
         h+7A+JwyTzIIOfVwmX2t0124VqaNm9J0//pzsMuNMPH5vHC14dYgeOljZAaJwNRyCRJd
         4c7fe8R2xeKY6tkfhvWDLSaSb7gsFy6W7KIDyVRi6MTlSlfewZKyi+IKLAcAZ7olmvRN
         dwJ8iWGeYZ1LtSVuz7m0o5fwZw/u9kt/2KhWaQrG+5H4SD84suX++EGVGyCvwhSC31G8
         jatsuNijDKaFQHH4Cu5eP7ZFsEabrU86NUvcApaL7xZ6GPgevSX+8V+FiYyYpwsO/RF8
         +lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xoPEBd/1Iqte6IzbZztfZ+anhXVKqhqN6nk4t1Ptvk0=;
        b=Z5jLeInR7S0Nt5ISUTA9++G0ejbFfi/+eFWC9BwLlK0nDU+Zpfs85dkb9IDqIblrrG
         eUNLtj1XlZP8Ia7l6Mw5/J/o21nNVuu3i+ftrStMb8gN0RB6aN3rsNPmQyDGyCb2WDiT
         GiJP63nVGOr4gQzRhpI33scIyKBC3hjskHGikX2/6KUMAHg7oOcFl2kObjXP2nU8oRFe
         YWYoMlClFaX9cgqdgS0NPmkAyiuy3CiEZGn4Y16v1lUxrHeYRScYvFBNk7J3XepTaj2e
         HMbnnHFan8mLN16cXpPMmEr3jFnZlJm9IJqyzkFRgcmMESyFBkQfZL4t0CrFXcFtxCRH
         ClCA==
X-Gm-Message-State: AGRZ1gKZJBkchNbLwXlUxM8HxtSt2Gts5GGZ4eL47TfNW4icory36ps4
        XElpRKKUiRNeqfUZzE5LhrU=
X-Google-Smtp-Source: AJdET5fC59lp2bbADD3w0sD3DeQpR0P5QwuNOxGqHrvl4b2Tkwj1cxdH+yE35P+Q5+WvhHcrX5t9Kw==
X-Received: by 2002:a62:2803:: with SMTP id o3-v6mr6431572pfo.57.1541714576185;
        Thu, 08 Nov 2018 14:02:56 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id t4-v6sm5463235pfb.44.2018.11.08.14.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 14:02:55 -0800 (PST)
Date:   Thu, 8 Nov 2018 12:02:52 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 27/30] powerpc/selftests: Wait all threads
 to join
Message-ID: <20181108220252.7g5jxzchbofov4ah@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20181104135325.88524-1-sashal@kernel.org>
 <20181104135325.88524-27-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="odb7vahhijq5em35"
Content-Disposition: inline
In-Reply-To: <20181104135325.88524-27-sashal@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--odb7vahhijq5em35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 08:53:22AM -0500, Sasha Levin wrote:
> From: Breno Leitao <leitao@debian.org>
>=20
> [ Upstream commit 693b31b2fc1636f0aa7af53136d3b49f6ad9ff39 ]
>=20
> Test tm-tmspr might exit before all threads stop executing, because it ju=
st
> waits for the very last thread to join before proceeding/exiting.
>=20
> This patch makes sure that all threads that were created will join before
> proceeding/exiting.
>=20
> This patch also guarantees that the amount of threads being created is eq=
ual
> to thread_num.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--odb7vahhijq5em35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlvksowACgkQ2rGdfm9D
tVKPpBAAv7TXwGMnR2M1aNjln82ZDktVhbeOiWQR50Qhw7KdSTu20xwsr4CCKrxg
zOHxJh0hfb57jwWJ0jyqzu1yG4e/WVHpJcAWoJM0OqIMTXs7+NPvo4O0TE9hRY+1
vsAO4Z/UPwHozy55xQVuFPDUnplDLif9oTqHjME3vS4binMNR+qu4/t32D5O8Uqg
8cmx8+HbK6OnnkH+VN72h6i0q+kZVJCBgBaiCwhZ7EewqZOFG4rfuXG8IYsg0TbZ
bBPwjC6b3UYlkAkPaaFPH5gcxgi7oTudqKNwUEg9AFN1t2dXKRThhky6uWuy1Sok
UOTIcCO2orXqjse7p87SFui8CLRGQq7PgJSMHA/9VOC2LwPp6zJX5EpP+IeVwbW/
kS6L+Fcb9YzCY2g6UavSfXg4CtWH7KFqfZZJu9ehnk7dHZXetTquOmokp/HDzvxF
IGX+CbP19ATbvIZbJsRDr0Dk/IbK4PbidMvheqNnF+H577+DxOaXOgZV8/4XvZa4
mguVImm1NUObFV/vNs+cVJzg/N7yw9KosTSOd/61F1NTgt0y0dVXOwL8idm/G6is
P6DhbTkQqUyxUwoQfVCGsgRRBUvUva24qyYY6fXLhgr+dUm4GQ7OOsY7kWgbZRjw
eYUgJ91G5PxfW/hLHWaok0oMs6H61ybdV7ATpQFH9Dj6zdHnC50=
=10uy
-----END PGP SIGNATURE-----

--odb7vahhijq5em35--
