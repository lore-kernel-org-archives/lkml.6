Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeCESFD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:05:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:14591 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeCESFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:05:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="21977846"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Topic: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Index: AQHTs7KEInSI42HCTUSCFlGLoOJ8nqPBeeQAgAAiLaCAADJYAIAAIjDw
Date: Mon, 5 Mar 2018 18:04:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E568@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180305125642.GA3425@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
 <20180305175912.GD5791@linux.intel.com>
In-Reply-To: <20180305175912.GD5791@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWViOTI1MGUtODQ3Yi00ZjNjLThmNmYtMjc0M2Y2NTRhMWIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ0S2ZHa3Jxd09OY2hoOEhKbWNPTERhaDJPa0hJd3Z6TlZ1eERLbUd1RjJ4SFdTNG5jYXo1eG5XUEhuclwveTRVZyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.226]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > enum tpm_duration {
> > > 	TPM_DURATION_DEFAULT = 2000,
> > > 	TPM_DURATION_LONG = 300000,
> > > };
> > >
> > How is this aligned with the spec PTP spec?
> 
> For TPM 2.0 that spec only partially defines durations for CCs and thus our
> look up table is already kind "flakky". In a sense that the default duration is
> upper limit for spec defined durations.

The timeouts for LONG and MEDIUM is defined by the  PTP spec,  we need to maintain those as those effect the system.
The UNDEFINED and LONG LONG is the implementation choice we driver from empirical data we have so far.

> 
> > > These would be both for TPM 1.2 and TPM 2.0. Instead of having table
> > > for every ordinal there should be a small tables describing commands
> > > that require long timeout.
> >
> > Yeah I didn't cover the 1.2.
> 
> I could probably help with TPM 1.2 changes if required.

In middle of it, will send for review in few.

Thanks
Tomas
