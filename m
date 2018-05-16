Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeEPSRD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:17:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37099 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEPSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:17:00 -0400
X-Google-Smtp-Source: AB8JxZr+C4M03WKdd5Ngfg5z/GXNwTAsAd6KVXlslL47lgHHeIAaQ9FJ1C7OtTX1Zc0RNXoLQU05hA==
Date: Wed, 16 May 2018 12:16:55 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hal Rosenstock <hal@dev.mellanox.co.il>
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
Message-ID: <20180516181655.GH25661@ziepe.ca>
References: <20180514210200.GN21531@ziepe.ca>
 <ab0e1318-8e1a-5822-5484-33e460095830@dev.mellanox.co.il>
 <E41BCEAA-0204-448D-8188-ACA03932B3AC@oracle.com>
 <20180515190424.GL5615@ziepe.ca>
 <3E15B62F-E705-43BD-8A72-9E74F784D40E@oracle.com>
 <20180516151201.GA25661@ziepe.ca>
 <695ae613-931a-50ba-2b83-9d172e0ac2bc@dev.mellanox.co.il>
 <151B2A36-28F0-4A88-8633-31AE7E55F848@oracle.com>
 <20180516180115.GF25661@ziepe.ca>
 <FDEBA43A-C98F-4E2B-A8F3-CA809FBAD479@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FDEBA43A-C98F-4E2B-A8F3-CA809FBAD479@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:14:50PM +0200, Håkon Bugge wrote:
> 
> 
> > On 16 May 2018, at 20:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Wed, May 16, 2018 at 07:46:10PM +0200, Håkon Bugge wrote:
> > 
> >>   OK. Lets take one example. The pkey table contains 0xFFFF, 0x8001,
> >>   0x0001.
> >> 
> >>   The wce.pkey_index is 1 (i.e., pointing to 0x8001). Now, tell me, was
> >>   BTH.PKey 0x8001 (matches 0x8001) or was it 0x0001 (also matching
> >>   0x8001) ?
> > 
> > As far as the Linux core is concerned, it must have been 0x8001,
> > because the only way the pkey_index feature works properly is if
> > exact-match takes precedence over in-exact match.
> 
> And now if the table only contains 0xFFFF, 0x8001, how do you tell?

It doesn't matter.

The delgation of Pkeys to VMs are on a pkey-table-index basis, so if
it matches table entry 1 and entry 1 is passed to the VM, then the
packet can be passed to the VM.

Jason
