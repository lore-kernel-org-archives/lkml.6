Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 993CEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49105208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49105208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935620AbeFMUiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:38:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:57776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935352AbeFMUiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:38:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="237219401"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2018 13:38:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1DDC0166; Wed, 13 Jun 2018 23:38:05 +0300 (EEST)
Date:   Wed, 13 Jun 2018 23:38:04 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 02/17] mm/khugepaged: Do not collapse pages in
 encrypted VMAs
Message-ID: <20180613203804.bpeipe4txckja6na@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-3-kirill.shutemov@linux.intel.com>
 <f0e4648f-a458-856e-8a06-d186c280530a@intel.com>
 <20180613201802.45m2745soztmkxmp@black.fi.intel.com>
 <7dccd52e-ca46-b417-5a7b-274dc7ff3e44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dccd52e-ca46-b417-5a7b-274dc7ff3e44@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 08:20:28PM +0000, Dave Hansen wrote:
> On 06/13/2018 01:18 PM, Kirill A. Shutemov wrote:
> >> Are we really asking the x86 maintainers to merge this feature with this
> >> restriction in place?
> > I gave it more thought after your comment and I think I see a way to get
> > khugepaged work with memory encryption.
> 
> So should folks be reviewing this set, or skip it an wait on your new set?

You gave me fair bit of feedback to work on, but AFAICS it doesn't change
anything fundamentally.

More feedback is welcome.

-- 
 Kirill A. Shutemov
