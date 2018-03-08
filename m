Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520493015-2-8687017823238267523
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
    t=1520493015; b=TgYSnoLjrIME4T0fdQF2nHzCuF28aRwP2nOerDll9kki7c4
    2m8u36D8AP3b6e2lJcdZUEmlKCTPGAt5wWOiT5jzaVCAypMQoduVxHFhbpjKVugP
    tAXVENW7Ih872eg200LUADt69TPa+dvuOa8uJwJTDNzWBGsnD7nFmAMm0Ix6d9OV
    mD2A1/mQ/pmSptNRAtF+FZChHzW1VnVsOoeh7W0ljrZ+0RJBUNPP1VVgJHNu9mpA
    XS10wwnXa6Pyf6+0u2Sj6scH3UPLz2bKbg4Z2XrMrCaDKFHkqe9T+iPfndcUnbnA
    xiyTVvMsQWg2mqzQ/AfTd8yKfutw0PLH3xDZ2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520493015; bh=vzZxQLpqSwe8F20e0Gxjsrm7vf
    jGDHU9PTU0+deMcgo=; b=kwQZf+hjSrGWLvuIqIXtZpuWNLvoxo4aEINAjvDznI
    Steowz+3cR7uC7rWmSn1Sf/H8kQLmbYNHrz3vHa0rpLu3BS7aacFeKKbScQAoYtX
    hQkgKhzGqZ87JvCYXnYEUhuUHvDcEtcqT3XKXXMzuzdDUucdmSaA1dcd3qOH2+NT
    NwmhDjzBQ8V78rA3aessw6en25yxzFg1tacFmv6DS17SWimnHXKOun/aPU8+vULf
    F490LrRb8Ay23MaCp6eM5rkV4ETD+emgvduY1Nt3TEFuhZFnBJyKCkiND1jYYCTM
    VIcBSCeupUF3DWUAolXXdTtCfO/aeZ6eqqkkNYb1cnhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeCHHJ5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755224AbeCHHJz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 02:09:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6685206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 8 Mar 2018 07:09:48 +0000
From: James Hogan <jhogan@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
Message-ID: <20180308070948.GA5187@saruman>
References: <20180307140633.26182-1-jhogan@kernel.org>
 <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
 <20180307202511.GT4197@saruman>
 <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 03:19:11PM -0800, Frank Rowand wrote:
> On 03/07/18 12:25, James Hogan wrote:
> > On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
> >> On 03/07/18 06:06, James Hogan wrote:
> >>> Quite a lot of dts files have hyphens, but its only a problem on MIPS
> >>> where such files can be built into the kernel. For example when
> >>> CONFIG_DT_NETGEAR_CVG834G=3Dy, or on BMIPS kernels when the dtbs targ=
et is
> >>> used (in the latter case it admitedly shouldn't really build all the
> >>> dtb.o files, but thats a separate issue).

> > I'll keep the paragraph about MIPS and the example configuration though,
> > as I think its important information to reproduce the problem, and to
> > justify why it wouldn't be appropriate to just rename the files (which
> > was my first reaction).
>=20
> Other than the part that says "its only a problem on MIPS".  That is
> pedantically correct because no other architecture (that I am aware
> of, not that I searched) currently has a devicetree source file name
> with a hyphen in it, where that file is compiled into the kernel as
> an asm file.  But it is potentially a problem on any architecture
> to it is misleading to label it as MIPS only.

Okay I'll reword to make it clearer and do a v2.

Thanks
James

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqg4bYACgkQbAtpk944
dnovAA/4nglpchL1DVTyXHlb/6+dRAHxxUOorst2GnEnlVqVTErOQrKX5SYL6LH9
w2+Xoa+D/+Yp11Hl1pqigmu3LYJ4uImBaV3Es0hF7gstyyloWyBiL1EcbyMRfxbR
4e89LgGvVroW2gbkUU0ENy59QRaBQ7+yJtvcpmAfJrzd6jVDnmsmEIr/9ohaxHbQ
V9JdhtqMYeJ/PWVrGJijj+q4cvQAh5FiGhelYzrvIpa1oh/PNOPRMM7oYLVLyh2k
Mol4Bsc2mptdGiGB06y+qZ4UbUbRBS5BTMDSiXTHIkG0vCbs5RtkghnBE1asZmJP
cXVYHA6c1uDkx0zPApccbFUpH/5ySLcEiSHftJV38XL52E+L1BOTqX8QXkl36MNZ
p9E+55c6cNwgRcbsA9xhAOf5XQLf+3n6EDSZiy1WQj6GF/A1OeQV3S6nJIV9KQ9g
S0SgJ5SV9CzYay9dL4cU0obY7bK5HJHHaF74jk93tgqrPqcik3gh8/CWjplng5UJ
vPSH6L0pYltTuc02MEmwbOY9gguYKPZ9t+L4pGjHREqRUYW9XMY9J98K0ZDufFvB
sXPG9GZPtXtE+YjaKP5cWZVM0vyrQNObGqleQgUXIx/gYhLFcjtHz3t47fMiKOmj
OJT4JVHONTlaYnAmh/1zB3/HUnJqM/hn6S+VS37UC03kKVKjgA==
=tjHY
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
