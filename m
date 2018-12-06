Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16725C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C2120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcgTJo/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C2120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeLFLHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:07:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44859 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeLFLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:07:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2545pfh.11;
        Thu, 06 Dec 2018 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrIhM/xlP5eUuLKgNu2kW1ruJtamdfeClZVoyt+Kzqw=;
        b=OcgTJo/v4Bh9xJrXmxDhIVekknqqELwtqvPGkPQTXVjI2tX2ESuLPvcoGcjOxzd16h
         jzGlKx7ZqZOa6cuW8eTmk2LMXo5GGFN+r5NpOo2f27i5jZ3uaLEYGwZBY8g9ZuO7Wo69
         2u/cVVWITZ7DuDeXzmS54nxS4JBP9fi7Ka8Y5oOMd/Qq9jurUWtpBSrg/U8pGXbSsIRj
         8eVo/Pz77nZtkixyXq61wrtkxqAjs2eUvtvicKx6VGL2CmdrDNVHH/Zd1qJC3v9kYE5j
         hg5sebyAlehp4rOKI2auopTRGiimQeWpo4lhaD2uNR3IBPwnpJ6hDEwZpgBrCDSbfPn7
         0vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrIhM/xlP5eUuLKgNu2kW1ruJtamdfeClZVoyt+Kzqw=;
        b=KO+kzU9wn6N5rUNV8JcrDVrkBf+M0u39jtcZ5S/AbtaKZGwNLX60/vItuOA0CnOQk/
         IZk3f6yulNebgSd3xAsvVerHbCKj+1D4hc0/pJrLwHJLtn2XFEaA1JvGFtVMB8+sY8ON
         G340uhEWK8vPWtfB9issLodb4QhtfwKhLckJ6CYdIENeNqo18W0KIgVNJT0o84FOxNah
         zNBlp3qBybSlapXcTXO+2PJxnGzacPF4ddO1EaSJ8FcnUBdvf27pEzkBz49ORMpTRaau
         8FxF+mzRBvk8c0kM10EbzhVieNo6fdZmKQU31el1giA/gAvxNaC0rCarXNX2MjAacTCE
         W6/g==
X-Gm-Message-State: AA+aEWY9WyH9Ak6CF53cwL543hpjJGOUoMzKmDk6mV+/PoJa7wi41bhT
        +07Vaalu7hnTSBvg0lfkZpM=
X-Google-Smtp-Source: AFSGD/U3h+40h5wRcfDvc0hEezaIXKtvZ+hAk2iuW01kuGxznf39p14QJWN4Crk7s7vZq9MsnCEe4g==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr24319012pfh.228.1544094450202;
        Thu, 06 Dec 2018 03:07:30 -0800 (PST)
Received: from gmail.com (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id k15sm143857pfb.147.2018.12.06.03.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 03:07:29 -0800 (PST)
Date:   Thu, 6 Dec 2018 20:08:25 +0900
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/11] livepatch: Change unsigned long old_addr ->
 void *old_func in struct klp_func
Message-ID: <20181206110817.GA14038@gmail.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-2-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The 11/29/2018 10:44, Petr Mladek wrote:
> The address of the to be patched function and new function is stored
s/new/the new/
> in struct klp_func as:
>=20
> 	void *new_func;
> 	unsigned long old_addr;
>=20
> The different naming scheme and type is derived from the way how
s/is/are/
> the addresses are set. @old_addr is assigned at runtime using
> kallsyms-based search. @new_func is statically initialized,
> for example:
>=20
>   static struct klp_func funcs[] =3D {
> 	{
> 		.old_name =3D "cmdline_proc_show",
> 		.new_func =3D livepatch_cmdline_proc_show,
> 	}, { }
>   };
>=20
> This patch changes unsigned log old_addr -> void *old_func. It removes
> some confusion when these address are later used in the code. It is
> motivated by a followup patch that adds special NOP struct klp_func
> where we want to assign func->new_func =3D func->old_addr respectively
> func->new_func =3D func->old_func.
>=20
> This patch does not modify the existing behavior.
>=20
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Alice Ferrazzi
PGP: 2E4E 0856 461C 0585 1336 F496 5621 A6B2 8638 781A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+h5loMdcUfRgx4r+1IFYAAgoofkFAlwJAyAACgkQ1IFYAAgo
ofleMQ//a5bAaJIVa7d2BY/vSKA3JMe4dW1vXNu+wDI9msj+uFr7ECBmacvdoIsy
xZVentWe336ewwinsCS5IQ2MLWk8wDYWWnpaO3CNnCL1p9cmTiLrG6jvHI2Q1rL9
ac9aYD9d60HofN2RO6aaznh4KPlajXa8ceJftSJAbwZ2PMNX2L+dAZV+myRRC5q5
YTRIC6uvwkCqdXbZzd0HlBGYaK1gARDXqCZPna2RRS9yiOGVo194tY98m+cyHo5s
QVQndYvBbo1zJDFEcrSnNKQhdYhxQJ7EZBli8KMhn8NlwM7MVj4cqr+Ii6/tX5vO
Old1h5U/J3TI8aUkh30R4m2cJNEZnV0//ROmFGHfdsmg5/S+o4idxOLeeX0UsERM
2QU0zhMd631iWty1RWUb+p7MuAeLzKvlCO2oNIrK7TIno459U+y9RbJiDWpR9oZz
AMdxyBAtuU9sURMnD9HKGSXK2D7pOz/xtmSvyEHokBmqt2qu/CVM0HjH3EO+9oGr
GC2Y0ftsY5K61L5b3gOqVoQpt8EKhQC9vArbR54W3ggRt7oXWWi8ce6G7kuuNSA4
7jGnPLS744i2tsMYKLKzMTQRcpDvb+svghiIWi2ZCPdrAxr4Y2oN69ljJE2CmHgY
KpBfGB8xQd7BXPOhd/Bh95ypMAtd5TMEAlzHck6EaEnf5cmtCpE=
=25iN
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
