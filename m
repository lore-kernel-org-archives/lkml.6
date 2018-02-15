Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032761AbeBODXQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 22:23:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:21121 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032563AbeBODXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 22:23:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="204340738"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert "e1000e:
 Avoid receiver overrun interrupt bursts"
Thread-Topic: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert
 "e1000e: Avoid receiver overrun interrupt bursts"
Thread-Index: AQHToKjK9REMYVbzqUmYzeYwVw+yAKOk1x1w
Date: Thu, 15 Feb 2018 03:23:12 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62AD@ORSMSX103.amr.corp.intel.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
In-Reply-To: <20180208064714.6042-1-bpoirier@suse.com>
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
> Sent: Wednesday, February 7, 2018 10:47 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-queue 1/3] Partial revert "e1000e:
> Avoid receiver overrun interrupt bursts"
> 
> This partially reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.
> 
> We keep the fix for the first part of the problem (1) described in the log
> of that commit, that is to read ICR in the other interrupt handler. We
> remove the fix for the second part of the problem (2), Other interrupt
> throttling.
> 
> Bursts of "Other" interrupts may once again occur during rxo (receive
> overflow) traffic conditions. This is deemed acceptable in the interest of
> avoiding unforeseen fallout from changes that are not strictly necessary.
> As discussed, the e1000e driver should be in "maintenance mode".
> 
> Link: https://www.spinics.net/lists/netdev/msg480675.html
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
