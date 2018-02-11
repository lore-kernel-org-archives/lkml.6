Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeBKJQP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:16:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:61216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeBKJQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:16:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,495,1511856000";
   d="scan'208";a="26448971"
Date: Sun, 11 Feb 2018 17:16:08 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, "Hao, Shun" <shun.hao@intel.com>
Subject: Re: Kconfig:12: can't open file "arch/powerpc64/Kconfig"
Message-ID: <20180211091608.auudrrbsjd4ljhsd@wfg-t540p.sh.intel.com>
References: <201802111111.M5DJTfR5%fengguang.wu@intel.com>
 <CAK7LNARudYhYCESdSDU7r_s8ppBp00jNok4S6jORYxTr+Lc2jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNARudYhYCESdSDU7r_s8ppBp00jNok4S6jORYxTr+Lc2jQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Sorry it looks like a regression in the robot. CC Shun for looking into this.

Thanks,
Fengguang

On Sun, Feb 11, 2018 at 01:07:32PM +0900, Masahiro Yamada wrote:
>Hi test robot,
>
>
>2018-02-11 12:41 GMT+09:00 kbuild test robot <fengguang.wu@intel.com>:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   d48fcbd864a008802a90c58a9ceddd9436d11a49
>> commit: 9e3e10c725360b9d07018cfcd5b7b6b7d325fae5 kconfig: send error messages to stderr
>> date:   2 days ago
>> config: powerpc64-defconfig
>> compiler: powerpc64-linux-gcc (GCC) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 9e3e10c725360b9d07018cfcd5b7b6b7d325fae5
>>         make.cross ARCH=powerpc64  defconfig
>>         make.cross ARCH=powerpc64
>
>
>I think this test setting is weird.
>
>With the following error, it is pointless to test this.
>
>>   Makefile:499: arch/powerpc64/Makefile: No such file or directory
>
>
>arch/powerpc64/ does not exist in the first place.
>
>
>If you really want to give ARCH=powerpc64,
>you need to add something like follows in the top Makefile
>(but I doubt this is the right thing to do)
>
>ifeq ($(ARCH),powerpc64)
>       SRCARCH := powerpc
>endif
>
>
>Could you check your test setting, please?
>
>
>
>
>
>
>> All errors (new ones prefixed by >>):
>>
>>    Makefile:499: arch/powerpc64/Makefile: No such file or directory
>>    make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
>>    make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>>>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
>>    make[2]: *** [defconfig] Error 1
>>    make[1]: *** [defconfig] Error 2
>>    make: *** [sub-make] Error 2
>> --
>>    Makefile:499: arch/powerpc64/Makefile: No such file or directory
>>    make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
>>    make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>>>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
>>    make[2]: *** [oldconfig] Error 1
>>    make[1]: *** [oldconfig] Error 2
>>    make: *** [sub-make] Error 2
>> --
>>    Makefile:499: arch/powerpc64/Makefile: No such file or directory
>>    make[1]: *** No rule to make target 'arch/powerpc64/Makefile'.
>>    make[1]: Failed to remake makefile 'arch/powerpc64/Makefile'.
>>>> Kconfig:12: can't open file "arch/powerpc64/Kconfig"
>>    make[2]: *** [olddefconfig] Error 1
>>    make[2]: Target 'oldnoconfig' not remade because of errors.
>>    make[1]: *** [oldnoconfig] Error 2
>>    make: *** [sub-make] Error 2
>>
>> vim +12 Kconfig
>>
>> 838a2e55 Arnaud Lacombe 2010-09-04   7
>> 838a2e55 Arnaud Lacombe 2010-09-04   8  config SRCARCH
>> 838a2e55 Arnaud Lacombe 2010-09-04   9          string
>> 838a2e55 Arnaud Lacombe 2010-09-04  10          option env="SRCARCH"
>> 838a2e55 Arnaud Lacombe 2010-09-04  11
>> 838a2e55 Arnaud Lacombe 2010-09-04 @12  source "arch/$SRCARCH/Kconfig"
>>
>> :::::: The code at line 12 was first introduced by commit
>> :::::: 838a2e55e6a4e9e8a10451ed2ef0f7a08dabdb04 kbuild: migrate all arch to the kconfig mainmenu upgrade
>>
>> :::::: TO: Arnaud Lacombe <lacombar@gmail.com>
>> :::::: CC: Arnaud Lacombe <lacombar@gmail.com>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>
>-- 
>Best Regards
>Masahiro Yamada
>
