Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2011FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C283A2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C283A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbeIGUMK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:12:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:48726 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbeIGUMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:12:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 08:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="88057773"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2018 08:30:44 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:30:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.225]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 08:30:43 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "Bowers, AndrewX" <andrewx.bowers@intel.com>
Subject: RE: linux-next: build failure after merge of the net-next tree
Thread-Topic: linux-next: build failure after merge of the net-next tree
Thread-Index: AQHUQxdRgVQMKTBaEkyNaCDZFitIB6TkcHKAgACIk2A=
Date:   Fri, 7 Sep 2018 15:30:42 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C7B651@ORSMSX115.amr.corp.intel.com>
References: <20180903094702.3e32d8f5@canb.auug.org.au>
 <20180907102055.001777b8@canb.auug.org.au>
In-Reply-To: <20180907102055.001777b8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzdjNmFhZTgtOGQxNi00MDM2LWIzMzAtNzhjMjU4MDdhMGRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiY2hiclRRcVdwMnR6eEhjVUNndmd5TXdqMDhvb0hwY1wvWng5TTAwOE9QWVRCbGQ4MFlXdjZvYzdzakYzXC9YRkprIn0=
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
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Stephen Rothwell
> Sent: Thursday, September 06, 2018 5:21 PM
> To: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing
> List <linux-kernel@vger.kernel.org>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Bowers, AndrewX
> <andrewx.bowers@intel.com>
> Subject: Re: linux-next: build failure after merge of the net-next tree
> 
> Hi all,
> 
> On Mon, 3 Sep 2018 09:47:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >
> > After merging the net-next tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > In file included from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:
> > drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
> '__i40e_add_stat_strings':
> > drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function
> '__i40e_add_stat_strings' can never be inlined because it uses variable argument
> lists
> >  static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats
> stats[],
> >                     ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   8fd75c58a09a ("i40e: move ethtool stats boiler plate code to
> i40e_ethtool_stats.h")
> >
> > It is not clear this patch has any value anyway as the moved functions
> > are only used in the file they were moved from.
> >
> > I reverted that commit for today.
> >
> > The same problem would exist in drivers/net/ethernet/intel/i40evf (where
> > a lot of code is duplicated from drivers/net/ethernet/intel/i40e) except
> > that this function is not declared inline there.
> > Luckily, i40e_ethtool_stats.h is only included my one file
> > drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c, otherwise there
> > would be multiple copies of __i40e_add_stat_strings().
> >
> > Surely there is some scope for factoring out some common code between
> > these two drivers?
> 
> Ping?
> 
> --
> Cheers,
> Stephen Rothwell

There's some discussion about this going on in the intel-wired-lan mailing list.

Thanks,
Jake
