Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4283C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908422070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfACPEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:04:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:11522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfACPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:04:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 07:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="132664067"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.238])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2019 07:04:35 -0800
Date:   Thu, 3 Jan 2019 17:04:34 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
Message-ID: <20190103150434.GC17015@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
 <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
 <1545519232.3940.115.camel@linux.ibm.com>
 <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
 <20190103132737.GD10491@linux.intel.com>
 <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 02:38:11PM +0100, Michael Niewöhner wrote:
> On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> > On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > > There is another issue but I don't know if both are related. Maybe that's
> > > just a
> > > timing issue...
> > > 
> > > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > > dd: error reading '/dev/hwrng': Operation not permitted
> > > 0+0 records in
> > > 0+0 records out
> > > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng bs=1
> > > count=1 | xxd
> > > dd: error reading '/dev/hwrng': Operation not permitted
> > > 0+0 records in
> > > 0+0 records out
> > > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > > 1+0 records in
> > > 1+0 records out
> > > 00000000: 52                                       R
> > > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > > 
> > > 
> > > Michael
> > 
> > What does /sys/devices/virtual/misc/hw_random/rng_current show?
> > 
> > Did run commands as a sanity check on my laptop and seem to work.
> > 
> > /Jarkko
> 
> rng_current says "tpm-rng-0", which should be correct

Is /dev/tpm0 accessible and usable?

/Jarkko
