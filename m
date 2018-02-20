Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3650906-1519155057-2-4798313390362334855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519155056; b=rInbmNqG7k/cT6a19Kty+WJcLlsZXStJuh0mBJmVjnTmtqv
    BvU1xI6mLCUKY7XX45YDcH4m8+Og3oIYT5ptrts1lsU1YZFOoW3OevglEQ2giDJ4
    4pKc6nkW2mD6K15q1Z6KJJtXRods4Rw9fP/cdBqR67Ws2L02OAek9NAxTQ2fT/5E
    ygfUBkCubo0Wo85xTAN5pH6vw6P0BHc5vKgE3OBuWRxLL6CZ8Tv8jcX4Wisyi02/
    fxPgZMGgg/dTmbjc4ktb02hDx9Val224s0BVXyV+f8mPRpF6ZFFjc93DHMr9M+Nn
    ndAuFplJB/FJFGZ0/yxjQHZ3KzAYToD43GJ953w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519155056; bh=XE5LJmNFIG7jCH1HtnoUIbmr7o
    bmxtwXNsCqK48HOgI=; b=dBH1+xYEM9A/kZWK/pgdM2YrhEZfBERUjSMU+8TFK8
    w2drp2BHpvvjU1bgCXgITRN2L992sKF6rzk27060EkAbWf6jHFsNWO8FKZfIzAeV
    +k53Mp2xnPVayCDrIvp6JQSXjlZRJYj0H7lZTJDRv4FPcVbgydW6AfxNvwX0Cfuw
    df8XLI/9UTh/3iehj8BknWkKYVYgDBbswQzPnkukyvx+jP3uYiqJk96oZ1IPTgbJ
    WdkTklah20mPrst6viE8SuIDUEqxEQykVbH9+cyK00mF6J35wcmNFUSPEcUQ5SKY
    HedqKprNIAiVV5BZSinrvNqf2gB2yCkxcVSr8x1Sf94A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=altlinux.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=altlinux.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeBTTaz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 14:30:55 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:42940 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeBTTay (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 14:30:54 -0500
Date: Tue, 20 Feb 2018 22:30:52 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ptrace, seccomp: add support for retrieving
 seccomp metadata
Message-ID: <20180220193051.GA22210@altlinux.org>
Mail-Followup-To: Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20171115020019.13517-1-tycho@tycho.ws>
 <20171115020019.13517-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20171115020019.13517-2-tycho@tycho.ws>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 14, 2017 at 07:00:19PM -0700, Tycho Andersen wrote:
> With the new SECCOMP_FILTER_FLAG_LOG, we need to be able to extract these
> flags for checkpoint restore, since they describe the state of a filter.
>=20
> So, let's add PTRACE_SECCOMP_GET_METADATA, similar to ..._GET_FILTER, whi=
ch
> returns the metadata of the nth filter (right now, just the flags).
> Hopefully this will be future proof, and new per-filter metadata can be
> added to this struct.
>=20
> v3: * use GET_METADATA instead of GET_FLAGS
> v4: * resend
>=20
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
[...]
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index e3939e00980b..e46d82b91166 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -66,6 +66,12 @@ struct ptrace_peeksiginfo_args {
>  #define PTRACE_SETSIGMASK	0x420b
> =20
>  #define PTRACE_SECCOMP_GET_FILTER	0x420c
> +#define PTRACE_SECCOMP_GET_METADATA	0x420d
> +
> +struct seccomp_metadata {
> +	unsigned long filter_off;	/* Input: which filter */
> +	unsigned int flags;		/* Output: filter's flags */
> +};

This "unsigned long" field is unacceptable unless you are willing
to implement a compat layer for this arch-dependent type.

Please use an arch-independent type instead.
See e.g. struct ptrace_peeksiginfo_args or struct struct seccomp_data.


--=20
ldv

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJajHdrAAoJEAVFT+BVnCUINQkP/RgI6Gb+m0kq5uh80NtSTMoO
gsimmfAr3F1t+CP1iDbtzT8mTX9mpc8Op1oLDvwoaMhLLajQnkXk1jl3suyYWFhR
NgL68rRPEbC6+cV95vQ9cQINEUUwOhEMmkdoH4NxxjwJmDj6wdYpAfqv5QgSYEuZ
4+vNb0NwMtHmrPcfZdQ9EokVdYTcJJfyY0f/nIhTsluFOhCSWUVWrXdyQvQ5EOZm
H+n+eGvL2+qv+PTB+w/yNKgyahIV9pUyvYy8J6U3LG441dOL2TZIY2uFp3s5Bu1y
GTVv730QnsTnenKmMuyLt1EBzEDwVvl98HLfTBNnlhLBhNNtxsVElJgZkBsMFRcX
BaaobUdckFBrj5Bbw5u17znisfLShHE03ngoi+Szgx8dFvt0icWuLNgyy9WvZyqJ
uEDPRZv1qqzOG1MPPIpwJgL1VjB9ItBa0DlIyVdUlym8Mtwjg7rslYkeFO4yvhcj
wv/aMA2GV6I/xPYj3ns98mkOOqE2tYOYGmMG5azxflMW+PeN0lPfhMIodkMqGCA9
nyESzRwpX9Id5Rm88cbW5UByNHcstNAHSjBaSGTkCiq1GLAdHlM9X18EVTivBKIQ
s289xp076dlkfaeL9jzIVyHxCO8HybAQG8Y4l37lht8R1HZ4B6nViugVUF7aJ0oj
uE73WuxIZVsczf1dL5Q+
=V7Ex
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
