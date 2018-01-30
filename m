Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeA3Sct (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:32:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33851 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeA3Scr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:32:47 -0500
X-Google-Smtp-Source: AH8x225aRAzw/43ena+LsJsq7vxhYXCAkaGIBbih/t+AT8/AyQhsczwGxbsMX5oz3bg83pLx3glhg1RAPKKo60rY5Lw=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
References: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 30 Jan 2018 10:32:26 -0800
Message-ID: <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: Dmitry Vyukov <dvyukov@google.com>
Cc: David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 4:09 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> The following program creates a hang in unregister_netdevice.
> cleanup_net work hangs there forever periodically printing
> "unregister_netdevice: waiting for lo to become free. Usage count = 3"
> and creation of any new network namespaces hangs forever.

Interestingly, this is not reproducible on net-next.
