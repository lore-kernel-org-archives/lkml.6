Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B470C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F238B2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F238B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLAONA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:13:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:45218 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLAONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:13:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 19:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="279585298"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 19:01:33 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 30 Nov 2018 19:01:33 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.195]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.125]) with mapi id 14.03.0415.000;
 Fri, 30 Nov 2018 19:01:32 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
 'PTR_ERR' warning in e100_load_ucode_wait
Thread-Topic: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
 'PTR_ERR' warning in e100_load_ucode_wait
Thread-Index: AQHUgAY7/1emlZVOn0O6g8b+qGpdU6VpRCFg
Date:   Sat, 1 Dec 2018 03:01:31 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965CB705@ORSMSX101.amr.corp.intel.com>
References: <20181119124819.15860-1-yuehaibing@huawei.com>
In-Reply-To: <20181119124819.15860-1-yuehaibing@huawei.com>
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

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of YueHaibing
> Sent: Monday, November 19, 2018 4:48 AM
> To: davem@davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
> 'PTR_ERR' warning in e100_load_ucode_wait
> 
> Fix a static code checker warning:
> drivers/net/ethernet/intel/e100.c:1349
>  e100_load_ucode_wait() warn: passing zero to 'PTR_ERR'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
