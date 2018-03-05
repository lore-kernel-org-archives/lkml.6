Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeCESH0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:07:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:37805 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbeCESHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:07:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="25357104"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH v7] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTtHaK+hxvgn33PUSUS7a38q1gsqPByrmAgAAEDACAACHVQA==
Date: Mon, 5 Mar 2018 18:07:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E57E@hasmsx108.ger.corp.intel.com>
References: <20180305113449.8876-1-tomas.winkler@intel.com>
 <20180305175128.GB5791@linux.intel.com>
 <20180305180558.GA6220@linux.intel.com>
In-Reply-To: <20180305180558.GA6220@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjhhYjYzYTItMDlmOS00OGQxLWFhNzItZDg0ZGQxODM1ZWE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJNTzhKYVpQaFp2M3NVZW5BUnlxTHVlNXpBUjREeTZuZ04xbTFWMzlGTDBMdkFNT2tPXC84WXJ5QmlTUFdoRFphTSJ9
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
> On Mon, Mar 05, 2018 at 07:51:28PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 05, 2018 at 01:34:49PM +0200, Tomas Winkler wrote:
> > > The correct sequence is to first request locality and only after
> > > that perform cmd_ready handshake, otherwise the hardware will drop
> > > the subsequent message as from the device point of view the
> > > cmd_ready handshake wasn't performed. Symmetrically locality has to
> > > be relinquished only after going idle handshake has completed, this
> > > requires that go_idle has to poll for the completion and as well
> > > locality relinquish has to poll for completion so it is not
> > > overridden in back to back commands flow.
> > >
> > > Two wrapper functions are added (request_locality
> > > relinquish_locality) to simplify the error handling.
> > >
> > > The issue is only visible on devices that support multiple localities.
> > >
> > > Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> >
> > Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
> 
> This commit has been applied.

Appreciated.
Tomas
