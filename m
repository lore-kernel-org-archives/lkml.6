Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDZGYa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:24:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:21482 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeDZGY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:24:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,329,1520924400";
   d="scan'208";a="219482852"
Date: Thu, 26 Apr 2018 14:23:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: kbuild-all@01.org, perex@perex.cz, tiwai@suse.com, arnd@arndb.de,
        baolin.wang@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, mingo@kernel.org,
        elfring@users.sourceforge.net, dan.carpenter@oracle.com,
        jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com,
        subhransu.s.prusty@intel.com, bhumirks@gmail.com,
        gudishax.kranthikumar@intel.com, naveen.m@intel.com,
        hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] ALSA: add new 32-bit layout for
 snd_pcm_mmap_status/control
Message-ID: <201804261232.TfqG5NRE%fengguang.wu@intel.com>
References: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.17-rc2]
[cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/soc/sh/rcar/core.c:773:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:773:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:774:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:774:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:780:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:780:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:781:33: sparse: expression using sizeof(void)
   sound/soc/sh/rcar/core.c:781:33: sparse: expression using sizeof(void)
--
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
--
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm.c:1169:67: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm.c:1169:67:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm.c:1169:67:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm.c:401:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm.c:438:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm.c:499:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm.c:1032:32: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm.c:1032:32:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm.c:1032:32:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm.c:1064:9: sparse: context imbalance in 'snd_pcm_detach_substream' - different lock contexts for basic block
--
   sound/core/pcm_native.c:561:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:653:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:654:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:655:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:727:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:727:38:    expected int [signed] state
   sound/core/pcm_native.c:727:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:739:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:739:38:    expected int [signed] state
   sound/core/pcm_native.c:739:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:776:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:777:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:788:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:788:38:    expected int [signed] state
   sound/core/pcm_native.c:788:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:803:39: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:884:23: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got signed int [srestricted snd_pcm_state_t [usertype] state @@
   sound/core/pcm_native.c:884:23:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:884:23:    got signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:885:33: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] suspended_state @@    got signed int [srestricted snd_pcm_state_t [usertype] suspended_state @@
   sound/core/pcm_native.c:885:33:    expected restricted snd_pcm_state_t [usertype] suspended_state
   sound/core/pcm_native.c:885:33:    got signed int [signed] [usertype] [explicitly-signed] suspended_state
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:927:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:928:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:935:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:996:34: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:996:34:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:996:34:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
   sound/core/pcm_native.c:1007:44: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] suspended_state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] suspended_state @@
   sound/core/pcm_native.c:1007:44:    expected signed int [signed] [usertype] [explicitly-signed] suspended_state
   sound/core/pcm_native.c:1007:44:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
   sound/core/pcm_native.c:1031:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1230:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1284:31: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1284:31:    expected int [signed] state
   sound/core/pcm_native.c:1284:31:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1291:40: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1291:40:    expected int [signed] state
   sound/core/pcm_native.c:1291:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1300:39: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1343:64: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1343:64:    expected int [signed] state
   sound/core/pcm_native.c:1343:64:    got restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1359:38: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1359:38:    expected int [signed] state
   sound/core/pcm_native.c:1359:38:    got restricted snd_pcm_state_t [usertype] <noident>
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1393:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1395:46: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1432:40: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1432:40:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1432:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1437:40: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1437:40:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1437:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1463:39: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1485:32: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1485:32:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1485:32:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1569:49: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1570:50: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1624:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1627:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1644:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1645:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1646:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1647:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1696:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1697:39: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1718:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1718:38:    expected int [signed] state
   sound/core/pcm_native.c:1718:38:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1746:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1749:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1767:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1768:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1769:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1784:61: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1784:61:    expected int [signed] state
   sound/core/pcm_native.c:1784:61:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1785:63: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1785:63:    expected int [signed] state
   sound/core/pcm_native.c:1785:63:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1787:56: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1787:56:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1787:56:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1791:48: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1791:48:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1791:48:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1794:48: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1794:48:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1794:48:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1781:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1790:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1793:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1801:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1802:76: sparse: incorrect type in initializer (different base types) @@    expected int [signed] new_state @@    got restricted snint [signed] new_state @@
   sound/core/pcm_native.c:1802:76:    expected int [signed] new_state
   sound/core/pcm_native.c:1802:76:    got restricted snd_pcm_state_t
   sound/core/pcm_native.c:1809:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1951:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1952:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1957:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1850:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1862:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1888:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1905:40: sparse: expression using sizeof(void)
   sound/core/pcm_native.c:1905:40: sparse: expression using sizeof(void)
   sound/core/pcm_native.c:1918:66: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2006:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2123:26: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2127:54: sparse: incorrect type in argument 1 (different base types) @@    expected restricted snd_pcm_format_t [usertype] format @@    got ricted snd_pcm_format_t [usertype] format @@
   sound/core/pcm_native.c:2127:54:    expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2127:54:    got unsigned int [unsigned] [assigned] k
   sound/core/pcm_native.c:2145:26: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2149:54: sparse: incorrect type in argument 1 (different base types) @@    expected restricted snd_pcm_format_t [usertype] format @@    got ricted snd_pcm_format_t [usertype] format @@
   sound/core/pcm_native.c:2149:54:    expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2149:54:    got unsigned int [unsigned] [assigned] k
   sound/core/pcm_native.c:2329:30: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2331:30: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2334:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2336:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2338:38: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2348:86: sparse: restricted snd_pcm_subformat_t degrades to integer
   sound/core/pcm_native.c:2418:58: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2613:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2617:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2619:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2620:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2622:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2624:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:2942:39: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:1093:47: sparse: too many warnings
   In file included from sound/core/pcm_native.c:3728:0:
   sound/core/pcm_compat.c: In function 'snd_pcm_ioctl_compat':
   sound/core/pcm_compat.c:580:2: error: duplicate case value
     case SNDRV_PCM_IOCTL_SYNC_PTR_X32:
     ^~~~
   sound/core/pcm_compat.c:547:2: note: previously used here
     case __SNDRV_PCM_IOCTL_SYNC_PTR64:
     ^~~~
