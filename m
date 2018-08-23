Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC09C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13345208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1+P8yKvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13345208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeHWNSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:18:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56831 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeHWNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:18:44 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7N9njx2020706
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 18:49:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7N9njx2020706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535017786;
        bh=TvPzzZ4JKLxUrlhEGeuicQFu2C5eFPVhdxxqB2/nKS8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1+P8yKvqUii95nG2896QQyvZ2JICvt/e7F4ZA99rF9SEMRuHKOgUk6mEUL61Jk4pj
         botS2dIkpJAybokwA7h3JZ3InqRG4Lx8XmXeZPRFx6uVDHa87KIRwViOKLQX8rtnmZ
         1Df6/HBNkIrlC16HVKtcskX4zBdcmWvTGfEPQFYAqRD+Y23bIrJ3ozo9GxwfV+q/zF
         ziJpiJdp9fb5RRbg+D6ycJcK/aMEgR4kjc2PDPyCop0HsbvRc2pWcDEOvAIsB/QFGe
         Oxw3tUAqUn49JCnYfWcpNMqdzpxPW5iOS/HBg0qWZFmr7U3cCsYJFBXjOK/940JooZ
         z5fF6TJVrviUA==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id e139-v6so2291790vkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:49:45 -0700 (PDT)
X-Gm-Message-State: APzg51BoJHilx+gBbmaGLJgl+M1zmhHR0H782mz1eFgFlPxhD4m2hkIf
        Zdw+r4K78uRFXuM3Kk088jRMAx3Rr5NMvN+9SM0=
X-Google-Smtp-Source: ANB0VdYgtfpBIgNeqT89ZwlzA9KhICYr8bpL76K2jjdGwwb09i7ovxTZsUcHLRBEdKhD9LXEM82V/bol46hEu3MUlH0=
X-Received: by 2002:a1f:793:: with SMTP id 141-v6mr6932590vkh.42.1535017784686;
 Thu, 23 Aug 2018 02:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 02:49:04
 -0700 (PDT)
In-Reply-To: <201808230645.ugGOpzNO%fengguang.wu@intel.com>
References: <201808230645.ugGOpzNO%fengguang.wu@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 18:49:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATT2JCRCnm6uux_QP74rd1Vvyns4zrJWYCDGyG34tHv8g@mail.gmail.com>
Message-ID: <CAK7LNATT2JCRCnm6uux_QP74rd1Vvyns4zrJWYCDGyG34tHv8g@mail.gmail.com>
Subject: Re: microblaze-linux-ld: cannot find sound/soc/jz4740/jz4740-i2s.o:
 No such file or directory
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-08-23 7:40 GMT+09:00 kbuild test robot <lkp@intel.com>:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   899fbc33fd775b9dfa363db28f322272920a2196
> commit: 0fbe9a245c60bedebb6dd329966f463bb724450a microblaze: add endianness options to LDFLAGS instead of LD
> date:   4 weeks ago
> config: microblaze-allmodconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 0fbe9a245c60bedebb6dd329966f463bb724450a
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=microblaze
>
> All errors (new ones prefixed by >>):
>
>>> microblaze-linux-ld: cannot find sound/soc/jz4740/jz4740-i2s.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find sound/soc/jz4740/qi_lb60.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find sound/soc/kirkwood/kirkwood-dma.o: No such file or directory
>>> microblaze-linux-ld: cannot find sound/soc/kirkwood/kirkwood-i2s.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find sound/soc/kirkwood/armada-370-db.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find drivers/media/usb/uvc/uvc_driver.o: No such file or directory
>>> microblaze-linux-ld: cannot find drivers/media/usb/uvc/uvc_v4l2.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find drivers/gpu/drm/vc4/vc4_fence.o: No such file or directory
>>> microblaze-linux-ld: cannot find drivers/gpu/drm/vc4/vc4_gem.o: No such file or directory
> --
>>> microblaze-linux-ld: cannot find drivers/media/pci/cobalt/cobalt-driver.o: No such file or directory
>>> microblaze-linux-ld: cannot find drivers/media/pci/cobalt/cobalt-v4l2.o: No such file or directory
>>> microblaze-linux-ld: cannot find drivers/media/pci/cobalt/cobalt-flash.o: No such file or directory
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


Thanks for the report.

I will fix this.

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 93b8e24..f5d7612 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -220,7 +220,7 @@ sub_cmd_record_mcount = set -e ; perl
$(srctree)/scripts/recordmcount.pl "$(ARCH
        "$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
        "$(if $(CONFIG_64BIT),64,32)" \
        "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
-       "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
+       "$(LD) $(LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
        "$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT





-- 
Best Regards
Masahiro Yamada
