Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82952205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="NEXADNZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82952205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJPWGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:06:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33537 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJPWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:06:31 -0400
Received: by mail-ua1-f67.google.com with SMTP id j13so3415811ual.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvDVrYhAXs6qMMZ59kNb7E6jjA+ioI1theBczKMNb14=;
        b=NEXADNZ4i1ErhMWb0xh9QjZrwc1s6gurSnmK+BVmDOObHuU5E/JnB1BEw8VJ9ScNgF
         xRz2NGbcDpj3WAhNIZf9paqi1VCIqAagtish99HsZqPwmmGeiuPNzIVeCmCI6pKIG1p9
         Z8NBWxhLMxHLS1iOTyOhAtLUHKrzuNCE4ZKh5SSlfMkf9SiF1SOb2KRqx7rTmBSSKcOF
         oGraDcOmgCi6zWzhfF2m30pdwLtZrU8fBsCZfJT8yJbSGv/71hLHp9I9plxBcDbisiHQ
         d0L48uvkU8Hga/21XPqPGvz3dGjw3Vyq7NEIqciNeD93WvF8/qMTBNNB4NRpec6B4G1C
         ZCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvDVrYhAXs6qMMZ59kNb7E6jjA+ioI1theBczKMNb14=;
        b=YP5rTZ0DmOJkFMDuqtKrFKhar43x6ZB7Fa39G87nK754Z1jqZyqqE/qo/vjkC2qtAM
         woTWOgm/695PE8d2HoG3ppRKot4y0t0BjR4fasQdVBR3YSIjiUWa4nDNJKnecFZ0FozG
         Yuqrl10B88nduwjZAu+1OmKNEjUS7cc77Jqsomms41/1wQ2XEH7YffsSGXnoiCI5EDMl
         bVXfoZkifw2dV6Ql/Ii6S+sYtSLjDsBC8Wk+V27DswiVRSyhayEoEcAndEzFJ5/1mVyD
         LOSS2bVmPfWoMUbQi4SCJkC60hqtjWMtZzbCpYS78aegnlzCUVXIuKM634W4BFVmQg5Y
         Zy1Q==
X-Gm-Message-State: ABuFfogIpYO7DEAaGMhLJkKhhL+GBoCTkg+zk0bcuaQh4jBTHF+V4fEx
        cTZ9XwqdEPPVWHvEflDsPtk1L90RxrgYI2OdXKEe2g==
X-Google-Smtp-Source: ACcGV62vFweSz1n4HMCRxglyZFKHWNiJWDagaHIe/BT5wq1/H/D8LiyOvar4Id2PQgSh2X42YUju6rNOHNl8xDzxBTA=
X-Received: by 2002:ab0:4812:: with SMTP id b18mr9585945uad.30.1539699349386;
 Tue, 16 Oct 2018 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181007125815.8392-1-jonas@threetimestwo.org> <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
In-Reply-To: <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Tue, 16 Oct 2018 16:15:37 +0200
Message-ID: <CALDOjzgxftbv=ePKcgXyDYZefve0Codqs5K-biDcgQRtpTRFYQ@mail.gmail.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
To:     Claudiu.Beznea@microchip.com
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:30 PM <Claudiu.Beznea@microchip.com> wrote:
>
> Hi Jonas,
>

Hi,

> On 07.10.2018 15:57, Jonas Danielsson wrote:
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
>
> Are you using kexec reboot or implemented hibernate mode on this machine?
> I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
> switching to hibernate mode.
>
> In case of normal reboot (e.g. reboot command) machine_restart() from
> arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.
>

We are not, we do regular reboots. I have read the code paths wrong.
Then I wonder what disables icache.

> Thank you,
> Claudiu Beznea

Thank you!

>
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
