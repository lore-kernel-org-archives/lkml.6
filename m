Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeEVU3X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:29:23 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33477 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeEVU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:29:20 -0400
X-Google-Smtp-Source: AB8JxZon4JouIGn9Qu7y+gsBlURVSmOeWclpC7/j3FBJXEo3H5aPCLDJciM+HT9HWCBouOe8i4xjPMIMXlolafY15ZU=
MIME-Version: 1.0
In-Reply-To: <8a7108ce-a109-a1b5-ace7-38a189d2352d@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-28-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VcTpAkMeKa0YXpp91WooVPs5X7jPGk0w2ruitp4siKLVw@mail.gmail.com> <8a7108ce-a109-a1b5-ace7-38a189d2352d@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 23:29:18 +0300
Message-ID: <CAHp75VddbUBmPJta93NqdNc9WTEVN2bqimYOSbi9ejNT2rg0kw@mail.gmail.com>
Subject: Re: [PATCH 27/33] sched/debug: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 3:10 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:

>>> +       i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
>>> +       if (i >= 0) {
>>
>> Why not
>>
>> if (i < 0)
>>  return i;
>
> if i >=0 it will also return i. so need return i just if (i < 0), right ?

Looking to the only (modified) caller, I think yes, either you return
error code or just 0.

>>> -       if (i == __SCHED_FEAT_NR)
>>> +       if (i < 0)
>>>                 return -EINVAL;
>>
>> Now it would be
>>

>> if (i < 0)

...even if (i) and rename i to ret to show the change in returned value meaning.

>>  return i;
>
> Right, will change it in next version

-- 
With Best Regards,
Andy Shevchenko
