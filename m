Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbeDXN3o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:29:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38145 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934322AbeDXN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:29:39 -0400
X-Google-Smtp-Source: AB8JxZoIO+EnPfN8JlKsxBlyVqUefaqChmi3UPK87jXVXhgFeFOD3IOTKsSlsA6pnFMZ5qC9vxh5bR/MGK5sQSp7Q/U=
MIME-Version: 1.0
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 15:29:38 +0200
X-Google-Sender-Auth: Wz7kbLdVwmodBAeAChJnt0YZwao
Message-ID: <CAK8P3a0aWk1yJtcBBBiHuaTOMvgy1v4KpnXqtc9HudOEoCfiaQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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

On Tue, Apr 24, 2018 at 2:06 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since many structures will use timespec type variables to record time stamp
> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
> tries to introduce new structures removing timespec type to compatible native
> mode and compat mode.
>
> Moreover this patchset also converts the internal structrures to use timespec64
> type and related APIs.
>
> Arnd Bergmann (2):
>   ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c
>   ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
>
> Baolin Wang (6):
>   ALSA: Replace timespec with timespec64
>   ALSA: Avoid using timespec for struct snd_timer_status
>   ALSA: Avoid using timespec for struct snd_ctl_elem_value
>   ALSA: Avoid using timespec for struct snd_pcm_status
>   ALSA: Avoid using timespec for struct snd_rawmidi_status
>   ALSA: Avoid using timespec for struct snd_timer_tread

Thanks a lot for picking this up again and including my two patches!

I've done a private review yesterday, but will have another look either
today or tomorrow to see if I missed anything. I've also applied the
series to my randconfig build tree and will see if that finds any new
bugs. The builder has already found a bug in one of my two patches,
so there might be more.

      Arnd
