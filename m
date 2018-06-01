Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFAMgS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:36:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34441 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeFAMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:36:16 -0400
X-Google-Smtp-Source: ADUXVKLO1OPfQ82zr5GSPvd9qlcmR9nvjDF9w/HVpC/ui2KQHh1hcev19DedJQffS8dvCc43i00+Xg==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL 00/20] lightnvm updates for 4.18
From: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <068976f7-38eb-1960-c62b-814ce75ab3e2@lightnvm.io>
Date: Fri, 1 Jun 2018 06:36:12 -0600
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Message-Id: <2B2C5081-DB3F-4328-B861-92362EE1EF7F@kernel.dk>
References: <20180528085841.26684-1-mb@lightnvm.io> <068976f7-38eb-1960-c62b-814ce75ab3e2@lightnvm.io>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51CaMjJ032459

On Jun 1, 2018, at 4:45 AM, Matias Bjørling <mb@lightnvm.io> wrote:
> 
>> On 05/28/2018 10:58 AM, Matias Bjørling wrote:
>> Hi Jens,
>> Please pick up the following patches.
>>  - Hans reworked the write error recovery path in pblk.
>>  - Igor added extra error handling for lines, and fixed a bug in the
>>    pblk ringbuffer during GC.
>>  - Javier refactored the pblk code a bit, added extra error
>>    handling, and added checks to verify that data returned from drive
>>    is appropriate.
>>  - Marcin added some extra logic to manage the write buffer. Now
>>    MW_CUNITS can be zero and the size of write buffer can be changed
>>    at module load time.
>> Thanks,
>> Matias
>> Hans Holmberg (3):
>>   lightnvm: pblk: rework write error recovery path
>>   lightnvm: pblk: garbage collect lines with failed writes
>>   lightnvm: pblk: fix smeta write error path
>> Igor Konopko (4):
>>   lightnvm: proper error handling for pblk_bio_add_pages
>>   lightnvm: error handling when whole line is bad
>>   lightnvm: fix partial read error path
>>   lightnvm: pblk: sync RB and RL states during GC
>> Javier González (11):
>>   lightnvm: pblk: fail gracefully on line alloc. failure
>>   lightnvm: pblk: recheck for bad lines at runtime
>>   lightnvm: pblk: check read lba on gc path
>>   lightnvn: pblk: improve error msg on corrupted LBAs
>>   lightnvm: pblk: warn in case of corrupted write buffer
>>   lightnvm: pblk: return NVM_ error on failed submission
>>   lightnvm: pblk: remove unnecessary indirection
>>   lightnvm: pblk: remove unnecessary argument
>>   lightnvm: pblk: check for chunk size before allocating it
>>   lightnvn: pass flag on graceful teardown to targets
>>   lightnvm: pblk: remove dead function
>> Marcin Dziegielewski (2):
>>   lightnvm: pblk: handle case when mw_cunits equals to 0
>>   lightnvm: pblk: add possibility to set write buffer size manually
>>  drivers/lightnvm/core.c          |  10 +-
>>  drivers/lightnvm/pblk-core.c     | 149 +++++++++++++++------
>>  drivers/lightnvm/pblk-gc.c       | 112 ++++++++++------
>>  drivers/lightnvm/pblk-init.c     | 112 +++++++++++-----
>>  drivers/lightnvm/pblk-map.c      |  33 +++--
>>  drivers/lightnvm/pblk-rb.c       |  51 +------
>>  drivers/lightnvm/pblk-read.c     |  83 +++++++++---
>>  drivers/lightnvm/pblk-recovery.c |  91 -------------
>>  drivers/lightnvm/pblk-rl.c       |  29 +++-
>>  drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>>  drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
>>  drivers/lightnvm/pblk.h          |  43 +++---
>>  drivers/nvme/host/lightnvm.c     |   1 -
>>  include/linux/lightnvm.h         |   2 +-
>>  14 files changed, 604 insertions(+), 408 deletions(-)
> 
> Hi Jens,
> 
> Javier had some comments to 16, 18, and 20. The rest is ready to go. Would you like me to resend the patches?

Yes please. 
