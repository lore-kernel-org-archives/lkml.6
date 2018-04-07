Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeDGKgU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 06:36:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:5840 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbeDGKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 06:36:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,418,1517904000";
   d="scan'208";a="218374847"
Date: Sat, 7 Apr 2018 13:36:10 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
Message-ID: <20180407103610.GA22542@linux.intel.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
 <20180405101210.GA21636@linux.intel.com>
 <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:03:37PM +0530, Nayna Jain wrote:
> On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> > On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> > > Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> > > handle the TPM2_RC_RETRY error. The loop retries the command after
> > > sleeping for the specified time, which is incremented exponentially in
> > > every iteration. This patch fixes the initial sleep to be the default
> > > sleep time.
> > I think I understand the code change but do not understand what the
> > long description.
> 
> It tells that the first sleep is delay_msec * 2 and not delay_msec.

So the problem is that the loop doubles the time before sleeping
for the first time. This is missing from the description. Please
refine it in some way.

/Jarkko
