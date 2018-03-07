Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbeCGPlo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:41:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:31051 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933386AbeCGPlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:41:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="23694058"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Topic: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Index: AQHTs7KEInSI42HCTUSCFlGLoOJ8nqPBeeQAgAAiLaCAARpWAIAAJchggABsQYCAACLBAIAAOJEAgAEjn4CAACaZwA==
Date: Wed, 7 Mar 2018 15:41:35 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9423012A@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
         <1520353933.5393.21.camel@HansenPartnership.com>
         <1520361396.10396.396.camel@linux.vnet.ibm.com>
         <20180306215904.GA32097@ziepe.ca>
 <1520436169.10396.516.camel@linux.vnet.ibm.com>
In-Reply-To: <1520436169.10396.516.camel@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGQ3MzA5NDQtMThjMC00NmNjLTg4YjQtZGYwNTE0ZTk0MDk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJBc29BVDJMaUkrdmJKY1BrRzBJMFQyRzlySGs0UkFoMXY0SER1K3FrMEdTdnc4ZEREbVhCN3RiYUcyNEt0Y3poIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.107]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27FfpXQ032071


> 
> On Tue, 2018-03-06 at 14:59 -0700, Jason Gunthorpe wrote:
> > On Tue, Mar 06, 2018 at 01:36:36PM -0500, Mimi Zohar wrote:
> > > On Tue, 2018-03-06 at 08:32 -0800, James Bottomley wrote:
> > > > On Tue, 2018-03-06 at 08:06 +0000, Winkler, Tomas wrote:
> > > > > >
> > > > > >
> > > > > > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > > > > >
> > > > > > > Why you need cover letter?  What are u missing in the patch
> > > > > > > description
> > > > > >
> > > > > > If you submit a *patch set* I *require* a cover letter, yes.
> > > > >
> > > > > It's good but it is not must, you are inventing your own rules.
> > > >
> > > > As long as the Maintainer is the gatekeeper, you're not going to
> > > > get very far with this argument.  The fact is that a lot of
> > > > subsystems have varying rules; often undocumented, some of which
> > > > are even in conflict, like alphabetic vs reverse christmas tree format for
> includes.
> > > >
> > > > A cover letter is actually one of the more uniform rules.  It's
> > > > referred to in submitting patches, but not actually documented there.
> > >
> > > I've heard that some maintainers are moving away from cover letters,
> > > since they are not include in the git repo and are lost.  I've seen
> > > Andrew Morton cut and paste the cover letter in the first patch
> > > description of the patch set.
> >
> > Andrew has a workflow unlike any other I've seen..
> 
> Andrew is the only one that actually cut and pasted the cover letter in the
> first patch description, but I've heard this from others.
> 
> > In my view the cover letter should explain why the maintainer should
> > apply the series, and give any guidance to the review process.
> 
> > Not duplicate information that belongs in the patch comments. It
> > shouldn't explain how/why the patch(es) works, etc.
> 
> Patch descriptions should never explain how/why a particular patch
> works.  If it is that difficult to understand, then something is wrong with the
> patch.  The individual patch descriptions should provide the current status,
> the motivation for the change, and short summary of the change (eg. new
> features, configs, etc).
> 
> The cover letter is needed for (larger) patch sets in order to explain the
> overall motivation, instead of having to guess where the patch set is going.  I
> wouldn't expect to see a cover letter for a single bug fix or two.
> 
> Mimi

I second that.

Tomas.
