Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfANUHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:07:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:11418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbfANUHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:07:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 12:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="310360145"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jan 2019 12:07:37 -0800
Date:   Mon, 14 Jan 2019 12:07:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [BISECTED] KVM error with 5.0-rc
Message-ID: <20190114200737.GC5141@linux.intel.com>
References: <c8d44a6a-bdb6-6b8c-4a50-1d152a3964f8@skogtun.org>
 <20190114183319.GB5141@linux.intel.com>
 <e0633c94-e0a3-a764-a69a-544890e02f63@skogtun.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0633c94-e0a3-a764-a69a-544890e02f63@skogtun.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:17:10PM +0100, Harald Arnesen wrote:
> Sean Christopherson [14.01.2019 19:33]:
> 
> > On Mon, Jan 14, 2019 at 06:04:27PM +0100, Harald Arnesen wrote:
> >> Qemu with KVM acceleration fails with kernel 5.0-rc1 and 5.0-rc2.
> >> It works fine with 4.20.
> 
> > Can you test the attached patch?  Found a bug when re-inspecting the
> > guilty commit, the wrong VMCS field is being modifying when applying an
> > errata to disable VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL.  Your CPU is
> > listed as one of the models affected by the errata.  Compile tested only.
> 
> Yes, this patch fixes the error.

Awesome, thanks!

> 
> Feel free to add a "Tested-by: Harald Arnesen <harald@skogtun.org>".
> -- 
> Hilsen Harald
