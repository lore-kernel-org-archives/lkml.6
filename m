Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBXGnj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 01:43:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:28383 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXGni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 01:43:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,386,1515484800";
   d="scan'208";a="19882094"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
 return value with autoneg off.
Thread-Topic: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
 return value with autoneg off.
Thread-Index: AQHTqhHJ6IMO60qBHUCQghCtaYBTtKOzIRjQ
Date: Sat, 24 Feb 2018 06:43:36 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7FA12E@ORSMSX101.amr.corp.intel.com>
References: <20180220061200.17708-1-bpoirier@suse.com>
In-Reply-To: <20180220061200.17708-1-bpoirier@suse.com>
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
> Sent: Monday, February 19, 2018 10:12 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
> return value with autoneg off.
> 
> When autoneg is off, the .check_for_link callback functions clear the
> get_link_status flag and systematically return a "pseudo-error". This means
> that the link is not detected as up until the next execution of the
> e1000_watchdog_task() 2 seconds later.
> 
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>  drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
