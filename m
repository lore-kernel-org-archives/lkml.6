Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21DC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D11B24E62
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 08:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GYSHA2BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D11B24E62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeFXI5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 04:57:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:64051 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeFXI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 04:57:10 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5O8v5Ja032666;
        Sun, 24 Jun 2018 17:57:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5O8v5Ja032666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529830626;
        bh=hCbj/YoFpi46cDjMGu1pcESpJ3SXvUqJBVK143TE5RU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GYSHA2BLKJG1LkStUo84igDLlxlnLSLCSKkJ7qcsTkL3y5h2wLqxrG2I5uR24Hnwa
         D0Eutffjv90PRXSgaond0ly4vHd6lv5owf9wCbBNtMxL3MDm5cusujVaoNCzLb7YtM
         6aas+O+xMBAsWAlyORCMe62WoRwdmWD1Jcuvi0vLCGvEQ6KDqdDsYKMD/KjbqnaCxg
         JmrYziKy+4iKsddwmDm4dDB0iZ46AgY/HSHy1QbOu8f79BBh5AqQSFK1tBZxRT4Uno
         EmMb8pR++7fOK8Cq6wCogR3wmqpLbwi385sb3stIkXvalGl9tLDk9Ql5V/sOBqZxW3
         TIN4IeEuOENBg==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id o138-v6so6213038vkd.3;
        Sun, 24 Jun 2018 01:57:06 -0700 (PDT)
X-Gm-Message-State: APt69E3B9kldDYqvuQ6wScFnVA0BgfAieJwoQiRAUwVJy1AjAn9M3wc5
        2CeZLS4i5sT0s89qULbpNCntQWC66YIQd4DRA/I=
X-Google-Smtp-Source: ADUXVKLhv00jRUAvh+pE99uLBUAXbKJGE0/hGiHzvVJyH4Ji9KhMTDFxLo4k9RAq71rIBUmaaJqEtNDlk/tCDRW+mVk=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr5083645vke.54.1529830625404;
 Sun, 24 Jun 2018 01:57:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 01:56:24
 -0700 (PDT)
In-Reply-To: <201806240006.eCGYTuNX%fengguang.wu@intel.com>
References: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com> <201806240006.eCGYTuNX%fengguang.wu@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 24 Jun 2018 17:56:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARv7VyPaew6XpRiYqh1YTapj-oErGuiq4rS1_BmEjC8Lw@mail.gmail.com>
Message-ID: <CAK7LNARv7VyPaew6XpRiYqh1YTapj-oErGuiq4rS1_BmEjC8Lw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kbuild: use 'include' directive to load auto.conf
 from top Makefile
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-06-24 3:59 GMT+09:00 kbuild test robot <lkp@intel.com>:
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on kbuild/for-next]
> [also build test ERROR on v4.18-rc1 next-20180622]
> [cannot apply to mmarek/for-next mmarek/rc-fixes]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-use-include-directive-to-load-auto-conf-from-top-Makefile/20180623-220114
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> config: xtensa-nommu_kc705_defconfig (attached as .config)
> compiler: xtensa-de212-elf-gcc (crosstool-NG crosstool-ng-1.23.0-307-g452ee331) 7.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.3.0 make.cross ARCH=xtensa

This did not work for me
because the make.cross script tries to download GCC 7.3.0 xtensa-linux
but it is missing in the web site.

$ GCC_VERSION=7.3.0 make.cross ARCH=xtensa
Cannot find xtensa-linux under
https://download.01.org/0day-ci/cross-package check
/tmp/crosstool-files


I installed xtensa-de212-elf-gcc by hand,
but I could not reproduce the error.


GCC_VERSION=7.2.0 make.cross ARCH=xtensa
worked, but I could not reproduce the issue either.
(the build terminated with a different error.)


Where can I see the full build log?


> All errors (new ones prefixed by >>):
>
>>> Makefile:592: include/config/auto.conf: No such file or directory
>    drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type
>    <stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-Wcpp]
>    <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
>
> vim +592 Makefile
>
>    590
>    591  ifeq ($(dot-config),1)
>  > 592  include include/config/auto.conf
>    593  endif
>    594
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best Regards
Masahiro Yamada
