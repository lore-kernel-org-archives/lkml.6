Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139BBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CF8218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfBATSg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:18:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:38514 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfBATSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:18:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 11:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="130442436"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2019 11:18:35 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.158]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.210]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 11:18:35 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Borislav Petkov <bp@suse.de>
CC:     Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Thread-Topic: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Thread-Index: AQHUuCejcDpsRrChaU6VvVuhWFd9jqXIjHsAgAAJQICAACvQgIACk0mw
Date:   Fri, 1 Feb 2019 19:18:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D4E216D@ORSMSX110.amr.corp.intel.com>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic> <20190130164626.GA17841@cmpxchg.org>
 <20190130171933.GC21221@zn.tnic> <20190130195621.GA30653@cmpxchg.org>
In-Reply-To: <20190130195621.GA30653@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZhMzM4MGYtZjE2Yy00MDljLTgxM2YtNjU3NmU0ZjhiY2MxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkRFeHg3UHNQWWVcL093OWxDVDE0RDFMcEJ2VDV5TThnZ014ZG9wQVpEVUtKdjVxaUxzdGFFSmd6aWVcL2FEUmQyIn0=
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

>> What about
>> 
>> s/X86_RESCTRL/X86_CPU_RESCTRL/g
>
> Good idea.
>
> Tony, Babu, that look okay to you guys as well?

For now.  But very soon we will also have ARM_CPU_RESCTRL, and some of
this code will become generic.  Will we need an arch-independent name for the
bits of code shared by arm and x86?  

-Tony
