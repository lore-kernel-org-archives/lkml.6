Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FA82075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FA82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIECks convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:40:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:29214 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbeIECks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:40:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="87642938"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2018 15:13:35 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.58]) by
 PGSMSX107.gar.corp.intel.com ([169.254.7.2]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 06:13:34 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "suresh.b.siddha@intel.com" <suresh.b.siddha@intel.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: RE: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Topic: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing
 enclaves
Thread-Index: AQHUPjfc29Kn4Rp1DkeLR/DtZ2Q8VaTTmtMAgACchICAAhw1QIAC8vSAgABkDoCABMj0AIAAzxpQgAB5ToCAAAnrgIAAEkcAgADj9JA=
Date:   Tue, 4 Sep 2018 22:13:34 +0000
Message-ID: <105F7BF4D0229846AF094488D65A09893541AF39@PGSMSX112.gar.corp.intel.com>
References: <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
 <1535406078.3416.9.camel@intel.com> <20180828070129.GA5301@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541037C@PGSMSX112.gar.corp.intel.com>
 <20180831121645.GA18075@linux.intel.com>
 <20180831181509.GB21555@linux.intel.com>
 <20180903191926.GC13497@linux.intel.com>
 <105F7BF4D0229846AF094488D65A09893541970F@PGSMSX112.gar.corp.intel.com>
 <20180904145451.GA5233@linux.intel.com>
 <20180904153021.GB8344@linux.intel.com>
 <20180904163546.GA5421@linux.intel.com>
In-Reply-To: <20180904163546.GA5421@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWQwN2RhYWQtNDg0Mi00ZjZmLWE3OTYtYzE5OGMwN2FlOTAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVQxNmdQaWR2THNJS0VRdlFsb0QycVN1TkFrUlhqamFcL1wvb2Y5cDk5blpVdnZWcDJTeE82WmFMUW1wMkl0dk5mIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> owner@vger.kernel.org] On Behalf Of Sean Christopherson
> Sent: Wednesday, September 5, 2018 4:36 AM
> To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Huang, Kai <kai.huang@intel.com>; platform-driver-x86@vger.kernel.org;
> x86@kernel.org; nhorman@redhat.com; linux-kernel@vger.kernel.org;
> tglx@linutronix.de; suresh.b.siddha@intel.com; Ayoun, Serge
> <serge.ayoun@intel.com>; hpa@zytor.com; npmccallum@redhat.com;
> mingo@redhat.com; linux-sgx@vger.kernel.org; Hansen, Dave
> <dave.hansen@intel.com>
> Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
> 
> On Tue, Sep 04, 2018 at 06:30:21PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 04, 2018 at 07:54:51AM -0700, Sean Christopherson wrote:
> > > I don't see any value in trying to rule out specific causes of
> > > INVALID_TOKEN, but we should only retry EINIT if ret==INVALID_TOKEN
> > > and RDMSR(HASH0) != sgx_lepubkeyhash[0].  Only the first MSR needs
> > > to be checked for validity as they're a package deal, i.e. they'll
> > > all be valid or all be reset.  There shouldn't be a limit on retry
> > > attempts, e.g. the MSRs could theoretically be reset between WRMSR and
> EINIT.
> >
> > Why is doing rdmsrs necessary? With the INVALID_TOKEN error we know we
> > are out-of-sync i.e. have been sleeping and then one just needs to do
> > wrmsrs.
> 
> As Kai mentioned, INVALID_TOKEN is returned for other reasons, e.g. a
> production enclave trying to use a debug token or reserved bits set in the token.
> And in the KVM case, the hash and token are provided by the guest, so it's
> entirely possible the enclave/token is not signed with the key specified in the
> hash.  RDMSR is relatively inexpensive compared to the overall cost of EINIT.
> Though of course EINIT failure isn't exactly a fast path, so I'm ok if you want to
> opt for simplicity and retry on INVALID_TOKEN without checking the MSRs, just
> make sure to add a comment indicating we're intentionally not checking the
> MSRs.
> 
> > I think one retry should be enough given that VMM traps EINIT. One
> > retry is needed to take care of the guest itself (or host if we are
> > running on bare metal) having been in a sleep state.
> 
> Assuming we do RDMSR(hash0), that should be sufficient to prevent infinite retry
> and 

IMHO probably we need to review this assumption w/ crypto guys, at least Intel internally.

Thanks,
-Kai

it protects against the MSRs being lost between WRMSR and EINIT during
> retry.  That being said, I'm ok retrying only once, especially if you want to omit
> the RDMSR.  Disabling preemption should prevent the kernel from suspending
> between WRMSR and EINIT, I'm just being paranoid.


