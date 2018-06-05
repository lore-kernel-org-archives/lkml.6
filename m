Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeFEOm4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:42:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45663 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeFEOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:42:55 -0400
X-Google-Smtp-Source: ADUXVKKc5c05YWfN4c/Gc6yleMWeUrxYo8ixKqC/uilIWAfwyOl5F4RNLchcyYbrjOaIlE2XPP2DcevzXZOJfqj44Gw=
MIME-Version: 1.0
References: <20180605114056.1239571-1-arnd@arndb.de>
In-Reply-To: <20180605114056.1239571-1-arnd@arndb.de>
From: =?UTF-8?B?RWNrbCwgTcOhdMOp?= <ecklm94@gmail.com>
Date: Tue, 5 Jun 2018 16:42:27 +0200
Message-ID: <CAPFYX+KmWcO390JP_UbkyuBZWvcxZ9ym=w=T=mA+anazGPOw-A@mail.gmail.com>
Subject: Re: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
To: arnd@arndb.de
Cc: pablo@netfilter.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, pabeni@redhat.com, willemb@google.com,
        edumazet@google.com, dsahern@gmail.com, kafai@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55Eh1cw016745

Arnd Bergmann <arnd@arndb.de> ezt írta (időpont: 2018. jún. 5., K, 13:41):
>
> It is now possible to enable the libified nf_tproxy modules without
> also enabling NETFILTER_XT_TARGET_TPROXY, which throws off the
> ifdef logic in the udp core code:
>
> net/ipv6/netfilter/nf_tproxy_ipv6.o: In function `nf_tproxy_get_sock_v6':
> nf_tproxy_ipv6.c:(.text+0x1a8): undefined reference to `udp6_lib_lookup'
> net/ipv4/netfilter/nf_tproxy_ipv4.o: In function `nf_tproxy_get_sock_v4':
> nf_tproxy_ipv4.c:(.text+0x3d0): undefined reference to `udp4_lib_lookup'
>
> We can actually simplify the conditions now to provide the two functions
> exactly when they are needed.
>
> Fixes: 45ca4e0cf273 ("netfilter: Libify xt_TPROXY")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Máté Eckl <ecklm94@gmail.com>
