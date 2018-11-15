Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490A721582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490A721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKOKWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:22:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:56410 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOKWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:22:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 16:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="106335751"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2018 16:17:18 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 14 Nov 2018 16:17:18 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.195]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.106]) with mapi id 14.03.0415.000;
 Wed, 14 Nov 2018 16:17:17 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Joe Perches <joe@perches.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] igb: Fix format with line continuation whitespace
Thread-Topic: [PATCH] igb: Fix format with line continuation whitespace
Thread-Index: AQHUcbEQB5kVrKYYhkaLebhSooKXo6VQDZzw
Date:   Thu, 15 Nov 2018 00:17:17 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965C10B5@ORSMSX101.amr.corp.intel.com>
References: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
In-Reply-To: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTliOTFiNDktMWZhMS00MjY2LTljOGUtYTUzZWY0YzhlNWRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYmFHbXN4eEp6QTY5Um5NSUMzbkxXb1lHSU1CSVJlelBPZGc3QlJ0Zk9paUx0ZDNzNHQwZ1VIUGppekZTTFFlbyJ9
x-ctpclassification: CTP_NT
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

> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Joe Perches
> Sent: Thursday, November 1, 2018 12:04 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: David S. Miller <davem@davemloft.net>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] igb: Fix format with line continuation whitespace
> 
> The line continuation unintentionally adds whitespace so
> instead use a coalesced format to remove the whitespace.
> 
> Miscellanea:
> 
> o Use a more typical style for ternaries and arguments
>   for this logging message
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
