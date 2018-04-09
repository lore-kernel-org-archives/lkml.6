Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1942698-1523305613-2-8318595427624052781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523305612; b=S44ahwwzwPwtU+NNPnuvEWcriNnhu5fMmv0utJvsiauxaKKfl5
    UeR+/3hO/RMrhjQhedrvOsej50hWgpM6DXOZqRA5C9R8rJji7MBM/byAiAUC+Hjn
    2ub2cvzrfWh+rFvuLXQ3oLV6BGXhiUDbN8pTu305UY24s3TDkCD4jRwjyBg7EcKN
    QRHpSpJ2EjxzGLCtsboBROv6J9wPuzHQf/HWvQYvRDUMlH7LisE1z0mMJEXuxias
    Hk5RLOHwa8UPydhbEt9bIdLb6uIceW2tyJhGc9+UV/phHTr4s6O2g6839AbhgAJT
    EfhdrTzx9OfPd9MT3IsSdjpT3vb+2SxGb4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523305612; bh=uuzBIstw5tGJ+WgoNcqruxBD50Yrgk
    K3zNTLDeZST/c=; b=iCrogXdWhDoVvwSlyBgDAHenWnT5wUiSiG+d1YJXrdEzps
    OKFHn7u3RprG50tKyrX5d/dY1fgPWa4XX+qSL6HZv83UZxdkxrMvKOYSsjqpAzdn
    Zy1tZ8bfMXM+IuntMYpNHUYNIi6sQ/pMO+O9of3bclIM0yQb4Thh/v2rLoZy0EIV
    qu14f3chaBxCaB/oUQ6sdeiZZjTZdLmhBZhf/ARGe1Q9tOO407qLf9lyVjQIuziz
    ayxMS4EvzbIHVRPu15Ib62oRl1gJU/rrSh2MsQT7JxPLmfqtfAND6TfDhqR34Zkf
    8OiMHRa6+WhKlBxrvJtBXY5Eea3gBJpn0RSKQa2g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLVhuL48oNz7xTX9+f91LeHg+oOpnIjDadC0adpZoTleTSvhiyGca6qXqwQKv2F50AlcAplPdG7df9+GCeRfODV+BIMsMgUxAdnv6hdQFFeG67yi4DNr
    CUdR+Alo2T86dWNvpw2gHGP/cce/UnE3SIkiYD2eJM0J9cOxwwESSRWlGgMhIglbmLSw4MhsveOzPUHbB2sGd95AY36C6oF/upr1mek2ukoFvmQDxVK+qFwA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zAyngx5bAAAA:8
    a=H7ZmIP57pRhpxBjkKAMA:9 a=QEXdDO2ut3YA:10 a=5W5dxfQKieNU4hkFybMA:9
    a=ONNS8QRKHyMA:10 a=4LA4qAFo6bo561LpWNDU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeDIU0t (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 16:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753480AbeDIU0t (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 16:26:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 9 Apr 2018 21:26:43 +0100
From: James Hogan <jhogan@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Message-ID: <20180409202642.GD17347@saruman>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
 <20180409002239.163177-160-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20180409002239.163177-160-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:24:58AM +0000, Sasha Levin wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> [ Upstream commit 669c4092225f0ed5df12ebee654581b558a5e3ed ]
>=20
> KProbes of __seccomp_filter() are not very useful without access to
> the syscall arguments.
>=20
> Do what x86 does, and populate a struct seccomp_data to be passed to
> __secure_computing().  This allows samples/bpf/tracex5 to extract a
> sensible trace.

This broke o32 indirect syscalls, and was fixed by commit 3d729deaf287
("MIPS: seccomp: Fix indirect syscall args").

Cheers
James

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLzIIACgkQbAtpk944
dnp/EA//SDhwZXbydTT8VuWsDZylcxmerobSmLfJ5EQPDcXUXH423Ae7UsznJ/k5
2d1ag8rbdB1VOTue43G8KJq6q7fXIp8MhO8KkcNvgBJrojbCoUCAoSKyeptCB2EP
AELPmibm2j+TPGc3JgnzHzB+GMKTjcpmEv0hSG4u+PEqWQOAMHJhcHGEc9eSaOry
ELGeogq44tITbjTEKKDenEv8OJ2gfb037e5deBNGcAWDbi0g9jF8O0wi4FK50G3v
Lj6Gnf/DC2HCJ8KxemOFNWzkgJ+/xu3flP96uR85hq3UnjMGK9qrTml2mg4VsIeH
lwmHoTRlpsgxYJrXI1KSTytKw725OhLHp+5GIYsyTrjOdUo5UZt0YmIW8y7Nt01q
gxjx5nYbTvVPzabUAH0l1RL6skEgSB6QvP/JnohMtDJ3ex7KJM/QVi07KuIvIVJ/
qSFXbhui8r4ALY0IOvLb5+YT88hzVBLxa1/ujdRr3WSjvvShHPcTtXUqwOAXVu2V
XvWJyaZOGzCo3UqZbxOPAY0nuB5NrO1wlbhuWlBfOi13+bD24f2nPUDgIvMH8bP8
znv1WRoytoIjBJqqeQWHLxU7BNmnR4f1s7ApVK9PBrDwhRNUnBaSH5D72clPUK/H
/Fpe2lJ7Z7zs9SgNW7plUu9wmbbY5x76jDHtHlKoD4kzW5RpE2Y=
=8wTE
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
