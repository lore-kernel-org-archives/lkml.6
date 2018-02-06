Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeBFUDC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:03:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:1866 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeBFUDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:03:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,470,1511856000";
   d="scan'208";a="16355919"
Date: Tue, 6 Feb 2018 22:02:55 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180206200255.ib7hblberqj6anh5@linux.intel.com>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
 <20180128075101.6883-2-tomas.winkler@intel.com>
 <20180128201559.GG23869@ziepe.ca>
 <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9420DD08@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 09:17:53PM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:
> > 
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index
> > > bcdd3790e94d..06639fb6ab85 100644
> > > +++ b/include/linux/tpm.h
> > > @@ -44,7 +44,7 @@ struct tpm_class_ops {
> > >  	bool (*update_timeouts)(struct tpm_chip *chip,
> > >  				unsigned long *timeout_cap);
> > >  	int (*request_locality)(struct tpm_chip *chip, int loc);
> > > -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > > +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);
> > 
> > This seems wrong.. What is the core code supposed to do if relinquish fails?
> 
> Not much just propage the error to the caller and leave the policy
> decision to it.

Your patch set must either cover this or keep it as void.

A better idea is to print an error to klog.

/Jarkko
