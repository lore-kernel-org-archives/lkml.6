Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD181C04ABF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED80217A6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED80217A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeHRFwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 01:52:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:7445 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeHRFwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 01:52:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 19:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,254,1531810800"; 
   d="scan'208";a="81290892"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2018 19:46:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2CD11300C6D; Fri, 17 Aug 2018 19:46:31 -0700 (PDT)
Date:   Fri, 17 Aug 2018 19:46:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabled
Message-ID: <20180818024631.GJ12066@tassilo.jf.intel.com>
References: <20180817222733.GA18575@roeck-us.net>
 <CA+55aFw6KDEts1bk7F-HYVn_dSuFQHZZh89Ydqh1rFn-c5V+eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw6KDEts1bk7F-HYVn_dSuFQHZZh89Ydqh1rFn-c5V+eQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Plus I'd have expected the problem to have been in mainline too, and
> apparently it's just the 4.4 and 4.9 backports.

There's another problem in 4.17, but not 4.18, see 
https://bugzilla.redhat.com/show_bug.cgi?id=1618792

Could be the same or different.

-Andi

> 
> Your test-case does have mprotect with PROT_NONE. Which together with
> that mask that *might* be PHYSICAL_PMD_PAGE_MASK makes me think it
> might be related.
> 
>              Linus
