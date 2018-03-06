Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeCFODE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:03:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:40535 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753664AbeCFODD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:03:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22195582"
Date: Tue, 6 Mar 2018 16:02:56 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
Message-ID: <20180306140256.GC5700@linux.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
 <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 01:39:49PM +0100, Javier Martinez Canillas wrote:
> On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> > On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> >> This series cleans up tpm timeouts setting and handling.
> >>
> >> First motivation was to fix failures coming from too short timeouts
> >> for commands that creates keys.
> >> Key generation may take significant time depending on the underlying
> >> hardware. Rather than increasing default timeout a new constant is
> >> added, to not stall too long on regular commands failures.
> >>
> >> Second is to define timeouts for new tpm2 commands
> >> defined in TCG 1.36 spec.
> >
> 
> Probably a typo, since the latest TCG spec version is the 1.38 [0].
>  
> > Where can we get that specification? I don't have that new
> > version and couldn't find it from the public internet.
> > 
> > /Jarkko
> > 
> 
> [0]: https://trustedcomputinggroup.org/tpm-library-specification/

I already have that version of the specifications but I thought that we
were speaking about PC Client Platform spefication, which is at version
1.30. TCG spec is an ambiguous term so that is where the confusion
started from.

The only spec I've seen some timeouts is the PC Client Specification but
I guess I've then missed the list in TPM 2.0 spefication. Where are they
listed? I worked with Will Arthur durations based on PC Client Specification
when TPM 2.0 support was first implemented.

/Jarkko
