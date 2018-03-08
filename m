Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935200AbeCHClW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:41:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35086 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935202AbeCHClH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:41:07 -0500
X-Google-Smtp-Source: AG47ELuOjQKmk2pOej3nzGdPoNwZfDj8FdHqTwcYd4QA/8cQsLa/XZXVnf4Du0GkjjPhOqVwm+2FDUvT+QbpReMz3Ys=
MIME-Version: 1.0
In-Reply-To: <CALvZod53CV+R0CeVPDJ=3JAtFjyOfSSSrr3x0tqAWHec0AshTA@mail.gmail.com>
References: <20180308002016.L3JwBaNZ9%akpm@linux-foundation.org>
 <41ec9eeb-f0bf-e26d-e3ae-4a684c314360@infradead.org> <d6ec23eb-a886-9fef-99c7-51c7ba4f5d18@infradead.org>
 <CALvZod53CV+R0CeVPDJ=3JAtFjyOfSSSrr3x0tqAWHec0AshTA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 7 Mar 2018 18:41:04 -0800
Message-ID: <CALvZod7qDS7YN1P45uaOwMK3qPBv=VSMC=8TZSRE_DTaspXxjA@mail.gmail.com>
Subject: Re: mmotm 2018-03-07-16-19 uploaded (UML & memcg)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-next@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
        mm-commits@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:34 PM, Shakeel Butt <shakeelb@google.com> wrote:
> On Wed, Mar 7, 2018 at 6:23 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 03/07/2018 06:20 PM, Randy Dunlap wrote:
>>> On 03/07/2018 04:20 PM, akpm@linux-foundation.org wrote:
>>>> The mm-of-the-moment snapshot 2018-03-07-16-19 has been uploaded to
>>>>
>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>
>>>> mmotm-readme.txt says
>>>>
>>>> README for mm-of-the-moment:
>>>>
>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>
>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>> more than once a week.
>>>
>>> UML on i386 and/or x86_64:
>>>
>>> defconfig, CONFIG_MEMCG is not set:
>>>
>>> ../fs/notify/group.c: In function 'fsnotify_final_destroy_group':
>>> ../fs/notify/group.c:41:24: error: dereferencing pointer to incomplete type
>>>    css_put(&group->memcg->css);
>>>                         ^
>>>
>>> From: Shakeel Butt <shakeelb@google.com>
>>> Subject: fs: fsnotify: account fsnotify metadata to kmemcg
>>
>>
>>
>> or x86 any time that CONFIG_MEMCG is not enabled.
>>
>>
>
> Sorry about that. Replacing this with mem_cgroup_put(group->memcg)
> should solve the issue on the mm tree.

Andrew, do you want me to extract mem_cgroup_put() API from Roman's
patches as a separate patch?
