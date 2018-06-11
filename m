Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2YAwBdYhHluMWgAAmS7hNA
	; Mon, 11 Jun 2018 07:16:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AAB3F60792; Mon, 11 Jun 2018 07:16:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2285B605A5;
	Mon, 11 Jun 2018 07:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2285B605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeFKHQw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:16:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:51769 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754001AbeFKHQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:16:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 00:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,500,1520924400";
   d="scan'208";a="48012419"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2018 00:16:49 -0700
Date: Mon, 11 Jun 2018 15:26:48 +0800
From: Philip Li <philip.li@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 68abbe729567cef128b2c2141f2ed2567f3b8372
Message-ID: <20180611072648.GA8748@intel.com>
References: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com>
 <CA+55aFwHCJ-ra6GOz3bFXx21D1bOjN4L11Dybr5t2OHCAYCL5Q@mail.gmail.com>
 <20180609002917.GA22101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609002917.GA22101@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 08:29:17AM +0800, Philip Li wrote:
> On Fri, Jun 08, 2018 at 08:48:29AM -0700, Linus Torvalds wrote:
> > On Fri, Jun 8, 2018 at 8:12 AM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > arch/sh/include/asm/io.h:246:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > arch/x86/net/bpf_jit_comp32.c:2449 do_jit() warn: potential off by one 'addrs[]' limit 'bpf_prog->len'
> > > drivers/acpi/battery.c:720:3-9: preceding lock on line 701
> > > drivers/gpu/drm/amd/amdkfd/Kconfig:8: unknown option "imply"
> > > drivers/gpu/drm/amd/amdkfd/Kconfig:9: syntax error
> > > .. lots of these ..
> > 
> > Hmm? Is the kbuild robot not feeling well? This looks odd.
> Thanks Linus, we will follow up to check what possibly went wrong here,
> this does look unreasonable.
Hi Linus, this is caused by some cherry picked old commits are compiled on one
randconfig, and triggers bisect. The error is discussed before as you may know,
at https://patchwork.kernel.org/patch/9459363/ or
http://lkml.iu.edu/hypermail/linux/kernel/1611.2/01337.html.

The bisect considers the errors belong to mainline tree, meanwhile, there's a
corner case, the bot sends out this mail externally which is supposed to send
only internally for double check.

Kindly ignore this. We will continue the improvement of the bot.

> 
> > 
> >                     Linus
> > 
