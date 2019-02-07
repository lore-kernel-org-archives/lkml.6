Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A2421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539744;
	bh=8GJQ6K8i8b2i9RUOR5rhXCJl7zECUdrLoSVF0mlLcsg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ih+F97x2Ifkq/woEMLizFFew5Ko+aTJh1/6LD5pQzF9wiDE6hQInqhk2eQjeX8HUw
	 9JMqc6R34oGM5M4Gx4OKxaM/rprC5qViOvsUcJPCuCoVNmJxDFxjOYhNyIrNVZJuTt
	 ebki6uOnVMA+dHspC2R6b+ENNcvqD9Uwm59gowW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBGLmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGLmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25656218FE;
        Thu,  7 Feb 2019 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539740;
        bh=8GJQ6K8i8b2i9RUOR5rhXCJl7zECUdrLoSVF0mlLcsg=;
        h=From:To:Cc:Subject:Date:From;
        b=xg25pfbHhSYHKVqwhpnNJGg0ijcYVTij1SchyCxceODY3UzxhYDNXrhf4NPYZuewR
         x3mNVpmOl0i63gnc+TdnftsCQ152DcYsA1csOou4h3PI4wKXPP2/6QVG15eOCrVgMG
         cIS6DJmwb6Suf6p82wNJTkGUTVhPYvbQjRq/yAdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/34] 4.4.174-stable review
Date:   Thu,  7 Feb 2019 12:41:42 +0100
Message-Id: <20190207113025.552605181@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.174-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.174-rc1
X-KernelTest-Deadline: 2019-02-09T11:30+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.174 release.
There are 34 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.174-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.174-rc1

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    rcu: Force boolean subscript for expedited stall warnings

Michal Kubecek <mkubecek@suse.cz>
    net: ipv4: do not handle duplicate fragments as overlapping

Dimitris Michailidis <dmichail@google.com>
    net: fix pskb_trim_rcsum_slow() with odd trim offset

Eric Dumazet <edumazet@google.com>
    inet: frags: better deal with smp races

Dan Carpenter <dan.carpenter@oracle.com>
    ipv4: frags: precedence bug in ip_expire()

Taehee Yoo <ap420073@gmail.com>
    ip: frags: fix crash in ip_do_fragment()

Peter Oskolkov <posk@google.com>
    ip: process in-order fragments efficiently

Peter Oskolkov <posk@google.com>
    ip: add helpers to process in-order fragments faster.

Peter Oskolkov <posk@google.com>
    ip: use rb trees for IP frag queue.

Eric Dumazet <edumazet@google.com>
    net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends

Florian Westphal <fw@strlen.de>
    ipv6: defrag: drop non-last frags smaller than min mtu

Peter Oskolkov <posk@google.com>
    net: modify skb_rbtree_purge to return the truesize of all purged skbs.

Peter Oskolkov <posk@google.com>
    ip: discard IPv4 datagrams with overlapping segments.

Eric Dumazet <edumazet@google.com>
    inet: frags: fix ip6frag_low_thresh boundary

Eric Dumazet <edumazet@google.com>
    inet: frags: get rid of ipfrag_skb_cb/FRAG_CB

Eric Dumazet <edumazet@google.com>
    inet: frags: reorganize struct netns_frags

Eric Dumazet <edumazet@google.com>
    rhashtable: reorganize struct rhashtable layout

Eric Dumazet <edumazet@google.com>
    ipv6: frags: rewrite ip6_expire_frag_queue()

Eric Dumazet <edumazet@google.com>
    inet: frags: do not clone skb in ip_expire()

Eric Dumazet <edumazet@google.com>
    inet: frags: break the 2GB limit for frags storage

Eric Dumazet <edumazet@google.com>
    inet: frags: remove inet_frag_maybe_warn_overflow()

Eric Dumazet <edumazet@google.com>
    inet: frags: get rif of inet_frag_evicting()

Eric Dumazet <edumazet@google.com>
    inet: frags: remove some helpers

Paolo Abeni <pabeni@redhat.com>
    ipfrag: really prevent allocation on netns exit

Alexander Aring <aring@mojatatu.com>
    net: ieee802154: 6lowpan: fix frag reassembly

Eric Dumazet <edumazet@google.com>
    inet: frags: use rhashtables for reassembly units

Eric Dumazet <edumazet@google.com>
    rhashtable: add schedule points

Ben Hutchings <ben.hutchings@codethink.co.uk>
    rhashtable: Add rhashtable_lookup()

Pablo Neira Ayuso <pablo@netfilter.org>
    rhashtable: add rhashtable_lookup_get_insert_key()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor lowpan_net_frag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipv6_frag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: refactor ipfrag_init()

Eric Dumazet <edumazet@google.com>
    inet: frags: add a pointer to struct netns_frags

Eric Dumazet <edumazet@google.com>
    inet: frags: change inet_frags_init_net() return value


-------------

Diffstat:

 Documentation/networking/ip-sysctl.txt  |  13 +-
 Makefile                                |   4 +-
 include/linux/rhashtable.h              | 143 ++++++--
 include/linux/skbuff.h                  |  16 +-
 include/net/inet_frag.h                 | 133 ++++----
 include/net/ip.h                        |   1 -
 include/net/ipv6.h                      |  26 +-
 include/uapi/linux/snmp.h               |   1 +
 kernel/rcu/tree.c                       |   2 +-
 lib/rhashtable.c                        |  15 +-
 net/core/skbuff.c                       |  21 +-
 net/ieee802154/6lowpan/6lowpan_i.h      |  26 +-
 net/ieee802154/6lowpan/reassembly.c     | 148 ++++-----
 net/ipv4/inet_fragment.c                | 389 +++++-----------------
 net/ipv4/ip_fragment.c                  | 571 ++++++++++++++++++--------------
 net/ipv4/proc.c                         |   7 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 100 +++---
 net/ipv6/proc.c                         |   5 +-
 net/ipv6/reassembly.c                   | 209 ++++++------
 19 files changed, 868 insertions(+), 962 deletions(-)


