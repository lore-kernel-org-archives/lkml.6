Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDDMyJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:54:09 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36937 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeDDMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:54:07 -0400
X-Google-Smtp-Source: AIpwx48tBicqLgGiDKBJJDyCwUU3Hb21opB1QHXX7gYKIOfv4Pn+IDFBjPvLPcu46ZY9XazEpMZE2vYXSl+Ti3emg4g=
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9mfukUhMb5wXVuTyF9gtmo-L6xs7axninLGQ+pJ1dmoA@mail.gmail.com>
References: <20180404094931.2345742-1-arnd@arndb.de> <CAOi1vP9mfukUhMb5wXVuTyF9gtmo-L6xs7axninLGQ+pJ1dmoA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 14:54:05 +0200
X-Google-Sender-Auth: z5vNiqrvX4cQRQnQm-m-fuYf25k
Message-ID: <CAK8P3a2KkQRrn7-GiSzmUO9Gvphu_GxjSYCcPQmOiMpbE4905g@mail.gmail.com>
Subject: Re: [PATCH] rbd: add missing return statements
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jason Dillaman <dillaman@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 1:04 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Apr 4, 2018 at 11:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> A new set of warnings appeared in next-20180403 in some configurations
>> when gcc cannot see that rbd_assert(0) leads to an unreachable code
>> path:
>>
>> drivers/block/rbd.c: In function 'rbd_img_is_write':
>> drivers/block/rbd.c:1397:1: error: control reaches end of non-void function [-Werror=return-type]
>> drivers/block/rbd.c: In function '__rbd_obj_handle_request':
>> drivers/block/rbd.c:2499:1: error: control reaches end of non-void function [-Werror=return-type]
>> drivers/block/rbd.c: In function 'rbd_obj_handle_write':
>> drivers/block/rbd.c:2471:1: error: control reaches end of non-void function [-Werror=return-type]
>>
>> To work around this, we can add a return statement to each of these
>> cases. An alternative would be to remove the unlikely() annotation
>> in rbd_assert(), or to just use BUG()/BUG_ON() directly. This adds the
>> return statements, guessing what the most reasonable behavior
>> would be.
>
> Hi Arnd,
>
> I don't like these bogus return statements.  Let's go with explicit
> BUG/BUG_ON() instead.

Sounds good. Sent a v2 now.

       Arnd
