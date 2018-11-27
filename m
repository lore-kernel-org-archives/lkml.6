Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23138C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46E720873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuLZlArG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46E720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeK1Jsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:48:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46425 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeK1Jsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:48:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so16326954ply.13;
        Tue, 27 Nov 2018 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=28kfNMT6RNOVuPhu+BrI2ezJ8GwHXxpYTt5CYfz40nc=;
        b=PuLZlArGDTkniEGhlKWaJ3JjL807JjuEXJXQXo/f15WBleuwW+tbBJgdbmaACXozKc
         FmaFZK67zKcK4RLWIwPeSrxjJgPk76yBH0tnbOr9UPOpGP7yl85BSZIqsCC/UPcW84f8
         ujZNretBkK3uMnWTM07GVoWmPjLv7+2EUUuYKVv720KKA59lAi+JTCyfcNXQW7CPIpbd
         mLJwrkaEitLPH0thBPOhVQk8I8MOT23OQ1mGtSTjv3V5pd2IuCL9T1C0r6QBWP3GbdLL
         a6C9yzXnjllk9DTcH9ptzLYixOv9Dz7wapZQA934U6XVU/AiwCwl0W45ghew8Bcd8mMh
         jLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=28kfNMT6RNOVuPhu+BrI2ezJ8GwHXxpYTt5CYfz40nc=;
        b=SqYj/8g6aJzAcw6QIT9dt5wTjSHTUEtNvpaeUFtI89gAh0+sf/7zlID/gSbJjIjG5W
         5e6gFLCOUfTu3QeEQ6CyD176x+eMPkx117m1TR9OfeFxmufDEfMi/wrm5Ro4JdG8euQV
         f5hsGsZnl8Z09MU3x5/Djh78CMS61aDySQm/eOR9FKsTixMCeVUVQ3NtAjwPKW3CVT7n
         D6GsFBax2TYPVBnCkE5C/UZRFqFzU7F8ME4E/apw008ek+Ba8hiHkNoDMZhgogUJrfu4
         sxxwotfVClDXzI4D3uqcjhL2plOkcGqzHqr7HrRR3+qi7rs+SuM9+DBOq8FyzOB/lZxn
         OHGQ==
X-Gm-Message-State: AA+aEWb4pPL0akj2P+vKJOTwaHA7Z31ejAsElR3CHtRHqV8M79KdymjD
        vXqcuixVKFJJUS2z3cqTUmk=
X-Google-Smtp-Source: AFSGD/XEPd3zQh3ypybv8rkc00pUyDMNHMyUvk9FeS93+x6Y9jynFpEPv4Y98klx63qe8IH7jE8mHA==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1-v6mr34948899plb.165.1543358945703;
        Tue, 27 Nov 2018 14:49:05 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id e14-v6sm5988102pfn.46.2018.11.27.14.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 14:49:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 12:49:00 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20181127224900.fpbqujcsqwgxpwyq@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cixxykv7p6jttu3e"
Content-Disposition: inline
In-Reply-To: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cixxykv7p6jttu3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 02:10:48PM -0800, Jarkko Sakkinen wrote:
> Added the tests that I've been using for testing TPM 2.0 functionality
> for long time but have out-of-tree so far residing in
>=20
> https://github.com/jsakkine-intel/tpm2-scripts
>=20
> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Just one thing I didn't really understand:

> +    def start_auth_session(self, session_type, name_alg =3D TPM2_ALG_SHA=
1):
> +        fmt =3D '>HII IIH16sHBHH'
> +        cmd =3D struct.pack(fmt,
> +                          TPM2_ST_NO_SESSIONS,
> +                          struct.calcsize(fmt),
> +                          TPM2_CC_START_AUTH_SESSION,
> +                          TPM2_RH_NULL,
> +                          TPM2_RH_NULL,
> +                          16,
> +                          '\0' * 16,
> +                          0,
> +                          session_type,
> +                          TPM2_ALG_NULL,
> +                          name_alg)
> +
> +        return struct.unpack('>I', self.send_cmd(cmd)[10:14])[0]
> +
> +    def __calc_pcr_digest(self, pcrs, bank_alg =3D TPM2_ALG_SHA1,
> +                          digest_alg =3D TPM2_ALG_SHA1):
> +        x =3D []

Is there a reason for using `'\0' * 16` there instead of just 0?

--=20
Cheers,
Joey Pabalinas

--cixxykv7p6jttu3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv9ydsACgkQ2rGdfm9D
tVJG2g/8DPPQ8Mt17gIFkwZ5htEJKnOHRgQF7iopCqkYwEbY/EDFflNsnmrSe5aS
nl9ZBIqr/3NG5JKpnqOEIaPBLC6omChvwIfjOMjHyc3EUwOPEu3vWeofvvOVIxQK
iJqiFKzHs9f2jZrpNZDeBlzPJnPyEqrWVz8rRZB242Xl0cLudmhGxrALCdSBXBW/
QB0XDHb38X04h7/zpjEWqfELgrZEDCVhqvfkylM/CB/H1MHo/d1fI2vxK2N/bF1o
fphW+eNB4/uZKZXHAvedp5mndNSbazY3aOnooxUpHnD7FsvHO9Oh1GB6TYjZhcQr
wd4lnxbigNZQ7C+ps5d1vWRm5Y1K65wWjBkt1u96qFsXKZ57eFWFZ2MF3yahvl5V
TliSHhGrqNVEH4PT5RpTqqdV6OLi5lJHfueIkpKZ++3HcJlm4b0fQfDlfYkHRw5Z
0V53m2fRsPxsdglz5hLSr1qFtCkiZXVodHuP4YNjjKJgMdutGSW1zgo1imLGQLEF
3h4xYqgMFADpmzeX1aoQqUC47st+aWE2r4j30jnlqB9+wGv+LdsYzJfRmJccyWIz
6EYpqhUAJUdOzsqoweY9+NJknhToCStalj7nZhAzlrbtNCaUnWk5Yt3S2fs3VHJx
rW5ZRrS7ZtJ1MXy2f3BQQRBUeBWjghgqw4f8eLw2SPEGeF5zEug=
=Is49
-----END PGP SIGNATURE-----

--cixxykv7p6jttu3e--
