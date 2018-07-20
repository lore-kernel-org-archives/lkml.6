Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2C420647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FMzsqSIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbeGTTrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:47:53 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46174 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbeGTTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:47:53 -0400
Date:   Fri, 20 Jul 2018 20:58:08 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1532113088.2309.0@smtp.crapouillou.net>
In-Reply-To: <20180720153027.GA11978@rob-hp-laptop>
References: <20180713143840.9721-1-paul@crapouillou.net>
        <20180720153027.GA11978@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532113096; bh=noGxpj1/96O+CqOPZKl3PFvnJEXE/W2MVqYzhUqJlRA=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=FMzsqSIojRwtmkGINWjvdr9iHlLf9ai5fbfqqjfeEDHK132zJ2os+1tQ568LYQmtA1bHPNZFmSAORBoKucw11QiH8g3yFJgZs8o7tEFbzmNfHSqVBNQUSWcDPbHIlr/eg/dTSXEOGtdMsr8mUG0k0hG9mSX57n9IDAcL0pGkiBc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le ven. 20 juil. 2018 =E0 17:30, Rob Herring <robh@kernel.org> a =E9crit :
> On Fri, Jul 13, 2018 at 04:38:40PM +0200, Paul Cercueil wrote:
>>  The UART in the jz4725b works just like in the other JZ SoCs, so=20
>> this
>>  commit simply adds a new compatible string.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
>>   drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
>>   2 files changed, 6 insertions(+)
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/serial/ingenic,uart.txt=20
>> b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  index c3c6406d5cfe..a0b34fd3b602 100644
>>  --- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
>>  @@ -3,6 +3,7 @@
>>   Required properties:
>>   - compatible : One of:
>>     - "ingenic,jz4740-uart",
>>  +  - "ingenic,jz4725b-uart",
>>     - "ingenic,jz4760-uart",
>>     - "ingenic,jz4770-uart",
>>     - "ingenic,jz4775-uart",
>>  diff --git a/drivers/tty/serial/8250/8250_ingenic.c=20
>> b/drivers/tty/serial/8250/8250_ingenic.c
>>  index 15a8c8dfa92b..760266559a5a 100644
>>  --- a/drivers/tty/serial/8250/8250_ingenic.c
>>  +++ b/drivers/tty/serial/8250/8250_ingenic.c
>>  @@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart,=20
>> ingenic_early_console_setup);
>>   OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
>>   		    ingenic_early_console_setup);
>>=20
>>  +EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
>>  +OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
>>  +		    ingenic_early_console_setup);
>>  +
>=20
> This shouldn't be necessary. Looks like it should be compatible with
> ingenic,jz4740-uart.
>=20
>>   EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
>>   OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
>>   		    ingenic_early_console_setup);
>>  @@ -330,6 +334,7 @@ static const struct ingenic_uart_config=20
>> jz4780_uart_config =3D {
>>=20
>>   static const struct of_device_id of_match[] =3D {
>>   	{ .compatible =3D "ingenic,jz4740-uart", .data =3D=20
>> &jz4740_uart_config },
>>  +	{ .compatible =3D "ingenic,jz4725b-uart", .data =3D=20
>> &jz4740_uart_config },
>=20
> And this too.

Well, I'm confused, the driver already uses multiple compatible strings=20
for SoCs that
work the exact same, so that was wrong?

>>   	{ .compatible =3D "ingenic,jz4760-uart", .data =3D=20
>> &jz4760_uart_config },
>>   	{ .compatible =3D "ingenic,jz4770-uart", .data =3D=20
>> &jz4760_uart_config },
>>   	{ .compatible =3D "ingenic,jz4775-uart", .data =3D=20
>> &jz4760_uart_config },
>>  --
>>  2.11.0
>>=20
=

