Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeBUVKd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:10:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44009 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeBUVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:10:30 -0500
X-Google-Smtp-Source: AH8x227FIsP6bL8JjwufK/Wt+e0+2vFZn4xpf+uB1KewoWl72KJrdqJyb+9/GiRsVRVUMNqVlQ9sqlOhnGSkASlJh4Y=
MIME-Version: 1.0
In-Reply-To: <20180220131253.GF25314@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com> <20180220131253.GF25314@hirez.programming.kicks-ass.net>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 21 Feb 2018 21:10:28 +0000
Message-ID: <CACvgo50rWD737JhfR=7sH3bVUwR3FdWN9bve7yZ2zxGHHuBFgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function v3
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LLAawU021115

On 20 February 2018 at 13:12, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Feb 20, 2018 at 01:58:26PM +0100, Christian König wrote:
>> amdgpu needs to verify if userspace sends us valid addresses and the simplest
>> way of doing this is to check if the buffer object is locked with the ticket
>> of the current submission.
>>
>> Clean up the access to the ww_mutex internals by providing a function
>> for this and extend the check to the thread owning the underlying mutex.
>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>
> Much thanks for Cc'ing the relevant maintainers :/
>
Doubt it's intentional. The get-maintainer script seems confused and
lists no maintainers?

$ ./scripts/get_maintainer.pl include/linux/ww_mutex.h
linux-kernel@vger.kernel.org (open list)

While the normal mutex header works fine.

$ ./scripts/get_maintainer.pl include/linux/mutex.h
Peter Zijlstra <peterz@infradead.org> (maintainer:LOCKING PRIMITIVES)
Ingo Molnar <mingo@redhat.com> (maintainer:LOCKING PRIMITIVES)
linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)

HTH
Emil
