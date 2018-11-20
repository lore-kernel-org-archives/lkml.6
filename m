Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E570BC41537
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C1321479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C1321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKUJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:39:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:30315 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeKUJjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:39:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 15:08:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="87466627"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2018 15:08:01 -0800
Date:   Wed, 21 Nov 2018 01:07:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tpm: add support for partial reads
Message-ID: <20181120230759.GF8391@linux.intel.com>
References: <154265371562.23494.10113870855345906523.stgit@tstruk-mobl1.jf.intel.com>
 <20181120124810.GB8813@linux.intel.com>
 <77b031b2-7fa2-f057-1e6a-70f0427ec6c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b031b2-7fa2-f057-1e6a-70f0427ec6c4@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:36:14AM -0800, Tadeusz Struk wrote:
> On 11/20/18 4:48 AM, Jarkko Sakkinen wrote:
> >> +	/* Holds the resul of the last successful call to tpm_transmit() */
> > This comment is cruft.
> 
> Do you want me to remove it? This is the comment you proposed.

As I explained before it made sense before you made the remark that
it can only get positive values i.e. the length.

> > data_pending would be now perfectly fine name now that we concluded
> > that the original length is not needed to be stored. Better than this
> > as once you decrease it the variable name and contents mismatch.
> > 
> 
> Can we finally agree on something? We have changed three times already.
> response_length is exactly what it is and data_pending is a bit vague.

You are correct in this one. If I remember right, I finally proposed
'response_pending' because 'data_pending' is really vague. For me
'response_length' is just fine too.

If you see problem in my review comment or inconsistency or whatever,
please just state it. I will listen. When you multitask between patch
reviews etc. forgetting stuff is not unheard.

And seriously, 5th iteration is not alot. User space facing changes
need alot of consideration and as uncluttered code change as possible.

/Jarkko
