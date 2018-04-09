Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1922823-1523304338-2-1530880713819057600
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
    1523304337; b=uxzkLDimn90RtB2LOtQKt6QG2gpBN/s5193XgaYV2UiPSJ9tRr
    f6deXisIHINcOv+4HGEjiYZ/zT0hsPNPSolAN0FNC60BigQR8UwAVcdAxK10jeGz
    ruqdjqOUvufTPDnAQSXsG92aSdksPPupjTTmwsGcSyV/R8U5Rid9ncb5B5WQvYkp
    kWZlM6YT1TqMGYfYNa+Y8Sv0t+6MlsC8QxXgZh81bWbogS1mELks4AEMRjuvMWqS
    i0h+bx+kWSS/saFP2htxbkUJqPzTwJ0zc47lgmXxIcPs1dNE//dVja6JalQKLxXw
    T2iU9cNhEJCiz6TYykS3KPf0zUuHdipQMWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523304337; bh=ji0VJPBWpft5zg5HyJ1eKb4CRnYEc9
    1Wt1zrxNVyaLg=; b=nYYHHLUgSz1R+B3hO9KrnP9pjkWBV6Cglu9KIcEW0pdO6v
    C7ChlfFrYe9BYMT0mhHnG2bMw9mmphxFf3ntD0CnfGLNP/aWco1bpAuOBGqwGUDF
    Mwyiktz158MT7U3CxWLBOOMZ2tiQI6SdFTIZNg2DW8984bNeZ2YgDP0jiUtjd2x9
    TjzFQ6avM9Z8IYTNwvksaEThER49UIsZ/+ZGjYFLg0eENz+Q9TMQzhuGSZ+Cd+im
    B+TQFTK6BOQteYU6T0Z89G59QOwDIEWkwwqcEqfgSp8dX1ovygA9KAu4Q2/lPzk0
    NYIzCT+bWs2RWGthnN9a74bgQy2FsAD/IJiQR3HA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKJDTa89OwJqRSNk/3jr+mPItokStSuRWnn9gRFEZmEkfQ2HTq5kQTzUx5j7DgCG3iYZ/td/z5bpkCHa8t2BaXlIs3ZeMg7lnRd7iGSWYmwPd9ESEMVs
    u19j8u6UK3yupyLFV7AsIHRbgK5GdZ5VvQUMqFVo9BYb8WQiAfMFxry0Wqf2lZObORlgJuwsbFqPz530ipuIVvbQAYaXwySbyyvWITC+wmMcFajTOamchgTP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8 a=NNUWomB6kc1TK5yini8A:9 a=QEXdDO2ut3YA:10
    a=UmgzWwaP7Hz4w_OgUw8A:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeDIUFg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 16:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754475AbeDIUFg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 16:05:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8B021785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 9 Apr 2018 21:05:30 +0100
From: James Hogan <jhogan@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Message-ID: <20180409200529.GA17347@saruman>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-41-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180409001936.162706-41-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Mon, Apr 09, 2018 at 12:20:18AM +0000, Sasha Levin wrote:
> From: James Hogan <jhogan@kernel.org>
>=20
> [ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]
>=20
> Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
> separate files, so none of these files get cleaned up by make clean.
> List the files separately instead.
>=20
> Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make =
clean"")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/18491/
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Perhaps you're already on top of it, but this would appear to be equally
relevant to the older stable branches too?

Thanks
James

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLx4MACgkQbAtpk944
dnq0FQ/9FSWP4uX0NBOiTuxYiENIbp6bvpM84Na7BB1P4K0lE6NiQZQ4oMYkH5Zw
bNxuuDK8BDD/zbzPP5sO78DzdLY/CHFr9Wzg/TjEClAfjV0o3kEL533VMX1o7AIY
TqodazVNp2e7v0APNA5B+SGu34A99TM9pSko2tcqAH7ehpFufbOXOLkD+QEtsE9E
o13OR3H0F5yzyUWQTwOKKhWeg2QFWHo7WE/cAgr5aJ0MgtFd7IiDmjtzKQKBTRVL
3WY1fguf27T6//dA+pB/9ORbpEUE1ThBJ8chbUmB9wQqlhTEIFhrblEQ6MSsO2DL
EYbiTVjZZuXGycspeTNB+srFhI3uNnp2dmATFBt1QqeDD65X9nCI/7vJrEJbWTeS
bqZAlhjzinvVqTvb4fH6iSh9M282p4F/GIJlHkAEcw3+kOwdbuG/pKcxNx/SSnlr
IX1iZq1NsyGYLfzV8d4aMTbfhLbtf9OhjxLiN0GZ74Gd9wkOoAJZLXSM7dSojsNT
D/oe5ymheW/mrjjYNvCWSmC4RVW+khOHtTf2GIrTcdHApZ151mpWsaX0a2cDyKBl
hpuNn5JnCj8hJe4XZhpvsFif1pT2c/M51PC7riAMn2MZ3ucgYWflAGCByiznsuJE
b5KLLvDa/559Ss5CVtLLyIooyrckQCO3gD7m/5+D3tgSWDw49bw=
=ZjxP
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
