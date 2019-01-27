Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F595C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5338F2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="JwtL4Yo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfA0Oun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:50:43 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25403 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0Oum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:50:42 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548600613; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UZEYNpdlWQwGViVnj4QfVOmnSVC2MXlOZsYHui0AqmUhMXMHoITkLLJ9j5fQZ451aWe5Qhch/WiFDhvtugJGwItdLp1SRb4TbEL78+dwqiytiAfuOA+uvheGiAow/bpprVCvAPwODfq7l3abvQ8/ig6Gl8C5M5FiS2NpfZg03gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548600613; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=uN4+A7naitFJKFYnJDq/jILFR4HnUlGZCEHcXnjmL0w=; 
        b=kDfzTqwfrsuYjX4fNXR8jImexmz9E38k0pp1EVTL+rPRa5TAk5FT/2pKbznYGdDoZHsrpiuCe9avzNlrTbx9BTcYgpC7yc0wi/Q2D7uiBmSy3tA/Hx49pjpXUQGQZ+id5d88Y3lfN7RUSG2L/PZjkU+cirU9ZXuNGgkfc1fRfbU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=nhubtxqt4q5ZggzVIVLM785WALesYOZrTvogHphuGjhFJngIbbNzSVeNk9dcXdvqeMNacs1oZ/EW
    VP5uh37X4JLAI3paEaFcHrBQaovldzgEAcN50MFKyCw9sRIxOlqj  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548600613;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=3483; bh=uN4+A7naitFJKFYnJDq/jILFR4HnUlGZCEHcXnjmL0w=;
        b=JwtL4Yo1dvkrK6TZFXnu8O/X4Yl9W+sG7yDZT/grpd34w0zIj22ZJJqTQfF7aSxx
        SPAdeZGSJpMe/F+DZL9QVI4h6VAU/QrlCAUwpNOHumC03eMKuFhaRCLciRbCrxzvwfq
        j+QOOcUb6GjdlT7zDjk6ve6dkHGXlAQRaxlJ8+bc=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548600611364948.3124948972608; Sun, 27 Jan 2019 06:50:11 -0800 (PST)
Subject: Re: [PATCH 1/4] Irqchip: Ingenic: Change interrupt handling form
 cascade to chained_irq.
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
 <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
 <86o982wgcr.wl-marc.zyngier@arm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, jason@lakedaemon.net,
        tglx@linutronix.de, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4DC50F.1000202@zoho.com>
Date:   Sun, 27 Jan 2019 22:49:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <86o982wgcr.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My fault, in the function "generic_handle_irq" should use "bit" instead=20
of "__fls(irq_reg)".
It will be fixed in the v2.

On 2019=E5=B9=B401=E6=9C=8827=E6=97=A5 18:21, Marc Zyngier wrote:
> On Sat, 26 Jan 2019 15:38:40 +0000,
> Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>> The interrupt handling method is changed from old-style cascade to
>> chained_irq which is more appropriate. Also, it can process the
>> corner situation that more than one irq is coming to a single
>> chip at the same time.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/irqchip/irq-ingenic.c | 49 ++++++++++++++++++++++-------------=
--------
>>   1 file changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic=
.c
>> index 2ff0898..2713ec4 100644
>> --- a/drivers/irqchip/irq-ingenic.c
>> +++ b/drivers/irqchip/irq-ingenic.c
>> @@ -1,16 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>   /*
>>    *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> - *  JZ4740 platform IRQ support
>> - *
>> - *  This program is free software; you can redistribute it and/or modif=
y it
>> - *  under  the terms of the GNU General=09 Public License as published =
by the
>> - *  Free Software Foundation;  either version 2 of the License, or (at =
your
>> - *  option) any later version.
>> - *
>> - *  You should have received a copy of the GNU General Public License a=
long
>> - *  with this program; if not, write to the Free Software Foundation, I=
nc.,
>> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>> - *
>> + *  Ingenic XBurst platform IRQ support
>>    */
>>  =20
>>   #include <linux/errno.h>
>> @@ -19,6 +10,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/ioport.h>
>>   #include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>>   #include <linux/irqchip/ingenic.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_irq.h>
>> @@ -41,22 +33,35 @@ struct ingenic_intc_data {
>>   #define JZ_REG_INTC_PENDING=090x10
>>   #define CHIP_SIZE=09=090x20
>>  =20
>> -static irqreturn_t intc_cascade(int irq, void *data)
>> +static void ingenic_chained_handle_irq(struct irq_desc *desc)
>>   {
>> -=09struct ingenic_intc_data *intc =3D irq_get_handler_data(irq);
>> -=09uint32_t irq_reg;
>> +=09struct ingenic_intc_data *intc =3D irq_desc_get_handler_data(desc);
>> +=09struct irq_chip *chip =3D irq_desc_get_chip(desc);
>> +=09bool have_irq =3D false;
>> +=09u32 pending;
>>   =09unsigned i;
>>  =20
>> +=09chained_irq_enter(chip, desc);
>>   =09for (i =3D 0; i < intc->num_chips; i++) {
>> -=09=09irq_reg =3D readl(intc->base + (i * CHIP_SIZE) +
>> +=09=09pending =3D readl(intc->base + (i * CHIP_SIZE) +
>>   =09=09=09=09JZ_REG_INTC_PENDING);
>> -=09=09if (!irq_reg)
>> +=09=09if (!pending)
>>   =09=09=09continue;
>>  =20
>> -=09=09generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
>> +=09=09have_irq =3D true;
>> +=09=09while (pending) {
>> +=09=09=09int bit =3D __ffs(pending);
> So 'bit' is the least significant bit in the pending word,
>
>> +
>> +=09=09=09generic_handle_irq(__fls(pending) + (i * 32) +
> and here you handle the *most significant* bit,
>
>> +=09=09=09=09=09JZ4740_IRQ_BASE);
>> +=09=09=09pending &=3D ~BIT(bit);
> yet it is the least significant bit that you clear. I am tempted to
> say that you have never tested this code with more than a single
> interrupt.
>
> Thanks,
>
> =09M.
>



