Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeCJLVY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:21:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:41379 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeCJLVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:21:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="scan'208";a="37593919"
Message-ID: <d00187b102355c74b5efc2f7923c441785a6390c.camel@linux.intel.com>
Subject: Re: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 10 Mar 2018 13:21:16 +0200
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
         <20180306092503.11568-4-tomas.winkler@intel.com>
         <1520339005.3779.3.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 15:19 +0000, Winkler, Tomas wrote:
> > On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> > > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > > generation of crypto keys which can be a computationally intensive task.
> > > The timeout is set to 3min.
> > > Rather than increasing default timeout a new constant is added, to not
> > > stall for too long on regular commands failures.
> > > 
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > Why are you radically chaging the default timeout? The commit message
> > does not tell anything about that change.
> > 
> 
> Let me, recheck but it should be same value just converted to msecs.
>  
> > Why couldn't we just have two timeouts: one default and one long that
> > would be at least as long as the longest timeout defined in the spec?
> 
> I've tried to explain it in the commit message but apparently has failed. 
> 
> We have a default or undefined which should be the same as it was unless I did
> some silly mistake in conversion to msecs (will check), ass all others are in
> msecs.
> It was 2 min = 2 * 60 * HZ (in jiffies) which would be msecs_to_jiffies(2 * 60
> * 1000 = 120000) 
> TPM2_DURATION_DEFAULT   = 120000

Aah, of course :-) The problem was that I had somehow a blid spot with
seeing the msec_to_jiffies() conversion.

TPM_NUM_DURATIONS would a better name than TPM_DURATION_MAX because
TPM_DURATION_MAX is easy to confuse with TPM_DURATION_* constants.

/Jarkko
