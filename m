Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7314C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1332087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1332087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHJVOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:14:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:50006 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbeHJVOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:14:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 11:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,220,1531810800"; 
   d="scan'208";a="247839875"
Received: from shader1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.32.244])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2018 11:43:33 -0700
Date:   Fri, 10 Aug 2018 21:43:31 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: add ptr to the tpm_space struct to file_priv
Message-ID: <20180810184331.GA5294@linux.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
 <153367366462.18015.12915462188877575543.stgit@tstruk-mobl1.jf.intel.com>
 <20180810172700.GU4692@linux.intel.com>
 <2bacb3d8-3897-e147-252f-c49de9e7806b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bacb3d8-3897-e147-252f-c49de9e7806b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:05:17AM -0700, Tadeusz Struk wrote:
> On 08/10/2018 10:27 AM, Jarkko Sakkinen wrote:
> > On Tue, Aug 07, 2018 at 01:27:44PM -0700, Tadeusz Struk wrote:
> >> Add a ptr to struct tpm_space to the file_priv to have an easy
> >> access to it in the async job without the need to allocate memory.
> >> This also allows to consolidate of the write operations for
> >> the two interfaces.
> > 
> > I think the 2nd premise should be the priority and the first premise should
> > be removed as it is not needed in any possible way to justify the
> > change.
> 
> Jarkko,
> The main reason why the pointer to tpm_space struct was added to the
> file_priv was to have access to space in the async job when it is enqueued
> via the /dev/tpm<N> interface. Currently it is only available in tpmrm_priv.
> Otherwise I would need to introduce yet another struct what would consist of
> a ptr file_priv and a ptr to tpm_space and allocate it on every enqueue.
> Much easier was to to it this way. The consolidation was only a side effect
> of this so I think the description is correct.
> Thanks,
> -- 
> Tadeusz

The less dependencies a commit has more easy it is for me pick up. Here
the consodilation is enough to accept the commit but with the current
commit message I cannot apply it without accepting the whole patch set.

/Jarkko
