Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeCHXsU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:48:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40293 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeCHXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:48:16 -0500
X-Google-Smtp-Source: AG47ELsXVG1DgpZ33pGqv/re0pZ3ua8Nu/jeUxA66PcqF5vgoO5M8KLCbgoa5062tzoDuCxNln2LiG/5T5y1ZMSzVeU=
MIME-Version: 1.0
In-Reply-To: <20180308154501.a42bb22af0da6ccd727773c8@linux-foundation.org>
References: <20180308024850.39737-1-shakeelb@google.com> <20180308154501.a42bb22af0da6ccd727773c8@linux-foundation.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 8 Mar 2018 15:48:14 -0800
Message-ID: <CALvZod5gy8iw-Va7-Gzyqv1xVkTGhU3k4UysktXb7bfbbtUt9Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: expose mem_cgroup_put API
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 3:45 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  7 Mar 2018 18:48:50 -0800 Shakeel Butt <shakeelb@google.com> wrote:
>
>> This patch exports mem_cgroup_put API to put the refcnt of the memory
>> cgroup.
>
> OK, I remember now.  This is intended to make
> fs-fsnotify-account-fsnotify-metadata-to-kmemcg.patch independent of
> mm-oom-cgroup-aware-oom-killer.patch by extracting mem_cgroup_put()
> from mm-oom-cgroup-aware-oom-killer.patch.

Yes, you are right, it is needed by the above fsnotify patch.

> However it will not permit me to stage
> fs-fsnotify-account-fsnotify-metadata-to-kmemcg.patch ahead of
> mm-oom-cgroup-aware-oom-killer.patch because there are quite a lot of
> syntactic clashes.
>
> I can resolve those if needed, but am keenly hoping that the
> mm-oom-cgroup-aware-oom-killer.patch issues are resolved soon so there
> isn't a need to do this.
>

Sounds good to me.
