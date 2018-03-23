Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeCWAbQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:31:16 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:46769 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeCWAbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:31:14 -0400
X-Google-Smtp-Source: AIpwx4/1gAmMoJokuZQmzwxxtdtkfVwxf4rfl9wiXVoqE//BC4B2jU7F0AdhQjLtbvBoc2lrJ/S0wiMhMXXIM9F5loo=
MIME-Version: 1.0
In-Reply-To: <20180322150037.GD6955@twin.jikos.cz>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-84-git-send-email-jix024@eng.ucsd.edu> <20180322150037.GD6955@twin.jikos.cz>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Thu, 22 Mar 2018 17:31:13 -0700
Message-ID: <CAD4Szjsg5_-Jy=1RQMFHHwYA9-uHu4SSDLYF8Q-GtcTWOAx3GA@mail.gmail.com>
Subject: Re: [RFC v2 83/83] Sysfs support.
To: dsterba@suse.cz, Andiry Xu <jix024@eng.ucsd.edu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        swhiteho@redhat.com, miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 8:00 AM, David Sterba <dsterba@suse.cz> wrote:
> On Sat, Mar 10, 2018 at 10:19:04AM -0800, Andiry Xu wrote:
>> From: Andiry Xu <jix024@cs.ucsd.edu>
>>
>> Sysfs support allows user to get/post information of running NOVA instance.
>> After mount, NOVA creates four entries under proc directory
>> /proc/fs/nova/pmem#/:
>>
>> timing_stats  IO_stats        allocator       gc
>>
>> Show NOVA file operation timing statistics:
>> cat /proc/fs/NOVA/pmem#/timing_stats
>>
>> Clear timing statistics:
>> echo 1 > /proc/fs/NOVA/pmem#/timing_stats
>>
>> Show NOVA I/O statistics:
>> cat /proc/fs/NOVA/pmem#/IO_stats
>>
>> Clear I/O statistics:
>> echo 1 > /proc/fs/NOVA/pmem#/IO_stats
>>
>> Show NOVA allocator information:
>> cat /proc/fs/NOVA/pmem#/allocator
>>
>> Manual garbage collection:
>> echo #inode_number > /proc/fs/NOVA/pmem#/gc
>
> IIRC no new entries should be added to /proc, /sys is supposed to be
> used. I can't find it documented though, so you'd better check with
> sysfs people.

Thanks. I will try to switch to sysfs.

Thanks,
Andiry
