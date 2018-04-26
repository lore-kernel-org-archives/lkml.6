Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbeDZMFa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:05:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:44812 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754428AbeDZMF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:05:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="40743281"
Date: Thu, 26 Apr 2018 20:04:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: net/core/dev.c:1588:2-3: Unneeded semicolon
Message-ID: <201804262021.shCCSL92%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69bfd470f4623d2d57ad62cb33791cded0c662f4
commit: ede2762d93ff16e0974f7446516b46b1022db213 net: Make NETDEV_XXX commands enum { }
date:   4 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> net/core/dev.c:1588:2-3: Unneeded semicolon

vim +1588 net/core/dev.c

  1573	
  1574	const char *netdev_cmd_to_name(enum netdev_cmd cmd)
  1575	{
  1576	#define N(val) 						\
  1577		case NETDEV_##val:				\
  1578			return "NETDEV_" __stringify(val);
  1579		switch (cmd) {
  1580		N(UP) N(DOWN) N(REBOOT) N(CHANGE) N(REGISTER) N(UNREGISTER)
  1581		N(CHANGEMTU) N(CHANGEADDR) N(GOING_DOWN) N(CHANGENAME) N(FEAT_CHANGE)
  1582		N(BONDING_FAILOVER) N(PRE_UP) N(PRE_TYPE_CHANGE) N(POST_TYPE_CHANGE)
  1583		N(POST_INIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER)
  1584		N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA) N(BONDING_INFO)
  1585		N(PRECHANGEUPPER) N(CHANGELOWERSTATE) N(UDP_TUNNEL_PUSH_INFO)
  1586		N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_LEN)
  1587		N(UNREGISTER_FINAL)
> 1588		};
  1589	#undef N
  1590		return "UNKNOWN_NETDEV_EVENT";
  1591	}
  1592	EXPORT_SYMBOL_GPL(netdev_cmd_to_name);
  1593	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
