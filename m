Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeDZL0A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:26:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:45893 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754347AbeDZLZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:25:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="223571223"
Date: Thu, 26 Apr 2018 19:25:13 +0800
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
Message-ID: <201804261905.bMSzVUh7%fengguang.wu@intel.com>
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
[cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
   sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
>> sound/firewire/motu/motu-pcm.c:204:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/motu/motu-pcm.c:223:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/motu/motu-pcm.c:238:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/motu/motu-pcm.c:254:50: sparse: restricted snd_pcm_state_t degrades to integer
--
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
>> sound/core/pcm.c:1169:67: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm.c:1169:67:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm.c:1169:67:    got restricted snd_pcm_state_t [usertype] <noident>
>> sound/core/pcm.c:401:39: sparse: restricted snd_pcm_state_t degrades to integer
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
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
>> sound/core/pcm_native.c:884:23: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got signed int [srestricted snd_pcm_state_t [usertype] state @@
   sound/core/pcm_native.c:884:23:    expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:884:23:    got signed int [signed] [usertype] [explicitly-signed] state
>> sound/core/pcm_native.c:885:33: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] suspended_state @@    got signed int [srestricted snd_pcm_state_t [usertype] suspended_state @@
   sound/core/pcm_native.c:885:33:    expected restricted snd_pcm_state_t [usertype] suspended_state
   sound/core/pcm_native.c:885:33:    got signed int [signed] [usertype] [explicitly-signed] suspended_state
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
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
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1343:64: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1343:64:    expected int [signed] state
   sound/core/pcm_native.c:1343:64:    got restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1359:38: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
   sound/core/pcm_native.c:1359:38:    expected int [signed] state
   sound/core/pcm_native.c:1359:38:    got restricted snd_pcm_state_t [usertype] <noident>
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1393:47: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1395:46: sparse: restricted snd_pcm_state_t degrades to integer
>> sound/core/pcm_native.c:1432:40: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1432:40:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1432:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1437:40: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1437:40:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1437:40:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1463:39: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1485:32: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/core/pcm_native.c:1485:32:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/core/pcm_native.c:1485:32:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/core/pcm_native.c:1569:49: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1570:50: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1624:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1627:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1644:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1645:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1646:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1647:14: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1696:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1697:39: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
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
>> include/sound/pcm.h:1093:47: sparse: too many warnings
   In file included from sound/core/pcm_native.c:3728:0:
   sound/core/pcm_compat.c: In function 'snd_pcm_ioctl_compat':
   sound/core/pcm_compat.c:580:2: error: duplicate case value
     case SNDRV_PCM_IOCTL_SYNC_PTR_X32:
     ^~~~
   sound/core/pcm_compat.c:547:2: note: previously used here
     case __SNDRV_PCM_IOCTL_SYNC_PTR64:
     ^~~~
--
>> sound/core/pcm_lib.c:205:39: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_lib.c:1032:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1032:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1033:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1033:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1405:34: sparse: expression using sizeof(void)
   sound/core/pcm_lib.c:1405:34: sparse: expression using sizeof(void)
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:677:55: sparse: restricted snd_pcm_state_t degrades to integer
   include/sound/pcm.h:676:54: sparse: restricted snd_pcm_state_t degrades to integer
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
   sound/firewire/oxfw/oxfw-pcm.c:34:25: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:34:25: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:35:25: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:35:25: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:100:36: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:100:36: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:101:36: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:101:36: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:103:32: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:103:32: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:104:32: sparse: expression using sizeof(void)
   sound/firewire/oxfw/oxfw-pcm.c:104:32: sparse: expression using sizeof(void)
>> sound/firewire/oxfw/oxfw-pcm.c:221:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/oxfw/oxfw-pcm.c:240:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/oxfw/oxfw-pcm.c:255:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/oxfw/oxfw-pcm.c:270:50: sparse: restricted snd_pcm_state_t degrades to integer
--
>> sound/firewire/tascam/tascam-pcm.c:98:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/tascam/tascam-pcm.c:118:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/tascam/tascam-pcm.c:133:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/tascam/tascam-pcm.c:149:50: sparse: restricted snd_pcm_state_t degrades to integer
--
   drivers/usb/gadget/function/u_uac1_legacy.c:104:21: sparse: incorrect type in assignment (different base types) @@    expected int [signed] access @@    got restricted snd_pcm_access_int [signed] access @@
   drivers/usb/gadget/function/u_uac1_legacy.c:104:21:    expected int [signed] access
   drivers/usb/gadget/function/u_uac1_legacy.c:104:21:    got restricted snd_pcm_access_t [usertype] <noident>
   drivers/usb/gadget/function/u_uac1_legacy.c:105:21: sparse: incorrect type in assignment (different base types) @@    expected int [signed] format @@    got restricted snd_pcm_format_int [signed] format @@
   drivers/usb/gadget/function/u_uac1_legacy.c:105:21:    expected int [signed] format
   drivers/usb/gadget/function/u_uac1_legacy.c:105:21:    got restricted snd_pcm_format_t [usertype] <noident>
   drivers/usb/gadget/function/u_uac1_legacy.c:135:21: sparse: incorrect type in assignment (different base types) @@    expected int [signed] access @@    got restricted sndint [signed] access @@
   drivers/usb/gadget/function/u_uac1_legacy.c:135:21:    expected int [signed] access
   drivers/usb/gadget/function/u_uac1_legacy.c:135:21:    got restricted snd_pcm_access_t
   drivers/usb/gadget/function/u_uac1_legacy.c:136:21: sparse: incorrect type in assignment (different base types) @@    expected int [signed] format @@    got restricted sndint [signed] format @@
   drivers/usb/gadget/function/u_uac1_legacy.c:136:21:    expected int [signed] format
   drivers/usb/gadget/function/u_uac1_legacy.c:136:21:    got restricted snd_pcm_format_t
>> drivers/usb/gadget/function/u_uac1_legacy.c:161:39: sparse: restricted snd_pcm_state_t degrades to integer
   drivers/usb/gadget/function/u_uac1_legacy.c:162:43: sparse: restricted snd_pcm_state_t degrades to integer
--
   sound/soc/intel/skylake/skl-pcm.c:159:43: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/soc/intel/skylake/skl-pcm.c:159:43:    expected unsigned int [unsigned] format
   sound/soc/intel/skylake/skl-pcm.c:159:43:    got restricted snd_pcm_format_t [usertype] format
   sound/soc/intel/skylake/skl-pcm.c:195:47: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/soc/intel/skylake/skl-pcm.c:195:47:    expected unsigned int [unsigned] format
   sound/soc/intel/skylake/skl-pcm.c:195:47:    got restricted snd_pcm_format_t [usertype] format
>> sound/soc/intel/skylake/skl-pcm.c:278:41: sparse: restricted snd_pcm_state_t degrades to integer
   sound/soc/intel/skylake/skl-pcm.c:574:55: sparse: restricted snd_pcm_state_t degrades to integer
--
   sound/pci/asihpi/asihpi.c:315:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:315:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:315:9:    got int
   sound/pci/asihpi/asihpi.c:318:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:318:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:318:9:    got int
   sound/pci/asihpi/asihpi.c:321:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:321:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:321:9:    got int
   sound/pci/asihpi/asihpi.c:322:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:322:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:322:9:    got int
   sound/pci/asihpi/asihpi.c:324:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:324:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:324:9:    got int
   sound/pci/asihpi/asihpi.c:325:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:325:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:325:9:    got int
   sound/pci/asihpi/asihpi.c:327:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:327:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:327:9:    got int
   sound/pci/asihpi/asihpi.c:328:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:328:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:328:9:    got int
   sound/pci/asihpi/asihpi.c:334:9: sparse: incorrect type in initializer (different base types) @@    expected restricted snd_pcm_format_t @@    got t_t @@
   sound/pci/asihpi/asihpi.c:334:9:    expected restricted snd_pcm_format_t
   sound/pci/asihpi/asihpi.c:334:9:    got int
   sound/pci/asihpi/asihpi.c:397:36: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:397:36: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:398:36: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:398:36: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:542:18: sparse: expression using sizeof(void)
>> sound/pci/asihpi/asihpi.c:668:51: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got igned] [usertype] [explicitly-signed] state @@
   sound/pci/asihpi/asihpi.c:668:51:    expected signed int [signed] [usertype] [explicitly-signed] state
   sound/pci/asihpi/asihpi.c:668:51:    got restricted snd_pcm_state_t [usertype] <noident>
   sound/pci/asihpi/asihpi.c:822:35: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:822:35: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:857:24: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:887:41: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:887:41: sparse: expression using sizeof(void)
   sound/pci/asihpi/asihpi.c:1026:49: sparse: restricted snd_pcm_format_t degrades to integer
   sound/pci/asihpi/asihpi.c:1208:49: sparse: restricted snd_pcm_format_t degrades to integer
--
   sound/firewire/fireface/ff-pcm.c:34:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:34:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:35:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:35:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:59:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:59:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:60:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:60:25: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:84:36: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:84:36: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:85:36: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:85:36: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:89:32: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:89:32: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:90:32: sparse: expression using sizeof(void)
   sound/firewire/fireface/ff-pcm.c:90:32: sparse: expression using sizeof(void)
>> sound/firewire/fireface/ff-pcm.c:202:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireface/ff-pcm.c:222:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireface/ff-pcm.c:237:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireface/ff-pcm.c:253:50: sparse: restricted snd_pcm_state_t degrades to integer
--
   sound/firewire/fireworks/fireworks_pcm.c:82:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:82:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:83:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:83:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:107:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:107:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:108:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:108:25: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:127:36: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:127:36: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:128:36: sparse: expression using sizeof(void)
   sound/firewire/fireworks/fireworks_pcm.c:128:36: sparse: expression using sizeof(void)
>> sound/firewire/fireworks/fireworks_pcm.c:233:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireworks/fireworks_pcm.c:252:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireworks/fireworks_pcm.c:265:50: sparse: restricted snd_pcm_state_t degrades to integer
   sound/firewire/fireworks/fireworks_pcm.c:279:50: sparse: restricted snd_pcm_state_t degrades to integer

vim +884 sound/core/pcm_native.c

60f96aae Takashi Sakamoto     2017-06-09  639  
877211f5 Takashi Iwai         2005-11-17  640  static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
877211f5 Takashi Iwai         2005-11-17  641  			     struct snd_pcm_hw_params *params)
^1da177e Linus Torvalds       2005-04-16  642  {
877211f5 Takashi Iwai         2005-11-17  643  	struct snd_pcm_runtime *runtime;
9442e691 Takashi Iwai         2006-09-30  644  	int err, usecs;
^1da177e Linus Torvalds       2005-04-16  645  	unsigned int bits;
^1da177e Linus Torvalds       2005-04-16  646  	snd_pcm_uframes_t frames;
^1da177e Linus Torvalds       2005-04-16  647  
7eaa943c Takashi Iwai         2008-08-08  648  	if (PCM_RUNTIME_CHECK(substream))
7eaa943c Takashi Iwai         2008-08-08  649  		return -ENXIO;
^1da177e Linus Torvalds       2005-04-16  650  	runtime = substream->runtime;
^1da177e Linus Torvalds       2005-04-16  651  	snd_pcm_stream_lock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  652  	switch (runtime->status->state) {
^1da177e Linus Torvalds       2005-04-16  653  	case SNDRV_PCM_STATE_OPEN:
^1da177e Linus Torvalds       2005-04-16  654  	case SNDRV_PCM_STATE_SETUP:
^1da177e Linus Torvalds       2005-04-16  655  	case SNDRV_PCM_STATE_PREPARED:
^1da177e Linus Torvalds       2005-04-16  656  		break;
^1da177e Linus Torvalds       2005-04-16  657  	default:
^1da177e Linus Torvalds       2005-04-16  658  		snd_pcm_stream_unlock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  659  		return -EBADFD;
^1da177e Linus Torvalds       2005-04-16  660  	}
^1da177e Linus Torvalds       2005-04-16  661  	snd_pcm_stream_unlock_irq(substream);
8eeaa2f9 Takashi Iwai         2014-02-10  662  #if IS_ENABLED(CONFIG_SND_PCM_OSS)
^1da177e Linus Torvalds       2005-04-16  663  	if (!substream->oss.oss)
^1da177e Linus Torvalds       2005-04-16  664  #endif
9c323fcb Takashi Iwai         2006-04-28  665  		if (atomic_read(&substream->mmap_count))
^1da177e Linus Torvalds       2005-04-16  666  			return -EBADFD;
^1da177e Linus Torvalds       2005-04-16  667  
^1da177e Linus Torvalds       2005-04-16  668  	params->rmask = ~0U;
^1da177e Linus Torvalds       2005-04-16  669  	err = snd_pcm_hw_refine(substream, params);
^1da177e Linus Torvalds       2005-04-16  670  	if (err < 0)
^1da177e Linus Torvalds       2005-04-16  671  		goto _error;
^1da177e Linus Torvalds       2005-04-16  672  
^1da177e Linus Torvalds       2005-04-16  673  	err = snd_pcm_hw_params_choose(substream, params);
^1da177e Linus Torvalds       2005-04-16  674  	if (err < 0)
^1da177e Linus Torvalds       2005-04-16  675  		goto _error;
^1da177e Linus Torvalds       2005-04-16  676  
f9a076bf Takashi Sakamoto     2017-06-09  677  	err = fixup_unreferenced_params(substream, params);
f9a076bf Takashi Sakamoto     2017-06-09  678  	if (err < 0)
f9a076bf Takashi Sakamoto     2017-06-09  679  		goto _error;
f9a076bf Takashi Sakamoto     2017-06-09  680  
^1da177e Linus Torvalds       2005-04-16  681  	if (substream->ops->hw_params != NULL) {
^1da177e Linus Torvalds       2005-04-16  682  		err = substream->ops->hw_params(substream, params);
^1da177e Linus Torvalds       2005-04-16  683  		if (err < 0)
^1da177e Linus Torvalds       2005-04-16  684  			goto _error;
^1da177e Linus Torvalds       2005-04-16  685  	}
^1da177e Linus Torvalds       2005-04-16  686  
^1da177e Linus Torvalds       2005-04-16  687  	runtime->access = params_access(params);
^1da177e Linus Torvalds       2005-04-16  688  	runtime->format = params_format(params);
^1da177e Linus Torvalds       2005-04-16  689  	runtime->subformat = params_subformat(params);
^1da177e Linus Torvalds       2005-04-16  690  	runtime->channels = params_channels(params);
^1da177e Linus Torvalds       2005-04-16  691  	runtime->rate = params_rate(params);
^1da177e Linus Torvalds       2005-04-16  692  	runtime->period_size = params_period_size(params);
^1da177e Linus Torvalds       2005-04-16  693  	runtime->periods = params_periods(params);
^1da177e Linus Torvalds       2005-04-16  694  	runtime->buffer_size = params_buffer_size(params);
^1da177e Linus Torvalds       2005-04-16  695  	runtime->info = params->info;
^1da177e Linus Torvalds       2005-04-16  696  	runtime->rate_num = params->rate_num;
^1da177e Linus Torvalds       2005-04-16  697  	runtime->rate_den = params->rate_den;
ab69a490 Clemens Ladisch      2010-11-15  698  	runtime->no_period_wakeup =
ab69a490 Clemens Ladisch      2010-11-15  699  			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
ab69a490 Clemens Ladisch      2010-11-15  700  			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
^1da177e Linus Torvalds       2005-04-16  701  
^1da177e Linus Torvalds       2005-04-16  702  	bits = snd_pcm_format_physical_width(runtime->format);
^1da177e Linus Torvalds       2005-04-16  703  	runtime->sample_bits = bits;
^1da177e Linus Torvalds       2005-04-16  704  	bits *= runtime->channels;
^1da177e Linus Torvalds       2005-04-16  705  	runtime->frame_bits = bits;
^1da177e Linus Torvalds       2005-04-16  706  	frames = 1;
^1da177e Linus Torvalds       2005-04-16  707  	while (bits % 8 != 0) {
^1da177e Linus Torvalds       2005-04-16  708  		bits *= 2;
^1da177e Linus Torvalds       2005-04-16  709  		frames *= 2;
^1da177e Linus Torvalds       2005-04-16  710  	}
^1da177e Linus Torvalds       2005-04-16  711  	runtime->byte_align = bits / 8;
^1da177e Linus Torvalds       2005-04-16  712  	runtime->min_align = frames;
^1da177e Linus Torvalds       2005-04-16  713  
^1da177e Linus Torvalds       2005-04-16  714  	/* Default sw params */
^1da177e Linus Torvalds       2005-04-16  715  	runtime->tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
^1da177e Linus Torvalds       2005-04-16  716  	runtime->period_step = 1;
^1da177e Linus Torvalds       2005-04-16  717  	runtime->control->avail_min = runtime->period_size;
^1da177e Linus Torvalds       2005-04-16  718  	runtime->start_threshold = 1;
^1da177e Linus Torvalds       2005-04-16  719  	runtime->stop_threshold = runtime->buffer_size;
^1da177e Linus Torvalds       2005-04-16  720  	runtime->silence_threshold = 0;
^1da177e Linus Torvalds       2005-04-16  721  	runtime->silence_size = 0;
ead4046b Clemens Ladisch      2010-05-21  722  	runtime->boundary = runtime->buffer_size;
ead4046b Clemens Ladisch      2010-05-21  723  	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
ead4046b Clemens Ladisch      2010-05-21  724  		runtime->boundary *= 2;
^1da177e Linus Torvalds       2005-04-16  725  
^1da177e Linus Torvalds       2005-04-16  726  	snd_pcm_timer_resolution_change(substream);
9b0573c0 Takashi Iwai         2012-10-12  727  	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
9442e691 Takashi Iwai         2006-09-30  728  
82f68251 James Bottomley      2010-07-05  729  	if (pm_qos_request_active(&substream->latency_pm_qos_req))
82f68251 James Bottomley      2010-07-05  730  		pm_qos_remove_request(&substream->latency_pm_qos_req);
9442e691 Takashi Iwai         2006-09-30  731  	if ((usecs = period_to_usecs(runtime)) >= 0)
82f68251 James Bottomley      2010-07-05  732  		pm_qos_add_request(&substream->latency_pm_qos_req,
ed77134b Mark Gross           2010-05-06  733  				   PM_QOS_CPU_DMA_LATENCY, usecs);
^1da177e Linus Torvalds       2005-04-16  734  	return 0;
^1da177e Linus Torvalds       2005-04-16  735   _error:
25985edc Lucas De Marchi      2011-03-30  736  	/* hardware might be unusable from this time,
^1da177e Linus Torvalds       2005-04-16  737  	   so we force application to retry to set
^1da177e Linus Torvalds       2005-04-16  738  	   the correct hardware parameter settings */
9b0573c0 Takashi Iwai         2012-10-12 @739  	snd_pcm_set_state(substream, SNDRV_PCM_STATE_OPEN);
^1da177e Linus Torvalds       2005-04-16  740  	if (substream->ops->hw_free != NULL)
^1da177e Linus Torvalds       2005-04-16  741  		substream->ops->hw_free(substream);
^1da177e Linus Torvalds       2005-04-16  742  	return err;
^1da177e Linus Torvalds       2005-04-16  743  }
^1da177e Linus Torvalds       2005-04-16  744  
877211f5 Takashi Iwai         2005-11-17  745  static int snd_pcm_hw_params_user(struct snd_pcm_substream *substream,
877211f5 Takashi Iwai         2005-11-17  746  				  struct snd_pcm_hw_params __user * _params)
^1da177e Linus Torvalds       2005-04-16  747  {
877211f5 Takashi Iwai         2005-11-17  748  	struct snd_pcm_hw_params *params;
^1da177e Linus Torvalds       2005-04-16  749  	int err;
^1da177e Linus Torvalds       2005-04-16  750  
ef44a1ec Li Zefan             2009-04-10  751  	params = memdup_user(_params, sizeof(*params));
ef44a1ec Li Zefan             2009-04-10  752  	if (IS_ERR(params))
ef44a1ec Li Zefan             2009-04-10  753  		return PTR_ERR(params);
ef44a1ec Li Zefan             2009-04-10  754  
^1da177e Linus Torvalds       2005-04-16  755  	err = snd_pcm_hw_params(substream, params);
f74ae15f Takashi Sakamoto     2017-06-11  756  	if (err < 0)
f74ae15f Takashi Sakamoto     2017-06-11  757  		goto end;
ef44a1ec Li Zefan             2009-04-10  758  
f74ae15f Takashi Sakamoto     2017-06-11  759  	if (copy_to_user(_params, params, sizeof(*params)))
f74ae15f Takashi Sakamoto     2017-06-11  760  		err = -EFAULT;
f74ae15f Takashi Sakamoto     2017-06-11  761  end:
^1da177e Linus Torvalds       2005-04-16  762  	kfree(params);
^1da177e Linus Torvalds       2005-04-16  763  	return err;
^1da177e Linus Torvalds       2005-04-16  764  }
^1da177e Linus Torvalds       2005-04-16  765  
877211f5 Takashi Iwai         2005-11-17  766  static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
^1da177e Linus Torvalds       2005-04-16  767  {
877211f5 Takashi Iwai         2005-11-17  768  	struct snd_pcm_runtime *runtime;
^1da177e Linus Torvalds       2005-04-16  769  	int result = 0;
^1da177e Linus Torvalds       2005-04-16  770  
7eaa943c Takashi Iwai         2008-08-08  771  	if (PCM_RUNTIME_CHECK(substream))
7eaa943c Takashi Iwai         2008-08-08  772  		return -ENXIO;
^1da177e Linus Torvalds       2005-04-16  773  	runtime = substream->runtime;
^1da177e Linus Torvalds       2005-04-16  774  	snd_pcm_stream_lock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  775  	switch (runtime->status->state) {
^1da177e Linus Torvalds       2005-04-16  776  	case SNDRV_PCM_STATE_SETUP:
^1da177e Linus Torvalds       2005-04-16  777  	case SNDRV_PCM_STATE_PREPARED:
^1da177e Linus Torvalds       2005-04-16  778  		break;
^1da177e Linus Torvalds       2005-04-16  779  	default:
^1da177e Linus Torvalds       2005-04-16  780  		snd_pcm_stream_unlock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  781  		return -EBADFD;
^1da177e Linus Torvalds       2005-04-16  782  	}
^1da177e Linus Torvalds       2005-04-16  783  	snd_pcm_stream_unlock_irq(substream);
9c323fcb Takashi Iwai         2006-04-28  784  	if (atomic_read(&substream->mmap_count))
^1da177e Linus Torvalds       2005-04-16  785  		return -EBADFD;
^1da177e Linus Torvalds       2005-04-16  786  	if (substream->ops->hw_free)
^1da177e Linus Torvalds       2005-04-16  787  		result = substream->ops->hw_free(substream);
9b0573c0 Takashi Iwai         2012-10-12 @788  	snd_pcm_set_state(substream, SNDRV_PCM_STATE_OPEN);
82f68251 James Bottomley      2010-07-05  789  	pm_qos_remove_request(&substream->latency_pm_qos_req);
^1da177e Linus Torvalds       2005-04-16  790  	return result;
^1da177e Linus Torvalds       2005-04-16  791  }
^1da177e Linus Torvalds       2005-04-16  792  
877211f5 Takashi Iwai         2005-11-17  793  static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
877211f5 Takashi Iwai         2005-11-17  794  			     struct snd_pcm_sw_params *params)
^1da177e Linus Torvalds       2005-04-16  795  {
877211f5 Takashi Iwai         2005-11-17  796  	struct snd_pcm_runtime *runtime;
1250932e Jaroslav Kysela      2010-01-07  797  	int err;
^1da177e Linus Torvalds       2005-04-16  798  
7eaa943c Takashi Iwai         2008-08-08  799  	if (PCM_RUNTIME_CHECK(substream))
7eaa943c Takashi Iwai         2008-08-08  800  		return -ENXIO;
^1da177e Linus Torvalds       2005-04-16  801  	runtime = substream->runtime;
^1da177e Linus Torvalds       2005-04-16  802  	snd_pcm_stream_lock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  803  	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
^1da177e Linus Torvalds       2005-04-16  804  		snd_pcm_stream_unlock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  805  		return -EBADFD;
^1da177e Linus Torvalds       2005-04-16  806  	}
^1da177e Linus Torvalds       2005-04-16  807  	snd_pcm_stream_unlock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  808  
145d92e7 Dan Carpenter        2015-09-23  809  	if (params->tstamp_mode < 0 ||
145d92e7 Dan Carpenter        2015-09-23  810  	    params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
^1da177e Linus Torvalds       2005-04-16  811  		return -EINVAL;
58900810 Takashi Iwai         2014-07-16  812  	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12) &&
58900810 Takashi Iwai         2014-07-16  813  	    params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
5646eda5 Takashi Iwai         2014-07-10  814  		return -EINVAL;
^1da177e Linus Torvalds       2005-04-16  815  	if (params->avail_min == 0)
^1da177e Linus Torvalds       2005-04-16  816  		return -EINVAL;
^1da177e Linus Torvalds       2005-04-16  817  	if (params->silence_size >= runtime->boundary) {
^1da177e Linus Torvalds       2005-04-16  818  		if (params->silence_threshold != 0)
^1da177e Linus Torvalds       2005-04-16  819  			return -EINVAL;
^1da177e Linus Torvalds       2005-04-16  820  	} else {
^1da177e Linus Torvalds       2005-04-16  821  		if (params->silence_size > params->silence_threshold)
^1da177e Linus Torvalds       2005-04-16  822  			return -EINVAL;
^1da177e Linus Torvalds       2005-04-16  823  		if (params->silence_threshold > runtime->buffer_size)
^1da177e Linus Torvalds       2005-04-16  824  			return -EINVAL;
^1da177e Linus Torvalds       2005-04-16  825  	}
1250932e Jaroslav Kysela      2010-01-07  826  	err = 0;
^1da177e Linus Torvalds       2005-04-16  827  	snd_pcm_stream_lock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  828  	runtime->tstamp_mode = params->tstamp_mode;
58900810 Takashi Iwai         2014-07-16  829  	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12))
5646eda5 Takashi Iwai         2014-07-10  830  		runtime->tstamp_type = params->tstamp_type;
^1da177e Linus Torvalds       2005-04-16  831  	runtime->period_step = params->period_step;
^1da177e Linus Torvalds       2005-04-16  832  	runtime->control->avail_min = params->avail_min;
^1da177e Linus Torvalds       2005-04-16  833  	runtime->start_threshold = params->start_threshold;
^1da177e Linus Torvalds       2005-04-16  834  	runtime->stop_threshold = params->stop_threshold;
^1da177e Linus Torvalds       2005-04-16  835  	runtime->silence_threshold = params->silence_threshold;
^1da177e Linus Torvalds       2005-04-16  836  	runtime->silence_size = params->silence_size;
^1da177e Linus Torvalds       2005-04-16  837          params->boundary = runtime->boundary;
^1da177e Linus Torvalds       2005-04-16  838  	if (snd_pcm_running(substream)) {
^1da177e Linus Torvalds       2005-04-16  839  		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
^1da177e Linus Torvalds       2005-04-16  840  		    runtime->silence_size > 0)
^1da177e Linus Torvalds       2005-04-16  841  			snd_pcm_playback_silence(substream, ULONG_MAX);
1250932e Jaroslav Kysela      2010-01-07  842  		err = snd_pcm_update_state(substream, runtime);
^1da177e Linus Torvalds       2005-04-16  843  	}
^1da177e Linus Torvalds       2005-04-16  844  	snd_pcm_stream_unlock_irq(substream);
1250932e Jaroslav Kysela      2010-01-07  845  	return err;
^1da177e Linus Torvalds       2005-04-16  846  }
^1da177e Linus Torvalds       2005-04-16  847  
877211f5 Takashi Iwai         2005-11-17  848  static int snd_pcm_sw_params_user(struct snd_pcm_substream *substream,
877211f5 Takashi Iwai         2005-11-17  849  				  struct snd_pcm_sw_params __user * _params)
^1da177e Linus Torvalds       2005-04-16  850  {
877211f5 Takashi Iwai         2005-11-17  851  	struct snd_pcm_sw_params params;
^1da177e Linus Torvalds       2005-04-16  852  	int err;
^1da177e Linus Torvalds       2005-04-16  853  	if (copy_from_user(&params, _params, sizeof(params)))
^1da177e Linus Torvalds       2005-04-16  854  		return -EFAULT;
^1da177e Linus Torvalds       2005-04-16  855  	err = snd_pcm_sw_params(substream, &params);
^1da177e Linus Torvalds       2005-04-16  856  	if (copy_to_user(_params, &params, sizeof(params)))
^1da177e Linus Torvalds       2005-04-16  857  		return -EFAULT;
^1da177e Linus Torvalds       2005-04-16  858  	return err;
^1da177e Linus Torvalds       2005-04-16  859  }
^1da177e Linus Torvalds       2005-04-16  860  
de41e437 Baolin Wang          2018-04-24  861  int snd_pcm_status64(struct snd_pcm_substream *substream,
de41e437 Baolin Wang          2018-04-24  862  		     struct snd_pcm_status64 *status)
^1da177e Linus Torvalds       2005-04-16  863  {
877211f5 Takashi Iwai         2005-11-17  864  	struct snd_pcm_runtime *runtime = substream->runtime;
^1da177e Linus Torvalds       2005-04-16  865  
^1da177e Linus Torvalds       2005-04-16  866  	snd_pcm_stream_lock_irq(substream);
3179f620 Pierre-Louis Bossart 2015-02-13  867  
3179f620 Pierre-Louis Bossart 2015-02-13  868  	snd_pcm_unpack_audio_tstamp_config(status->audio_tstamp_data,
3179f620 Pierre-Louis Bossart 2015-02-13  869  					&runtime->audio_tstamp_config);
3179f620 Pierre-Louis Bossart 2015-02-13  870  
3179f620 Pierre-Louis Bossart 2015-02-13  871  	/* backwards compatible behavior */
3179f620 Pierre-Louis Bossart 2015-02-13  872  	if (runtime->audio_tstamp_config.type_requested ==
3179f620 Pierre-Louis Bossart 2015-02-13  873  		SNDRV_PCM_AUDIO_TSTAMP_TYPE_COMPAT) {
3179f620 Pierre-Louis Bossart 2015-02-13  874  		if (runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK)
3179f620 Pierre-Louis Bossart 2015-02-13  875  			runtime->audio_tstamp_config.type_requested =
3179f620 Pierre-Louis Bossart 2015-02-13  876  				SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK;
3179f620 Pierre-Louis Bossart 2015-02-13  877  		else
3179f620 Pierre-Louis Bossart 2015-02-13  878  			runtime->audio_tstamp_config.type_requested =
3179f620 Pierre-Louis Bossart 2015-02-13  879  				SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT;
3179f620 Pierre-Louis Bossart 2015-02-13  880  		runtime->audio_tstamp_report.valid = 0;
3179f620 Pierre-Louis Bossart 2015-02-13  881  	} else
3179f620 Pierre-Louis Bossart 2015-02-13  882  		runtime->audio_tstamp_report.valid = 1;
3179f620 Pierre-Louis Bossart 2015-02-13  883  
^1da177e Linus Torvalds       2005-04-16 @884  	status->state = runtime->status->state;
^1da177e Linus Torvalds       2005-04-16 @885  	status->suspended_state = runtime->status->suspended_state;
^1da177e Linus Torvalds       2005-04-16  886  	if (status->state == SNDRV_PCM_STATE_OPEN)
^1da177e Linus Torvalds       2005-04-16  887  		goto _end;
de41e437 Baolin Wang          2018-04-24  888  	status->trigger_tstamp_sec = runtime->trigger_tstamp.tv_sec;
de41e437 Baolin Wang          2018-04-24  889  	status->trigger_tstamp_nsec = runtime->trigger_tstamp.tv_nsec;
8c121586 Jaroslav Kysela      2008-01-11  890  	if (snd_pcm_running(substream)) {
^1da177e Linus Torvalds       2005-04-16  891  		snd_pcm_update_hw_ptr(substream);
8c121586 Jaroslav Kysela      2008-01-11  892  		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
de41e437 Baolin Wang          2018-04-24  893  			status->tstamp_sec = runtime->status->tstamp.tv_sec;
de41e437 Baolin Wang          2018-04-24  894  			status->tstamp_nsec =
de41e437 Baolin Wang          2018-04-24  895  				runtime->status->tstamp.tv_nsec;
de41e437 Baolin Wang          2018-04-24  896  			status->driver_tstamp_sec =
de41e437 Baolin Wang          2018-04-24  897  				runtime->driver_tstamp.tv_sec;
de41e437 Baolin Wang          2018-04-24  898  			status->driver_tstamp_nsec =
de41e437 Baolin Wang          2018-04-24  899  				runtime->driver_tstamp.tv_nsec;
de41e437 Baolin Wang          2018-04-24  900  			status->audio_tstamp_sec =
de41e437 Baolin Wang          2018-04-24  901  				runtime->status->audio_tstamp.tv_sec;
de41e437 Baolin Wang          2018-04-24  902  			status->audio_tstamp_nsec =
de41e437 Baolin Wang          2018-04-24  903  				runtime->status->audio_tstamp.tv_nsec;
3179f620 Pierre-Louis Bossart 2015-02-13  904  			if (runtime->audio_tstamp_report.valid == 1)
3179f620 Pierre-Louis Bossart 2015-02-13  905  				/* backwards compatibility, no report provided in COMPAT mode */
3179f620 Pierre-Louis Bossart 2015-02-13  906  				snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
3179f620 Pierre-Louis Bossart 2015-02-13  907  								&status->audio_tstamp_accuracy,
3179f620 Pierre-Louis Bossart 2015-02-13  908  								&runtime->audio_tstamp_report);
3179f620 Pierre-Louis Bossart 2015-02-13  909  
8c121586 Jaroslav Kysela      2008-01-11  910  			goto _tstamp_end;
8c121586 Jaroslav Kysela      2008-01-11  911  		}
0d59b814 Pierre-Louis Bossart 2015-02-06  912  	} else {
0d59b814 Pierre-Louis Bossart 2015-02-06  913  		/* get tstamp only in fallback mode and only if enabled */
ac8bbfea Baolin Wang          2018-04-24  914  		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
ac8bbfea Baolin Wang          2018-04-24  915  			struct timespec64 tstamp;
ac8bbfea Baolin Wang          2018-04-24  916  
ac8bbfea Baolin Wang          2018-04-24  917  			snd_pcm_gettime(runtime, &tstamp);
de41e437 Baolin Wang          2018-04-24  918  			status->tstamp_sec = tstamp.tv_sec;
de41e437 Baolin Wang          2018-04-24  919  			status->tstamp_nsec = tstamp.tv_nsec;
ac8bbfea Baolin Wang          2018-04-24  920  		}
0d59b814 Pierre-Louis Bossart 2015-02-06  921  	}
8c121586 Jaroslav Kysela      2008-01-11  922   _tstamp_end:
^1da177e Linus Torvalds       2005-04-16  923  	status->appl_ptr = runtime->control->appl_ptr;
^1da177e Linus Torvalds       2005-04-16  924  	status->hw_ptr = runtime->status->hw_ptr;
^1da177e Linus Torvalds       2005-04-16  925  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
^1da177e Linus Torvalds       2005-04-16  926  		status->avail = snd_pcm_playback_avail(runtime);
^1da177e Linus Torvalds       2005-04-16  927  		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
4bbe1ddf Takashi Iwai         2008-10-13  928  		    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
^1da177e Linus Torvalds       2005-04-16  929  			status->delay = runtime->buffer_size - status->avail;
4bbe1ddf Takashi Iwai         2008-10-13  930  			status->delay += runtime->delay;
4bbe1ddf Takashi Iwai         2008-10-13  931  		} else
^1da177e Linus Torvalds       2005-04-16  932  			status->delay = 0;
^1da177e Linus Torvalds       2005-04-16  933  	} else {
^1da177e Linus Torvalds       2005-04-16  934  		status->avail = snd_pcm_capture_avail(runtime);
^1da177e Linus Torvalds       2005-04-16  935  		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
4bbe1ddf Takashi Iwai         2008-10-13  936  			status->delay = status->avail + runtime->delay;
^1da177e Linus Torvalds       2005-04-16  937  		else
^1da177e Linus Torvalds       2005-04-16  938  			status->delay = 0;
^1da177e Linus Torvalds       2005-04-16  939  	}
^1da177e Linus Torvalds       2005-04-16  940  	status->avail_max = runtime->avail_max;
^1da177e Linus Torvalds       2005-04-16  941  	status->overrange = runtime->overrange;
^1da177e Linus Torvalds       2005-04-16  942  	runtime->avail_max = 0;
^1da177e Linus Torvalds       2005-04-16  943  	runtime->overrange = 0;
^1da177e Linus Torvalds       2005-04-16  944   _end:
^1da177e Linus Torvalds       2005-04-16  945   	snd_pcm_stream_unlock_irq(substream);
^1da177e Linus Torvalds       2005-04-16  946  	return 0;
^1da177e Linus Torvalds       2005-04-16  947  }
^1da177e Linus Torvalds       2005-04-16  948  

:::::: The code at line 884 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
