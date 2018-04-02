Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeDBH6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:58:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:37062 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754231AbeDBH57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:57:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,394,1517904000";
   d="scan'208";a="42673106"
Date: Mon, 2 Apr 2018 15:57:18 +0800
From: kbuild test robot <lkp@intel.com>
To: Anton Gary Ceph <agaceph@gmail.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: improve ipv4 performances
Message-ID: <201804021425.2Zqa6ICF%fengguang.wu@intel.com>
References: <20180401183121.13022-1-agaceph@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180401183121.13022-1-agaceph@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]
[also build test WARNING on v4.16 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anton-Gary-Ceph/net-improve-ipv4-performances/20180402-103807
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/bridge/br_private.h:690:15: sparse: restricted __be16 degrades to integer
   net/bridge/br_private.h:694:15: sparse: restricted __be16 degrades to integer
--
>> net/bridge/br_multicast.c:66:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:69:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:96:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:99:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:171:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:175:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:96:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:99:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:581:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:584:14: sparse: restricted __be16 degrades to integer
>> net/bridge/br_multicast.c:66:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:69:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:96:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:99:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:96:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:99:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1325:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1328:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1765:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1769:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1913:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:1917:14: sparse: restricted __be16 degrades to integer
>> net/bridge/br_private.h:690:15: sparse: restricted __be16 degrades to integer
   net/bridge/br_private.h:694:15: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:2497:14: sparse: restricted __be16 degrades to integer
   net/bridge/br_multicast.c:2532:14: sparse: restricted __be16 degrades to integer
--
   net/core/filter.c:318:33: sparse: subtraction of functions? Share your drugs
   net/core/filter.c:321:33: sparse: subtraction of functions? Share your drugs
   net/core/filter.c:324:33: sparse: subtraction of functions? Share your drugs
   net/core/filter.c:327:33: sparse: subtraction of functions? Share your drugs
   net/core/filter.c:330:33: sparse: subtraction of functions? Share your drugs
   net/core/filter.c:1184:39: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct sock_filter const *filter @@    got struct sockstruct sock_filter const *filter @@
   net/core/filter.c:1184:39:    expected struct sock_filter const *filter
   net/core/filter.c:1184:39:    got struct sock_filter [noderef] <asn:1>*filter
   net/core/filter.c:1286:39: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct sock_filter const *filter @@    got struct sockstruct sock_filter const *filter @@
   net/core/filter.c:1286:39:    expected struct sock_filter const *filter
   net/core/filter.c:1286:39:    got struct sock_filter [noderef] <asn:1>*filter
   net/core/filter.c:1547:43: sparse: incorrect type in argument 2 (different base types) @@    expected restricted __wsum [usertype] diff @@    got unsigned lonrestricted __wsum [usertype] diff @@
   net/core/filter.c:1547:43:    expected restricted __wsum [usertype] diff
   net/core/filter.c:1547:43:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1550:36: sparse: incorrect type in argument 2 (different base types) @@    expected restricted __be16 [usertype] old @@    got unsigned lonrestricted __be16 [usertype] old @@
   net/core/filter.c:1550:36:    expected restricted __be16 [usertype] old
   net/core/filter.c:1550:36:    got unsigned long long [unsigned] [usertype] from
   net/core/filter.c:1550:42: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __be16 [usertype] new @@    got unsigned lonrestricted __be16 [usertype] new @@
   net/core/filter.c:1550:42:    expected restricted __be16 [usertype] new
   net/core/filter.c:1550:42:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1553:36: sparse: incorrect type in argument 2 (different base types) @@    expected restricted __be32 [usertype] from @@    got unsigned lonrestricted __be32 [usertype] from @@
   net/core/filter.c:1553:36:    expected restricted __be32 [usertype] from
   net/core/filter.c:1553:36:    got unsigned long long [unsigned] [usertype] from
   net/core/filter.c:1553:42: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __be32 [usertype] to @@    got unsigned lonrestricted __be32 [usertype] to @@
   net/core/filter.c:1553:42:    expected restricted __be32 [usertype] to
   net/core/filter.c:1553:42:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1598:59: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __wsum [usertype] diff @@    got unsigned lonrestricted __wsum [usertype] diff @@
   net/core/filter.c:1598:59:    expected restricted __wsum [usertype] diff
   net/core/filter.c:1598:59:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1601:52: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __be16 [usertype] from @@    got unsigned lonrestricted __be16 [usertype] from @@
   net/core/filter.c:1601:52:    expected restricted __be16 [usertype] from
   net/core/filter.c:1601:52:    got unsigned long long [unsigned] [usertype] from
   net/core/filter.c:1601:58: sparse: incorrect type in argument 4 (different base types) @@    expected restricted __be16 [usertype] to @@    got unsigned lonrestricted __be16 [usertype] to @@
   net/core/filter.c:1601:58:    expected restricted __be16 [usertype] to
   net/core/filter.c:1601:58:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1604:52: sparse: incorrect type in argument 3 (different base types) @@    expected restricted __be32 [usertype] from @@    got unsigned lonrestricted __be32 [usertype] from @@
   net/core/filter.c:1604:52:    expected restricted __be32 [usertype] from
   net/core/filter.c:1604:52:    got unsigned long long [unsigned] [usertype] from
   net/core/filter.c:1604:58: sparse: incorrect type in argument 4 (different base types) @@    expected restricted __be32 [usertype] to @@    got unsigned lonrestricted __be32 [usertype] to @@
   net/core/filter.c:1604:58:    expected restricted __be32 [usertype] to
   net/core/filter.c:1604:58:    got unsigned long long [unsigned] [usertype] to
   net/core/filter.c:1650:28: sparse: incorrect type in return expression (different base types) @@    expected unsigned long long @@    got nsigned long long @@
   net/core/filter.c:1650:28:    expected unsigned long long
   net/core/filter.c:1650:28:    got restricted __wsum
   net/core/filter.c:1672:35: sparse: incorrect type in return expression (different base types) @@    expected unsigned long long @@    got restricted unsigned long long @@
   net/core/filter.c:1672:35:    expected unsigned long long
   net/core/filter.c:1672:35:    got restricted __wsum [usertype] csum
>> net/core/filter.c:2244:14: sparse: restricted __be16 degrades to integer
   net/core/filter.c:2246:14: sparse: restricted __be16 degrades to integer
--
>> include/linux/netdevice.h:4035:14: sparse: restricted __be16 degrades to integer
   include/linux/netdevice.h:4037:14: sparse: restricted __be16 degrades to integer
>> net/core/skbuff.c:4646:14: sparse: restricted __be16 degrades to integer
   net/core/skbuff.c:4650:14: sparse: restricted __be16 degrades to integer
--
>> include/net/netfilter/nf_queue.h:83:14: sparse: restricted __be16 degrades to integer
   include/net/netfilter/nf_queue.h:89:14: sparse: restricted __be16 degrades to integer
>> include/net/netfilter/nf_queue.h:83:14: sparse: restricted __be16 degrades to integer
   include/net/netfilter/nf_queue.h:89:14: sparse: restricted __be16 degrades to integer
--
>> net/netfilter/nf_tables_netdev.c:27:14: sparse: restricted __be16 degrades to integer
   net/netfilter/nf_tables_netdev.c:30:14: sparse: restricted __be16 degrades to integer
--
>> include/net/netfilter/nf_queue.h:83:14: sparse: restricted __be16 degrades to integer
   include/net/netfilter/nf_queue.h:89:14: sparse: restricted __be16 degrades to integer
--
>> net/netfilter/nf_flow_table_inet.c:14:14: sparse: restricted __be16 degrades to integer
   net/netfilter/nf_flow_table_inet.c:16:14: sparse: restricted __be16 degrades to integer
--
>> net/openvswitch/conntrack.c:1113:14: sparse: restricted __be16 degrades to integer
   net/openvswitch/conntrack.c:1116:14: sparse: restricted __be16 degrades to integer

vim +690 net/bridge/br_private.h

cc0fdd80 Linus Lüssing       2013-08-30  685  
cc0fdd80 Linus Lüssing       2013-08-30  686  static inline bool br_multicast_querier_exists(struct net_bridge *br,
cc0fdd80 Linus Lüssing       2013-08-30  687  					       struct ethhdr *eth)
b00589af Linus Lüssing       2013-08-01  688  {
f9ba1e10 Anton Gary Ceph     2018-04-01  689  	switch (__builtin_expect(eth->h_proto, ETH_P_IP)) {
cc0fdd80 Linus Lüssing       2013-08-30 @690  	case (htons(ETH_P_IP)):
0888d5f3 daniel              2016-06-24  691  		return __br_multicast_querier_exists(br,
0888d5f3 daniel              2016-06-24  692  			&br->ip4_other_query, false);
cc0fdd80 Linus Lüssing       2013-08-30  693  #if IS_ENABLED(CONFIG_IPV6)
cc0fdd80 Linus Lüssing       2013-08-30  694  	case (htons(ETH_P_IPV6)):
0888d5f3 daniel              2016-06-24  695  		return __br_multicast_querier_exists(br,
0888d5f3 daniel              2016-06-24  696  			&br->ip6_other_query, true);
cc0fdd80 Linus Lüssing       2013-08-30  697  #endif
cc0fdd80 Linus Lüssing       2013-08-30  698  	default:
cc0fdd80 Linus Lüssing       2013-08-30  699  		return false;
cc0fdd80 Linus Lüssing       2013-08-30  700  	}
b00589af Linus Lüssing       2013-08-01  701  }
1080ab95 Nikolay Aleksandrov 2016-06-28  702  

:::::: The code at line 690 was first introduced by commit
:::::: cc0fdd802859eaeb00e1c87dbb655594bed2844c bridge: separate querier and query timer into IGMP/IPv4 and MLD/IPv6 ones

:::::: TO: Linus Lüssing <linus.luessing@web.de>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
