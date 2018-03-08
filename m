Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934743AbeCHCet (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:34:49 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:40637 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934554AbeCHCeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:34:46 -0500
X-Google-Smtp-Source: AG47ELtmsDs8yIoyb16dzIW4XftKyfTq8moskHIlKcuITz+f/4p3ZKq1UvvuRKdKRlSPPxTrMizZs0c+Hf+cuIYXBFI=
MIME-Version: 1.0
In-Reply-To: <d6ec23eb-a886-9fef-99c7-51c7ba4f5d18@infradead.org>
References: <20180308002016.L3JwBaNZ9%akpm@linux-foundation.org>
 <41ec9eeb-f0bf-e26d-e3ae-4a684c314360@infradead.org> <d6ec23eb-a886-9fef-99c7-51c7ba4f5d18@infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 7 Mar 2018 18:34:44 -0800
Message-ID: <CALvZod53CV+R0CeVPDJ=3JAtFjyOfSSSrr3x0tqAWHec0AshTA@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 6:23 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 03/07/2018 06:20 PM, Randy Dunlap wrote:
>> On 03/07/2018 04:20 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2018-03-07-16-19 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>
>> UML on i386 and/or x86_64:
>>
>> defconfig, CONFIG_MEMCG is not set:
>>
>> ../fs/notify/group.c: In function 'fsnotify_final_destroy_group':
>> ../fs/notify/group.c:41:24: error: dereferencing pointer to incomplete type
>>    css_put(&group->memcg->css);
>>                         ^
>>
>> From: Shakeel Butt <shakeelb@google.com>
>> Subject: fs: fsnotify: account fsnotify metadata to kmemcg
>
>
>
> or x86 any time that CONFIG_MEMCG is not enabled.
>
>

Sorry about that. Replacing this with mem_cgroup_put(group->memcg)
should solve the issue on the mm tree.
