Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86C218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfB0BC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:02:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:32375 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbfB0BCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:02:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 17:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,417,1544515200"; 
   d="scan'208";a="121071040"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2019 17:02:53 -0800
Date:   Tue, 26 Feb 2019 15:57:34 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>,
        weijiang.yang@intel.com
Subject: Re: [PATCH v3 2/8] KVM:CPUID: Define CET CPUID bits and CR4.CET
 master enable bit.
Message-ID: <20190226075734.GB10256@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-3-weijiang.yang@intel.com>
 <CALMp9eRJ_ayTPbDC5nOuJ00GjRxqd+je0qAyCoeyU9zT698XhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRJ_ayTPbDC5nOuJ00GjRxqd+je0qAyCoeyU9zT698XhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:48:59AM -0800, Jim Mattson wrote:
> On Mon, Feb 25, 2019 at 10:32 PM Yang Weijiang <weijiang.yang@intel.com> wrote:
> >
> > Guest queries CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> > in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> > corresponds to IBT feature.
> > CR4.CET[bit 23] is CET master enable bit, it controls CET feature
> > availability in guest OS.
> >
> > Note: Although SHSTK or IBT can be enabled independently,
> >       either of the features is controlled by CR4.CET.
> >
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> 
> Am I missing something? X86_CR4_CET and X86_FEATURE_SHSTK and
> X86_FEATURE_IBT don't appear to be defined in Linus' tree.
The patch-set has dependency on this CET Kernel patch-set:
https://lkml.org/lkml/2018/11/20/203
I reused some definitions from the kernel patches.

