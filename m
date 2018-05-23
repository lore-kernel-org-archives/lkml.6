Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933021AbeEWNQW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:16:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:27584 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932932AbeEWNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:16:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="61043788"
Date: Wed, 23 May 2018 16:16:16 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180523131616.GD363@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > 
> > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > > New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> > > streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is
> > abused
> > > to resolve tpm spaces recursive calls to tpm_transmit().
> > 
> > This looks good and all but I don't think we want to abuse anything in the
> > driver code, do we?
> 
> It's not abuse just the flag UNLOCKED is not really named correctly 
> I think this has to be backported so wanted to do less invasive change.

It should be renamed anyway and possible merge conflicts are not hard to
sort out in this change. Can you rename it as SPACE?

Right, and even without rename this will probably cause merge conflicts
at least in v4.4 an v4.9 since in-kernel RM landed in v4.12, so not much
gain not do the rename :-)

/Jarkko
