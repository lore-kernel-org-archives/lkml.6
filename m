Return-Path: <corsac@debian.org>
X-Google-Smtp-Source: AH8x225gjFCJHhPFmaAOvpDrO1QN+5Fk5mi3iCaTiHwXUNP9bXmgE/9AhlEm5S6wTYk4eOiQnGYf
ARC-Seal: i=1; a=rsa-sha256; t=1518093633; cv=none;
        d=google.com; s=arc-20160816;
        b=Pd2XMfhsNbPnNzxj7nbhg+EDpx6KX5QgvoayknVqIxhWDrJWIbhN8J2t2sKjARHmo4
         jkMPJMCY5DMiBdPqsjwPYkhstFhRESygkwU6qpVig3lEjFC4wXDTK76ainRgZg3IlwFW
         Q9PKdTdIpyGEgLTOZAACSEAYCHRWZyZIBgHSgnAUh4cEADxiPitTCfHU7PZXOtsCSNNF
         +fEfgFAgNJAO534+Vvbcf5RDGjmzFSCURdSW5vxMBGNrmgd0kPk02YwRUNBXQp1o9aqt
         g1hSR8pE9M3jCWLRP19rn4KS9IETwSyEXonKPeaH6Ipr1+feR91ZCq+fMvQkFZXK8o/p
         cxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=tyYuY65BLDWhKXiyil+4BX5/wNtqOTHXK38NhPDkby4=;
        b=MDguPiFYOipeYHr5pDarzTmaTjWS9DUCyxAaNhItpN9VikQvm84Y7zqKI91jSLHbqI
         OLmFR/vmXMKlaVgiKYXkocUl8inG6PPXgt4h7fWPAXYC1NW3Al58EELqX27Fs+Ndd9M2
         uGWMkJ9mUPFpI0wfGhnW3eTyquHJ/lw7EUI29H1HInC785wV4NY5NtH1J7PxSGtFr8UG
         vJHiPNJ+3ygp+mQl0QJJNzGmIpN3o5PBwzVKzZ2dKtJOMQDs/bvRZiVozKwW9LkzBcLV
         VfdsJZvB8h/OecfmgovqhvfSQiu5Fycm4SQrl2YnN7LzJYBboJpF63lSgKBhMY8wLS5t
         cFsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 78.194.244.226 is neither permitted nor denied by best guess record for domain of corsac@debian.org) smtp.mailfrom=corsac@debian.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 78.194.244.226 is neither permitted nor denied by best guess record for domain of corsac@debian.org) smtp.mailfrom=corsac@debian.org
Message-ID: <1518093624.2997.10.camel@debian.org>
Subject: Re: Regression for ip6-in-ip4 IPsec tunnel in 4.14.16
From: Yves-Alexis Perez <corsac@debian.org>
To: Mike Maloney <maloneykernel@gmail.com>
Cc: Mike Maloney <maloney@google.com>, "David S. Miller"
 <davem@davemloft.net>,  Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 debian-kernel@lists.debian.org, Tobias Brunner <tobias@strongswan.org>
Date: Thu, 08 Feb 2018 13:40:24 +0100
In-Reply-To: <1518032786.4024.1.camel@debian.org>
References: <1518021487.2100.2.camel@debian.org>
	 <1518023139.2100.7.camel@debian.org> <1518024182.2136.3.camel@debian.org>
	 <CAJegeYkqg97ZyiJRe9ZZAk_C_KX_NrcmuK9SRrEbLzHMXfdv1Q@mail.gmail.com>
	 <1518032786.4024.1.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1M+ItS7DYMfiUOkz2pVV"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591760909212986452?=
X-GMAIL-MSGID: =?utf-8?q?1591836550379620231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-1M+ItS7DYMfiUOkz2pVV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-07 at 20:46 +0100, Yves-Alexis Perez wrote:
> Maybe. I tried with removing the MTU setting, and I get (on ping again)
>=20
> f=C3=A9vr. 07 20:44:01 scapa kernel: mtu: 1266
>=20
> which means I would get -EINVAL on standards kernels, which is not really=
 good
> either.

Actually after rebooting on the Debian 4.14.17 kernel, with the outter MTU
unset (or set to 1360), I don't get the -EINVAL anymore, so maybe it'd be O=
K.

Unfortunately I have the feeling that debugging this will be a bit tricky f=
or
other people. MTU tuning for tunnels are always a bit confusing, but having
the kernel return EINVAL on a ping doesn't really help narrowing it down to
that MTU setting. Not sure if some kind of logging could be added to help?

Regards,
--=20
Yves-Alexis
--=-1M+ItS7DYMfiUOkz2pVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlp8RTgACgkQ3rYcyPpX
RFti+wgA4Fcde2WJ7DWd4poQv9UdVn2ecwdr5s8klsNVdXAypInq1gTqublhulT6
2sV365q1LDYbTyTbHJn0brxVPNRX50xsUiRXkfrc3hB6lN8ZPya0ZUwq7ICP5Ot4
HZvaId0ZyHhOgFSO4oap3VSHXEL2S0F0xq/nanTXwfj+tMCCCf1T+BKEdOyuBLF7
OugVaRSzPWBe2jl+dQPT1u+8EhE6o1CY7wIl4Do9ybI7aXWfaC5SGYpoM6e4wd7W
nrUDA5cgRJLH8Tnl8uTGeeXDcDtiTVLXZEd+B+so0TwvqDRHgPSNPirsSlUcMtkN
tDB+A1oWnzzrb85JwWhL2HMbJri6gQ==
=CI3S
-----END PGP SIGNATURE-----

--=-1M+ItS7DYMfiUOkz2pVV--
