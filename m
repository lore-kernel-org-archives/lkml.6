Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2B217B9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B2B217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFURRw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:17:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:30223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932800AbeFURRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:17:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 10:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="51190584"
Received: from lmrad-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2018 10:17:46 -0700
Date:   Thu, 21 Jun 2018 20:17:46 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        James.Bottomley@HansenPartnership.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
Message-ID: <20180621171746.GJ11859@linux.intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
 <20180619131046.GC5609@linux.intel.com>
 <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:45:35PM -0700, Tadeusz Struk wrote:
> Hi Jarkko,
> Thanks for reviewing the patch.
> There are applications/frameworks where a worker thread is not an option.
> Take for example the IoT use-cases and frameworks like IoT.js, or "Node.js for IoT".
> They are all single threaded, event-driven frameworks, using non-blocking I/O as the base of their processing model.
> Similarly embedded applications, which are basically just a single threaded event loop, quite often don't use threads because of resources constrains.
> 
> If your concern is that user space will not adopt to this, I can say that TSS library [1] is currently blocked on this feature, and we can not enable some of the use-cases mentioned above because of this.
> 
> Thanks,
> Tadeusz
> 
> [1] https://github.com/tpm2-software/tpm2-tss

I put this into "mathematical" terms. TPM is by nature is blocking. It
does not scale this way so you are essentially just simulating
non-blocking behaviour.

/Jarkko
