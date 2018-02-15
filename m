Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967880AbeBODYA convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 22:24:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:21145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966428AbeBODX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 22:23:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="204254533"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-queue 3/3] e1000e: Avoid missed
 interrupts following ICR read.
Thread-Topic: [Intel-wired-lan] [PATCH net-queue 3/3] e1000e: Avoid missed
 interrupts following ICR read.
Thread-Index: AQHToKi1kS2OvYi6CE6rXtjT9NpTMaOk1xXw
Date: Thu, 15 Feb 2018 03:23:57 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62D1@ORSMSX103.amr.corp.intel.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
 <20180208064714.6042-3-bpoirier@suse.com>
In-Reply-To: <20180208064714.6042-3-bpoirier@suse.com>
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
> Subject: [Intel-wired-lan] [PATCH net-queue 3/3] e1000e: Avoid missed
> interrupts following ICR read.
> 
> The 82574 specification update errata 12 states that interrupts may be
> missed if ICR is read while INT_ASSERTED is not set. Avoid that problem by
> setting all bits related to events that can trigger the Other interrupt in
> IMS.
> 
> The Other interrupt is raised for such events regardless of whether or not
> they are set in IMS. However, only when they are set is the INT_ASSERTED
> bit also set in ICR.
> 
> By doing this, we ensure that INT_ASSERTED is always set when we read ICR
> in e1000_msix_other() and steer clear of the errata. This also ensures that
> ICR will automatically be cleared on read, therefore we no longer need to
> clear bits explicitly.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/defines.h | 21
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 11 ++++-------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
