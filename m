Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeBFV0W convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:26:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:7036 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753043AbeBFV0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:26:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,470,1511856000";
   d="scan'208";a="15782957"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTmHTVmx/EguNS8EGzZkDVTfYkOKOJwfqwgA32iYCAAC9fsA==
Date: Tue, 6 Feb 2018 21:26:15 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9421889F@hasmsx108.ger.corp.intel.com>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
 <20180128075101.6883-2-tomas.winkler@intel.com>
 <20180128201559.GG23869@ziepe.ca>
 <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
 <20180206200255.ib7hblberqj6anh5@linux.intel.com>
In-Reply-To: <20180206200255.ib7hblberqj6anh5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmMyYjFhZjgtMmFjZC00MmNjLTliZWYtMzY2ZGU3M2U1ZDlhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJYUjVMMU1EZXRTOHE5TkdhRHk2a3k0ZTR4M2x1NXdFMEU5TTg1TGVlTWVSSjRseFNER1ZPc3V2VkV3SmkrN0NBIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.249.81.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, Jan 28, 2018 at 09:17:53PM +0000, Winkler, Tomas wrote:
> >
> > >
> > > On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:
> > >
> > > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index
> > > > bcdd3790e94d..06639fb6ab85 100644
> > > > +++ b/include/linux/tpm.h
> > > > @@ -44,7 +44,7 @@ struct tpm_class_ops {
> > > >  	bool (*update_timeouts)(struct tpm_chip *chip,
> > > >  				unsigned long *timeout_cap);
> > > >  	int (*request_locality)(struct tpm_chip *chip, int loc);
> > > > -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > > > +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > >
> > > This seems wrong.. What is the core code supposed to do if relinquish
> fails?
> >
> > Not much just propage the error to the caller and leave the policy
> > decision to it.
> 
> Your patch set must either cover this or keep it as void.


How the code is covering other failures in the transmit functions,  
how is this one different from for example request_locality failure?
Why we should not propage this error up?

> 
> A better idea is to print an error to klog.
We can do that in addition.


Thanks
Tomas
