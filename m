Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeCPOCs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:02:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:1687 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPOCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:02:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="212184887"
Date: Fri, 16 Mar 2018 16:02:40 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
Message-ID: <20180316140240.GA9616@linux.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
 <20180310082428.31519-4-tomas.winkler@intel.com>
 <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94237DCA@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94237DCA@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:24:23PM +0000, Winkler, Tomas wrote:
> > 
> > On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > > +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> > > +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> > > +			      recd) {
> > > +			total = -EFAULT;
> > > +			break;
> > > +		}
> > > +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data,
> > recd);
> > 
> > This rlength stuff can be handled with tpm_buf_length() as I do in my
> > pendig-for-review patch set:
> > 
> > https://patchwork.kernel.org/patch/10259331/
> 
> Right, as I wrote before not sure it's good to move and change the code more than necessary at the same time. 
> I would leave the tpm_buf_ changes after this series. 

Right, this is a valid point. I'll ack this as it is. Thanks for
pointing this out.

/Jarkko
