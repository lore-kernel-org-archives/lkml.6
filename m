Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB7FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C3120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeK0Kbh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:31:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:32007 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbeK0Kbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:31:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 15:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="scan'208";a="89153388"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 26 Nov 2018 15:35:49 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.124]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.228]) with mapi id 14.03.0415.000;
 Mon, 26 Nov 2018 15:35:48 -0800
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
Thread-Topic: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
Thread-Index: AQHUha64oZemZKTHvEK6Vqrl0RX6bKVitgrw
Date:   Mon, 26 Nov 2018 23:35:49 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32ACF0@ORSMSX104.amr.corp.intel.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
In-Reply-To: <20181124205801.67828-1-jelsasser@appneta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzQzYzcwNzgtNzQxMy00NjAyLWFkMjEtMGUyMmI5YzVkYWFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYlg0S1wvcGxRWFl1a3FWMnlyNW52ZkVaVjdEeGxQSE94dGpnczV5bm1YVXlxYWdEaGtqZHNIREFxK1pTUE5vWk8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Josh Elsasser
> Sent: Saturday, November 24, 2018 12:58 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; David S. Miller <davem@davemloft.net>; Josh
> Elsasser <jelsasser@appneta.com>; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
> modules as 1Gbps
> 
> Add the two 1000BaseLX enum values to the X550's check for 1Gbps
> modules, allowing the core driver code to establish a link over this SFP type.
> 
> This is done by the out-of-tree driver but the fix wasn't in mainline.
> 
> Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


