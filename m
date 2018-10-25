Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB8BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783ED2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gpfGn+mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783ED2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJYWjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:39:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60400 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJYWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HE4iFcyPC+8hu5gdN5JBY9HN7c8veRR2q40wLLU4Iqs=; b=gpfGn+mNJ+YN7PoNXKDzXGSzI
        vZSl0XsQxl3JOKP16+bx9Sp7clJFbD2GUVhDuHT4zW7KkYTPMP3IlyqZtojUhuLAh3YVNCtXnbSZu
        ncugwvx9dY4lxBtdb6uULjCAOWeN+IdRx08FvpofXu9yx1lvJLilUCleprZ2hWEgng2Sk=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:52037)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFgHY-0007zw-Oe; Thu, 25 Oct 2018 15:06:40 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFgHV-0007NS-OQ; Thu, 25 Oct 2018 15:06:37 +0100
Date:   Thu, 25 Oct 2018 15:06:36 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        christoffer.dall@arm.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        bcm-kernel-feedback-list@broadcom.com, andreyknvl@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] of/fdt: Absorb ARM64's
 __early_init_dt_declare_initrd()
Message-ID: <20181025140636.GA30658@n2100.armlinux.org.uk>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
 <20181025001742.6510-2-f.fainelli@gmail.com>
 <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:25:04AM -0500, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 7:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > ARM64 is the only architecture that requires a re-definition of
> > __early_init_dt_declare_initrd(), absorb its custom implemention in
> > drivers/of/fdt.c.
> >
> > Suggested-by: Rob Herring <robh@kernel.org.
> 
> You forgot a shift key. :)
> 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/of/fdt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 800ad252cf9c..7d316f008f22 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
> >  static void __early_init_dt_declare_initrd(unsigned long start,
> >                                            unsigned long end)
> >  {
> > +#if IS_ENABLED(CONFIG_ARM64)
> 
> C code, not preprocessor please.
> 
> > +       initrd_start = start;
> > +       initrd_end = end;
> 
> Thinking some more about this, perhaps it is better to just add the
> *_phys variants now along side the VA variants and set them here. Then
> the arm64 code can override the initrd_start, initrd_end, and
> initrd_below_start_ok values.

Please, let's not make the age old mistake of inventing new symbols
for stuff that already exists:

$ grep phys_initrd_start arch/ -rl
arch/arm/mm/init.c
arch/nds32/mm/init.c
arch/unicore32/mm/init.c
$ grep initrd_start_phys arch/ -rl
$

Please use the "phys_initrd_start" and "phys_initrd_end" naming,
which already exist on some architectures rather than inventing a new
set of symbols for the same thing and then forcing arches to change.
We could then get rid of:

        /* FDT scan will populate initrd_start */
        if (initrd_start && !phys_initrd_size) {
                phys_initrd_start = __virt_to_phys(initrd_start);
                phys_initrd_size = initrd_end - initrd_start;
        }

        initrd_start = initrd_end = 0;

in ARM, which exists purely to cope with DT.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
