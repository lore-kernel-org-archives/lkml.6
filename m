Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73028C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D00B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="FIFv9mF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D00B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPWKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:10:09 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42707 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeJPWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:10:09 -0400
Received: by mail-vk1-f194.google.com with SMTP id s129so456294vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lGUG5ILzEdj8i+d2ziAO67cZztPLKU6+lT4ER+ot0HQ=;
        b=FIFv9mF1VYlvIp/1SjVMaw1n/7X6jQOdR4J9GlfmAnpgLM+4b6cif5+dl60AC8VHbw
         AhpywmKv4Jvh8ec9OPRHnbyYwWv2LPwgwxxOLP9Xqj4qq/+dCjOo0sH0zmOdfy6zFUno
         5NyrNbUDDVpX9LUk15b8Kx225mOUS4Uxyap9G8XniyDfpYR5182Mk/HMSN8XL1K3bnHN
         MNTJwA1DsXe3dtx96sFqwExx/YQs3/B7yy+hoqYJfuRw7h7Y7vkcPMfmRgaKn7kZTPdR
         YFpUug14RiRR9tA4IxSZJwSTvbMFYKp7gKuMqaHmLFKkBMgYbnb+hr5+8flPl4QnCQBQ
         Sf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lGUG5ILzEdj8i+d2ziAO67cZztPLKU6+lT4ER+ot0HQ=;
        b=WHb6e+x+nqPg/QpIjHCokXzLDdxjE4/11RBpuO5uJQfJPEvinwWo2nVcighv69cn05
         JaRMLK6wZ8s5Vtx4ZPEOBUdw1mzyoLqfviVB73PA0KmoMCC2wk/gnc/m5aW+9oeXyIIm
         oJoeFHFwXiF5huiAo96/DKWvFTNcbtq0lTXYO/Fex4gA62BtQvYRHQ1eQiPcnx34IrWC
         GzDF9lvLWR0xakNDP32IcgOwk5Kk95S3GGuyt/6IhEJhnFip7vmcJ+5sxD6RU2Ke5Epz
         Y3JVFsGDvalps3PsZAkM9NvcOQf9BBYRRvOYNyW9rXH3XQNAzc8ncXGj/zHfOArJb1FH
         TnIg==
X-Gm-Message-State: ABuFfogdazZa3u6OM/S+BI335SpBNFKsQL8rPwXWN30fB7IjyGebMqZd
        N16LR5pvkneal5GUGFnwiv2gc5dgYG6p7QSFqjkc5w==
X-Google-Smtp-Source: ACcGV616tjKgEf1bxxdvQfwBasxYKjBNaw2yC1gVFG1vIybXlWqo3ZzEub8ArZrHNwZEYuWqHZTxRRMFY5GFCbu1ZK0=
X-Received: by 2002:a1f:8252:: with SMTP id e79mr8599085vkd.62.1539699567378;
 Tue, 16 Oct 2018 07:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181007125815.8392-1-jonas@threetimestwo.org> <4836921.pHbLXnhTfm@ws-140106>
In-Reply-To: <4836921.pHbLXnhTfm@ws-140106>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Tue, 16 Oct 2018 16:19:15 +0200
Message-ID: <CALDOjzh4+gtFk2ezvY4MYCT_rhjUdhfjdYgNFakA=TaXk5Oo2Q@mail.gmail.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
To:     alexander.stein@systec-electronic.com
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:03 PM Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
>
> Do you have CONFIG_CPU_ICACHE_DISABLE enabled?
> I wonder why I-cache is disabled. I know about this errata, AT91SAM9G20 i=
s affected as well.
>

Hi Alexander!

I just checked, we do not have CONFIG_CPU_ICACHE_DISABLE enabled.
I wonder as well! If you have any idea I can try them out on my board tomor=
row!

The effect of enabling them is real. I have managed over 1000 reboots
with this patch.
And at the most 20 without.

> Best regards,
> Alexander

Jonas

