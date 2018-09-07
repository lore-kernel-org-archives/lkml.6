Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B819EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQhSFjUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF5C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIGWvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeIGWvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:51:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522E320844;
        Fri,  7 Sep 2018 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536343787;
        bh=L7wGbreVhUx1lVJ7CVnPLtPFbdFKVn8p5oVnUSyARqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KQhSFjUZzyN++d/akpeQRDO9XrzlAMqK2rU2u3uNOQFTVcBDx0gNa61/8O8qejST+
         r1r4gYo/r8rd9AIMTSYSYG10KFBEcyYBsvzZWPJ9NT1n7+bGeGZGXiMrKU7kcVBUwS
         wI3dvLR/4KsqP8E+3jCBEvST0BCaTwGYlxVoVz88=
Received: by mail-qk1-f170.google.com with SMTP id c126-v6so10238216qkd.7;
        Fri, 07 Sep 2018 11:09:47 -0700 (PDT)
X-Gm-Message-State: APzg51A56EqusimwGeTh7yuiAeWM7Czep1lwohwggowZuieGKSExcEap
        ctEoUwSLayDlLjyTZtN3J9U3SIjCE+vAOSkW+g==
X-Google-Smtp-Source: ANB0VdZf2csLfiwJsB788g+pL8BJveaTSsPChLMvQyma0gOP3sxDqS5sJ8rTDdWsTfLaIrDjGs+Mn1n4UprELUCBfF8=
X-Received: by 2002:a37:f19:: with SMTP id z25-v6mr6791434qkg.147.1536343786511;
 Fri, 07 Sep 2018 11:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180905235327.5996-1-robh@kernel.org> <20180905235327.5996-3-robh@kernel.org>
 <1536286895.6128.4.camel@intel.com>
In-Reply-To: <1536286895.6128.4.camel@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Sep 2018 13:09:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ocQEUsm-JBEeMfnkKRSRO3-UrvA7no+c3Cmp44c0OGg@mail.gmail.com>
Message-ID: <CAL_Jsq+ocQEUsm-JBEeMfnkKRSRO3-UrvA7no+c3Cmp44c0OGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] nios2: build .dtb files in dts directory
To:     ley.foon.tan@intel.com
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        nios2-dev@lists.rocketboards.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 9:21 PM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
>
> On Wed, 2018-09-05 at 18:53 -0500, Rob Herring wrote:
> > Align nios2 with other architectures which build the dtb files in the
> > same directory as the dts files. This is also in line with most other
> > build targets which are located in the same directory as the source.
> > This move will help enable the 'dtbs' target which builds all the
> > dtbs
> > regardless of kernel config.
> >
> > This transition could break some scripts if they expect dtb files in
> > the old location.
> >
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: nios2-dev@lists.rocketboards.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack so I can take the whole series via the DT tree.
> >
> >  arch/nios2/Makefile          | 4 ++--
> >  arch/nios2/boot/Makefile     | 4 ----
> >  arch/nios2/boot/dts/Makefile | 1 +
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/nios2/boot/dts/Makefile
> >
> > diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
> > index 8673a79dca9c..50eece1c6adb 100644
> > --- a/arch/nios2/Makefile
> > +++ b/arch/nios2/Makefile
> > @@ -59,10 +59,10 @@ archclean:
> >         $(Q)$(MAKE) $(clean)=$(nios2-boot)
> >
> >  %.dtb: | scripts
> > -       $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> > +       $(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
> >
> >  dtbs:
> > -       $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> > +       $(Q)$(MAKE) $(build)=$(nios2-boot)/dts
> >
> >  $(BOOT_TARGETS): vmlinux
> >         $(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
> > diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
> > index 2ba23a679732..007586094dde 100644
> > --- a/arch/nios2/boot/Makefile
> > +++ b/arch/nios2/boot/Makefile
> > @@ -47,10 +47,6 @@ obj-$(CONFIG_NIOS2_DTB_SOURCE_BOOL) +=
> > linked_dtb.o
> >
> >  targets += $(dtb-y)
> >
> > -# Rule to build device tree blobs with make command
> > -$(obj)/%.dtb: $(src)/dts/%.dts FORCE
> > -       $(call if_changed_dep,dtc)
> > -
> >  $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
> >
> >  install:
> > diff --git a/arch/nios2/boot/dts/Makefile
> > b/arch/nios2/boot/dts/Makefile
> > new file mode 100644
> > index 000000000000..f66554cd5c45
> > --- /dev/null
> > +++ b/arch/nios2/boot/dts/Makefile
> > @@ -0,0 +1 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > --
> > 2.17.1
> >
> Hi Rob
>
> I have synced your all-dtbs branch from here: https://git.kernel.org/pu
> b/scm/linux/kernel/git/robh/linux.git/log/?h=all-dtbs
>
> It shows error when compile kernel image and also when "make
> dtbs_install".

Can you fetch the branch again and try it. I fixed a few dependency issues.

> make dtbs_install
> make[1]: *** No rule to make target
> 'arch/nios2/boot/dts/arch/nios2/boot/dts/10m50_devboard.dtb', needed by
> 'arch/nios2/boot/dts/arch/nios2/boot/dts/10m50_devboard.dtb.S'.  Stop.

What is the value of CONFIG_NIOS2_DTB_SOURCE? As patch 3 notes, it now
should not have any path.

If that's a problem, I could take the basename to strip the path, but
then sub directories wouldn't work either.

BTW, next up, I want to consolidate the config variables for built-in dtbs.

Rob
