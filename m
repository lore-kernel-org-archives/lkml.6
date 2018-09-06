Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537C7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD852075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD852075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeIFVxO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:53:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:40156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeIFVxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:53:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 10:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="68077034"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2018 10:16:26 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 10:16:25 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.72]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 10:16:25 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH v2 1/2] net: ethernet: i40e: fix build error
Thread-Index: AQHURMAOHuyMEikkN06R2JwEV2/dyqTjf3nw
Date:   Thu, 6 Sep 2018 17:16:24 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGJhMTJkNWQtMjY4ZC00ZWY1LWEwMDMtNzhjNTUxNDI2NGY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYkJzN2x6b1ZPWjVhUFwvOFZVSDFiNEhpSjNnQVdMVHJpajdyaW1DdEpTNGRNbXgwZmZZUGdRUUhzK1wvUFNCdW1cLyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wang, Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
> Sent: Wednesday, September 05, 2018 8:36 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; sergei.shtylyov@cogentembedded.com
> Cc: davem@davemloft.net; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] net: ethernet: i40e: fix build error
> 
> Yes,  but not only i40e. igb/vf, ixgb/vf also share same code. If we change any of
> them, means we need to broken the whole layout of driver/net/ethernet/intel/ .
> Obviously we can't put header files to $src/include/net. ：|
> 
> Cheers,
> Dongsheng
> 
> 

I'm more worried about how it interacts with modules. For example, we could have i40e and i40evf share some code, but then wouldn't one of them become dependent on the other? i.e. you'd have to load i40e in order to successfully load i40evf? Or you'd have to have some sort of common glue module which you load first, and then load i40e and i40evf after? This also creates some interactions with out-of-tree modules which make it difficult. It would be nice if we could share the code in some way that still resulted in allowing each module to be separate...

And yes, I igb/vf and ixgbe/vf and i40e/vf all share some code though i40e is the most shared, comparatively. It's not an easy undertaking, which is why it's not been done before. For fm10k, the same driver handles both the PF and VF, but I know that users weren't happy about having the driver change a lot when fixing/changing the PF, and thus thinking they might need to update their VF too much.

Thanks,
Jake