--
   sound/core/pcm_lib.c:205:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1032:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1032:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1033:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1033:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1405:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1405:34: sparse: expression using sizeof(void)
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1851:37: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1851:37: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1882:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1885:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1888:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1894:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1895:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1896:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1899:22: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2069:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2077:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2078:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2079:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2081:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2083:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2178:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2186:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2197:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:2205:42: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:2205:42: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:2245:47: sparse: restricted snd_pcm_state_t degrades to integer
--
   sound/drivers/aloop.c:235:45: sparse: restricted snd_pcm_format_t degrades to integer
   sound/drivers/aloop.c:238:39: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/drivers/aloop.c:238:39:    expected unsigned int [unsigned] format
   sound/drivers/aloop.c:238:39:    got restricted snd_pcm_format_t [usertype] format
>> sound/drivers/aloop.c:411:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/drivers/aloop.c:914:34: sparse: incorrect type in assignment (different base types) @@    expected long [signed] max @@    got restricted snd_pcm_formatlong [signed] max @@
   sound/drivers/aloop.c:914:34:    expected long [signed] max
   sound/drivers/aloop.c:914:34:    got restricted snd_pcm_format_t [usertype] <noident>
   sound/drivers/aloop.c:1040:39: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/drivers/aloop.c:1040:39:    expected unsigned int [unsigned] format
   sound/drivers/aloop.c:1040:39:    got restricted snd_pcm_format_t [usertype] <noident>
