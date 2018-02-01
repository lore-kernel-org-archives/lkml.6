Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeBAOfK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:35:10 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:37327 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeBAOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:34:58 -0500
X-Google-Smtp-Source: AH8x225lst1Im8M82Kx5eiziqMBvA0NH4/wTTIejcV43bNsySp71mukY6z+WmQp6LPj7etrejsMSkaFfo7ip1loOZlY=
MIME-Version: 1.0
In-Reply-To: <20180131072750.GF2736@zzz.localdomain>
References: <001a114292fa7f761c0560ad62e1@google.com> <001a113f542aed9c4e0560b66f3b@google.com>
 <20180131072750.GF2736@zzz.localdomain>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 1 Feb 2018 15:34:56 +0100
Message-ID: <CAAeHK+xwrXTsgKpXKbJJXeneXeh2eLhYegdPbJYEJH3sD6Ld5A@mail.gmail.com>
Subject: Re: WARNING in refcount_inc (2)
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot
        <bot+944a064dbc165044476317df06ebfb218415e951@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>, gscrivan@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, luc.vanoostenryck@gmail.com,
        Ingo Molnar <mingo@kernel.org>, netdev <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 8:27 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>
> Also Dmitry, syzbot seems to be grouping together unrelated bugs under the
> refcount_t WARNINGs; maybe those should be on a blacklist?

Not a blacklist, we need a proper way of extracting the offending
caller like it's done for reports from __this_cpu_* [1].

[1] https://github.com/google/syzkaller/blob/master/pkg/report/linux.go#L579
