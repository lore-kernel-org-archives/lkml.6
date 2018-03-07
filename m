Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4155223-1520454329-2-14586829653087378000
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
    t=1520454328; b=ilw1lZMgxYSZ5udxhvGMA5Sqidk6l4dH9qV83jYZKccOGXj
    JnUZZp0eLaz1duF+hrwmzNDBkXJ7j39aXlaz7mVC1wmZ+8eMHxEav1rmzLM9+S7r
    6rNBn05S3TCd/jghGdF0ySaoHbUdxghdHSM1PCxJBYnBwFRpx8GThcvnkMS2AdQ1
    NroaypuHwt0gmvH0BLSZ4/2ezcw1WoV7wMt6PkZh8LPYRICKBYRIdZWlsY2Xhq+r
    4J04G2Uhk82KJrxd5nkwaWXYwWehWtyoKU0j1uf6QggLQMI5dHDc7fI3icM0njn9
    DvpyAqv015EonB0oNMVRVGREio0rSDj242UMakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520454328; bh=ph+NdbTJbCLJYDlz/vRGYZw9Ef
    yefBk9lhqUG+U8zYI=; b=oDgUDjvDR97bxaeGpVgGTlLTaqsamTfcy1feYsaySQ
    AGn5JuYd2aP7PTnOtGYgIzGkywmGpmfXi4e8JOpfdLZ6s1A6QNLX60YhFKyvMNQi
    /YwsSOf8sqsCpSqaYeKq5HOJcz58ZhVA4f4jTfLWujTEb4Qpq9xF8YcMB2Xu+oMq
    qUVrGWsxPEmfikgSp/U0sM5GUGIReomuxl7ah0794PqLo6z2QvgU/17qrfo7QHkZ
    IbhkXxnhvjn8TQ2oJugpO7EZgLnnqMQBGbmSUHmBq5Cn8JuyvZBtVqeg5IjrG0vj
    AY9kUrn7baTfivk8baV9WgEYMKlGh4ILaXX5ElHw+Ngw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S964927AbeCGUZZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964922AbeCGUZY (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 15:25:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51AA2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 7 Mar 2018 20:25:14 +0000
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
Message-ID: <20180307202511.GT4197@saruman>
References: <20180307140633.26182-1-jhogan@kernel.org>
 <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ck3np9Ek/EMsFxRu"
Content-Disposition: inline
In-Reply-To: <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ck3np9Ek/EMsFxRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
> I initially misread the patch description (and imagined an entirely
> different problem).
>=20
>=20
> On 03/07/18 06:06, James Hogan wrote:
> > On dtb files which contain hyphens, the dt_S_dtb command to build the> =
dtb.S files (which allow DTB files to be built into the kernel) results> in=
 errors like the following:> > bcm3368-netgear-cvg834g.dtb.S: Assembler mes=
sages:> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section> bcm3368-=
netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized cha=
racter is `-'> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode =
`__dtb_bcm3368-netgear-cvg834g_begin:'> bcm3368-netgear-cvg834g.dtb.S:8: Er=
ror: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'> bcm3368-netg=
ear-cvg834g.dtb.S:9: Error: : no such section> bcm3368-netgear-cvg834g.dtb.=
S:9: Error: junk at end of line, first unrecognized character is `-'
> Please replace the following section:
>=20
> > This is due to the hyphen being used in symbol names. Replace all
> > hyphens=20
> > with underscores in the dt_S_dtb command to avoid this problem.
> >=20
> > Quite a lot of dts files have hyphens, but its only a problem on MIPS
> > where such files can be built into the kernel. For example when
> > CONFIG_DT_NETGEAR_CVG834G=3Dy, or on BMIPS kernels when the dtbs target=
 is
> > used (in the latter case it admitedly shouldn't really build all the
> > dtb.o files, but thats a separate issue).
>=20
> with:
>=20
>    cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
>    FDT (that is, the .dtb file) as binary data in the kernel image.
>    This assembly source contains labels before and after the binary data.
>    The label names incorporate the file name of the corresponding .dtb
>    file.  Hyphens are not legal characters in labels, so transform all
>    hyphens from the file name to underscores when constructing the labels.

Thanks, that is clearer.

I'll keep the paragraph about MIPS and the example configuration though,
as I think its important information to reproduce the problem, and to
justify why it wouldn't be appropriate to just rename the files (which
was my first reaction).

> Reviewed-by: Frank Rowand <frowand.list@gmail.com>

Thanks
James

--ck3np9Ek/EMsFxRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgSqEACgkQbAtpk944
dno+qg/+OVG/O0znyZup1R3l0Cs07bQYye+qoIv2byyBKi2HJtRKIRA/9oUww8L6
b0/aBIY0NpayhhsC0/EziivmKMwTF1aQROnbN5AS1Z1B+vVnFX38jw2yc7C0RMd3
bezjC4/qxZ3Tt5Q24ITliAc8IS36fo7448F1nCRhjqHkF4wOEmZ8GzGYY7SoOIaf
u1NS/Cjl/gwEGN6XlLVVY7S6pdtNYYjOSS04UWTPBYsjqESLznkHYDeHvoS2kpsf
HOnVTAqYv5Vv03iA3g+Rfse6sOuzIA9cL79Y7y7RQgbh/eqtXQzXbYdOrboFr7ZI
cUn0p2YLSQvpbJe4wuXndmkJGotJIomhsgFZGs1B3FEyE1Hg7f/PIRzp3MTXnbDd
pvDKQ7Y3n9K0dm4XIKcp0b3BH7sLNuxOnb2l/DVbf9uSLtcnfSbRyNDwGlqqHyEH
JHvyo5odx80kL5+0w74ABX5hDOuK7bPqhF8slID+xv8zsnAt2vMIkVqx2TmIYqBo
GL6RJI3xZPZk/oDA+rN3zw4TssFdQ5JBOs9B3q3iAtkGqd0/CIKMj4P5IItxqw2E
tnucDBhc0cvbNCYpWw5X6wCiMzhhM8MdVTxnGvzKn/DAk+EWnGh6dfgvoY/Sl3r5
O3g7tS2zfrFqvdm6Wecbro58Mzs+WcctRqK2h2LTXorEjBIRjig=
=+//s
-----END PGP SIGNATURE-----

--ck3np9Ek/EMsFxRu--
