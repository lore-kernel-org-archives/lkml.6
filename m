Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AB8JxZrZbw/jZploFunbiT6l3KbiDVcWvZllbqpCex2jIMQ46AlxqoPchmrvhfV9/6mlRJ92BSbj
ARC-Seal: i=1; a=rsa-sha256; t=1525373452; cv=none;
        d=google.com; s=arc-20160816;
        b=blpaRJ8aVgvFPfKMLTpHNkw8VzWCStlLFyPS3g40yXVWM4dDQGXAVEBPNGgTwoIOl0
         u22926WIFfd4JxHcSJnq36QfUSQaj29isyIN9Jdl8PFyzPUEnED21LS34z6RLoz9/Yi0
         es4mHjWw5PSkDMJhS/ypzIZHG00P/6A7z19oUbRdBh5l/84lKh+xjpsQlhs4FaaI0vWH
         YfI6i8NV1Mea61YronbW/IxkcwzT+aGXXff2jsXlj1WMEjsXfDqtRPdXYPw44qv41HtZ
         8yCEiJGX7X+HmlgQaOynVIRmVhab1q4q6Mqt9zKqgxxl9oxOJ4uE7rGQ9OEOjAjELoKW
         kwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=vjErQ3NY6+q9jsSXBBJfTNoR6Wgl1S9bv8gHOvwl39E=;
        b=rj/TMJOL48LwxSi8QcyjlLpZgMRAO+fnGjxn69UAbELPQEhII24Od7f4hrBrp6vZur
         zwh1NzuQFgMAwPmUTJkqkIz7vmMuam8ornlTmJRAXc2OisAUibast0fkG2EFHiLnArCE
         Zd2ZZSCM5r1YC5gd8gCSoR4bdma7i+YuC1ZYIKg4V/CnG/ABSKZexwQbUlHp0QyyUX//
         XcD6fGZcGWn+UFFm5LPBCZz4j/VvnDoE9OCONrxvrK4QkdKhBvGol1ZmqOj8fUiSkOXY
         HwdsTSBF2WBu60DGbD76mfwiP+fdYVDr1lOX7RZVfDyg8sxzz+V+mljj6kGa/pLZlb7v
         VKXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Thu, 3 May 2018 20:50:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180503205037.7be552c1@aktux>
In-Reply-To: <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
References: <20180424163458.11947-1-johan@kernel.org>
	<20180424163458.11947-5-johan@kernel.org>
	<CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
	<20180426091018.GU4615@localhost>
	<CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
	<20180502081637.GE2285@localhost>
	<5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HLhJ7LSIWZdtL++bNKyJ94a"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599469992888490013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/HLhJ7LSIWZdtL++bNKyJ94a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 May 2018 11:35:21 +0200
H. Nikolaus Schaller <hns@goldelico.com> wrote:


> I have realized that the w2sg0004 is an exception (although a Sirf chip)
> that it does not provide a WAKEUP signal. And another significant
> difference is that we have to keep the serdev UART enabled even if there
> is no user-space client. Otherwise we are not able to detect unexpected
> activity. So we unfortunately can't move serdev open/close into the .open
> and .close ops but need to open it in probe.
>=20
how much power does it use to keep the uart enabled? Or should it
better be reprogrammed as gpio?

Regards,
Andreas

--Sig_/HLhJ7LSIWZdtL++bNKyJ94a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlrrWf0ACgkQfb1qx03i
kyQlqhAAtbo5wUH6KEaDMqYMadQUYR/q46hYFG2drKJQU2au0ZoTHugUaLZ1SY0a
PAHAfxnBYAT/SHVOn7Tp1XkdwhsTVXj2Y/S2YgYymOqD/eDwO66ncyNhP1lWQwX8
PxvtjelEqt4/U/x+QyXgp9eUltmdHDyFe4viZIAWi/ypK2Dltt4hHtry4UYdbmHu
8rQYIesshXI/aaPHbGgE6P53gWl1Qyae68w+HnpjfT79c7mvldJEWAm+bFrJjgRA
XlPnbBJ8X7T1J7V06d9xGhDd5GIYwBN8MaKTtejZ4LZs1tdAUQ029ZLVo0YNw2Ce
aT9UsymY9wHVAinBQGiA7gogwusLOgoq62wDtTRmhKdsX/aE2zx0iKn8plowTcQ4
knr+PHLT8jOnFWp8ecfCdRHIdLjywbMc8kM3oqIvXtZPDYfia2fcbySlSOJslE2V
gk7JTgSZ5OCn3W0M8MObVzifq/G2XzWrqfOGGPm29CJfsDBR5p6FPj8Iqk1/U/Rc
ITWgZWesivmVRXpQQUnoyhmKol21NI/LV7xLgVFJ2IEZzcLKz83cVoQgZKQ8oRUy
PU2dHeAHMFTURTiCW6v+i80icUxOr5gbQAjYGl8KTOfGdB1hSEMK4/L664RecgVh
vX40PHpsiAW8Hi+TvGNxI+jP7YYdKrrPEBoC6py0Q1PxBSp4W9k=
=TFvd
-----END PGP SIGNATURE-----

--Sig_/HLhJ7LSIWZdtL++bNKyJ94a--
