Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeFAPDj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:03:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39749 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeFAPDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:03:36 -0400
X-Google-Smtp-Source: ADUXVKI4+H+hCP2/I29fTavsfshPhqd2QTU1K7Qk0tN+FiXp7G2DvhQ5uqlsHRhAS5ZviowKl/ZzWw==
Subject: Re: [GIT PULL v3 00/10] lightnvm updates for 4.18
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
References: <20180601144114.17490-1-mb@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <166defee-d9a7-dcec-8c77-b7e9d4e0d78e@kernel.dk>
Date: Fri, 1 Jun 2018 09:03:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/18 8:41 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches.
> 
> Changes since v2:
> 
>  Rebased write error recovery patch on top of latest
>  for-4.18/block
> 
>  Added (missed the first round)
>   lightnvm: pblk: only try to recover lines with written smeta
>   lightnvm: pblk: kick writer on new flush points
>   lightnvm: pblk: take bitmap alloc. out of critical section
> 
> Changes since v1:
> 
>  Removed
>   lightnvm: pblk: sync RB and RL states during GC
>   lightnvm: error handling when whole line is bad
>   lightnvm: pblk: handle case when mw_cunits equals to 0
> 
>  Added
>   lightnvm: pblk: remove unnecessary bio_get/put
> 
> Thanks!
> 
> Hans Holmberg (5):
>   lightnvm: pblk: rework write error recovery path
>   lightnvm: pblk: garbage collect lines with failed writes
>   lightnvm: pblk: fix smeta write error path
>   lightnvm: pblk: only try to recover lines with written smeta
>   lightnvm: pblk: kick writer on new flush points
> 
> Igor Konopko (2):
>   lightnvm: proper error handling for pblk_bio_add_pages
>   lightnvm: fix partial read error path
> 
> Javier González (2):
>   lightnvm: pblk: remove unnecessary bio_get/put
>   lightnvm: pblk: take bitmap alloc. out of critical section
> 
> Marcin Dziegielewski (1):
>   lightnvm: pblk: add possibility to set write buffer size manually
> 
>  drivers/lightnvm/pblk-cache.c    |  10 +-
>  drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++-------
>  drivers/lightnvm/pblk-gc.c       | 102 ++++++++------
>  drivers/lightnvm/pblk-init.c     |  62 ++++++---
>  drivers/lightnvm/pblk-rb.c       |  43 +-----
>  drivers/lightnvm/pblk-read.c     |  69 +++++-----
>  drivers/lightnvm/pblk-recovery.c | 121 +++--------------
>  drivers/lightnvm/pblk-rl.c       |  29 +++-
>  drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>  drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
>  drivers/lightnvm/pblk.h          |  37 ++++--
>  11 files changed, 524 insertions(+), 402 deletions(-)

Applied, thanks.

-- 
Jens Axboe
