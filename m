Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D2021736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfBSPgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:36:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:57148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSPgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:36:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 07:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="276199068"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2019 07:36:05 -0800
Date:   Tue, 19 Feb 2019 07:36:05 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm tree
Message-ID: <20190219153605.GC29888@linux.intel.com>
References: <20190218144200.2dc3283f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218144200.2dc3283f@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 02:42:00PM +1100, Stephen Rothwell wrote:
> Hi all,

...

> Caused by commits
> 
>   1561fcbc8e16 ("KVM: x86: Explicitly #define the VCPU_REGS_* indices")
>   a46e726511f4 ("KVM: VMX: Move vCPU-run code to a proper assembly routine")
> 
> It looks like a file was not git added :-(

Yep, 1561fcbc8e16 should have introduced arch/x86/include/asm/kvm_vcpu_regs.h.

I assume there's nothing to do but wait for Paolo or Radim to fixup the
KVM tree?


Original patch:

  https://patchwork.kernel.org/patch/10781575/
