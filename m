Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC96C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A6620873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwP/Mfvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A6620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK1Jwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:52:39 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42767 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1Jwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:52:38 -0500
Received: by mail-pf1-f176.google.com with SMTP id 64so9117882pfr.9;
        Tue, 27 Nov 2018 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AyOc1My/dt/Ck8Gv1XJwTK8IgtOFiMnAyigJ/HMreA=;
        b=WwP/Mfvs5KCeO6ZkqVtFku1WJoeSq2PWAQFsqoAKM8G7xsDcDz8VEr4jwTCLIuVZs2
         Sgy3MZZWWuQjiA8CUx3V9/mzdTKbyH5wLzsy5tQP8SeMLstmFRvlAUyYn5bP2RqWvjMr
         kfJGuF0wEC8WpVwEzHty06nJLZ4PMFgz3ut+UnOCGvAi53lw8C52nTzP+lnP2s5ONjrg
         CUUMCBE+XeV4hBGAtcZtCSPNB6we6LUI3UFcoNW8q1wOfWXECTdERkJokkK8M1iLjII7
         m/RE1/ju+EJBnbsHDbP71lXow7C09hhs6BGAJDLF7mbU4xE4MpT1y0DAhyBDoGt/aAzm
         YwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8AyOc1My/dt/Ck8Gv1XJwTK8IgtOFiMnAyigJ/HMreA=;
        b=M40hSjWcKOs+S/cEsqRGcE4tw9mLYCS3ghnTRM/vb3IF10OCrGj31O3YgJAMYtL9Rj
         pVH9sS2iNqYEUvNkau0RkmbtEn3zTOc36Bg3x9tyqm5fL8/xjBkLHIStYU3ky1gksV3d
         rfBRZEBINSfU0D+uReoq6UfTbt+La8QZ5paHFHmrtAp4YUBTw4Dfh4xFdtyXIo7uqkgY
         L/ErefP6+k26fn2iZ+4+dxOcZIRYgJWlDqtks0AOo3TlO0IbS/RHdxLIo2N0cRbl0Kt9
         +9S8kSxgPEU7KLL+9eXgQsto5KnrbJJE4oGjynvkA9iMnDWLSqLGxEbfjs7oVt0hvb6s
         D9vg==
X-Gm-Message-State: AA+aEWbAjmfAlr7GV3xxS5Y/F2RG41LKRijUsF9HDZt0dmrQwF0syO5o
        6LzGD+HCTaRzox7zVo2onIo=
X-Google-Smtp-Source: AFSGD/WWHzEqapUJzLM2ffLVDyE6COEKLi4Z15bg8EOO6v2mxobX3mi4ufdiZUVUojOitG2xVCCigQ==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr16134313pfi.164.1543359192219;
        Tue, 27 Nov 2018 14:53:12 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id p9-v6sm6358763pfa.22.2018.11.27.14.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 14:53:11 -0800 (PST)
Date:   Tue, 27 Nov 2018 12:53:07 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20181127225307.3wc3gd7zmfauie6i@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
 <20181127224900.fpbqujcsqwgxpwyq@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdifjrdhqbntdhag"
Content-Disposition: inline
In-Reply-To: <20181127224900.fpbqujcsqwgxpwyq@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdifjrdhqbntdhag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 12:49:00PM -1000, Joey Pabalinas wrote:
> > +    def start_auth_session(self, session_type, name_alg =3D TPM2_ALG_S=
HA1):
> > +        fmt =3D '>HII IIH16sHBHH'
> > +        cmd =3D struct.pack(fmt,
> > +                          TPM2_ST_NO_SESSIONS,
> > +                          struct.calcsize(fmt),
> > +                          TPM2_CC_START_AUTH_SESSION,
> > +                          TPM2_RH_NULL,
> > +                          TPM2_RH_NULL,
> > +                          16,
> > +                          '\0' * 16,
> > +                          0,
> > +                          session_type,
> > +                          TPM2_ALG_NULL,
> > +                          name_alg)
> > +
> > +        return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
> > +
> > +    def __calc_pcr_digest(self, pcrs, bank_alg =3D TPM2_ALG_SHA1,
> > +                          digest_alg =3D TPM2_ALG_SHA1):
> > +        x =3D []
>=20
> Is there a reason for using `'\0' * 16` there instead of just 0?

Nevermind, I keep forgetting that the * operator on strings performs
repetition. I've been programming too much C lately, it seems.

Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--kdifjrdhqbntdhag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv9ytIACgkQ2rGdfm9D
tVI8YBAAj8anlvZDjgpEaTmqa5oicbayoo+Zl5VmO6NgWvuPOs4DBx7PDeBlCUl2
qF7CYw8aWlSgW1XqsZQIrP33cnzp7rD4tmGuEvtx985e3o/zuru4e0QEtBadPA+G
6Bijx7Ba/9ddE4lRa8bSuN0ePEYWMKI+RQ9bPJEuBlMqUbugsYOP4BdZQMYhLOHB
mFqmCgOjIOiW69ydAEou3rLaco4hjUh2O/UmCeY6q8peEzPz5Hmb+oy1y/Q2jcMA
PQcFX7Ngwmxy2zLEI6oCd50kI1RhP7XeYOF9SYfvOAeK08aKsbk1r7/zeVM2K9bt
dZhSx6fxl0mwwr755V8qjeiArDkmv5ugtqySlWo0v23kbK1lBFsWIri9nOygCVXU
Ns4fYBa/d4AYTJGKsV3FA8WLWHNc039iMm5AjPPjbUHNzgUw30RwgGXwyLh/zZdo
KtmhtSr9a26w7IHvffxxfZJRjJuoZH27n9/7KJAxS4GYI1YePxZmg1mOmY809m+e
xr3XiESPRh/1SwjWPYdYvrAAJeVHlDEtnceDRpqr4JBBDB7q/ZdkrIkCYqElw2Iq
zbFhiN3G6+FUB35WWzT+TBD4AzVSZDzwXqoPSn9+POWmtJZqO+CjkMmNOjO88LgE
29HJPFu3nbg3z/RTN2AVVDq4fceMHFnv/91Pc7ODHRLWh/lrMF8=
=CD+q
-----END PGP SIGNATURE-----

--kdifjrdhqbntdhag--
