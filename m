Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B324C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A75521479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A75521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQAJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:09:23 -0400
Received: from anholt.net ([50.246.234.109]:45314 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeJQAJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:09:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4458910A122F;
        Tue, 16 Oct 2018 09:18:13 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oSjfAYXx_stw; Tue, 16 Oct 2018 09:18:11 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 50A0310A060E;
        Tue, 16 Oct 2018 09:18:11 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9D9422FE1BEE; Tue, 16 Oct 2018 09:18:10 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     stefan.wahren@i2se.com, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tiwai@suse.de, nsaenzjulienne@suse.de
Subject: Re: [PATCH 7/9] ARM: dts: bcm2835-rpi: add onboard audio device
In-Reply-To: <20181016150228.16994-8-nsaenzjulienne@suse.de>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de> <20181016150228.16994-8-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 16 Oct 2018 09:18:10 -0700
Message-ID: <877eih6f25.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> The audio device interfaces with VCHIQ to send audio through the rpi's
> Headphones & HDMI.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index cb2d6d78a7fb..6cc580d17862 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -35,6 +35,11 @@
>  			reg = <0x7e00b840 0xf>;
>  			interrupts = <0 2>;
>  		};
> +
> +		audio: audio {
> +			compatible = "brcm,bcm2835-audio";
> +			brcm,pwm-channels = <8>;
> +		};
>  	};
>  };

Assuming the DT binding gets acked,

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvGD0IACgkQtdYpNtH8
nuif9xAApg+DGvoIpJnp//LGcqJbH9rM/So9OtjNIl8pZLp+dJ3L0j0g9EToe2/N
fc8gDUBbeSH81O/a+rsm+DN+sp37SZ5UzFbTpuaiuDKBKcS/E577xzIfk+NRcqT7
GmAAerqj3b3jN8nJ6INXvYX6FYxoOpyvJETkjCaZuJIcGBKsAdAonghwxMJPOrCA
OUnMOrHmDvl/qXJ2yIKuJj3Tk3CRTe1HMN0EkoYIqjhHZ3UZJCS3IDtqYfTPxJZT
exLLEsol6E5T4AZddNq1bX5nLT+XO39gZZ4bg6AA2N1kfAIotp/kGjNXM2swN8ks
IjqIByjDoPiv0Ow+JoZwaD0y1AKT5EsLNKxJleZu4vRaSOa+0xcPWtcwSFYSonR0
UT5IZwNpo0EQ2rlPld1f1sqbtqNs3Is0RUXiIpJrFIoxEFsWESwMoBuCSoVz0H6j
DPpALctlRBvDqnj0lNEi5iHA0I+PbH9tbLckukeXecpIsmb/wXVlk1ZPUElyrfK7
badEgKijZn1MUJuNQoYZO704iWwDRbvm0itw6FOMgGhzMAoEBAqYaqL6kJAo0O2r
hsbcxh2geqmgVk/Qe4AmMmqklpD47xVCbuUNQm6kZ+DfY55gQL+QDZBI+JQZrMB+
pIJap0492wXd63R5ZTGrCitrF6v99D45Wqym2BFQhMZZi8inOjE=
=9slk
-----END PGP SIGNATURE-----
--=-=-=--
