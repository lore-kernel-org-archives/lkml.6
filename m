Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5F20873
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeIFN4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:56:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:47312 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeIFN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:56:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 02:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="78403172"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.69])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2018 02:21:01 -0700
Date:   Thu, 6 Sep 2018 12:21:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        suresh.b.siddha@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 11/13] platform/x86: Intel SGX driver
Message-ID: <20180906092100.GA27302@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-12-jarkko.sakkinen@linux.intel.com>
 <CAHp75VcqKunkHYNdd287_F7APHwYr7K9QD2PVCkqBqJWG2_E-g@mail.gmail.com>
 <20180905173355.GE11368@linux.intel.com>
 <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:36:54PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 5, 2018 at 8:34 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Tue, Sep 04, 2018 at 08:59:58PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Thanks, very detailed! Does not make sense to ack these separately so I
> > just say that I try to fix them all with care.
> 
> Just comment on which you disagree.
> I think one of them is the header file location. It seems I missed
> it's current place.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Ah, right, sorry forgot to comment it in LKML.

There is another open. If I grep through the kernel tree I see SPDX
headers that are decorated both with C99- and C89-style comments. I
guess I ended up using C99-style because when I was instructed to add
SPDX headers in the first place that was the example I was given. Still
checkpatch.pl complains about C99-style comments.

Which one is right and why the kernel tree is polluted with C99-headers
when they do not pass checkpatch.pl? How those commits were ever
accepted?

/Jarkko
