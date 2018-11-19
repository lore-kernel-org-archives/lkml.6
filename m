Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997FC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14C320831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14C320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeKTBGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:06:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:60255 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbeKTBGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:06:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 06:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="87592502"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2018 06:42:57 -0800
Date:   Mon, 19 Nov 2018 16:42:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 7/7] tpm: pass an array of tpm_bank_list structures to
 tpm_pcr_extend()
Message-ID: <20181119144256.GI8755@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-8-roberto.sassu@huawei.com>
 <20181116150352.GA3612@linux.intel.com>
 <9c534ed1-7832-7a3b-3e69-5fcc25c565cc@huawei.com>
 <20181118072901.GB5897@linux.intel.com>
 <5dd9fc97-2fb8-0e17-9ae0-88ce8db83903@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd9fc97-2fb8-0e17-9ae0-88ce8db83903@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:22:32AM +0100, Roberto Sassu wrote:
> On 11/18/2018 8:29 AM, Jarkko Sakkinen wrote:
> > On Fri, Nov 16, 2018 at 04:55:36PM +0100, Roberto Sassu wrote:
> > > I understood from a previous email that you want to include all API
> > > changes for crypto agility in the same patch set.
> > 
> > Hmm.. maybe there is some misunderstading. Can you point me to the
> > comment? Thanks.
> 
> ---
> On Thu, Nov 08, 2018 at 03:24:46PM +0100, Roberto Sassu wrote:
> > Should I include the patch for tpm_pcr_extend() in this patch set, even
> > if the set fixes the digest size issue?
> 
> Just add some note to the cover letter. Makes sense here to have a
> prequel patch for that because otherwise the implementation will be
> a bit messy and half-baked.

Ok, I guess it is OK as long as IMA (namely Mimi) gives that patch
reviewed-by. It is not a huge change.

PS. I noticed that earlier patches have postfixes like '_struct' and
'_ptr' for function arguments. Can you remove them in the next version?

/Jarkko
