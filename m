Return-Path: <kernel-hardening-return-12599-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsi5Z25jyZtqe80E1VOqEpkVvv3fDeIZGL7M8tgJ6z2Fw5qlr3oNN6+rT9kPAl4bNKWlBxI
ARC-Seal: i=1; a=rsa-sha256; t=1521035574; cv=none;
        d=google.com; s=arc-20160816;
        b=IB2qXeuamCe15AE00oYJqJTHWScQryttB8YZBVOu/CxIlRTaI050VU9VnSRAhOcJOG
         0LkN3Q6lYCgtVmoaL8zzZ36IHA7yKk8ock5KlmGd6LQ2WeqRDOSJxnp04fYmGdtqmt5J
         2UHPtCiCA0PUqE1iXh5SGD1f7nYPEm469w2pzBtrbqGM2HNlqRsg3/qk+e018f4Y69S9
         iWaE+B0LywGiUI+YbXZuSFlUXsZEu/ZkpoIXiKbsE6j6ITY1cQ6cnLxhz3o8XfJ3mv9b
         COzHIpZr27/qT+AhGhN0LIYxO/qSPtBXf9kgWoZazzai39BvOlSAf2xTFQVYc6MF1wfZ
         ZX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=PzLuAGZKzr8wfzrb1CrlCZ8fZgynhA5+/oWBrSwSvQY=;
        b=C7VJEBwnaX3hpW7Q1EvDxKm2Ui+hFagv4Cc1j7nkMKy7pg7ooGm7rpnnAmF/K4o6b3
         WWW51m5+EvvdVHJCzxvM9S03SxrLtorHwpGk2JaOWlCsu70MySpZDlwf/gIKLRbqJoUS
         S7S/0BOIVzazx0g0Ti2D7u+hYruGWNQ9xrIo3qxjo3MzxEUYAzTipzwbKaKGvCU02LIl
         xRRIwrcj733FZwrgupZLqVLIdPTsm7g9URybCakjm5/klI6+Bf/pXgd0Q1V4kgwYpDYx
         AtcedCeWovDORoX9aaESPD2igpn826pKV4sJFoE7CVe+AAgoSBRbz4iQoMKQgsFj1IXV
         Zs4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chronox.de header.s=strato-dkim-0002 header.b=JQNCu31q;
       spf=pass (google.com: domain of kernel-hardening-return-12599-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12599-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chronox.de header.s=strato-dkim-0002 header.b=JQNCu31q;
       spf=pass (google.com: domain of kernel-hardening-return-12599-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12599-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7UitqoI1j72u2V/AXnS74hsOoMO59NEAAKweXfYQ==
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
Date: Wed, 14 Mar 2018 14:52:29 +0100
Message-ID: <2286764.GK92XWVYGX@tauon.chronox.de>
In-Reply-To: <CAJHCu1LOhCcCcYqbKWFi1ac+raxoHGm75Y_njGHQD=S+9ZE1Xg@mail.gmail.com>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com> <4726635.XOh0VtZf4O@tauon.chronox.de> <CAJHCu1LOhCcCcYqbKWFi1ac+raxoHGm75Y_njGHQD=S+9ZE1Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594921398340142059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, 14. M=E4rz 2018, 14:46:29 CET schrieb Salvatore Mesoraca:

Hi Salvatore,

> 2018-03-14 14:31 GMT+01:00 Stephan Mueller <smueller@chronox.de>:
> > Am Mittwoch, 14. M=E4rz 2018, 14:17:30 CET schrieb Salvatore Mesoraca:
> >=20
> > Hi Salvatore,
> >=20
> >>       if (walk.nbytes) {
> >>=20
> >> -             crypto_ctr_crypt_final(&walk, child);
> >> -             err =3D blkcipher_walk_done(desc, &walk, 0);
> >> +             err =3D crypto_ctr_crypt_final(&walk, child);
> >> +             err =3D blkcipher_walk_done(desc, &walk, err);
> >=20
> > I guess you either want to handle the error from crypto_ctr_crypt_final=
 or
> > do an err |=3D blkcipher_walk_done.
>=20
> I think that blkcipher_walk_done handles and returns the error for me.
> Am I wrong?

You are right as you want to finalize the crypto operation even though the=
=20
encryption fails.

Please disregard my comment.
>=20
> Best regards,
>=20
> Salvatore



Ciao
Stephan
