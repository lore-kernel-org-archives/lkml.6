Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeDZIlX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:41:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44826 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754663AbeDZIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:41:15 -0400
X-Google-Smtp-Source: AB8JxZrI/r5mM7z4RIQm1u46n/mI8vZZFGhjvhlI0gyE21bCBixIuR3qSdJcLkGvUSESzv0Qu4LtzEcpxdZsydearZA=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2TpW8rDw9YrWsJRkyawi+VkqaZQR6_WCSRpn96W6UbEg@mail.gmail.com>
References: <7373ade7cb5a8d6a5fca07e78cf992ba7372bd7f.1524570852.git.baolin.wang@linaro.org>
 <201804261345.1lsWsCDl%fengguang.wu@intel.com> <CAK8P3a2TpW8rDw9YrWsJRkyawi+VkqaZQR6_WCSRpn96W6UbEg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 26 Apr 2018 16:41:14 +0800
Message-ID: <CAMz4kuL-3m-jPGV1ZdsadXyWxnu+jNMccCtzbcKGcpN33gnaxg@mail.gmail.com>
Subject: Re: [PATCH 1/8] ALSA: Replace timespec with timespec64
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 April 2018 at 16:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 26, 2018 at 10:15 AM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Baolin,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on v4.17-rc2]
>> [also build test ERROR on next-20180424]
>> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
>> config: sh-ecovec24_defconfig (attached as .config)
>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=sh
>>
>> Note: the linux-review/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145 HEAD 53cdcc389f07bdd923be240cdb746a97de063301 builds fine.
>>       It only hurts bisectibility.
>>
>> All errors (new ones prefixed by >>):
>>
>>    sound/core/pcm_lib.c: In function 'update_audio_tstamp':
>>>> sound/core/pcm_lib.c:256:54: error: passing argument 2 of 'timespec_equal' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
>>                                                          ^~~~~~~~~~~~
>
>
> Probably a mistake during rebasing: patch 8/8 fixes this, but it should be done
> right here by moving the open-coded comparison into the first patch:
>
> -       if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
> +       if (runtime->status->audio_tstamp.tv_sec != audio_tstamp->tv_sec ||
> +           runtime->status->audio_tstamp.tv_nsec != audio_tstamp->tv_nsec) {
>

Sorry, it's my mistake. Yes, I can fix this issue like what you showed.

-- 
Baolin.wang
Best Regards
