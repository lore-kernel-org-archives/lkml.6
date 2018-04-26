Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbeDZKxT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:53:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38130 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbeDZKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:53:17 -0400
X-Google-Smtp-Source: AB8JxZr9QNh3yUa4NgXg8RFWtBOysObuMOjE4oxHYoZNCwVIJ9OQJ6dLZO/1cy1Bh9xyksu8MnT5EVBpgzpimPrUGig=
MIME-Version: 1.0
In-Reply-To: <201804261703.caDB8Qo5%fengguang.wu@intel.com>
References: <7809a25514e8f7f72a276d19414346b2e4100945.1524570852.git.baolin.wang@linaro.org>
 <201804261703.caDB8Qo5%fengguang.wu@intel.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 26 Apr 2018 18:53:16 +0800
Message-ID: <CAMz4kuJ0xy-0UByd8UzSUyc9iwgytH7EYE2JPDXFTe-1PFG3+A@mail.gmail.com>
Subject: Re: [PATCH 4/8] ALSA: Avoid using timespec for struct snd_pcm_status
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Ingo Molnar <mingo@kernel.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com,
        Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        subhransu.s.prusty@intel.com, Bhumika Goyal <bhumirks@gmail.com>,
        gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>,
        hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Fabian Frederick <fabf@skynet.be>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QArO8b023618

Hi Arnd,

