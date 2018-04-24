Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934687AbeDXNhw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:37:52 -0400
Received: from mail1.perex.cz ([77.48.224.245]:36282 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933338AbeDXNht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:37:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E7B6FA0040
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
To: Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com, arnd@arndb.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp,
        mingo@kernel.org, elfring@users.sourceforge.net,
        dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com,
        guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com,
        bhumirks@gmail.com, gudishax.kranthikumar@intel.com,
        naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com,
        fabf@skynet.be, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <cover.1524570852.git.baolin.wang@linaro.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
Date: Tue, 24 Apr 2018 15:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <cover.1524570852.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
> Since many structures will use timespec type variables to record time stamp
> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
> tries to introduce new structures removing timespec type to compatible native
> mode and compat mode.
> 
> Moreover this patchset also converts the internal structrures to use timespec64
> type and related APIs.

Thanks for your patchset. A few comments:

It might be more nice to reuse the existing structures and put
timespec64 to the reserved field and duplicate information (with the
32-bit wrapping for the old fields). It means that we do not need new
ioctls and old libraries will be fine.

It may make sense to define private snd_timespec32 and snd_timespec64
with s32/s64 types instead separate sec/usec fields.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