--
>> sound/hda/hdmi_chmap.c:777:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/hda/hdmi_chmap.c:778:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/hda/hdmi_chmap.c:780:14: sparse: restricted snd_pcm_state_t degrades to integer
--
>> include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
--
>> sound/core/oss/pcm_oss.c:1225:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1226:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1243:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1255:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1256:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1266:54: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1277:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1296:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1297:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1314:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1325:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1326:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:1336:54: sparse: restricted snd_pcm_state_t degrades to integer
>> sound/core/oss/pcm_oss.c:1618:23: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got signed int [srestricted snd_pcm_state_t [usertype] state @@
   sound/core/oss/pcm_oss.c:1618:23:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/oss/pcm_oss.c:1618:23:    got signed int [signed] [usertype] [explicitly-signed] state
   include/sound/pcm.h:1093:47: sparse: cast removes address space of expression
   sound/core/oss/pcm_oss.c:1854:55: sparse: incorrect type in argument 1 (different base types) @@    expected restricted snd_pcm_format_t [usertype] format @@    got pcm_format_t [usertype] format @@
   sound/core/oss/pcm_oss.c:1854:55:    expected restricted snd_pcm_format_t [usertype] format
   sound/core/oss/pcm_oss.c:1854:55:    got int [signed] [assigned] fmt
   sound/core/oss/pcm_oss.c:2821:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/oss/pcm_oss.c:2822:48: sparse: restricted snd_pcm_state_t degrades to integer
>> sound/core/oss/pcm_oss.c:2832:29: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] ostate @@    got signed int [srestricted snd_pcm_state_t [usertype] ostate @@
   sound/core/oss/pcm_oss.c:2832:29:    expected restricted snd_pcm_state_t [usertype] ostate
   sound/core/oss/pcm_oss.c:2832:29:    got signed int [signed] [usertype] [explicitly-signed] state
>> sound/core/oss/pcm_oss.c:2833:46: sparse: call with no type!
--
   sound/firewire/bebob/bebob_pcm.c:32:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:32:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:33:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:33:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:61:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:61:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:62:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:62:25: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:86:36: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:86:36: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:87:36: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:87:36: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:89:32: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:89:32: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:90:32: sparse: expression using sizeof(void)
   sound/firewire/bebob/bebob_pcm.c:90:32: sparse: expression using sizeof(void)
>> sound/firewire/bebob/bebob_pcm.c:200:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/bebob/bebob_pcm.c:220:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/bebob/bebob_pcm.c:234:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/bebob/bebob_pcm.c:249:50: sparse: restricted snd_pcm_state_t degrades to integer
--
   sound/firewire/dice/dice-pcm.c:82:17: sparse: expression using sizeof(void)
>> sound/firewire/dice/dice-pcm.c:136:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/dice/dice-pcm.c:155:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/dice/dice-pcm.c:170:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/dice/dice-pcm.c:186:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/dice/dice-pcm.c:335:31: sparse: expression using sizeof(void)
   sound/firewire/dice/dice-pcm.c:341:32: sparse: expression using sizeof(void)
--
   sound/firewire/digi00x/digi00x-pcm.c:28:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:28:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:29:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:29:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:51:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:51:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:52:25: sparse: expression using sizeof(void)
   sound/firewire/digi00x/digi00x-pcm.c:52:25: sparse: expression using sizeof(void)
>> sound/firewire/digi00x/digi00x-pcm.c:169:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/digi00x/digi00x-pcm.c:189:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/digi00x/digi00x-pcm.c:204:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/digi00x/digi00x-pcm.c:220:50: sparse: restricted snd_pcm_state_t degrades to integer

vim +676 include/sound/pcm.h

30b771cf8 Takashi Iwai   2014-10-30  637  
30b771cf8 Takashi Iwai   2014-10-30  638  /**
30b771cf8 Takashi Iwai   2014-10-30  639   * snd_pcm_stream_lock_irqsave - Lock the PCM stream
30b771cf8 Takashi Iwai   2014-10-30  640   * @substream: PCM substream
30b771cf8 Takashi Iwai   2014-10-30  641   * @flags: irq flags
30b771cf8 Takashi Iwai   2014-10-30  642   *
30b771cf8 Takashi Iwai   2014-10-30  643   * This locks the PCM stream like snd_pcm_stream_lock() but with the local
30b771cf8 Takashi Iwai   2014-10-30  644   * IRQ (only when nonatomic is false).  In nonatomic case, this is identical
30b771cf8 Takashi Iwai   2014-10-30  645   * as snd_pcm_stream_lock().
30b771cf8 Takashi Iwai   2014-10-30  646   */
^1da177e4 Linus Torvalds 2005-04-16  647  #define snd_pcm_stream_lock_irqsave(substream, flags)		 \
^1da177e4 Linus Torvalds 2005-04-16  648  	do {							 \
7af142f75 Takashi Iwai   2014-09-01  649  		typecheck(unsigned long, flags);		 \
7af142f75 Takashi Iwai   2014-09-01  650  		flags = _snd_pcm_stream_lock_irqsave(substream); \
^1da177e4 Linus Torvalds 2005-04-16  651  	} while (0)
7af142f75 Takashi Iwai   2014-09-01  652  void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
7af142f75 Takashi Iwai   2014-09-01  653  				      unsigned long flags);
^1da177e4 Linus Torvalds 2005-04-16  654  
30b771cf8 Takashi Iwai   2014-10-30  655  /**
30b771cf8 Takashi Iwai   2014-10-30  656   * snd_pcm_group_for_each_entry - iterate over the linked substreams
30b771cf8 Takashi Iwai   2014-10-30  657   * @s: the iterator
30b771cf8 Takashi Iwai   2014-10-30  658   * @substream: the substream
30b771cf8 Takashi Iwai   2014-10-30  659   *
30b771cf8 Takashi Iwai   2014-10-30  660   * Iterate over the all linked substreams to the given @substream.
30b771cf8 Takashi Iwai   2014-10-30  661   * When @substream isn't linked with any others, this gives returns @substream
30b771cf8 Takashi Iwai   2014-10-30  662   * itself once.
30b771cf8 Takashi Iwai   2014-10-30  663   */
ef991b95a Takashi Iwai   2007-02-22  664  #define snd_pcm_group_for_each_entry(s, substream) \
ef991b95a Takashi Iwai   2007-02-22  665  	list_for_each_entry(s, &substream->group->substreams, link_list)
^1da177e4 Linus Torvalds 2005-04-16  666  
30b771cf8 Takashi Iwai   2014-10-30  667  /**
30b771cf8 Takashi Iwai   2014-10-30  668   * snd_pcm_running - Check whether the substream is in a running state
30b771cf8 Takashi Iwai   2014-10-30  669   * @substream: substream to check
30b771cf8 Takashi Iwai   2014-10-30  670   *
30b771cf8 Takashi Iwai   2014-10-30  671   * Returns true if the given substream is in the state RUNNING, or in the
30b771cf8 Takashi Iwai   2014-10-30  672   * state DRAINING for playback.
30b771cf8 Takashi Iwai   2014-10-30  673   */
877211f5e Takashi Iwai   2005-11-17  674  static inline int snd_pcm_running(struct snd_pcm_substream *substream)
^1da177e4 Linus Torvalds 2005-04-16  675  {
^1da177e4 Linus Torvalds 2005-04-16 @676  	return (substream->runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
^1da177e4 Linus Torvalds 2005-04-16  677  		(substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING &&
^1da177e4 Linus Torvalds 2005-04-16  678  		 substream->stream == SNDRV_PCM_STREAM_PLAYBACK));
^1da177e4 Linus Torvalds 2005-04-16  679  }
^1da177e4 Linus Torvalds 2005-04-16  680  

:::::: The code at line 676 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
