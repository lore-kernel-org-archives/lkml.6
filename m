Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938709AbeBUR5w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:57:52 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:36022 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932551AbeBUR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:57:50 -0500
Date: Wed, 21 Feb 2018 11:57:47 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Shakeel Butt <shakeelb@google.com>
cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Directed kmem charging
In-Reply-To: <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1802211155500.13845@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake> <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfAhe/OtEzw9US2KrOeQnMDAXPXTwZkG4G/EP9RpXuGHdnASiARxcy0R6fXttn9tBYPb8cWx+pG3XqUnmYlepIodohgXBs7xt+rpx3+EcAcVpqvtb4Ipa
 9f6CyQlc/SrUjGU6f/xNRK5wuQZa9ZTCnohRh+/HFJElxfP017G5XcC8icSDHTy8Ll2c6vjVq105z4o7oQIbrfi4/i8KBgvp138mHAEck6Sh1/E5HblpIejM
 gPUHD6QNRwGKNV9tjkGngge2DdEsM4lW9piKX4E91HV9sY98c4Zp/iXCbuF/hL7/petmJbCt05DgLZuxmnFicoKBKhAIy+YcnQlhYLRpoQuMQ61EytMuzTSQ
 co7QLtnHMMGyaFNryCN4DocTV6kpA6ySKMWvFXuZXV5HPnpCvDsike3MQq6evJOKsPuaNZqw9YMxfHg0UuAe7QuR2nxyW6zFLYByDh6EWFtFgd4cEq6fB8AC
 ubqbirQc4625dhoWCgQ4+FiVTYPU0AhtKH8tlkeZkOtvSeY/fa6I+G9paEuemsnNXtWa9Ab5lTENO0aJa5QkQb+ZkUe27sfki3mljvcOwR9+y/xZYox4uYeE
 3UKAYlBqBI/isebYmoqveyE/x0kuW/sYoiPcCqsVatrts1/gWc4tWwk0oNUoBVM3f+0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Shakeel Butt wrote:

> On Wed, Feb 21, 2018 at 8:09 AM, Christopher Lameter <cl@linux.com> wrote:
> > Another way to solve this is to switch the user context right?
> >
> > Isnt it possible to avoid these patches if do the allocation in another
> > task context instead?
> >
>
> Sorry, can you please explain what you mean by 'switch the user
> context'. Is there any example in kernel which does something similar?

See include/linux/task_work.h. One use case is in mntput_no_expire() in
linux/fs/namespace.c

> > Are there really any other use cases beyond fsnotify?
> >
>
> Another use case I have in mind and plan to upstream is to bind a
> filesystem mount with a memcg. So, all the file pages (or anon pages
> for shmem) and kmem (like inodes and dentry) will be charged to that
> memcg.

The mount logic already uses task_work.h. That may be the approach to
expand there.
