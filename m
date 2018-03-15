Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeCOXYa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:24:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:28910 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:24:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="208653454"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
Thread-Topic: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
Thread-Index: AQHTvHtt2cKWQ/d7s0yRrtebaVoIRqPR77vw
Date: Thu, 15 Mar 2018 23:24:23 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DCA@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-4-tomas.winkler@intel.com>
 <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
In-Reply-To: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGU0OTk0ZmYtMDNkMi00ZDNmLTk4YzQtZjkxODczNDM2NGE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrZnJzUURTTVhqNXlKZ0V0NFllS01MMEVGRngyTnpaWEl6K0xZd3FPY1dNZ2xHdk40SFA3Uks4U1RYemhwRnd5In0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.20.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FNOd3e032381

> 
> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> > +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> > +			      recd) {
> > +			total = -EFAULT;
> > +			break;
> > +		}
> > +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data,
> recd);
> 
> This rlength stuff can be handled with tpm_buf_length() as I do in my
> pendig-for-review patch set:
> 
> https://patchwork.kernel.org/patch/10259331/

Right, as I wrote before not sure it's good to move and change the code more than necessary at the same time. 
I would leave the tpm_buf_ changes after this series. 

Thanks
Tomas