On 26 April 2018 at 17:20, kbuild test robot <lkp@intel.com> wrote:
> Hi Baolin,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on v4.17-rc2]
> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    sound/core/pcm_native.c:561:51: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
>    sound/core/pcm_native.c:561:51:    expected restricted snd_pcm_state_t [usertype] state
>    sound/core/pcm_native.c:561:51:    got int [signed] state
>    sound/core/pcm_native.c:726:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:726:38:    expected int [signed] state
>    sound/core/pcm_native.c:726:38:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:738:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:738:38:    expected int [signed] state
>    sound/core/pcm_native.c:738:38:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:787:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:787:38:    expected int [signed] state
>    sound/core/pcm_native.c:787:38:    got restricted snd_pcm_state_t [usertype] <noident>
>>> sound/core/pcm_native.c:995:34: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] state @@
>    sound/core/pcm_native.c:995:34:    expected signed int [signed] [usertype] [explicitly-signed] state
>    sound/core/pcm_native.c:995:34:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
>>> sound/core/pcm_native.c:1006:44: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] suspended_state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] suspended_state @@
>    sound/core/pcm_native.c:1006:44:    expected signed int [signed] [usertype] [explicitly-signed] suspended_state
>    sound/core/pcm_native.c:1006:44:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
>    sound/core/pcm_native.c:1259:32: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
>    sound/core/pcm_native.c:1259:32:    expected restricted snd_pcm_state_t [usertype] state
>    sound/core/pcm_native.c:1259:32:    got int [signed] state
>    sound/core/pcm_native.c:1283:31: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1283:31:    expected int [signed] state
>    sound/core/pcm_native.c:1283:31:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1290:40: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1290:40:    expected int [signed] state
>    sound/core/pcm_native.c:1290:40:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1316:28: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/core/pcm_native.c:1318:40: sparse: incorrect type in assignment (different base types) @@    expected restricted snd_pcm_state_t [usertype] state @@    got t [usertype] state @@
>    sound/core/pcm_native.c:1318:40:    expected restricted snd_pcm_state_t [usertype] state
>    sound/core/pcm_native.c:1318:40:    got int [signed] state
>    sound/core/pcm_native.c:1342:64: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1342:64:    expected int [signed] state
>    sound/core/pcm_native.c:1342:64:    got restricted snd_pcm_state_t [usertype] state
>    sound/core/pcm_native.c:1358:38: sparse: incorrect type in argument 3 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1358:38:    expected int [signed] state
>    sound/core/pcm_native.c:1358:38:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1717:38: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1717:38:    expected int [signed] state
>    sound/core/pcm_native.c:1717:38:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1783:61: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1783:61:    expected int [signed] state
>    sound/core/pcm_native.c:1783:61:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1784:63: sparse: incorrect type in argument 2 (different base types) @@    expected int [signed] state @@    got restricted snd_pcm_state_int [signed] state @@
>    sound/core/pcm_native.c:1784:63:    expected int [signed] state
>    sound/core/pcm_native.c:1784:63:    got restricted snd_pcm_state_t [usertype] <noident>
>    sound/core/pcm_native.c:1801:76: sparse: incorrect type in initializer (different base types) @@    expected int [signed] new_state @@    got restricted snint [signed] new_state @@
>    sound/core/pcm_native.c:1801:76:    expected int [signed] new_state
>    sound/core/pcm_native.c:1801:76:    got restricted snd_pcm_state_t
>    sound/core/pcm_native.c:1904:40: sparse: expression using sizeof(void)
>    sound/core/pcm_native.c:1904:40: sparse: expression using sizeof(void)
>    sound/core/pcm_native.c:2122:26: sparse: restricted snd_pcm_format_t degrades to integer
>    sound/core/pcm_native.c:2126:54: sparse: incorrect type in argument 1 (different base types) @@    expected restricted snd_pcm_format_t [usertype] format @@    got ricted snd_pcm_format_t [usertype] format @@
>    sound/core/pcm_native.c:2126:54:    expected restricted snd_pcm_format_t [usertype] format
>    sound/core/pcm_native.c:2126:54:    got unsigned int [unsigned] [assigned] k
>    sound/core/pcm_native.c:2144:26: sparse: restricted snd_pcm_format_t degrades to integer
>    sound/core/pcm_native.c:2148:54: sparse: incorrect type in argument 1 (different base types) @@    expected restricted snd_pcm_format_t [usertype] format @@    got ricted snd_pcm_format_t [usertype] format @@
>    sound/core/pcm_native.c:2148:54:    expected restricted snd_pcm_format_t [usertype] format
>    sound/core/pcm_native.c:2148:54:    got unsigned int [unsigned] [assigned] k
>    sound/core/pcm_native.c:2328:30: sparse: restricted snd_pcm_access_t degrades to integer
>    sound/core/pcm_native.c:2330:30: sparse: restricted snd_pcm_access_t degrades to integer
>    sound/core/pcm_native.c:2333:38: sparse: restricted snd_pcm_access_t degrades to integer
>    sound/core/pcm_native.c:2335:38: sparse: restricted snd_pcm_access_t degrades to integer
>    sound/core/pcm_native.c:2337:38: sparse: restricted snd_pcm_access_t degrades to integer
>    sound/core/pcm_native.c:2347:86: sparse: restricted snd_pcm_subformat_t degrades to integer
>    include/sound/pcm.h:1093:47: sparse: cast removes address space of expression
>    include/sound/pcm.h:1100:47: sparse: cast removes address space of expression
>    include/sound/pcm.h:1100:47: sparse: cast removes address space of expression
>    include/sound/pcm.h:1093:47: sparse: cast removes address space of expression
>    sound/core/pcm_compat.c:241:32: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] state @@
>    sound/core/pcm_compat.c:241:32:    expected signed int [signed] [usertype] [explicitly-signed] state
>    sound/core/pcm_compat.c:241:32:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
>    sound/core/pcm_compat.c:252:42: sparse: incorrect type in initializer (different base types) @@    expected signed int [signed] [usertype] [explicitly-signed] suspended_state @@    got restricted ssigned int [signed] [usertype] [explicitly-signed] suspended_state @@
>    sound/core/pcm_compat.c:252:42:    expected signed int [signed] [usertype] [explicitly-signed] suspended_state
>    sound/core/pcm_compat.c:252:42:    got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
>    include/sound/pcm.h:1093:47: sparse: cast removes address space of expression
>    include/sound/pcm.h:1100:47: sparse: cast removes address space of expression
>    sound/core/pcm_compat.c:480:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
>    sound/core/pcm_compat.c:480:13:    expected signed int [signed] [explicitly-signed] __pu_val
>    sound/core/pcm_compat.c:480:13:    got restricted snd_pcm_state_t [assigned] [usertype] state
>    sound/core/pcm_compat.c:483:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
>    sound/core/pcm_compat.c:483:13:    expected signed int [signed] [explicitly-signed] __pu_val
>    sound/core/pcm_compat.c:483:13:    got restricted snd_pcm_state_t [assigned] [usertype] suspended_state
>    sound/core/pcm_compat.c:569:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
>    sound/core/pcm_compat.c:569:13:    expected signed int [signed] [explicitly-signed] __pu_val
>    sound/core/pcm_compat.c:569:13:    got restricted snd_pcm_state_t [assigned] [usertype] state
>    sound/core/pcm_compat.c:572:13: sparse: incorrect type in assignment (different base types) @@    expected signed int [signed] [explicitly-signed] __pu_val @@    got restrictesigned int [signed] [explicitly-signed] __pu_val @@
>    sound/core/pcm_compat.c:572:13:    expected signed int [signed] [explicitly-signed] __pu_val
>    sound/core/pcm_compat.c:572:13:    got restricted snd_pcm_state_t [assigned] [usertype] suspended_state
>    sound/core/pcm_native.c:112:9: sparse: context imbalance in 'snd_pcm_stream_lock' - different lock contexts for basic block
>    sound/core/pcm_native.c:134:28: sparse: context imbalance in 'snd_pcm_stream_unlock' - unexpected unlock
>    sound/core/pcm_native.c:1130:52: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
>
> vim +995 sound/core/pcm_native.c
>
>    971
>    972  static int snd_pcm_status_user32(struct snd_pcm_substream *substream,
>    973                                   struct snd_pcm_status32 __user * _status,
>    974                                   bool ext)
>    975  {
>    976          struct snd_pcm_status64 status64;
>    977          struct snd_pcm_status32 status32;
>    978          int res;
>    979
>    980          memset(&status64, 0, sizeof(status64));
>    981          memset(&status32, 0, sizeof(status32));
>    982          /*
>    983           * with extension, parameters are read/write,
>    984           * get audio_tstamp_data from user,
>    985           * ignore rest of status structure
>    986           */
>    987          if (ext && get_user(status64.audio_tstamp_data,
>    988                              (u32 __user *)(&_status->audio_tstamp_data)))
>    989                  return -EFAULT;
>    990          res = snd_pcm_status64(substream, &status64);
>    991          if (res < 0)
>    992                  return res;
>    993
>    994          status32 = (struct snd_pcm_status32) {
>  > 995                  .state = status64.state,
>    996                  .trigger_tstamp_sec = status64.trigger_tstamp_sec,
>    997                  .trigger_tstamp_nsec = status64.trigger_tstamp_nsec,
>    998                  .tstamp_sec = status64.tstamp_sec,
>    999                  .tstamp_nsec = status64.tstamp_nsec,
>   1000                  .appl_ptr = status64.appl_ptr,
>   1001                  .hw_ptr = status64.hw_ptr,
>   1002                  .delay = status64.delay,
>   1003                  .avail = status64.avail,
>   1004                  .avail_max = status64.avail_max,
>   1005                  .overrange = status64.overrange,
>> 1006                  .suspended_state = status64.suspended_state,

I am not sure for the warning here, we should change 'snd_pcm_state_t'
to 's32' for struct snd_pcm_status64?

typedef int __bitwise snd_pcm_state_t;

-- 
Baolin.wang
Best Regards
