Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDZBVY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:21:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37605 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDZBVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:21:22 -0400
X-Google-Smtp-Source: AIpwx4/Pu2OG8VowHJ/Nq9OagWahcb3ixZQXNg0932qBF/zy5Lzzc1R0YjcT4hFfo4aCaVqs7T/fzGQV5MVvu65fHfA=
MIME-Version: 1.0
In-Reply-To: <20180425214307.159264-1-edumazet@google.com>
References: <20180425214307.159264-1-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Wed, 25 Apr 2018 21:20:40 -0400
Message-ID: <CACSApvZF8CJqcRx7FGkMGitBiC6m0=_FT9XRZ=VV07U62wGM3Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/2] tcp: mmap: rework zerocopy receive
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 5:43 PM, Eric Dumazet <edumazet@google.com> wrote:
> syzbot reported a lockdep issue caused by tcp mmap() support.
>
> I implemented Andy Lutomirski nice suggestions to resolve the
> issue and increase scalability as well.
>
> First patch is adding a new setsockopt() operation and changes mmap()
> behavior.
>
> Second patch changes tcp_mmap reference program.
>
> v2:
>  Added a missing page align of zc->length in tcp_zerocopy_receive()
>  Properly clear zc->recv_skip_hint in case user request was completed.

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thank you Eric for the nice redesign!

> Eric Dumazet (2):
>   tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive
>   selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE
>
>  include/uapi/linux/tcp.h               |   8 ++
>  net/ipv4/tcp.c                         | 189 +++++++++++++------------
>  tools/testing/selftests/net/tcp_mmap.c |  63 +++++----
>  3 files changed, 142 insertions(+), 118 deletions(-)
>
> --
> 2.17.0.441.gb46fe60e1d-goog
>
