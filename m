Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756081AbeCHPpr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:45:47 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34870 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755696AbeCHPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:45:45 -0500
X-Google-Smtp-Source: AG47ELunDlO8SMpDqMfDgJYIgU1fDUe3zDPPB6uFlVYaLFsjjdglbgTgyvJrgXnQqKhnN+o18dWzhA==
Date: Thu, 8 Mar 2018 07:45:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        andreyknvl <andreyknvl@google.com>
Subject: Re: KASAN poisoning for skb linear data
Message-ID: <20180308074543.250898af@xeon-e3>
In-Reply-To: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
References: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2018 15:15:04 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> Hi,
> 
> As far as I understand pskb_may_pull() plays important role in packet
> parsing for all protocols. And we did custom fragmentation of packets
> emitted via tun (IFF_NAPI_FRAGS). However, it seems that it does not
> give any results (bugs found), and I think the reason for this is that
> linear data is rounded up and is usually quite large. So if a parsing
> function does pskb_may_pull(1), or does not do it at all, it can
> usually access more and it will go unnoticed. KASAN has an ability to
> do custom poisoning: it can poison/unpoison any memory range, and then
> detect any reads/writes to that range. What do you think about adding
> custom KASAN poisoning to pskb_may_pull() and switching it to
> non-eager mode (pull only what was requested) under KASAN? Do you
> think it has potential for finding important bugs? What amount of work
> is this?
> 
> Thanks

Also, kernel networking only deals with in-tree upstream code.
Any problems with infrastructure for custom code are your problem
to deal with, not our problem.
