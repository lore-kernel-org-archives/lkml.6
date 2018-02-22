Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3951499-1519292053-2-6666575295261796492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519292053; b=jxxmDGHvRW5q+O4suhzcRddXzL8jvegRfyK1x6QaNHxIRgH
    80uH0xlR3x7gEp8B1wUcNKdj1x2bH1dm1RWxHbw4vu+JPlLlz3E3XbgnTs9Axekd
    mQDVKiHll5TGm51whFNdc3zmlzvaetWxVRETOG8zRbUP0PA/nl7fFXGoEfl/ClTU
    th7Cbp9ww6CF5KyzWJhkGBzH9Km5mzVTOvtssklBwQvZDBsuKsMuviJSIdzfLUOm
    VlKr/FfOyf8UUe4v7kquVV8CXkbYvzcbZZiMwFJ4zRrCSXzvGJVczT1zorJLqWVf
    cI6NLLfKNeCiax12yzrpuc5NRc7Zs12bTlCRk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1519292053; bh=XFRcBJM8uccH2fRMomeQRvV7So
    nrociOP0F4ySrX0To=; b=YRD9mbO+wfVEIMbqsneYtF748RaWxK0AmnepC038RN
    VTz1cSJb8RbqcGgxyFSqMhuXVbnDeWIrcdEWjk7Uo1rvuD79VgD2LGLIwyfyYVOG
    TYruPpcHCKOOQwfHrPC2IdcoFMy7fWgJaaNcHZ9xXmxTt12uTDMs0hYEmTJKeb5m
    lEsDLYwi5+sQPcTChs8rM32iuEPtNL9fWrS5YU8yqqsgJhY2LRe6eNnfTt+9voCX
    xZN/5dVjAvTcpuZI/sfVPpt/mWnfTzYGZWUXz48qyvY0n2/OOTr8jmNg5pNdp5qI
    DK3870hcFGVMTurLiUkcuOfZBm1oBg45PB3pVJatxDTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeBVJd6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 04:33:58 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:33462
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbeBVJd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 04:33:56 -0500
Message-ID: <1519292030.2388.14.camel@debian.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
From: Yves-Alexis Perez <corsac@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 10:33:50 +0100
In-Reply-To: <87k1v5rg66.fsf@concordia.ellerman.id.au>
References: <20180221124432.172390020@linuxfoundation.org>
         <20180221124433.618725458@linuxfoundation.org>
         <87k1v5rg66.fsf@concordia.ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MrSbtf+2kC3JOrhBBxFi"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-MrSbtf+2kC3JOrhBBxFi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-22 at 12:01 +1100, Michael Ellerman wrote:
> So I guess this patch is OK for now, but we do need a full back port of
> 222f20f to 4.9.

Hi,

in the light of this, do you know the full status of protections against
Meltdown on powerpc/ppc64el architecures on 4.9?

Regards,
--=20
Yves-Alexis
--=-MrSbtf+2kC3JOrhBBxFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOjn4ACgkQ3rYcyPpX
RFsouggAiJMi8EmhJ6J6VX6PoLoJ1OKwfMQ8i1vYpvSwTE6HkG1tarrOMEZbISCF
nSIXtWv+0I+PP8yl2CSbsSd1D89wxYe4drQlj/QfSQIj2932lx2CrwH/tan61HFj
d4O0/MofRhlOm5KqF5V018hCsVgkZbucHDQKzrlfsB6R5MsqltU9lfQuwx7iuHqR
BlgAPcquR0YAA5rSrrejqpXq+NJIzxMV7ay1k5iv+l6iKxiUa8mZGD082SRx+Pok
1MIp2Lipuz1epBQz2ffKsljUAp+p6X8ORgyP8BPLXxqaaxSq3HC0bW89bVfQRtkx
WT3nJgCr695olo6pOA+547IlN3CWMg==
=oOhY
-----END PGP SIGNATURE-----

--=-MrSbtf+2kC3JOrhBBxFi--
