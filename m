Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5CFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEAD208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UJkFF1Az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEAD208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbeHPGXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:23:54 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42756 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHPGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:23:54 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7G3SPdo017673;
        Thu, 16 Aug 2018 12:28:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7G3SPdo017673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534390106;
        bh=UmUeBq+cLjZpsoZ+ey+NnhFkHKNOoIUVwTYmWFNQoCc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UJkFF1AzrtC3hxx48EvIbzWhkRxc7l5nEmOy7rPY4J8c9IIUER9dAv73zw0+OQ9JL
         u+asdkHq44VMUwoGhSI6GO2P2pCa0Wcg7HTiOwUnkLja88BmMF0thF+0U5jK4spc8i
         UKLH75p6GtEKxRwI/ZZr0R8X0ohFz5Sbj69cxiCbdd15Nq4N8Oc0Cdst83XJurLJ5r
         DmqnE+OyZ4fiNzaDuOUhDRJO5wJZbF9F0HOuOfkTj5LOitv52P6YwiVAVkpq3WViqp
         Qx7U2zyBRTUpgqPyv9RqZsDaat1xjjbZ0XL4tDJAIF2gP5GzmziRhOnVUEYRdgmhZn
         ytgmX920JN4Gw==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id q12-v6so2853563ual.2;
        Wed, 15 Aug 2018 20:28:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlEKE+/UTz5Af9AXzrSd2TqeBXsAmj82YQZB3WV+tuRPAqS/CkSX
        XXVT/lFEOlyUch+3QNtd6+4bHXD7FB6amHbHzC4=
X-Google-Smtp-Source: AA+uWPzRqh60DrnBSK662Q/HP40mct5vuf5Jdt8OYTaXNzLAagmIUDMWHzS1Jb5SQ75UuXbEfm5QMJmimNoe0nQODHg=
X-Received: by 2002:ab0:52f1:: with SMTP id w46-v6mr18596127uaw.52.1534390105256;
 Wed, 15 Aug 2018 20:28:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 20:27:44
 -0700 (PDT)
In-Reply-To: <abba6b9a-597b-a3eb-6d91-8a7261492c78@infradead.org>
References: <abba6b9a-597b-a3eb-6d91-8a7261492c78@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 Aug 2018 12:27:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3NnWvK=jJ5a-bpYuCGtpfYztu7qPpi4Gd+6jR_62eQQ@mail.gmail.com>
Message-ID: <CAK7LNAQ3NnWvK=jJ5a-bpYuCGtpfYztu7qPpi4Gd+6jR_62eQQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add build-only configurator targets
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-15 9:36 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add build-only targets for build_menuconfig, build_nconfig,
> build_xconfig, and build_gconfig.
> (targets must end in "config" to qualify in top-level Makefile)
>
> This allows these target to be built without execution (e.g., to
> look for errors or warnings) and/or to be built and checked by sparse.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  scripts/kconfig/Makefile |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> --- linux-next-20180814.orig/scripts/kconfig/Makefile
> +++ linux-next-20180814/scripts/kconfig/Makefile
> @@ -33,6 +33,14 @@ config: $(obj)/conf
>  nconfig: $(obj)/nconf
>         $< $(silent) $(Kconfig)
>
> +build_menuconfig: $(obj)/mconf
> +
> +build_nconfig: $(obj)/nconf
> +
> +build_gconfig: $(obj)/gconf
> +
> +build_xconfig: $(obj)/qconf
> +
>  localyesconfig localmodconfig: $(obj)/conf
>         $(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
>         $(Q)if [ -f .config ]; then                                     \
>


OK, seems useful,
but these should be phony targets.

May I squash the following change?


diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index c0ca9ea..f7bdcc9 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -3,7 +3,8 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile

-PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig
+PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig \
+       build_menuconfig build_nconfig build_gconfig build_xconfig

 ifdef KBUILD_KCONFIG
 Kconfig := $(KBUILD_KCONFIG)





-- 
Best Regards
Masahiro Yamada
