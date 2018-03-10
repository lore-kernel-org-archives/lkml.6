Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeCJEuS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 23:50:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:4951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932858AbeCJEuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 23:50:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,449,1515484800";
   d="scan'208";a="32740865"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: RE: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate
 signaling for link check/link up"
Thread-Topic: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate
 signaling for link check/link up"
Thread-Index: AQHTtO5Yj5rEs8kwsEuU0WJCrzcdnqPI7HiQ
Date: Sat, 10 Mar 2018 04:50:14 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C801AAC@ORSMSX101.amr.corp.intel.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
In-Reply-To: <20180306015553.10441-1-bpoirier@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Monday, March 5, 2018 5:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: Separate signaling for
> link check/link up"
> 
> This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
> This reverts commit d3604515c9eda464a92e8e67aae82dfe07fe3c98.
> 
> Commit 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> changed what happens to the link status when there is an error which
> happens after "get_link_status = false" in the copper check_for_link
> callbacks. Previously, such an error would be ignored and the link
> considered up. After that commit, any error implies that the link is down.
> 
> Revert commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up") and its followups. After reverting, the race condition described in
> the log of commit 19110cfbb34d is reintroduced. It may still be triggered
> by LSC events but this should keep the link down in case the link is
> electrically unstable, as discussed. The race may no longer be
> triggered by RXO events because commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts") restored reading icr in the Other
> handler.
> 
> Link: https://lkml.org/lkml/2018/3/1/789
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 13 ++++---------
>  drivers/net/ethernet/intel/e1000e/mac.c     | 13 ++++---------
>  drivers/net/ethernet/intel/e1000e/netdev.c  |  2 +-
>  3 files changed, 9 insertions(+), 19 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
