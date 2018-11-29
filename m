Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D8C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262012146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0wZ9qjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262012146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeK3K0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3K0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:26:31 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E427121019;
        Thu, 29 Nov 2018 23:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543533559;
        bh=csSKUpgZONU0nmpFRcE2r6cm1Jjd5vLKitToD311j7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G0wZ9qjZuV0yYSK+4OQpDBmYs4axW2Y7HXSvy/l9/SA0P5E+8YJju6FMAOEQ5+KC7
         zEidhTmNj1xvUPPOJQeCSIxilF62hZwVYPQeR0bI2mCrNdJ+TjuNKwscv2nToxLyiK
         JOs16kBo3rDyz6r9FC3T+TkftNqpBb/wUo3n5kBM=
Date:   Fri, 30 Nov 2018 08:19:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/2] =?ISO-2022-JP?B?RG9uGyRCIUcbKEJ0?= leave executable
 TLB entries to freed pages
Message-Id: <20181130081913.916a27c8230b125da4bcf2f7@kernel.org>
In-Reply-To: <4cddc2ba36ba3b6d528556207b8d4592209797ea.camel@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
        <20181129230616.f017059a093841dbaa4b82e6@kernel.org>
        <4cddc2ba36ba3b6d528556207b8d4592209797ea.camel@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 18:49:26 +0000
"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:

> On Thu, 2018-11-29 at 23:06 +0900, Masami Hiramatsu wrote:
> > On Tue, 27 Nov 2018 16:07:52 -0800
> > Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> > 
> > > Sometimes when memory is freed via the module subsystem, an executable
> > > permissioned TLB entry can remain to a freed page. If the page is re-used to
> > > back an address that will receive data from userspace, it can result in user
> > > data being mapped as executable in the kernel. The root of this behavior is
> > > vfree lazily flushing the TLB, but not lazily freeing the underlying pages. 
> > 
> > Good catch!
> > 
> > > 
> > > There are sort of three categories of this which show up across modules,
> > > bpf,
> > > kprobes and ftrace:
> > 
> > For x86-64 kprobe, it sets the page NX and after that RW, and then release
> > via module_memfree. So I'm not sure it really happens on kprobes. (Of course
> > the default memory allocator is simpler so it may happen on other archs) But
> > interesting fixes.
> Yes, I think you are right, it should not leave an executable TLB entry in this
> case. Ftrace actually does this on x86 as well.
> 
> Is there some other reason for calling set_memory_nx that should apply elsewhere
> for module users? Or could it be removed in the case of this patch to centralize
> the behavior?

According to the commit c93f5cf571e7 ("kprobes/x86: Fix to set RWX bits correctly
before releasing trampoline"), if we release readonly page by module_memfree(),
it causes kernel crash. And at this moment, on x86-64 set the trampoline page
readonly becuase it is an exacutable page. Setting NX bit is for security reason
that should be set before making it writable.
So I think if you centralize setting NX bit, it should be done before setting
writable bit.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
