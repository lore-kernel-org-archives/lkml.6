Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967715AbeBNMiy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:38:54 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967589AbeBNMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:38:53 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
 <20180214045442.jyv6zpbwz5glzi4z@gordon>
 <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net>
 <20180214102410.dxgbayb4i76h5exo@gordon>
 <24ddea73-5c84-e098-caae-8a4c14834cbd@metux.net>
 <CAFLxGvzxLP_UTQbwEY99bQfyftWzZHwaOP+WrzJ8099EKtbVLg@mail.gmail.com>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4864d279-9a3f-eaf4-c297-ea34be604e41@metux.net>
Date: Wed, 14 Feb 2018 13:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzxLP_UTQbwEY99bQfyftWzZHwaOP+WrzJ8099EKtbVLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:3g6GrV+vrY6SR7uS7H1tfEfWBfljNboSpMO7VZgSV1X4+5VqTTN
 n6bIA/KNJZrzynATbGfihzByxeF2ce3KzQoIYk7rw37JLMZYV6W30WL1dfeBmMbeyNmM9qT
 XriykL+7xSew3bln3olE8AFJ3vZDbcCrqnFllcPPch5EPSadTOjHTnEjfrpRlKcFFxnK2fZ
 6YunGWo8W9wgQ2HRq7C6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kOr3SAVYVmU=:ooTQmlRnRJRafLB8VGxRao
 w69dIQGLCFGn2918e6PtSNws4VkuCp6vBK6FfWdaKhiytOCEi/iNrpNMx3IOjTFxy1XDjgf4c
 cXARWquWxueBxq4TRrCLW3sZ27tAwSoawPBfbvbrh6/fQ4DiaxkWtvtmF3favWzaqZcKdr+RK
 QZq8YXESiQcH5/4BAJiNq/71snlN1rpE5Aid1bk7WWWVXJgRhShomcGY3adv7wvzHiCpZ9e62
 PLsfNM0Z5vy7YYJZSwl1yhhILjeZjJEBKbqB+vs9hhgD2yvan4n5Nw3J5OxxvARMhxdgF22i4
 E6dRcqDbyYbUh1Q1cUEaDLp7mBpelg+bN9lZK5eW//2o1tcc8Qrl+oaYWZpSIjrqeyds9MycQ
 jAhQP2R3Dq9jyG7aGHzapxOimFUQ6K2nuc0MP9TOYd/tl+CMjW9mNJTFBveCuWsKzEV62oaZl
 EsbOICeIJUQb4nrRRf0hbX3tP4/jydHEPVhgE4ha2WbhXYOXFjxlaIWp/aDhtmGhJQYHTV4Pw
 6x5cfUZ+yAr6x2zO35wfgOx3dDWYLza4qxE78/HVmI0jx28V2NG6TAX6O8dMsdIYni4uwfyOn
 oGUsYANB1WVbsZ6RxcIQ4SDyz5A9ZwtisE1i3hi5dyHU3L/sslTRswogJ3C466lNSS8wBzBIv
 1ZTettIAGZ82qwvw2JqNpITb8rfPYYHWTfgHA0IinQyTn7XtMy3H0FK5VHk/Ufj8W4okeUS0w
 hSQMie7rX3Ty9Y9tgpEiNf4qdaW/ECCaUobD5yQ4EDmNt6Ud2m42Wgcy6Co=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 12:30, Richard Weinberger wrote:
> On Wed, Feb 14, 2018 at 12:27 PM, Enrico Weigelt <lkml@metux.net> wrote:
>> On 14.02.2018 11:24, Aleksa Sarai wrote:
>>
>>> What distribution are you using and which release?
>>
>>
>> On a self-compiled system.
>>
>> Forgot to enable namespaces in the kernel. Now it seems to work
>> as root, but not as an unprivileged user:
>>
>>
>> daemon@alphabox:~ unshare -r -U
>> unshare: can't open '/proc/self/setgroups': Permission denied
>> daemon@alphabox:~ unshare -f -r -U
>> unshare: can't open '/proc/self/setgroups': Permission denied
>>
> 
> Please read http://man7.org/linux/man-pages/man7/user_namespaces.7.html
> setgroups is a corner case and needs special care.

I'm still confused. Does the unshare program do something wrong here ?

Anyways, I doubt that user namespaces help solving my problem.

What I'd like to achieve is that processes can manipulate their private 
namespace at will and mount other filesystems (primarily 9p and fuse).

For that, I need to get rid of setuid (and per-file caps) for these
private namespaces.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
