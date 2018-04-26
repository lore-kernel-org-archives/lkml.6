Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeDZLbU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:31:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43630 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbeDZLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:31:19 -0400
X-Google-Smtp-Source: AB8JxZrZbgzk2aYHO/ODu0PT3ifY10+XXSCfB0EXadF+qLled3XUUpvxF/0sPo5naW691MrTMODxTuDWHsTIcDKsz/U=
MIME-Version: 1.0
In-Reply-To: <201804261905.bMSzVUh7%fengguang.wu@intel.com>
References: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
 <201804261905.bMSzVUh7%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 13:31:17 +0200
X-Google-Sender-Auth: Nf8FsdO6mznuIsOuyG-_jVrTjtQ
Message-ID: <CAK8P3a19Nst2UwZart_kzbT6iJD+D9RPMpq_yAzgumjNtxFNGg@mail.gmail.com>
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

On Thu, Apr 26, 2018 at 1:25 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
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
>    sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
>>> sound/firewire/motu/motu-pcm.c:204:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:223:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:238:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:254:50: sparse: restricted snd_pcm_state_t degrades to integer

>From what I can tell, these are all existing driver problems, no idea why we now
have one more warning than before.

       Arnd
