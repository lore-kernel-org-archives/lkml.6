Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AAD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AAD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIJX2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:28:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:34820 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeIJX2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:28:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 11:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="256020382"
Received: from fbaehren-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.49.250])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2018 11:33:02 -0700
Date:   Mon, 10 Sep 2018 21:33:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 11/13] platform/x86: Intel SGX driver
Message-ID: <20180910183301.GA20225@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-12-jarkko.sakkinen@linux.intel.com>
 <CAHp75VcqKunkHYNdd287_F7APHwYr7K9QD2PVCkqBqJWG2_E-g@mail.gmail.com>
 <20180905173355.GE11368@linux.intel.com>
 <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
 <20180906092100.GA27302@linux.intel.com>
 <CANiq72kpY1y2aPH+GMi8mWZdttfdYJ3wk0cvE_qVD97vdvTJbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kpY1y2aPH+GMi8mWZdttfdYJ3wk0cvE_qVD97vdvTJbQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:35:46PM +0200, Miguel Ojeda wrote:
> Hi Jarkko,
> 
> On Thu, Sep 6, 2018 at 11:21 AM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > There is another open. If I grep through the kernel tree I see SPDX
> > headers that are decorated both with C99- and C89-style comments. I
> > guess I ended up using C99-style because when I was instructed to add
> > SPDX headers in the first place that was the example I was given. Still
> > checkpatch.pl complains about C99-style comments.
> >
> > Which one is right and why the kernel tree is polluted with C99-headers
> > when they do not pass checkpatch.pl? How those commits were ever
> > accepted?
> 
> See Documentation/process/license-rules.rst. Headers should go with
> C-style comments:
> 
>    The SPDX license identifier is added in form of a comment.  The comment
>    style depends on the file type::
> 
>       C source: // SPDX-License-Identifier: <SPDX License Expression>
>       C header: /* SPDX-License-Identifier: <SPDX License Expression> */
> 
> And:
> 
>    If a specific tool cannot handle the standard comment style, then the
>    appropriate comment mechanism which the tool accepts shall be used. This
>    is the reason for having the "/\* \*/" style comment in C header
>    files. There was build breakage observed with generated .lds files where
>    'ld' failed to parse the C++ comment. This has been fixed by now, but
>    there are still older assembler tools which cannot handle C++ style
>    comments.
> 
> The ones that got in are probably either old or they slipped through
> (and they do not break the build).

Thank you, this clears things up. Highly appreciated!

> Cheers,
> Miguel

/Jarkko
