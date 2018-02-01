Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeBAWIe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:08:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:57896 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbeBAWIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:08:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="24237309"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "tpmdd-devel@lists.sourceforge.net"
        <tpmdd-devel@lists.sourceforge.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH 1/3] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTlElMx0TrUrXsWkqVKWv8E7WPWqODVukAgAcZy4CABbcioA==
Date: Thu, 1 Feb 2018 22:08:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94214CFE@hasmsx108.ger.corp.intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
 <20180123125426.t6xjgrqcfbkmvkdl@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94203771@hasmsx108.ger.corp.intel.com>
 <20180129084441.6oc4m4jgbqzsfq3v@linux.intel.com>
In-Reply-To: <20180129084441.6oc4m4jgbqzsfq3v@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmZlOWEzNzMtMTdjNi00OGIwLTkwZWQtNGMyNjUwOThjYzkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ4ZW92SFB6aXZkZXN5QjNnXC9BK1FrRG1uRTZYUW5IV21kelBLdjFkMTIrYzM1RGUzdmZRXC96eW5POG1pMDR0MksifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.16.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed, Jan 24, 2018 at 06:33:53PM +0000, Winkler, Tomas wrote:
> > > > -	pm_runtime_put(dev);
> > > > +	pm_runtime_put_sync(dev);
> > >
> > > Change to put_sync is needed so that the idle handshake gets
> completed?
> >
> > Right.
> 
> Since we seem to agree that your change to get rid of the use of PM runtime
> should that be actually the first change in the patch set?
> 
> Or are you looking forward to get these backported to stable kernels?

Yes, that was one of the reason behind for splitting this into two patches. 
So this first patch is the actual fix and second is the rather non user visible fix 
as runtime_pm should be enabled by default.  But .. maybe both need to be backported.

Thanks
Tomas
