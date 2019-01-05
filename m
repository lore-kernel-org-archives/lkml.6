Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5DDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9AD21874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfAEEE0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:04:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:7817 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfAEEEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:04:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 20:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="115594931"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2019 20:04:25 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.158]) with mapi id 14.03.0415.000;
 Fri, 4 Jan 2019 20:04:24 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] e1000e: Exclude device from suspend direct complete
 optimization
Thread-Topic: [PATCH 1/2] e1000e: Exclude device from suspend direct
 complete optimization
Thread-Index: AQHUkSeX0skms0B0m0i+tTFo1prs4KWgNQTA
Date:   Sat, 5 Jan 2019 04:04:24 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9660FBCD@ORSMSX103.amr.corp.intel.com>
References: <20181211075938.32026-1-kai.heng.feng@canonical.com>
In-Reply-To: <20181211075938.32026-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Kai-Heng Feng
> Sent: Tuesday, December 11, 2018 12:00 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: davem@davemloft.net; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Kai-Heng Feng
> <kai.heng.feng@canonical.com>
> Subject: [PATCH 1/2] e1000e: Exclude device from suspend direct complete
> optimization
> 
> e1000e sets different WoL settings in system suspend callback and
> runtime suspend callback.
> 
> The suspend direct complete optimization leaves e1000e in runtime
> suspneded state with wrong WoL setting during system suspend.
> 
> To fix this, we need to disable suspend direct complete optimization to
> let e1000e always use suspend callback to set correct WoL during system
> suspend.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

