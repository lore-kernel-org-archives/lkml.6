Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE632089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE632089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeH2Lby convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:31:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:50902 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH2Lbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:31:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 00:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="68695142"
Received: from pgsmsx104.gar.corp.intel.com ([10.221.44.91])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 00:36:14 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.58]) by
 PGSMSX104.gar.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0319.002;
 Wed, 29 Aug 2018 15:36:14 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Kai Huang <kai.huang@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
 features
Thread-Topic: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
 features
Thread-Index: AQHUPjeYRx2wMmEsxEKLT9SJazBQeaTUSTXA///ylICAAh0zAA==
Date:   Wed, 29 Aug 2018 07:36:13 +0000
Message-ID: <105F7BF4D0229846AF094488D65A0989354103A9@PGSMSX112.gar.corp.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-3-jarkko.sakkinen@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893540B623@PGSMSX112.gar.corp.intel.com>
 <20180828071723.GA15508@linux.intel.com>
In-Reply-To: <20180828071723.GA15508@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmIyZmJlZGQtNGEwYy00M2RiLWI4ZDItYTgyMDQ2ZmZmNTY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiandnZThmUENNaEhXVCtKMEpveGFFUWtzV1wvVUg0WGdzR3pBUGt4dGJpYWFDQkoxaVdpckVaSCtlSXIwSWxPY3kifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> Sent: Tuesday, August 28, 2018 7:17 PM
> To: Huang, Kai <kai.huang@intel.com>
> Cc: x86@kernel.org; platform-driver-x86@vger.kernel.org; Hansen, Dave
> <dave.hansen@intel.com>; Christopherson, Sean J
> <sean.j.christopherson@intel.com>; nhorman@redhat.com;
> npmccallum@redhat.com; linux-sgx@vger.kernel.org; Kai Huang
> <kai.huang@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Borislav
> Petkov <bp@suse.de>; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>;
> David Woodhouse <dwmw@amazon.co.uk>; open list:X86 ARCHITECTURE (32-
> BIT AND 64-BIT) <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
> features
> 
> On Tue, Aug 28, 2018 at 12:07:41AM +0000, Huang, Kai wrote:
> > > +#define X86_FEATURE_SGX_LC		(16*32+30) /* supports SGX
> launch
> > > configuration */
> >
> > Sorry if it was me who wrote the comment "SGX launch configuration". I
> > think we should just use "SGX launch control". :)
> 
> Not sure if we should change though. The former is more self-explaining, the
> latter is "more official".

I'll let you decide.  To me the comment should explain what does "LC" mean, and to me it means "launch control". :)

Thanks,
-Kai
> 
> /Jarkko
