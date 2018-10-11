Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6771BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3399A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3399A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeJKT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:28:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:38243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeJKT2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:28:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 05:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="94293216"
Received: from mrahma3x-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.109])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2018 05:01:41 -0700
Date:   Thu, 11 Oct 2018 15:01:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181011120140.GA15767@linux.intel.com>
References: <20181010133817.GA11485@embeddedor.com>
 <20181010140638.GA3894@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010140638.GA3894@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 08:06:38AM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> > Currently, there are some values assigned to variable *rc*, which
> > are never actually used in any computation, because such variable
> > is updated at line 550, before they can be used:
> > 
> > 549out:
> > 550        rc = tpm_go_idle(chip, flags);
> > 551        if (rc)
> > 552                goto out;
> > 
> > Fix this by removing such assignments. 
> 
> Should this be done by not quashing rc during the error unwind rather
> than dropping the errors?

Yeah.`

Wondering if tpm_go_idle() should simply be a void-function i.e. issue
just a warning inside (disclaimer: did not revisit its code when writing
this).

> Jason

/Jarkko
