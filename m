Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A8ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7FF2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7FF2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeITESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:18:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:48408 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeITESa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:18:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 15:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="74641137"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2018 15:38:25 -0700
Date:   Wed, 19 Sep 2018 16:40:19 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 6/7] mm/gup: Combine parameters into struct
Message-ID: <20180919224019.GB29003@localhost.localdomain>
References: <20180919210250.28858-1-keith.busch@intel.com>
 <20180919210250.28858-7-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919210250.28858-7-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:02:49PM -0600, Keith Busch wrote:
>  	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
> -		page = follow_huge_pd(vma, address,
> -				      __hugepd(pmd_val(pmdval)), flags,
> -				      PMD_SHIFT);
> +		page = follow_huge_pd(ctx->vma, ctx->address,
> +				      __hugepd(pmd_val(pmdval)),
> +				      ctx->flags, PGDIR_SHIFT);

Shoot, that should have been PMD_SHIFT.

I'll let this current set sit a little longer before considering v2.
