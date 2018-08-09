Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16283C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8637217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0N0Hcd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8637217D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeHIMYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:24:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35564 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:24:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so5829068wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vy+ixb0l9D3jUjo7yUJ7L/ni0TdyIian7AsJ6AjCBNE=;
        b=K0N0Hcd3DyOZv3hKcWXe4Fcwz8NEqJSLxqNJXKDri3CVmOrYH4dC3eMq++fm9s6LV4
         YGUeQ1eVzzS/cAZ2O1GuRFJa16UHiPeujjJGNUDPOYgxn/eQ8UChsIfPsva1wdwNNHIB
         +X5Zwn3qGFiOxht1DOOIoDxr4IiIX/EPsb2r6WuwHdSrZBaPn9Uv3FnfUZ1mb2lzTG9V
         BqKnRXcWME4PeGYEE6FUSUuVYpWbO1b2jXlnypPe63eaiCdSh9h0MXaTVdwf3Xy5EQxw
         GClj/qq7Kwrr/pGqPYV59IvFNCagX8slbEFUFKegIGdPHzU09fDE7fJNYvZM3MWO5xqw
         oX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vy+ixb0l9D3jUjo7yUJ7L/ni0TdyIian7AsJ6AjCBNE=;
        b=qGB6Oz3MBEiXa3ocetysKOzFhxGc4q0YaiPQnJmEsEgdVanqGyNU9g4/hDZUwA8dom
         NvnOmpQfIc5Crkdr2hEH+qQgqNY8ciC4LCqi9sMQIUZqNg8Z21ZHI81fpWUzDTBxxI8R
         3CU2q7UFSkDEXr8ekOl5pIA3p/g6XtnAMSK5iqSG9iw2stLFS2yUDwFbqTlbpIBY+WSz
         Za6pk+YgF6HvmkNBNHA9G2inTSVbAgfR7X02aHjbz3Jk+uCVx9k9+ET7MTGTsW8q8c4K
         NC8THaCAaDk+uVAo2QsPWnbE6ht6Ypsy+9NFF85pJDo6aEQu/wop8ZidUHSLk1DTVbTY
         y76g==
X-Gm-Message-State: AOUpUlF141W5AurNU+iSoqRvhJgznucnmp8A6BygA/7kOhd6NccyqTKU
        JntmN2RCQdRS8R0jnEOOWcM=
X-Google-Smtp-Source: AA+uWPzmV1QoPBkV0KlJa22FJ27XW97izRmn5AdeBbBjYNOM0vAIkPkg+rgizPGZRsztvbArnV+ilg==
X-Received: by 2002:a1c:b286:: with SMTP id b128-v6mr1052685wmf.121.1533808799071;
        Thu, 09 Aug 2018 02:59:59 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id l15-v6sm6326782wrt.67.2018.08.09.02.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 02:59:58 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:59:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     airlied@linux.ie, Jagan Teki <jagannadh.teki@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: simple: fix -Wliteral-conversion warning
Message-ID: <20180809095957.GA21639@ulmo>
References: <20180615223749.149073-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180615223749.149073-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 03:37:49PM -0700, Nick Desaulniers wrote:
> Fixes commit 8cfe83419cdb ("drm/panel: simple: Add
> support for KEO TX31D200VM0BAA")
>=20
> drivers/gpu/drm/panel/panel-simple.c:1250:27: warning: implicit conversio=
n from
>       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
>       [-Wliteral-conversion]
>         .vfront_porch =3D { 6, 21, 33.5 },
>                         ~        ^~~~
> drivers/gpu/drm/panel/panel-simple.c:1251:26: warning: implicit conversio=
n from
>       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
>       [-Wliteral-conversion]
>         .vback_porch =3D { 6, 21, 33.5 },
>                        ~        ^~~~
>=20
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Alternatively, should these be rounded up to 34?  I'm guessing the
> current behaviour (truncation) is correct since that's how the patch was
> operating.

Looks like this is a duplicate of what was merged as:

commit c9b6be7dc13e2f87592ee4c9812cb450dba484d5
Author: Stefan Agner <stefan@agner.ch>
Date:   Thu Apr 19 23:20:03 2018 +0200

    drm/panel: simple: Fix data type in KEO TX31D200VM0BAA timings
   =20
    All values in a struct struct timing_entry (every entry in
    struct display_timing) require an integer. Choose the closest
    safe integer of 32.
   =20
    This avoids a warning seen with clang:
      drivers/gpu/drm/panel/panel-simple.c:1250:27: warning: implicit
           conversion from 'double' to 'u32' (aka 'unsigned int')
           changes value from 33.5 to 33 [-Wliteral-conversion]
             .vfront_porch =3D { 6, 21, 33.5 },
                             ~        ^~~~
      drivers/gpu/drm/panel/panel-simple.c:1251:26: warning: implicit
            conversion from 'double' to 'u32' (aka 'unsigned int')
            changes value from 33.5 to 33 [-Wliteral-conversion]
              .vback_porch =3D { 6, 21, 33.5 },
                             ~        ^~~~
   =20
    Signed-off-by: Stefan Agner <stefan@agner.ch>
    Signed-off-by: Thierry Reding <treding@nvidia.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20180419212003.8155=
-1-stefan@agner.ch

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsEJoACgkQ3SOs138+
s6FCyQ//bVHrl+Gzj3ilKtzK0SyWlW+cdLwqsfM1QGEVMmPl/+X/v39JLeL3sPR/
eLZEUf9HD2kaDXVKsOyBlD6G1TYnOgh0Du3qKxUBHvUaIMpOVozDctGKFh1SE/IX
gCevfcbGn7isq9GvCdHMWrerLce8+6QfYbh4hCIRXT+CqiEo0BtsJHb7u/g9QvTS
6l0Wfq0pw54CuLUNLDol/XywbIxaiv52kis0IM31+nUTaAL32+PErq6+YQdNMOXw
TyLmDjZ6m9PJDEct1cB+39IFApeAs31e7sG43hisSGC9I6WNtrzn5u0X7xxmwzDV
8If5uN7wA9Mo5seZDK4TMYFZgduU+jr5/I2/17NVsuTXbW143XwnaPHerODvfosv
imFTpOCnjteTHX7zNwuyT/HWB6OB2mSPXuZwOrJEAPmkIKkyY75XKHYm9f4g+9t8
nBtzOxs/9l5Rc2/iHg5d56WZAO6C+F9beNRbDjp5LcOlsGAutOA+PfTIIHQ/nOiF
c7kqVWHueHiQ5sTRakxajnmbel1zgnTaEZKz+Iqm6eMFMGL/x//kfmczm78m7joF
LV58eSKGmPZ5QZJ0IOJlmHsuPWFX8Q97S+XW2seh9vTbFlifMp1PlqeRSE3rEJSU
I9ueyA62+EZ9f4sGfFXBa4nSuOXEvqBnDe4ytj51E1QtdmWkdLY=
=NqZw
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
