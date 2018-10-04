Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9520856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ajPt6DJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B9520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJDKBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:01:55 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:31515 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeJDKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:01:55 -0400
X-Greylist: delayed 81754 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 06:01:53 EDT
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w943AVGS029083;
        Thu, 4 Oct 2018 12:10:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w943AVGS029083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538622632;
        bh=XCc2bhNVnY24GeDtgNiWgekrdP4E0CdUVVzwq2axZU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ajPt6DJV/V8q3JQdE3WCfrVBA9g7Ow3AzPrJvRnBmzOXHv6QKJLHfvHw+341Yvpqm
         mt4K5em6qtI3UB1oxuB0GjbrXKDwOtst3oIbYyNhIGinaWe4GzvlnJ/amKBd3xVZKn
         XL5/7nNWF8VhVAslFSfazgx6JiXBMKhcZKSfhG7ovc+QPfbSVcG4HjPA7mypdKFzOM
         MvQ+5yz2dFMnsp0EE+soHKk3FIA/5GS0LNck01fymkoVLrVsXoSX4XwUhzdsUklDI9
         DqXCoABUysSfM7y77YYwF6jf0PcVzcbmrO07NEvxhW9MRev3X+p1aJfW7fbWq7LkZ6
         ecsTjNJzJ3nqg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id w85so4512712vsa.10;
        Wed, 03 Oct 2018 20:10:31 -0700 (PDT)
X-Gm-Message-State: ABuFfog9CT1ytduX1MIbh3NUAEzHsnX2DTntPOiu82SzZS3lVAi+q7eU
        WQo8r2A5vRnrPbpVEV93UMcmktwqDI9Q6JYhacQ=
X-Google-Smtp-Source: ACcGV60wYaqBr4PpRSks5bELetIB+kDnwMPQEAfvpGWnAl3ybOyyw9qy1nR0FF7hvwlhImRGnluvtc8coPak6h8eG8Q=
X-Received: by 2002:a67:3793:: with SMTP id j19mr1517297vsi.215.1538622630767;
 Wed, 03 Oct 2018 20:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181003135038.24438d97@canb.auug.org.au> <CAK7LNARD6qxX1fz4XF7yj2vWZurayhtksQnGfHBEUtCTNLmGYw@mail.gmail.com>
 <20181003165534.4bc87bbe@canb.auug.org.au> <20181004103937.5601c02a@canb.auug.org.au>
 <20181004115653.6a97e131@canb.auug.org.au>
In-Reply-To: <20181004115653.6a97e131@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Oct 2018 12:09:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsvtyU_2Lm4gPSU=q9KeAwjPCfQiwUeOjw=JjUpks_Pw@mail.gmail.com>
Message-ID: <CAK7LNAQsvtyU_2Lm4gPSU=q9KeAwjPCfQiwUeOjw=JjUpks_Pw@mail.gmail.com>
Subject: Re: linux-next: occassional build errors
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


On Thu, Oct 4, 2018 at 10:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> On Thu, 4 Oct 2018 10:39:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 3 Oct 2018 16:55:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > > >  The latest example is this:
> > > > >
> > > > > include/linux/kconfig.h: file not recognized: file format not recognized
> > > > > make[2]: *** [scripts/Makefile.build:492: crypto/crypto_user.o] Error 1
> > > > > make[1]: *** [Makefile:1057: crypto] Error 2
> > > > > make: *** [Makefile:152: sub-make] Error 2
> > > > > Command exited with non-zero status 2
> > > > >
> > > > > It is always complaining about a .h file ...
> > > > >
> > > > > Makefile:152 is the MAKE lien below:
> > > > >
> > > > > # Invoke a second make in the output directory, passing relevant variables
> > > > > sub-make:
> > > > >         $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
> > > > >         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
> > > > >
> > > > > Makefile:1057 is the MAKE line below:
> > > > >
> > > > > PHONY += $(vmlinux-dirs)
> > > > > $(vmlinux-dirs): prepare scripts
> > > > >         $(Q)$(MAKE) $(build)=$@ need-builtin=1
> > > > >
> > > > > scripts/Makefile.build:492 is the if_changed line below:
> > > > >
> > > > > $(multi-used-m): FORCE
> > > > >         $(call if_changed,link_multi-m)
> > > > >         @{ echo $(@:.o=.ko); echo $(filter-out FORCE,$^); \
> > > > >            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> > > > > $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
> > > > >
> > > > > Not sure what else I can tell you.
> > > >
> > > > Does this happen only when building a module?
> > >
> > > I don't know, sorry, I build with -s and -j80, so it is hard to tell
> > > what it is currently up to.
> >
> > Today, I got this from the x86_64 allmodconfig build after merging the hid tree:
> >
> > x86_64-linux-gnu-ld: include/config/acpi.h: file not recognized: file truncated
> > make[4]: *** [/home/sfr/next/next/scripts/Makefile.build:492: drivers/hid/i2c-hid/i2c-hid.o] Error 1
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.build:520: drivers/hid/i2c-hid] Error 2
> > make[2]: *** [/home/sfr/next/next/scripts/Makefile.build:520: drivers/hid] Error 2
> > make[1]: *** [/home/sfr/next/next/Makefile:1057: drivers] Error 2
> > make: *** [Makefile:152: sub-make] Error 2
>
> OK, it seems to have to do with an object changing from a simple build
> to a multi object build.
>
> i.e. Tuesday's linux-next has these changes:
>
>  obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
> +crypto_user-y := crypto_user_base.o crypto_user_stat.o
>  obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
>
>  obj-$(CONFIG_I2C_HID)                          += i2c-hid.o
> +
> +i2c-hid-objs                                   =  i2c-hid-core.o
> +i2c-hid-$(CONFIG_DMI)                          += i2c-hid-dmi-quirks.o
>


OK, confirmed.


This is a regression of

commit bb5de5d28f730eeec0aa1ced51a6f11327cd1201
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu Sep 13 17:20:41 2018 +0900

    kbuild: remove unneeded link_multi_deps



I will fix like follows for tomorrow's linux-next.  Thanks!




diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d7fa203..f21b48d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -486,11 +486,11 @@ targets += $(obj)/lib-ksyms.o
 endif

 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter-out FORCE,$^)
$(cmd_secanalysis)
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
$(cmd_secanalysis)

 $(multi-used-m): FORCE
        $(call if_changed,link_multi-m)
-       @{ echo $(@:.o=.ko); echo $(filter-out FORCE,$^); \
+       @{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
           $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)




-- 
Best Regards
Masahiro Yamada
