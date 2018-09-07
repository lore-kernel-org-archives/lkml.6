Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BB1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3DB206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3DB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeIHCcy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:32:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:20829 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbeIHCZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 14:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="71248768"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2018 14:42:50 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 14:42:50 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.64]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 14:42:50 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wyborny, Carolyn" <carolyn.wyborny@intel.com>
Subject: RE: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Thread-Topic: [PATCH v3 1/2] net: ethernet: i40e: fix build error
Thread-Index: AQHURpzA7MyI4tgZj0GeYoDpgGVJFqTlWedA
Date:   Fri, 7 Sep 2018 21:42:49 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C7B944@ORSMSX115.amr.corp.intel.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-2-git-send-email-dongsheng.wang@hxt-semitech.com>
 <f2b0bdfcb53c461191e71603257874ac@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <f2b0bdfcb53c461191e71603257874ac@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTlmOWI1NmUtZTEzYi00NzJjLTkxZmEtNjhlMGIwMjc5NGNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjB1SHNhaXA0Z2NDTVZcL2cxejkwVGFmeTdhbzhSRlZ4R1B5cnZHXC9sNzFIc3B4MGIyNStuRmdMdzFOZ2E5ajJaIn0=
x-ctpclassification: CTP_NT
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



> -----Original Message-----
> From: Wang, Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
> Sent: Friday, September 07, 2018 5:41 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov@cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem@davemloft.net; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Subject: Re: [PATCH v3 1/2] net: ethernet: i40e: fix build error
> 
> Hello all,
> 
> The i40e_ethtool_stats.h is just included by i40e/i40e_ethtool.c. So the
> static doesn't make any affect. And Carolyn's team is working rebuild
> i40e and i40evf.
> 
> Cheers,
> Dongsheng

Dave wanted a fix sent to netdev by end of day today. I think the best immediate solution is to just migrate that code back into the i40e_ethtool.c and i40evf_ethtool.c files, rather than only the single function.

I'm going to send that patch to netdev now, since Jeff Kirsher is on vacation.

Thanks,
Jake
