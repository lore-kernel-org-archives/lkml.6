Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDJMbR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:31:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:15795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbeDJMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:31:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="32243827"
Message-ID: <d7989ecd5e2d6463636ba291128b525b89cb2521.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com
Date: Tue, 10 Apr 2018 15:31:09 +0300
In-Reply-To: <1523284198.16421.196.camel@linux.vnet.ibm.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
         <20180405101210.GA21636@linux.intel.com>
         <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
         <20180407103610.GA22542@linux.intel.com>
         <1523284198.16421.196.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 10:29 -0400, Mimi Zohar wrote:
> On Sat, 2018-04-07 at 13:36 +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 06, 2018 at 02:03:37PM +0530, Nayna Jain wrote:
> > > On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> > > > > Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> > > > > handle the TPM2_RC_RETRY error. The loop retries the command after
> > > > > sleeping for the specified time, which is incremented exponentially in
> > > > > every iteration. This patch fixes the initial sleep to be the default
> > > > > sleep time.
> > > > 
> > > > I think I understand the code change but do not understand what the
> > > > long description.
> > > 
> > > It tells that the first sleep is delay_msec * 2 and not delay_msec.
> > 
> > So the problem is that the loop doubles the time before sleeping
> > for the first time. This is missing from the description. Please
> > refine it in some way.
> 
> Sure, how about replacing the last line of the patch description with:
>     Unfortunately, the loop doubles the time before sleeping, causing the
>     initial sleep to be doubled.  This patch fixes the initial sleep time.
> 
> If this change is acceptable, do you want to make the change or should Nayna
> repost the patch?

No need. I'll move on to testing.

/Jarkko
