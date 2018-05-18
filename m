Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeERFPQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:15:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:53466 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERFPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:15:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="40311265"
Date: Fri, 18 May 2018 13:14:23 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yuchung Cheng <ycheng@google.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] tcp: tcp_rack_reo_wnd() can be static
Message-ID: <20180518051423.GA41595@lkp-ivb-ep02>
References: <201805181300.JN7KwXNm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805181300.JN7KwXNm%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 20b654dfe1be ("tcp: support DUPACK threshold in RACK")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 tcp_recovery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index 30cbfb6..71593e4 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -21,7 +21,7 @@ static bool tcp_rack_sent_after(u64 t1, u64 t2, u32 seq1, u32 seq2)
 	return t1 > t2 || (t1 == t2 && after(seq1, seq2));
 }
 
-u32 tcp_rack_reo_wnd(const struct sock *sk)
+static u32 tcp_rack_reo_wnd(const struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
