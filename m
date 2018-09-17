Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83242086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83242086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIRCsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:48:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:37683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeIRCsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:48:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 14:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="92550334"
Received: from maclarck-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.39.44])
  by orsmga002.jf.intel.com with ESMTP; 17 Sep 2018 14:19:01 -0700
Date:   Tue, 18 Sep 2018 00:19:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Restore functionality to xen vtpm driver.
Message-ID: <20180917211900.GD6716@linux.intel.com>
References: <20180913212551.2435-1-boris.ostrovsky@oracle.com>
 <20180916192510.GF7473@linux.intel.com>
 <b82c4603-1a60-16ec-14b6-81251e114b75@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82c4603-1a60-16ec-14b6-81251e114b75@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:54:37AM -0400, Boris Ostrovsky wrote:
> On 9/16/18 3:25 PM, Jarkko Sakkinen wrote:
> > On Thu, Sep 13, 2018 at 05:25:51PM -0400, Boris Ostrovsky wrote:
> >> From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>
> >>
> >> Functionality of the xen-tpmfront driver was lost secondary to
> >> the introduction of xenbus multi-page support in commit ccc9d90a9a8b
> >> ("xenbus_client: Extend interface to support multi-page ring").
> >>
> >> In this commit a pointer to the shared page address was being
> >> passed to the xenbus_grant_ring() function rather then the
> >> address of the shared page itself.  This resulted in a situation
> > I'm sorry but I'm far from being expert with Xen and this sentence
> > confuses me so maybe could open it up a bit.
> >
> > For me "shared page address" and "address of the shared page" are
> > the same thing. What am I missing? I mean just different forms in
> > english to describe the exact same thing...
> 
> xenbus_grant_ring() takes as an argument address of the ring shared
> between two guests. What Greg was trying to describe was the fact that
> existing code instead passes address of location where this address is
> stored (i.e. somewhat similar to difference between pointer and pointer
> to a pointer).

Just to understand this bug better why did not the wrong version
cause any undefined behavior? Sounds like a fatal bug. Does this
cause crashes?

> Would this be better:
> 
> "In this commit pointer to location of the where the shared page address
> is stored was being passed to the xenbus_grant_ring() function rather
> then the
> address of the shared page itself."

Yes, definitely!

> Or please suggest a better alternative, I'll be happy to amend the
> commit message.

Thank you.

> Thanks.
> -boris

/Jarkko