>
> On Sunday, October 7, 2018, 2:57:45 PM CEST Jonas Danielsson wrote:
> > From: Jonas Danielsson <jonas@orbital-systems.com>
> >
> > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > hang at reboot. At the most we managed 16 boot loops without a hang.
> >
> > With this patch applied the problem has not been observed and the board
> > has managed above 250 boot loops.
> >
> > The AT91SAM9260 datasheet tells us that with the instruction cache
> > disabled all instructions are fetched from SDRAM. And we have an errata
> > telling us we must power down the SDRAM before issuing cpu reset.
> >
> > This means we need the instruction cache enabled in at91sam9260_reset()
> > At the moment it is being disabled in cpu_proc_fin() which is called fr=
om
> > arch/arm/kernel/reboot.c.
> >
> > Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> > ---
> >  drivers/power/reset/at91-reset.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c
> > index f44a9ffcc2ab..78972bba64df 100644
> > --- a/drivers/power/reset/at91-reset.c
> > +++ b/drivers/power/reset/at91-reset.c
> > @@ -50,14 +50,24 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_=
base;
> >  static struct clk *sclk;
> >
> >  /*
> > -* unless the SDRAM is cleanly shutdown before we hit the
> > +* Errata 43.1.7.1 RSTC: Reset during SDRAM Accesses
> > +*
> > +* Unless the SDRAM is cleanly shutdown before we hit the
> >  * reset register it can be left driving the data bus and
> >  * killing the chance of a subsequent boot from NAND
> > +*
> > +* Since we are disabling SDRAM need to make sure that the
> > +* instruction cache is enabled.
> >  */
> >  static int at91sam9260_restart(struct notifier_block *this, unsigned l=
ong mode,
> >                              void *cmd)
> >  {
> >       asm volatile(
> > +             /* Enable I-cache */
> > +             "mrc    p15, 0, r0, c1, c0, 0\n\t"
> > +             "orr    r0, r0, #4096\n\t" /* CR_I (bit 12) */
> > +             "mcr    p15, 0, r0, c1, c0, 0\n\t"
> > +
> >               /* Align to cache lines */
> >               ".balign 32\n\t"
> >
> >
>
>
> --
> SYS TEC electronic GmbH
> Am Windrad 2
> 08468 Heinsdorfergrund
> Germany
> Telefon : +49 (0) 3765 38600-0
> Fax     : +49 (0) 3765 38600-4100
> Email   : alexander.stein@systec-electronic.com
> Website : http://www.systec-electronic.com
>
> Managing Director   : Dipl.-Phys. Siegmar Schmidt
> Commercial registry : Amtsgericht Chemnitz, HRB 28082
> USt.-Id Nr.         : DE150534010
>
> Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte=
 Informationen.
> Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=C3=BCmli=
ch erhalten haben, informieren Sie bitte sofort den Absender und vernichten=
 Sie diese Mail.
> Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail sind n=
icht gestattet.
>
> This e-mail may contain confidential and/or privileged information.
> If you are not the intended recipient (or have received this e-mail in er=
ror) please notify the sender immediately and destroy this e-mail.
> Any unauthorized copying, disclosure or distribution of the material in t=
his e-mail is strictly forbidden.
>
>


--=20






JONAS DANIELSSON
Software Developer

+46 72 361 5022
Malm=C3=B6 - Sweden

ORBITAL SYSTEMS
orbital-systems.com




The information contained in this message is intended for the personal
and confidential use of the designated recipients named above and may
contain confidential and/or privileged material. If the reader of this
message is not the intended recipient or an agent responsible for
delivering it to the intended recipient, you are hereby notified that
you have received this document in error, and that any review,
dissemination, distribution, or copying of this message is strictly
prohibited. If you have received this communication in error, please
notify the sender immediately and delete this e-mail from your system.

Although this transmission and any attachments are believed to be free
of any virus or other defect that might affect any computer system
into which it is received and opened, it is the responsibility of the
recipient to ensure that it is virus free and no responsibility is
accepted by ORBITAL SYSTEMS AB, its subsidiaries and affiliates, as
applicable, for any loss or damage arising in any way.
