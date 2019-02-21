Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BEBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47520838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBUW5v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:57:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:17383 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBUW5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:57:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 14:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="124264095"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2019 14:57:50 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Feb 2019 14:57:50 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.35]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.233]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 14:57:49 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     "Xu, Tao3" <tao3.xu@intel.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Ingo Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
Thread-Topic: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait
 instructions
Thread-Index: AQHUreHh7DA2XBxC0kqOjmFVuVmk4qXqiiqAgABQLQCAADkjMA==
Date:   Thu, 21 Feb 2019 22:57:49 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D877F3A@ORSMSX106.amr.corp.intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
 <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
 <20190221192424.GA158428@romley-ivt3.sc.intel.com>
In-Reply-To: <20190221192424.GA158428@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
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

> From: Fenghua Yu [mailto:fenghua.yu@intel.com]
> On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
> Or to simplify the situation, how about we still use zero as global max wait
> time (i.e. no limitation for global wait time) as implemented in this patch
> set? User can still change the value to any value based on their usage. Isn't
> this a right way to take care of any usage?

Plus, if scheduler timers works, umwait will be forced time out by timer in HZ anyway.

Only for case without scheduler timer, sysadmin may need to set a small max umwait time to force timout. But in this case (real time), I doubt user app really wants to call umwait to save power with long latency of waking up from umwait. So likely in this case, user app won't call umwait and there is no usage to set a small value for max umwait time. 

Thanks.

-Fenghua
