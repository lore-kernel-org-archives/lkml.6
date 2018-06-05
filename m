Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeFETgD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:36:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:29706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeFETgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:36:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="45502530"
Date: Tue, 5 Jun 2018 22:35:57 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Message-ID: <20180605193557.GA27994@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
 <20180518223032.ihszdef5wesj5nie@cantor>
 <20180523125655.GB363@linux.intel.com>
 <20180527091452.azwuh5u7rjyy7z6h@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527091452.azwuh5u7rjyy7z6h@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 02:14:52AM -0700, Jerry Snitselaar wrote:
> On Wed May 23 18, Jarkko Sakkinen wrote:
> > On Fri, May 18, 2018 at 03:30:32PM -0700, Jerry Snitselaar wrote:
> > > On Mon Mar 26 18, Jarkko Sakkinen wrote:
> > > > In order to make struct tpm_buf the first class object for constructing TPM
> > > > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> > > > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> > > > prints an error message.
> > > >
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Thanky you Jerry. I'll do one more round for this only to update kdoc.
> > It does not involve code changes so are you OK if you I keep your
> > reviewed-by despite this update?
> > 
> > /Jarkko
> 
> Sure

I pushed this commit to my master branch. The only changes are:

1. Update to kdoc.
2. Removed change to tpm2_flush_context_cmd() (should not be part
   of the commit).

 Did not make sense to cycle it through ML anymore.

/Jarkko
