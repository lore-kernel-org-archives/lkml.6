Return-Path: <eric@anholt.net>
X-Google-Smtp-Source: AIpwx4+1c3LV4SO95YKEKFDA3AcOagg3Q5qEGo3MJvfRlIVo9jn0QLRjYyG1QQmPZ/ikbfBbSE+j
ARC-Seal: i=1; a=rsa-sha256; t=1523302780; cv=none;
        d=google.com; s=arc-20160816;
        b=q+7tRJNKDgnnYjhMebWtYAmhtAPASMk5RlW0wJn7sKZ03+aydL8nFSVsScvOaxog/L
         Js6VrrUD558gi4hwqiyWCVtroZIvzyv4+uhPXw9LPlmRCYnZBZoflcN+Pu+5QZtDM76t
         UcLzz3kr3+OqZN4r04zNz9oxjkvHlWaZN4dDe2JfwCCnCwXUHUOr/GB6IfsrjhA6Sxua
         +gOirjto5JCjYXE3eALiNh9rKxdkI017AOTMFP2IYFSTfG6ZoWqBv+wh/C6HYE/8tPq5
         bWHKrjSPf9eYhHHI1ZN+uiFI69ESYqK+RXLDqEOkNS2qm8xJ1935c+HFuxBqVtUqtgg7
         E1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=AHLBxORWEQH+WU8Eapxn1ni2Si4bbxg0EPNJYi8d6yw=;
        b=RXDlVcdroGEG1T/GWpDGlaHrfPTg9LwTZlWxkzkFsXRNZy13lPstFGhJhgiS1xG69W
         R/TEY8B0zhmFS+iRqh5Wu2G6VW1yZUwAFHKemGawvFlezzh8Zvc5TUvrd2t/bEanUEfj
         knWVVMFIsWEzTHrGfEQELh0zlPZts3AwdnT7ELTBeIGHOtaUEOKAAxO9fLJSKGxCr+D+
         SjtFYJK0TVbg7SQdw6uhZ0kDYRZ6xnD8h66ei4sfiTuMY8jt5Kj2/fDYZxvc5ffFJIQQ
         2YGdgLZnPl+Fq8/BqhGA4mCnNcTQgwFy/bYk+GVBKNWTw5MO/0PYlgXMsppZuEUzzuMB
         MNFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure
In-Reply-To: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 09 Apr 2018 12:39:37 -0700
Message-ID: <87muycw4na.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597298736781587566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> If CONFIG_RASPBERRYPI_FIRMWARE=3Dn:
>
>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gpi=
o_get_polarity=E2=80=99:
>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: =E2=80=98get.polarit=
y=E2=80=99 is used uninitialized in this function
>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gpi=
o_get_direction=E2=80=99:
>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: =E2=80=98get.direct=
ion=E2=80=99 is used uninitialized in this function
>
> The dummy firmware interface functions return 0, which means success,
> causing subsequent code to make use of the never initialized output
> parameter.
>
> Fix this by making the dummy functions return an error code (-ENOSYS)
> instead.
>
> Note that this assumes the firmware always fills in the requested data
> in the CONFIG_RASPBERRYPI_FIRMWARE=3Dy case.
>
> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware fun=
ctions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

You should definitely not be calling these if rpi_firmware_get() failed,
so this seems like a good solution.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrLwXkACgkQtdYpNtH8
nuh2WQ/+JptLzv1KnWerohYv1FMIuzJL1mhg/BZUTBqkHx2Tp1SyJ6a8/+MpVQ9Q
4INe5it8Jeu+dRlOig2r9pNB4614rlQuk8bVmyp12PTnF91XmTANfXMmPd2XLWme
EyydjBjx26cLRTP2lBA6NuM4jouaqiO74GAOvy3jwAUzK7Wk2DlL3lgj4alb77A/
cfunOumi3NFt7Yq4PT5fuN/CkBT01qPU6yzRQPu3QhscyXm982TafcSdLS+6l0eS
Kwi92VhtELTiuT047ShL/FbLtT7ISnrTYMKUXHsgpbhvVJSBESDS0tk2tLe9t9cs
1LtD90y31XeNh1MAUsu4A+USB7PdzKWEpCF3pYSW56Iw+cQcHgKVVVE4P+PHycRG
8XVN6IYu7LjPOMDGLyYPPhOvIwvhB7u30JAy6bi11kJagf1RiHN7Eg6lzxT9NlXo
p4MqzG3qhr6mwLVfP3TopVOQ6VDeuaOFu1v1guA2G8No4z6upfxBpwwVe5eUqmKo
Q84gFA6L3agScWlFFcPhMQ9X/ss4osBg4wChXDdkHI4ShQnvETjgMB/oKYKa8sKG
Aqycd9oho8p227UTrg+gAnH01D2acnqJI8c9Jgqu3uKZTDUjLOoVg2/m6pdoQJJP
wSA+wn0JfMkCtq5Xyg+vwzV/smdmhT9n6+0A1ZQ9oACiHia/73A=
=tHsI
-----END PGP SIGNATURE-----
--=-=-=--
