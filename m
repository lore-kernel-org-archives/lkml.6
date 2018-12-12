Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E8C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58052084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58052084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeLLScM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:32:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:59089 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeLLScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:32:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 10:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="101024909"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2018 10:32:06 -0800
Date:   Wed, 12 Dec 2018 20:32:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v6 1/7] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20181212183204.GK6333@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-2-roberto.sassu@huawei.com>
 <20181204231848.GA1233@linux.intel.com>
 <9193bc05-8222-f0d6-9ad8-a2a7eaf1a34c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9193bc05-8222-f0d6-9ad8-a2a7eaf1a34c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:56:33PM +0100, Roberto Sassu wrote:
> 2 PCR selections
>     hash TPM_ALG_SHA1
>     TPMS_PCR_SELECTION length 3
>     ff ff ff
>     hash TPM_ALG_SHA256
>     TPMS_PCR_SELECTION length 3
>     00 00 00
> 
> The pcr_select fields - "ff ff ff" and "00 00 00" - are bit masks for
> the enabled PCRs. The SHA1 bank is enabled for all PCRs (0-23), while
> the SHA256 bank is not enabled.

Uh, thanks. Can you add a note to the commit message?

 
> > 
> > /* Check that at least some of the PCRs have been allocated. This is
> >   * required because CAP_PCRS ...
> >   */
> > if (memchr_inv(pcr_selection.pcr_select, 0, pcr_selection.size_of_select))
> > 	nr_allocated_banks++;
> > 
> > [yeah, comment would be awesome about CAP_PCRS. Did not finish up the
> > comment because I don't know the answer]
> > 
> > In addition, it would be consistent to call the local variable also
> > nr_allocated_banks (not nr_alloc_banks).
> 
> Unfortunately, I exceed the limit of characters per line.

Not sure what you mean?

/Jarkko
