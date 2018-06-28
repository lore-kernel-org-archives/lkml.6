Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4EFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE95216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="szszYERX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE95216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966189AbeF1Nkh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:40:37 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25231 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965245AbeF1Nkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:40:35 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5SDeEQR001705;
        Thu, 28 Jun 2018 22:40:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5SDeEQR001705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530193215;
        bh=8qe21NudDhwnIm2BZIu/COYCTDIJMlNY6Fj/t4XEifk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=szszYERX3oF0pJappMJGMC3cNFAOKxlJiyVErpbSxpC8kTqY/miTlHUsjMFZ/eyKR
         aQgP32fENEs1r8V/TNfUOuZHRjDD3famhiejoSQFQAHDNA8qlJyhi8scVfqYycxB9Y
         5Q9QYuowUG+nJ6fQs5upIiD9z/BJ94rm0cU4den6J0aN+5dD68v0awA2ZaVOtMuanu
         P8ZkyjFl09Gh/lV+oI7tY9Z67tcTgEvp7/48LpjWnp4EyLlcgdWWX8CxrVXzL968jS
         L1M5Kw7S5xO5F0IZbFTfdi0gglhP7F08cg8L+LNdeZOqx2IL8N4GhReqwtSpsxl+Lp
         E+zfrjDa60nMg==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id l64-v6so3289459vkl.12;
        Thu, 28 Jun 2018 06:40:14 -0700 (PDT)
X-Gm-Message-State: APt69E2L6t5dJCI9ai9yaVNdKmgbEeMXS3ks4twSFp3X74ltuqHJM5bw
        DZ6wUnTSMMB31KQULQ6Vt2zmHGSHbo5XHp4wyzM=
X-Google-Smtp-Source: AAOMgpeBtz8Dp7S+JxqSVgR9Mn7AITmnoqACaONt+7JYiWMN9YVH6uR80VtPPGfkaf+0kK9AwV4J0jLS3aslqZo4q3M=
X-Received: by 2002:a1f:d982:: with SMTP id q124-v6mr6320387vkg.166.1530193213755;
 Thu, 28 Jun 2018 06:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 06:39:33
 -0700 (PDT)
In-Reply-To: <201806240006.eCGYTuNX%fengguang.wu@intel.com>
References: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com> <201806240006.eCGYTuNX%fengguang.wu@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Jun 2018 22:39:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATEc6SO9ws9zS7zAnQThKf8q1bK1S3DdSGKfipDz8sAhA@mail.gmail.com>
Message-ID: <CAK7LNATEc6SO9ws9zS7zAnQThKf8q1bK1S3DdSGKfipDz8sAhA@mail.gmail.com>
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
>
> All errors (new ones prefixed by >>):
>
>>> Makefile:592: include/config/auto.conf: No such file or directory


I was able to reproduce this.


This depends on the version of GNU Make.

The warning is displayed if you use GNU Make 4.1 or older.
No more annoying warning is displayed for GNU Make 4.2 or later.

Probably, this commit in GNU Make:

commit 87a5f98d248fe63fe6e3e53ee3e1b1b1fa5e49dc
Author: Paul Smith <psmith@gnu.org>
Date:   Sat Apr 9 19:49:27 2016 -0400

    [SV 102] Don't show unnecessary include file errors.


However, 4.2 is quite new.  I will do something with it.


Thanks.






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
