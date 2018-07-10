Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AAAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnn/wjq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AF42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbeGJKks (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:40:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbeGJKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:40:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so14063793wrd.4;
        Tue, 10 Jul 2018 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxRHoq3/jud9l0v3qBYfCoV2KnlscAqLcOLZ/54YuWs=;
        b=Xnn/wjq+t4MnJ1F2yokSOBTMcbIJMjMAwSgLYllcZGqGUDd/QniFGTHEPzEr1EACws
         ENJiEdi6YB9qbw2GyQaYdKrJIq92yeMy4xt16BTPjimPNKExbYrT8wOAgOO8ZXBU+wN9
         1ypV7UBaDjYsLLjAvSSqUyjhERNw0THyoBj2YQ5EmBh39rqQjFh3fxrE0EjDTZlMWmXj
         +fJ7+mOv6LVA8/nH7bG7rx4U6eNHVHcd9z30QAJ9r0L0Ik4MtMhUZ/JbQPXlnWio785U
         5PEReS9051IjqBrvKgv2ZlqSnHuEXTcaqgWr7Vo4vyuvXZcvoqiVgNrm9nawKCmgBdUW
         T7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxRHoq3/jud9l0v3qBYfCoV2KnlscAqLcOLZ/54YuWs=;
        b=RJEqoUWjWcFsyiunv7/Jr3SrsvahJuOZsGqgomY2N8fPMbSm56rRjjz8HjBtIpBo8m
         ypiZqXSxhgRSioVC9EQmZrjUGgEsB8YmV/xKrfAPee1P+OXSGKsR5Sa3Herwt7TPb7Nb
         xvJHkElUcPeCV9I38kiO4IwOIYnHeIB0Td8kgI7CqMRHHw6okWZLD82SnWoEU0lsun5F
         YZn4Qyx7dWs0DwIR+DsPC7Sgz2L3VNUBabYmp9ApBEgvv6Yp4ffE6MIw7EkDRLdsTBsr
         wESrJOvKvGB6WFmyVx63WL0njsOAYg4sjTVP2v19cwuX+ntgL+EO+Hnu8iJ2Rlxalnvy
         iEgg==
X-Gm-Message-State: APt69E3J2Aop8O8Maq0OsM8Cx146yIMLLWEjs00s87hFZ67CoY4vWUO3
        ZSsHDSxlgDoU/KavCf4uCKif1w==
X-Google-Smtp-Source: AAOMgpcgosqCoKVW2BjArKQlaT6xiKFwVOF7xa0jV32IN0ix5XzdCbgOScQqGQcdBGmipIFFtSnitQ==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr16771831wru.64.1531219245084;
        Tue, 10 Jul 2018 03:40:45 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id l10-v6sm28273434wrv.23.2018.07.10.03.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 03:40:44 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:40:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add DataImage, Inc. vendor prefix
Message-ID: <20180710104043.GH1504@ulmo>
References: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 02:41:29PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> DataImage is a Taiwan-based manufacturer of LCD panels.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEjSsACgkQ3SOs138+
s6H4lw//dKcbehB51HlHzjmDWDA+WU6I6J/Tul8lab4KTbUnEDomqqMSnFDk2QbJ
Lg/FxidKclveZUdEPOH8whbO+QnDephWDR1lHIeMq2Oo6WDQZmu0ZcSveH+hr3s5
6Pk24hT0LFccd93FK23vOKSdHgQwoagGm0trdndGB6jwuQvjQYhTrBbKwGBLuw+y
axe5SYAeB2wZs60x8s+t8efXIL5FSEwDzeApAzDB5/iW5MWg0bGqzBh47sAo75p9
YGBhvlv7vOj7f2R4d6g0K4rL2+ftOLR+rkJ4F77vMB/vHvw6zYzZz0y+C+8qN6Dr
gFs1yErBauayV54RKX9dVAvDHVeQUjHTc5xiu4k33oX4TlJSAqgpRRqLBVnMtw5H
pgcydp2RSEq09tcbv8XQNW1t/AFdMDl4wdlsli+8uNPUf5eN0+0viPTHRmd86W/M
eLrxMSV7Gt3e+HkWa11/eZU7zEJ+1lLr6YqB5i1/QpH8OC/xxeLd2ppQNI777VXG
3XficI4AGAro0ngMxaBBzp7kwpmKBsOb+3tokmQBTN81xp4T+6FMccT4/IGqzXOR
ReI9sF1tc3CpcDK9xVJSUSJ6PORXhqkZJfxNSokKO6KqJsG81P5Hqohd/RQ9q6Wh
xt1xJda8xJSYMRmjL/xpfGAuH8o3T93WdNIJ9cCHmOZZwGaDEA8=
=TSH6
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
