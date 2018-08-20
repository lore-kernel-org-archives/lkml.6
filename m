Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDAFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973C220C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973C220C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHTXfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:35:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:8081 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTXfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:35:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 13:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="64633644"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2018 13:18:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A15DF300DDE; Mon, 20 Aug 2018 13:18:43 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:18:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        dvyukov@google.com, hughd@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabled
Message-ID: <20180820201843.GA15008@tassilo.jf.intel.com>
References: <20180817222733.GA18575@roeck-us.net>
 <20180820162938.GR29735@dhcp22.suse.cz>
 <20180820180353.GO12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820180353.GO12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 11:03:53AM -0700, Andi Kleen wrote:
> On Mon, Aug 20, 2018 at 06:29:38PM +0200, Michal Hocko wrote:
> > On Fri 17-08-18 15:27:33, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > the following crash is seen in v4.4.148, v4.4.149, v4.9.120, and v4.9.121
> > > with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y.
> > 
> > Could you try to apply fd7e315988b7 ("x86/mm: Simplify p[g4um]d_page()
> > macros"). I do not see it in stable 4.4 tree and it has been introduced
> > much later in 4.14. This one gave us quite some headache because it is
> > soooo easy to overlook.
> 
> Good catch!
> 
> I tested that with 4.9 and backporting the patch indeed fixes the
> syzcaller test case running in a KVM VM. Backported patch appended.

Tested on 4.4 too and it fixes the syzkaller test case there too.

-Andi
