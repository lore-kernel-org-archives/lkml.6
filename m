Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeEOBid (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:38:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:57617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbeEOBib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:38:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,402,1520924400";
   d="scan'208";a="50855182"
Date: Tue, 15 May 2018 09:38:20 +0800
From: kbuild test robot <lkp@intel.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org, davem@davemloft.net,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        ast@kernel.org, daniel@iogearbox.net, edumazet@google.com,
        vladbu@mellanox.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 05/14] net: sched: always take reference to action
Message-ID: <201805150914.qi3ndJdl%fengguang.wu@intel.com>
References: <1526308035-12484-6-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-6-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]
[also build test WARNING on v4.17-rc5 next-20180514]
[cannot apply to net-next/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vlad-Buslov/Modify-action-API-for-implementing-lockless-actions/20180515-025420
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   net/sched/act_api.c:71:15: sparse: incorrect type in initializer (different address spaces) @@    expected struct tc_cookie [noderef] <asn:4>*__ret @@    got [noderef] <asn:4>*__ret @@
   net/sched/act_api.c:71:15:    expected struct tc_cookie [noderef] <asn:4>*__ret
   net/sched/act_api.c:71:15:    got struct tc_cookie *new_cookie
   net/sched/act_api.c:71:13: sparse: incorrect type in assignment (different address spaces) @@    expected struct tc_cookie *old @@    got struct tc_cookie [noderef] <struct tc_cookie *old @@
   net/sched/act_api.c:71:13:    expected struct tc_cookie *old
   net/sched/act_api.c:71:13:    got struct tc_cookie [noderef] <asn:4>*[assigned] __ret
>> net/sched/act_api.c:287:6: sparse: symbol '__tcf_idr_check' was not declared. Should it be static?
   net/sched/act_api.c:144:48: sparse: dereference of noderef expression

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
