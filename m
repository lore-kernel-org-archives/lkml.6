Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967864AbeBODXk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 22:23:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:21134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966428AbeBODXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 22:23:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="28054593"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Benjamin Poirier <bpoirier@suse.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
 interrupt re-raising in Other interrupt.
Thread-Topic: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
 interrupt re-raising in Other interrupt.
Thread-Index: AQHToKjG9s14zqBi50mFCa/glayHzqOk1xkw
Date: Thu, 15 Feb 2018 03:23:36 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E62BB@ORSMSX103.amr.corp.intel.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
 <20180208064714.6042-2-bpoirier@suse.com>
In-Reply-To: <20180208064714.6042-2-bpoirier@suse.com>
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
> Subject: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
> interrupt re-raising in Other interrupt.
> 
> restores the ICS write for rx/tx queue interrupts which was present before
> commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt",
> v4.5-rc1) but was not restored in commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts", v4.15-rc1).
> 
> This re-raises the queue interrupts in case the txq or rxq bits were set in
> ICR and the Other interrupt handler read and cleared ICR before the queue
> interrupt was raised.
> 
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
