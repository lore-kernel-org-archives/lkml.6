Return-Path: <eric@anholt.net>
X-Google-Smtp-Source: AG47ELtq2yl41+znmtVGgvfSkOpGbIfcCSeIsSQkRJdJMe/TYhKS6DuT+XvzjS7qYOHOJdSnHIKv
ARC-Seal: i=1; a=rsa-sha256; t=1520619110; cv=none;
        d=google.com; s=arc-20160816;
        b=rvpH/JrnYgz1dZ87nrg1z+H4NFZBDrvgIYuZOlmYanZ8iQ6vxl1Mj8veReNTr8WTyO
         Wh5xaadcKwWztl01TONk4Z2GoB+vr+y1HIfEsa8o+4s3zBJ8i0XlbYAdVYEdQY9BqtDq
         wd9XO0mmuoMtJrbx6HcZ970OfZjrqaUAcWQhp/LeJKdwVsh2J0CNvwjMeERpPkr2YALU
         ofFnEtolS7wfFVd3o7AyKNO94pFa/SUV9loJ9+9w4m2AqEkRLq/LU8+1xxDRelz2iC7X
         OXmaKWk9dQ+Jb50zWQl38/gAvaJs56wjFL2FuZZOAonwptmyN5DbbTLIa0stwEQIgWXV
         s2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=fX4X+VJzZeeiCKyRfh9g4HodN1kQ2D6/jgn3qfoLhLY=;
        b=sN8gEEV7Le9FGwPHfnVoA2JZm3g1vWYfMAtcsz90XXqbvk2ZOeKhy3swrZ+Delxpyo
         A1n7gVPSsnJvoqo9PodLK8b8ky1LVFzb7I9Xcy7Tqt3aA8DZ1o+eflE//xEKB52aFL27
         jncJdainXxsi6GFFKpNOfRC3ClujPnV5mPQGgHOMdUW2cBVAVimzm7ue4ryobyKLIfZt
         zNEVkl9osk94fIOmcyen/zxlKF9GR8YvdfAViyGeFEJRmuh6axJuxK+svnB5iFNcKgZ6
         YvVKpBgbqvq8QJA0drhXGhHrMUEh8+gClK7CUnX9cN1Eq/EL0HWtBCCVK2cgPwq1yXhM
         3+Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
From: Eric Anholt <eric@anholt.net>
To: "Tobin C. Harding" <me@tobin.cc>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, driverdev-devel@linuxdriverproject.org, Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] staging: vchiq_arm: Clear VLA warning
In-Reply-To: <1520576470-20628-1-git-send-email-me@tobin.cc>
References: <1520576470-20628-1-git-send-email-me@tobin.cc>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 09 Mar 2018 10:11:47 -0800
Message-ID: <877eqli0f0.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594440016675851024?=
X-GMAIL-MSGID: =?utf-8?q?1594484704466249627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain

"Tobin C. Harding" <me@tobin.cc> writes:

> The kernel would like to have all stack VLA usage removed[1].  The
> array here is fixed (declared with a const variable) but it appears
> like VLA to the compiler.  We can use a pre-processor define to quiet
> the compiler.
>
> [1]: https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>
> The name of this constant may need changing, there is already a
> pre-processor constant VCHIQ_MAX_SERVICES

Maybe just use ARRAY_SIZE(local_max_services) and not have the #define?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqizmQACgkQtdYpNtH8
nuip/g//fOzcTK1Mgomn3nfvXcxq5Rzl5d1e9ZX5CeOd1ecNomwGhAuMWxYWf4rP
g7j+Kah7c13lGQ0EcJTlC59T1Ml2WAtfEU5RiY0396+W30eRABALO3Afa/bsghHZ
HfgruKUTGA6MipeguFadfLSh/WPDy/AEW+pcCe005MZ+R9PYau+KK+d2BZfntMoI
4TncmLyCSChsYmWW/HFZreaNncV3C53tMv0R2uLoH/a7MmQhHWqwcuFPLp9BJ8Vq
UzfXx7Kbhd7zs6knQOv0wHULUAcoh61MR+wNYpZZycJ6gM2hmJNKRTnLE5ZfPRS7
4Zt9dhdIYODmlRZ5oItFHOxYakWGfDTKTjLWfbl0dBdHnPbZwVvdnafhfKMLcBIw
5dHbxJvdJPM4HEqjq95Ky9aXuCxq36OQK8qpi7W/9xsJCh1AqPw6li4611uULF/w
6X6NN7Xv+bOXFhndA0AKEn52+/zu80vpCPhK/MG7NUy9djLIX0ELM/dJQmDH8yPC
6cHK8fZpOBFaCqvTm5nwuduKRYGYfY1pdgQ1g6D9s/sMcwTESxBITIovTdtIKjq4
d5WvFvIXKzP/DgiPrHyOhfNcRgyQN4RDwdm4tCxQLHFGOwS9nUwSaottCMOVQCYM
GZTIiWGky7/1vOa5ynJVkItUTopwqiBKtsnOIxCGCaryEunp0dQ=
=1Rra
-----END PGP SIGNATURE-----
--=-=-=--
