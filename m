Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeCFPFx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:05:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:57858 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753291AbeCFPFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:05:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="35910834"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5 V2] tpm: timeouts revamp
Thread-Topic: [PATCH 0/5 V2] tpm: timeouts revamp
Thread-Index: AQHTtUUWa2w7XNJLoU6dUA5o8zEWQKPDBFyAgAAXOQCAADJ/MA==
Date: Tue, 6 Mar 2018 15:05:44 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F491@hasmsx108.ger.corp.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
 <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
 <20180306140256.GC5700@linux.intel.com>
In-Reply-To: <20180306140256.GC5700@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTgzZDY4MDEtMDM3MC00NjhmLTgxNDktMjQwYjc5MDU0MTc3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJyT2RJdTZlODdIYkNuT1FOWTd1bDRKWHpmK1E0a1FwRm9NMmNCMlh6eEZKb0psdHZJUHpTR28zOXptRUozOW9EIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.24.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> On Tue, Mar 06, 2018 at 01:39:49PM +0100, Javier Martinez Canillas wrote:
> > On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> > > On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> > >> This series cleans up tpm timeouts setting and handling.
> > >>
> > >> First motivation was to fix failures coming from too short timeouts
> > >> for commands that creates keys.
> > >> Key generation may take significant time depending on the
> > >> underlying hardware. Rather than increasing default timeout a new
> > >> constant is added, to not stall too long on regular commands failures.
> > >>
> > >> Second is to define timeouts for new tpm2 commands defined in TCG
> > >> 1.36 spec.
> > >
> >
> > Probably a typo, since the latest TCG spec version is the 1.38 [0].
> >
> > > Where can we get that specification? I don't have that new version
> > > and couldn't find it from the public internet.
> > >
> > > /Jarkko
> > >
> >
> > [0]: https://trustedcomputinggroup.org/tpm-library-specification/
> 
> I already have that version of the specifications but I thought that we were
> speaking about PC Client Platform spefication, which is at version 1.30. TCG
> spec is an ambiguous term so that is where the confusion started from.
> 
TCG spec doesn't define timeouts just new commands 

> The only spec I've seen some timeouts is the PC Client Specification but I
> guess I've then missed the list in TPM 2.0 spefication. Where are they listed?
> I worked with Will Arthur durations based on PC Client Specification when
> TPM 2.0 support was first implemented.


That's correct, this  PTP spec. It defines the timeouts for the commands, this is stated in the patch comments.

Need to cross reference these two specs. 

Thanks
Tomas
