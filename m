Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-346323-1519183058-2-17090697310944694159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519183057; b=D/4uwYKSsgGobI5cyaL4I1Hjxksm6qAYGk9pf4pI83kGz+4
    jyTx36X5+aIZGd3p6GBc+v2CUoUfNHpu7+pxUuCDJXIwSvamqthNmjD14eEJd7c8
    BF9RLVtpjk/SCD1HWaEmNzkw8mZzpn7kpaosoGgnkX49OzOfiZe85r7aEGCxkNJn
    lT7gZa5GvaOhp12nuJj0txoRQ+kVpH+vif6nqycvwzXNfDA9GeK9osuCRc1mmMrt
    gB+SNFL5MEKwG+2UtCXyGJlYAdMYeu0HmxJOdfGytU7LGW+4xCd/ARATkdWbNiVR
    puISx/V3IS/GbxwcCxddbhP+2gEOOeJX1d8IYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519183057; bh=7O4aXD8kuhmcdyLnqnjg9Et45k
    YmMaIUTPW5bNiVN6s=; b=nOvjhr9bTLQX2McczjWOydkfabgLq0AHqIuc9IJTjj
    sNp/aVu2Qty+qhaguOvNoJd1QmvSVnLRQG4lJ8NBZ5H/1nji22oijA1scId2al1S
    UTxcg/H2SK/jxoQiXaBQOtGVgPqMY3n9mHEBHL73VU7hoQneJhNYSI08dkRnEKwv
    HHvDW5ghl/LtheaUh7q1NMC6MvFBCqQxgGYe1lt3JcEe3n3/EojSLzKlf5912lQN
    +lNRkbPIUieIKXAdJLqJZDVMtd6ISJlQ/ByBB4SBdNemJ8QCtxxAcl+vknixNJuJ
    wuCZK4mDUxu+blMNdXYtAoe7Cw6GAp2yDb/uwatgwC5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBUDRg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 22:17:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41494 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeBUDRf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 22:17:35 -0500
Date: Wed, 21 Feb 2018 06:17:34 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] seccomp, ptrace: switch get_metadata types to arch
 independent
Message-ID: <20180221031734.GA27173@altlinux.org>
Mail-Followup-To: Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180221024747.9659-1-tycho@tycho.ws>
 <20180221024747.9659-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20180221024747.9659-2-tycho@tycho.ws>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 07:47:45PM -0700, Tycho Andersen wrote:
> Commit 26500475ac1b ("ptrace, seccomp: add support for retrieving seccomp
> metadata") introduced `struct seccomp_metadata`, which contained unsigned
> longs that should be arch independent. The type of the flags member was
> chosen to match the corresponding argument to seccomp(), and so we need
> something at least as big as unsigned long. My understanding is that __u64
> should fit the bill, so let's switch both types to that.
>=20
> While this is userspace facing, it was only introduced in 4.16-rc2, and so
> should be safe assuming it goes in before then.
>=20
> Reported-by: "Dmitry V. Levin" <ldv@altlinux.org>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/uapi/linux/ptrace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index e46d82b91166..d5a1b8a492b9 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -69,8 +69,8 @@ struct ptrace_peeksiginfo_args {
>  #define PTRACE_SECCOMP_GET_METADATA	0x420d
> =20
>  struct seccomp_metadata {
> -	unsigned long filter_off;	/* Input: which filter */
> -	unsigned int flags;		/* Output: filter's flags */
> +	__u64 filter_off;	/* Input: which filter */
> +	__u64 flags;		/* Output: filter's flags */
>  };
> =20
>  /* Read signals from a shared (process wide) queue */

That's much better, thanks.

Reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>


--=20
ldv

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJajOTOAAoJEAVFT+BVnCUIIA0P/2LbxLylC5R7NWmIU2vQRGE/
NXfjcwTLx3qfipqkNS/FhRl9w+divvq5l8nV6syOoITUSs7hOprSTaOx1lFXOkc5
t87YXM+72wphybm2y6qC+7GuR2F8M5YfuGf/Kh2e23wOUYmMa6g4AwvxkQ2BqPPb
I31bj49xZwNJjXS72nneUCVz+IrTlDIqqoVZJxYlcIztioOxmiVPwBN4oNVEgLf0
yYZzhdEXUlsEbLZ+F9bXabA0YQqxb1i0a2anLZLCz3B2layeb8aHicTbEPmi+OLp
F8zVF98HnO9/16Iyz7K2bNS3TX4ARxI94NeH80IItom+z9sU+bjRFFALTw8VLbsx
pgWtARb91GBL9vBLzAzxpuhQAKgS6SQOiWnLvtyOPRW0Nv+kfLnFNa8VbDoBers6
Fj4pMDnRD18PGYspeXVogH8Ygbq/BDaHJtTfcXUKIbCs8OjpZuv1U68cb6ny06KP
iuJkb0TRqNycPVqpefrqD7fYaqGjsA1uM4WGNN7gu3if6n6sEpHreJQk8VsQVAjD
6EDZyTXD8DDKHgOUGmtFv3i9GwwuRa2Y4N9g54WTLR7pQYKimZ5VJynBFbhTcpW9
5+g9H1LPo3DS/3dqd4r9nFwqVFr4MITv81xx/c5duO8y166s2XELaS8tIyeURn4c
WmVlNilb2R86K4o3AkWu
=YuP6
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
