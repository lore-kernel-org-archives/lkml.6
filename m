Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1551384-1526337445-5-982088122982656334
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526337445; b=RK7AvSFKbXlLwzqGgQbo4MZK9zz/Pb5hQhTD9dHktlFnHsinfT
    GSCAeKsTGWqY2VziUVfkawCmuQ2w8/ImfSkIaIMhCcPNJI5lPU2AKgoO0CHN7eFp
    rM2tnr0vwQfmFSwTMtnu1wozkRAyM9FkYNNrRexvAOQuHJkFaOv19be20e/ZlHt/
    fxMKHIT49J5nK1A8J4IZSas0EDgWHg73wuJkx3dLKABmPmQfaxHCJqBFeu0kSrby
    K9H6eKZkzI1jQOcltowVOKbqNXFajFzg8aKgxrc56aseQ7LJzpV2V3PhgM6u67gE
    9Y7+C/JvsW3A1QWmV1s97r60wG5wEiNKhc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526337445; bh=BXCDBGjieH1jkU+xvpCvuSvzEvKkbB
    FOA/VOVHyHg1o=; b=eAzRFjXjB6Uig+Y5HoqbNqsKav5+XyruFXuyhXouPCRSko
    4OkUcEz24r/MOe6VKwo7zZtfQz9lu+Ijm5EvRPEm9EyI5jLb3TV/Yl3RKK0dvJIN
    avMKJqF3pBcPZ5Ep3oupgaSrwSp07XpxZsAldEpi+Bv0d/ja2WZAcB1u2b7It3up
    vpJc8npK3TTMGEk1RLbcvjuLjyJ6tk5rB5pQbUcvBcXy6wbpbwDozkWwC/9PfYmm
    3+3FovY1rZbPwYdnsAu1AoKcb+fhCCSU0oHL8QrzrzAty0g3zsDqMLTqCv15tXSi
    ea3N7IJO9Kxp99mTkiQn4jXLuzMlEliGdaVLS+GQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=0ZaiXcWD x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=0ZaiXcWD x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzkTk2c+MqSoLVm9MkQ0dHuAWHcyAYSUAucQ+Q+7WsLKHn+FYiGqRB/j6319XN9EYj2StEpGnanVA8xluM3sz9QLB7i5hBh2LvYDuFAeSYyE/slztqq
    mvcf0LRda2xIttXbrNgdn/kSb1hOTH85ElCaz3SyJ9H8V2Xg0R4NB/0O366HEBk8DdldGNL4NuORfL73rBeHMSipxdcEiaKWVl7WtH3QoEJZt7JkwLiO41Px
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=gPJu0pBYAAAA:8 a=VWvHJwViXKD5TdvyoV4A:9 a=QEXdDO2ut3YA:10
    a=ApAiYKHuzAQ2Zs7a978A:9 a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeENWhV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbeENWhU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 18:37:20 -0400
Date: Mon, 14 May 2018 23:37:16 +0100
From: James Hogan <jhogan@kernel.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR
 accesses to o32 FGRs
Message-ID: <20180514223715.GE29541@jamesdev>
References: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 04:49:43PM +0100, Maciej W. Rozycki wrote:
> Check the TIF_32BIT_FPREGS task setting of the tracee rather than the=20
> tracer in determining the layout of floating-point general registers in=
=20
> the floating-point context, correcting access to odd-numbered registers=
=20
> for o32 tracees where the setting disagrees between the two processes.
>=20
> Cc: stable@vger.kernel.org # 3.14+
> Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Hi,
>=20
>  These are not the usual requests used by GDB to access the floating-poin=
t=20
> context, which is likely why it went unnoticed so long.  They are only=20
> used as a fallback in the case where PTRACE_GETFPREGS and PTRACE_SETFPREG=
S=20
> requests are not supported, i.e. with ancient kernels.
>=20
>  However to verify an unrelated GDB bug fix I have tweaked GDB to always=
=20
> use PTRACE_PEEKUSR and PTRACE_POKEUSR, and then discovered this issue in=
=20
> native GDB regression testing, as it showed regressions from corrupt FGR=
=20
> contents across numerous tests compared to the usual results.  This fix=
=20
> removed those regressions then.
>=20
>  Not being typically used does not mean we ought to keep the interface=20
> broken.  Therefore please apply.

Looks good. Applied to fixes branch for 4.17.

Thanks
James

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoPmgAKCRA1zuSGKxAj
8vHgAQCWxOnS4xlCHH+ctDoJS88qeXWE6ojQ4iM0LlzCyfNKrAEAo6VvdB1DEWg1
tBq1rCXSUbUnkg+qpV7h9T1CG5N1Cgc=
=df5g
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
