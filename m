Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C22C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81543208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81543208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeFUP12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:27:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:45949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933114AbeFUP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:27:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 08:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="66091318"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2018 08:27:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C6E69143; Thu, 21 Jun 2018 18:27:25 +0300 (EEST)
Date:   Thu, 21 Jun 2018 18:27:25 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from
 relocation
Message-ID: <20180621152725.oewogsv2alkicy6s@black.fi.intel.com>
References: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
 <alpine.LSU.2.11.1805022001080.3096@eggly.anvils>
 <20180503083849.j42uzp6jjpauk475@kshutemo-mobl1>
 <20180503105205.qmosbbbbp5jssehj@black.fi.intel.com>
 <alpine.LSU.2.11.1805031017420.1259@eggly.anvils>
 <20180621151805.GA27636@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621151805.GA27636@gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:18:05PM +0000, Ingo Molnar wrote:
> 
> * Hugh Dickins <hughd@google.com> wrote:
> 
> > On Thu, 3 May 2018, Kirill A. Shutemov wrote:
> > 
> > > On Thu, May 03, 2018 at 08:38:49AM +0000, Kirill A. Shutemov wrote:
> > > > The patch is bogus and I still don't understand what is going on.
> > > 
> > > I think I found the issue. Could you check the patch below:
> > 
> > Sorry, no good on either machine, immediate reboot as before.
> > I'm gathering the info you asked, will send privately in an hour or so.
> 
> Hi, any update on this bug?
> 
> Kirill: mind (re-)sending a series of any resulting patches that you have pending?
> 
> If there's no fix, is there any list of SHA1's to revert?

The root cause of the bug was fixed in v4.17 by

  5c9b0b1c4988 ("x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()").

The only pending patch I have at the moment is

http://lkml.kernel.org/r/20180612103657.18041-1-kirill.shutemov@linux.intel.com

Do you want me to resend it again?

-- 
 Kirill A. Shutemov
