Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F199ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D7C21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D7C21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeIROV2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:21:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:59653 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeIROV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:21:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 01:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="71713987"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2018 01:49:35 -0700
Received: from lcsmsx152.ger.corp.intel.com (10.186.165.231) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 18 Sep 2018 01:49:35 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.242]) by
 LCSMSX152.ger.corp.intel.com ([10.186.165.231]) with mapi id 14.03.0319.002;
 Tue, 18 Sep 2018 11:49:33 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     zhong jiang <zhongjiang@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: remove redundant include moduleparam.h
Thread-Topic: [PATCH] misc: remove redundant include moduleparam.h
Thread-Index: AQHUTyxMiZuS8PDbUEO00Z6XmPtKsKT1un4g
Date:   Tue, 18 Sep 2018 08:49:32 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9B18CD@hasmsx108.ger.corp.intel.com>
References: <1537259682-44758-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537259682-44758-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDc3YjliYjktMWNmOS00ODljLWI1OTItNDg1YmM5NDdkOTgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZzlWWHk2UlIzcHlGaXk3QkNaSEtRT0VTQ3A3ZmpXZllzUDM1RWlKeGhxK05HcjRiRVwvNzBVYXBXWUJoZ3J3NUMifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> module.h already contains moduleparam.h,  so it is safe to remove the
> redundant include.
> 
> The issue is detected with the help of Coccinelle.
> 
> eePlease enter the commit message for your changes. Lines starting
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/mei/bus-fixup.c      | 1 -
>  drivers/misc/vmw_vmci/vmci_host.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c index
> a6f41f9..80215c3 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c

Ack.
Tomas

> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/module.h>
> -#include <linux/moduleparam.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c
> b/drivers/misc/vmw_vmci/vmci_host.c
> index 83e0c95..be732e5 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -15,7 +15,6 @@
> 
>  #include <linux/vmw_vmci_defs.h>
>  #include <linux/vmw_vmci_api.h>
> -#include <linux/moduleparam.h>
>  #include <linux/miscdevice.h>
>  #include <linux/interrupt.h>
>  #include <linux/highmem.h>
> --
> 1.7.12.4

