Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965846AbeBMUyO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:54:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:11806 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965676AbeBMUyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:54:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="34431828"
From: "Brown, Aaron F" <aaron.f.brown@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
Thread-Topic: [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
Thread-Index: AQHTn4OHcDeCrzjbZEOHna/FuAZEK6Oi2msw
Date: Tue, 13 Feb 2018 20:54:10 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E574C@ORSMSX103.amr.corp.intel.com>
References: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1DKsIbw022881

> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Christophe JAILLET
> Sent: Tuesday, February 6, 2018 11:48 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>
> Subject: [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
> 
> 'HWTSTAMP_TX_ON' should be handled as a value, not as a bit mask.
> The modified code should behave the same, because HWTSTAMP_TX_ON is
> 1
> and no other possible values of 'tx_type' would match the test.
> However, this is more future-proof, should other values be allowed one day.
> 
> See 'struct hwtstamp_config' in 'include/uapi/linux/net_tstamp.h'
> 
> This fixes a warning reported by smatch:
>    igb_xmit_frame_ring() warn: bit shifter 'HWTSTAMP_TX_ON' used for
> logical '&'
> 
> Fixes: 26bd4e2db06be ("igb: protect TX timestamping from API misuse")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
