Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AIpwx4/GT1155sju+YhZL7ZoQ4XdiClBdaxI5Z1hV6kU+4pXqH3TxCoT7CrJIKXovWYJyyIyRZgJ
ARC-Seal: i=1; a=rsa-sha256; t=1523186889; cv=none;
        d=google.com; s=arc-20160816;
        b=sOQU7gBr16OjgbVWMSRXoej+AQLTEsr1kQOOZIemDNhIIwY4Jl538g73Q280Vzh2aO
         XKHcbJShdLFvN0v5fAqVs3SpzSHig/XYpVs745KIEDC/2FkEmBBXyVhmQj5BzTFhOBKc
         0M02LSAGXkpF3YYy9Cu+uDLK5qSg7OtHCmW8n/7tAiL1atCPAr4/SW0nO7H810zCcEMF
         CSrBycxixc7OYBa/FJ0/Osz1zpPrB+pJKVGqzTaRgu6FSSHGbviNvLTnNPWobdT3Q8gG
         TgsMlmLcnoxvwFEVNo3wClGyf3U+rJYX3G6lS4w3tNtV1njX7KH0N7Ff06GMVeIWURWq
         OCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=NVV3oLzOJTiUJEiTdQsGPMtdSouzSJX9slEWwaOMhDU=;
        b=es/9VmXEsSeCA/c9wF1MmitjKww58kPrvc1hLEn01HjQwjDLgLgt6GObAs3gYSNnEP
         x3tcH0/SVPJ6pa9Nu0Jqi0FDEFZ+O+a/hXWsk9fKFn8rgBkrNTX6DdHaDQCaNhKzyfqu
         tnms5yC2rtqwbg1ev6xDbRhgdTtMw+jvebr667iR7h6geMQYhlz7Kzk1yTbFGdgQGb+i
         +Vkr2OAnQq8ThNJyzoiGIHf4PhZL1XkLl3a+JP7yTWZoNee+xxRUZkNAQwWrq07sAtHR
         a21Smb8zPXQfH1FNjpAP7vSTt/zi4XAy7SXG2alvDe7cSoYoAosi4PTAmDFDZ4ZqxraO
         tglg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Sun, 8 Apr 2018 13:28:04 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Scott Branden <sbranden@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	phil@raspberrypi.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <2047337098.98106.1523186884813@email.1und1.de>
In-Reply-To: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:xxB1SbtqIrBEmGVLl5/LrRcV4SwoOHH63deXNlflL69lxDUYbLB
 Uoj5mVcda7Y2dI3M4ChzQKILc4Xsn+mnYtYBrfZJR6LkifoHehMKKlpcHmCfGy81InbVMSB
 Fa52BzxIIlchmJx7ExWvgctAx6g44SEnBkiMnJboQqPABOYKxP/PbETAvkKe7BE9Fkb+5GM
 zMU739VjQ1gb5q90J6/Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hFG2G3BXAF4=:7eA/GqjwKOSRX6JW8N7Ggh
 spgtAISX9gm/jVSpefuFMw+xxrkp8qJ04xhf9wy6YG8Yu5TEPDKkqTUFXTJwqihll3PTitBML
 wxoIed0UhTzy5feVzRuFZjCrzqA++jTDKCFVL0Nn17WtLdY2hxpwA5kjhu2k8LViDA3tL/43T
 4iNXN0HqQoxOZp+SkataSYtwZ2ZOqNeTIlWY6hrKhZ4E4e8b1flY1gf/JigtboKfjHqoTyt7r
 5Qo4GsaurxWp5IC22IpH+qdeoSoGfwftA/pw39AGtt/oXNWd4HeSIf7cjkv4MhpK7TCIZxYS/
 xxS3uVOjZTOb7KR+TTqmT824uXE03jffF98nsdUvHAxJuPDpO8clvvgBt8DcyG0oKAlh7fAfB
 wFRBys7+8exavaJjTOxHGO59XlX7offBFUvUM+fu1a2GnuidtOvRXD0ByCCRJ9YHihTOnR+9X
 RWN6RYWWQhbvi8RFaW4cxbM3vrYYAb/DZYwYYUfL2C6bvc2eVi26neEkDFXGkrpN4tsO3hAP1
 diCSjf/LMd7ecqvp/icp4nErkp4Y1T+YbrvWpFS6VpGuzwsivBK6Ilm1dHUKQaqdOatI+N8jg
 DW+HGItzWe+/5udT1z8e2nTRXXPmXjX38CT9VYrztU200S5Avae7TUmMJCK802HgQ/RoPCqyY
 jmdk8ntuEH66qYHJYh8AcnX8svGj2sCMwUWnwHXVZW16N/XKipL5qeWpxN2NRnsPEGaUm8eHY
 mIQ1fOksKVKXFY1K6dHpQDLiau2CUwE36qskkzz7CJm/fsrfWa7e8bH5YfU=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597177216541053037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

[add Phil]

> Geert Uytterhoeven <geert@linux-m68k.org> hat am 8. April 2018 um 11:05 g=
eschrieben:
>=20
>=20
> If CONFIG_RASPBERRYPI_FIRMWARE=3Dn:
>=20
>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gpi=
o_get_polarity=E2=80=99:
>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: =E2=80=98get.polarit=
y=E2=80=99 is used uninitialized in this function
>     drivers/gpio/gpio-raspberrypi-exp.c: In function =E2=80=98rpi_exp_gpi=
o_get_direction=E2=80=99:
>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: =E2=80=98get.direct=
ion=E2=80=99 is used uninitialized in this function
>=20
> The dummy firmware interface functions return 0, which means success,
> causing subsequent code to make use of the never initialized output
> parameter.

i think this is more theoritical, because we need to get rpi_firmware first=
 and in this case it's NULL.

>=20
> Fix this by making the dummy functions return an error code (-ENOSYS)
> instead.

Anyway i'm okay with the change.

>=20
> Note that this assumes the firmware always fills in the requested data
> in the CONFIG_RASPBERRYPI_FIRMWARE=3Dy case.

Unfortunately i don't know.

>=20
> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware fun=
ctions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Should get.polarity resp. get.direction be preinitialized instead,
> like is done for get.state?
>=20
> static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
> {
>         ...
>         get.state =3D 0;          /* storage for returned value */
>=20
>         ret =3D rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STA=
TE,
>                                          &get, sizeof(get));
>         ...
> }
>=20
> This would avoid returning uninitialized data if the firmware did not
> fill in the requested data.
> ---
>  include/soc/bcm2835/raspberrypi-firmware.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm=
2835/raspberrypi-firmware.h
> index 50df5b28d2c9df6e..8ee8991aa099af3a 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -143,13 +143,13 @@ struct rpi_firmware *rpi_firmware_get(struct device=
_node *firmware_node);
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag=
,
>  =09=09=09=09=09void *data, size_t len)
>  {
> -=09return 0;
> +=09return -ENOSYS;
>  }
> =20
>  static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
>  =09=09=09=09=09     void *data, size_t tag_size)
>  {
> -=09return 0;
> +=09return -ENOSYS;
>  }
> =20
>  static inline struct rpi_firmware *rpi_firmware_get(struct device_node *=
firmware_node)
> --=20
> 2.7.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
