Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbeDZLej (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:34:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34096 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbeDZLef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:34:35 -0400
X-Google-Smtp-Source: AB8JxZpnwfugIxnhA0HxURqb5434NswDXQlnqzpjE1KYvKWb7nGoEHDhU21I+LwkWbFZQ8cCFSa+KXUDmAj4ZSo8nbw=
MIME-Version: 1.0
In-Reply-To: <201804261121.VJnJJU0C%fengguang.wu@intel.com>
References: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
 <201804261121.VJnJJU0C%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 13:34:34 +0200
X-Google-Sender-Auth: 2F6rv1pHLgeT1wknVRh5nuHM3wo
Message-ID: <CAK8P3a1Axa35n508VwyQkEqzhKOJ48UpwRi2x0Y7T4z2G3SetQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
To: kbuild test robot <lkp@intel.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, kbuild-all@01.org,
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

On Thu, Apr 26, 2018 at 5:07 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on v4.17-rc2]
> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
> config: i386-randconfig-n0-201816 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>>> sound/core/pcm_native.c:2827:25: error: field 'tstamp' has incomplete type
>      struct compat_timespec tstamp;
>                             ^~~~~~
>>> sound/core/pcm_native.c:2829:25: error: field 'audio_tstamp' has incomplete type
>      struct compat_timespec audio_tstamp;
>                             ^~~~~~~~~~~~

This is due to a dependency on one of Deepa's patches that is
currently in linux-next,
scheduled for 4.18-rc1, but that won't be in 4.17.

It seems likely that we won't come to a conclusion in time for 4.18
anyway, so that's
probably fine. If we want the patches in 4.18, I can come up with a
different way of
doing this.

       Arnd
