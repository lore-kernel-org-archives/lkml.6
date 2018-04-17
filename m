Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523979806-2-18115637937037413868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523979805; b=OlFwHZqvOQyqOL3piPlwl6qa2rghkH1FTacIFS9MGXsg5Du7u7
    KZZ2igD/hpZiGjI8n9EbtioZln3HSbCGfswXk09TQ9S7cGhbgp6DiqHT+JijslKL
    7iYjaIw1M28RuWyGvDW5UrhVRxz/Rc2pQW0KW78fdv+cgoDY5lnf4zAbdTFAPg6c
    05WqgpZox/hVzHXBVS6LcSIcEyBHxCAtw+BQQPzUTdjOJ22zm44ZlK7YqmF0SfFg
    AxHlob48o3a3dNwebV9YF5vosLKI9pUASQ2Z6PcDf6Kunn5nMt1QeY3fr7o6mhcT
    kNGbxeq+g4FB9TZvagV4KPkZAJ+t2gMO0uZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523979805; bh=9hPquF0kCF/+G9C+joX4DrqhnLprmc
    XH1pp4z8ClW4Q=; b=J3x46BG0DniPS9sQccghJg7KZFv7l2W0RDAX1QPsZCrbPh
    uZIUdVonaoQiXKHDiBEfZW72Nvn18Z2cWcFzOEOkGWKcPhbaHGToe/zHLBwczphd
    0v+pqTAN8Eg3faD/BkA2G6EV6bWZDHb41+OLMtgDR/Pt3OfFYidBRUr9NjCuRLJH
    57RKi31LZqzEmtegz5ixp8G61nESgwlRtRdKooTdRk454KcZ4MSHHDXNHOHCiBeC
    xD+0RALmF8NCFujmpu9yaNr5jRtgYW+vNm6Ip2hH8t33tMFW2vxI3NipHw4xs2xe
    NV3FvQSoVAAaKPqQuE9r30bEiAcbQx2QAxAJa6Yg==
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
X-CM-Envelope: MS4wfIWDR+I3CGqmILZDcTN06G7flH2gQOI+a07zAWf9N+z7HZtQYEaEt/AuppGHsBSG7IewIjrr3xoMObU/MbmKBT37aEFstEEo7YqL4q9Rtr/vn7UAOyj9
    64494OvtEpIQoJ8ji5rmCOXfg7+eiKokl0vJQ4VP5wDMdwY2RuhdP+S9bYiVmfyKh0yTqe8pi/yQ7rg6rUJHrhrGrW33mEECX8gwf/ziwlj5WfBVU/YsSpDS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gPJu0pBYAAAA:8 a=63iQj23F-LE0gtu1XhcA:9 a=rW8FwOWMn3ou01gC:21
    a=ddGu9DAmhlBZAX5g:21 a=QEXdDO2ut3YA:10 a=ssQs5qQxk9ChQg5-MAoA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeDQPnN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbeDQPnE (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 11:43:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAB9217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 17 Apr 2018 16:43:00 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: memset.S: Fix return of __clear_user from
 Lpartial_fixup
Message-ID: <20180417154259.GA21386@saruman>
References: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
 <1523976741-29916-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1523976741-29916-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 03:52:21PM +0100, Matt Redfearn wrote:
> The __clear_user function is defined to return the number of bytes that
> could not be cleared. From the underlying memset / bzero implementation
> this means setting register a2 to that number on return. Currently if a
> page fault is triggered within the memset_partial block, the value
> loaded into a2 on return is meaningless.
>=20
> The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
> out how many bytes failed to copy, the exception handler should find how
> many bytes left in the partial block (andi a2, STORMASK), add that to
> the partial block end address (a2), and subtract the faulting address to
> get the remainder. Currently it incorrectly subtracts the partial block
> start address (t1), which has additionally has been clobbered to
> generate a jump target in memset_partial. Fix this by adding the block
> end address instead.
>=20
> This issue was found with the following test code:
>       int j, k;
>       for (j =3D 0; j < 512; j++) {
>         if ((k =3D clear_user(NULL, j)) !=3D j) {
>            pr_err("clear_user (NULL %d) returned %d\n", j, k);
>         }
>       }
> Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Suggested-by: James Hogan <jhogan@kernel.org>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Applied, thanks
James

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrWFgMACgkQbAtpk944
dnrf1BAAmf3KlW6EcbOTuhPhsCrFWYl1zVFklbUG7arIV3Y6cMpd9WkYKZFB6fM4
mkwb9INdDK1wLiI0CAXfR/+1Sj5aPuCTMMbqmTKAcEfni6vvGG6PPybpZMiHZ7IL
X8WJJ58rCP6Mn81FYtg/rQy0zgC6u3v5PgwNg/JTz9Uv7THxJffHETO5Sz7UH5Ie
lndhniM9hNrqqZF1Xu+JWvZH2tyjvHR/fzjxIrAC9uF+hBMX0rkEoNg96e96huPj
JYCDBnfODbN/8mweoAP25/8vOSLKsIifLR/gfQBLupcaXat/PXkG5X0If3/n7kM7
5MDjl8R0XVn8ko/pspWovGghwzDc0vnOqAAmQXT1jsf11ccVpLpar/qCJs7Fn+74
e4K84skeasyhKa9VbhPAgvsKXJkm/7LyQSJtTDRTvWXqduJWBmeuYoDLmt8/21rH
H04cg0P6HojTnF1rwhiL/3V5Mv159cWE7tfLBv30J+ANdS+FbgcIUwP4OrqJwPwl
A9O0stHBqoBsF5BozXO+QnkgpHyqqsFwc15qBKAe4jAtlfmD4meJ+v99334gwylq
86qH6G+IeFGhWgakd5haXeH5x3CtiIpm/Y0MpkGXgolQvs9sU08ZTGRgM19bEkEo
9xNjFGXSmDRrkWAg1Vw1KwMOB0RCorQIEBNI8z/OsQ0eOvfBFv8=
=fP0w
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
