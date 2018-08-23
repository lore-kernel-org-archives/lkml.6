Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC305C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501BB2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501BB2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHXAfi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:35:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:34485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbeHXAfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:35:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 14:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,279,1531810800"; 
   d="scan'208";a="85898320"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2018 14:04:09 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.46]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.80]) with mapi id 14.03.0319.002;
 Thu, 23 Aug 2018 14:04:09 -0700
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace
 GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
Thread-Topic: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace
 GFP_ATOMIC with GFP_KERNEL in igb_sw_init()
Thread-Index: AQHUJYCyDcK1KNmEWkCbAPhBTkPl1aTN/nMw
Date:   Thu, 23 Aug 2018 21:04:08 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9655021D@ORSMSX101.amr.corp.intel.com>
References: <20180727080453.3198-1-baijiaju1990@gmail.com>
In-Reply-To: <20180727080453.3198-1-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Jia-Ju Bai
> Sent: Friday, July 27, 2018 1:05 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-
> wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: Replace GFP_ATOMIC
> with GFP_KERNEL in igb_sw_init()
> 
> igb_sw_init() is never called in atomic context.
> It calls kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
