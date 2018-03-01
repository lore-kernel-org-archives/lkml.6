Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2993705-1519911871-2-14877424032318054700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519911870; b=TmlkaDAGXRCQUT00pgPLd4OMP8aIylwsN7UUGEYIBr/yV+W
    GsB0GXhvobJ4OFI2ljiBs30fc/aD2w8TCnxp2BOWYT5T+AbT8y5t9utHM29yIsjh
    HuDhb74i+DGql+PzwxDPauv4HcOqu78uBQdlFgfnpSYXOsx7Llt1K75D8gDfU/QA
    zp3Nk524WRrpFXLGEpGGO/V1XYUYFNbsril8+zedf7PIptv117LyCLpYGWNOSDoL
    0TOc66TfeXA2quNsWY/TSIWMSTy1y/mtjR+NpHT59l7q4e36yGS+2oHImqJFKM16
    0B5Q0NWbhdsDxMRcg0QdL+dPOoA6KqRfm6K0rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519911870; bh=tm954kJPYCOAEOq0PjxuXncDRG
    D9D13CQAO5gFzF7SI=; b=iFn0IBWFIPWlvmtUXLbKWiPfqVu1Gr0RrdZtONKSAg
    gRSYAFat6FrFbViN8so4C71mTVRtqq2MJzt6NxKFbPxVoGkuYzwBLH+twqGT7bLf
    9oyejOw8KBuMba3r4Y31KGWQAMhLDntDW58UbXnfA3A6doX1sLOfIgF4KpYoba3N
    CjYgn9B4MtEuXwcdu9bZOiUP943Vuj1Emu09WoLVfu3Dj908MQeosbo/7I7TCkKh
    RWenT5stdugOvlG2lpKCWNSVmzbJPX4eE/HhPGcfxJl0xeYROS8ka0Dd9hxHG5HY
    QdSgWswsGMD0JeBdbhXHCq0SDKx2U5ib+gve7r1OzKQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030748AbeCANo2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030717AbeCANo1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 08:44:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867E42177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 1 Mar 2018 13:44:02 +0000
From: James Hogan <jhogan@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.16 091/254] MIPS: CPS: Fix r1 .set mt assembler warning
Message-ID: <20180301134401.GQ6245@saruman>
References: <lsq.1519831217.271785318@decadent.org.uk>
 <lsq.1519831218.652977295@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
In-Reply-To: <lsq.1519831218.652977295@decadent.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 03:20:18PM +0000, Ben Hutchings wrote:
> 3.16.55-rc1 review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: James Hogan <jhogan@kernel.org>
>=20
> commit 17278a91e04f858155d54bee5528ba4fbcec6f87 upstream.

You'll want this too:

8dbc1864b74f5dea5a3f7c30ca8fd358a675132f
MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout

Its only tagged for stable 4.15 since the one it fixes wasn't tagged for
stable.

If you're going to select patches for backporting based on Fixes tags,
maybe its worth looking for patches which are marked as fixing ones
you've backported too.

Cheers
James

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqYA5oACgkQbAtpk944
dnoCAg/+KTDFkcVwtPk3I4VT7ZMasy/wlIdy+6qCZwo6ErA7Ao32wQoEUm5Mh5jw
0CH7F2+iSftl6SCZ0cASnq9EVkK5qSdqDmjh6rdeJQAGxaOaK9ybMPQBpK1URwoc
TlfJSAurtgwqL/QPsAwKJSrUjX0HInBlt0sl6+cpYW8ToocBQZhL4iKywyfyFKeB
ZB+0pNHDnDcpy8a10ju8iqfXNDebZRcEunD2SumDw3Ccn5t+mQ87ABpUwhX61G1J
KPPvLJcnQ77pa9/P7Gi4hE8m7VbhZcaRCcPBzaV7UaMHKWxnK07A4Qbp6uSMGS2G
z6YAtIMzbBdGdB9Yeu6iyVLrDUZMSU3ctRu7Vbyj1RwPmM2KJ0cUaoiaWFSbPGtX
3PdwI1RoWiFF23rBlxQLclY1KI0U8tvB7diWX89COoAbHksk7cCNJCkBz0W1q5YY
M1XTl3RLmboGQRmIms0mTSsv6N+KWL567I+02OsnzXyopQoM6fG3qf//InwmLHfQ
SoGgJWXAsnn+l4PDZQlNrH+N3VSibUavdIomWpLouBSX3mSY5loe5aK0LD7IP9T7
ZV53I3nwJb8Ev7oaKs/kGVZ/DSPsRS937NB+ps6UWgcafPZDH6cvd+MIVFCc8euJ
2IOooTEES12UEM65n0X+gzYbBjYJ5uVRPTFKwpxzh8Bt9BimLoE=
=zDIT
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
