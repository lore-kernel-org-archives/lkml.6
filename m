Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934108AbeEIIY4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:24:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43914 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934072AbeEIIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:24:50 -0400
X-Google-Smtp-Source: AB8JxZqQejrsIMtinTO1Xcz4GYb0PXsPA78UfqS+qlI7M21Ctcc1sfAjGn8T7xEQvWY20Vuy7j5XP74klP6xddCgs0w=
MIME-Version: 1.0
In-Reply-To: <20180509141908.7b07df43@canb.auug.org.au>
References: <20180509141908.7b07df43@canb.auug.org.au>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 9 May 2018 10:24:49 +0200
Message-ID: <CADYN=9JYJVVKyrPexNKNkbNjNBr1B3Xeuf6-wpdpE9+Px1UF9g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2018 at 06:19, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   tools/testing/selftests/net/Makefile
>
> between commit:
>
>   1751eb42ddb5 ("selftests: net: use TEST_PROGS_EXTENDED")
>
> from the net tree and commits:
>
>   a7b15ab887e5 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc tools/testing/selftests/net/Makefile
> index 3ff81a478dbe,73af45773938..000000000000
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@@ -5,10 -5,13 +5,13 @@@ CFLAGS =  -Wall -Wl,--no-as-needed -O2
>   CFLAGS += -I../../../../usr/include/
>
>   TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh rtnetlink.sh
> - TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh
> + TEST_PROGS += fib_tests.sh fib-onlink-tests.sh in_netns.sh pmtu.sh udpgso.sh

in_netns.sh shouldn't be in the above list, its already in the
TEST_PROGS_EXTENDED below.

Cheers,
Anders

> + TEST_PROGS += udpgso_bench.sh
>  -TEST_GEN_PROGS_EXTENDED := in_netns.sh
>  +TEST_PROGS_EXTENDED := in_netns.sh
>   TEST_GEN_FILES =  socket
>   TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy
> + TEST_GEN_FILES += tcp_mmap tcp_inq
> + TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
>   TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
>   TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict
>
