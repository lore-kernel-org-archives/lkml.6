Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-155233-1525440280-2-14909002322276707223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525440280; b=HDNQRrNRLKhFa2MSF+QJ9Pla1qeMO1fVH9cu2MMI74ZlmlrBdC
    bvEB3x1OYx2IdBmIwyRxBUf1395rKGgSZttt/TeiludOTFiroO+nRpUZ2m+lBVzJ
    e1Wc8VFjTsIGH3HXlmMbMMwKAg+Obj8Wfk/XHUZS/3KotBfahRiXIhzNLzWCCdxE
    ji7241ehLNdSgKfYaSvucj6ExhvTfCWTAACcvomzDlgfFw+09wj5syuUjETpUcA1
    yYkEc2KTbaMHD9KliPEnXMgcZXJbp7OiGu/XdPhqKXqL1kUOBTZHoaNhoc39mtZ6
    ipOS6PVDfxKqg/nYbP9UMq42H0+GYSCqnEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525440280; bh=8DaIsRvvib4k3SRAmldQr1mX+KGT9c
    RTGSSsmbCi/pU=; b=MSiZhZ7RgRVYEALZTlN8WVoa73b0ysLHJAj30OkQLdDnLr
    B/XR1G7GQidIW0hc+3lozeAcroeVtjV7uB4jCOPxIvV6l0l2JM7DFnQROgH3rEm7
    noJ16rhhlKFo3WQU9z2gxxmbAhjChiguFtbd4qd8M4bo3jWU5RK3Jdw2VIZ0s6Hh
    ncvnsSNBIykiVyZ1Gwhy1nZSXzsjy6i/naAa/3wxaF7imOD/xQjHQkkYcFk9nqQs
    U1BgC/vj4WDzdgWnJAdn9if8gX5z1+iENnydutP4rX5gSzQcrbebovTi7V9zbCNE
    WKKay6kSzAsmf+3LIScJXu1ArT0fK4Gw2fpS136w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=fOC5RfIQ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=fOC5RfIQ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIciBJh9YKv2TBkMknSs55Wyciax8ZxQx7Ufxif935HRhv31gs8M3rCI+wpZA0n26PdBzWyvV0jLMWpFzJHgTJ+Am6iEdKI81YVDjJlx5QZ96llhfSWV
    s3W36d7NglSowPz87tPOnYoeXvqYQNzZg0YzKuU82gl386ABpVZsd75QskzfWM+I61ox6Rlen+5DgVoLmnURDHk4mhLmWNE8ShMau/ze4g0fgdEMWoIeADwZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=anJn6clNCpoq59n8QpgA:9 a=QEXdDO2ut3YA:10 a=NqPdRVzkrt-dKUH-aH8A:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeEDNYi (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 09:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeEDNYi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 May 2018 09:24:38 -0400
Date: Fri, 4 May 2018 14:24:33 +0100
From: James Hogan <jhogan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Matthew Fortune <Matthew.Fortune@mips.com>
Subject: Re: Introducing a nanoMIPS port for Linux
Message-ID: <20180504132432.GA30458@jamesdev>
References: <20180502215107.GA9884@saruman>
 <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>=20
> > Due to the binary incompatibility between previous MIPS architecture
> > generations and nanoMIPS, and the significantly revamped compiler ABI,
> > where for the first time, a single Linux kernel would not be expected to
> > handle both old and new ABIs, we have decided to also take the
> > opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> > use of generic interfaces as possible and modernising the true
> > architecture specific parts.
> >
> > This is similar to what a whole new kernel architecture would be
> > expected to adopt, but has been done within the existing MIPS
> > architecture port to allow reuse of the existing MIPS code, most of
> > which does not depend on these ABI specifics. Details of the proposed
> > Linux user ABI changes for nanoMIPS can be found here:
>=20
> While I haven't looked at the individual changes, I wonder whether
> it would be useful to make this new ABI use 64-bit time_t from
> the start, using the new system calls that Deepa and I have been
> posting recently.

Personally I'm all for squeezing as much API cleanup in as possible
before its merged, though obviously there'll be a point when the ABI may
need to be frozen, at which point we'll mostly have to accept what we
have within reason.

> There are still a few things to be worked out:
> only the first of four sets of syscall patches is merged so far,
> and we have a couple of areas that will require further ABI changes
> (sound, sockets, media and maybe a couple of smaller drivers),
> so it depends on the overall timing. If you would otherwise merge
> the patches quickly, then it may be better to just follow the existing
> 32-bit architectures and add the 64-bit entry points when we do it
> for everyone.

I think it'll likely be a couple of cycles before it gets merged anyway.
There's still work to do, and limited resources.

Cheers
James

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuxfDgAKCRA1zuSGKxAj
8gFKAQDBKIiLApOFjRYGPadIj0pTPL6FcfLozP0XuoIjjwlKdAEAguVMty7TjYS0
+MKImps2UKe+xTw3YLPtnZlk+cVTpQ0=
=7SKV
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
