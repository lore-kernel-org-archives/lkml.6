Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8E8217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bwj5kH7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeLRJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:19:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VsFfhRXaZebKtuBfnxACiTbRMtGxqmEyBsj6azXoeiA=; b=Bwj5kH7CBEnLxw8ZAvERHI5nH
        Z63YB8R6p2wYgj7C+ZpKqqySjM44PkJ5/GcCtnkORnJf4NDUhu9wNC96TSkcU6yKuIf/mF30qVlt7
        06qIg1kd7U3l7aT/vaAam3m2NoTWhkBPlKgLV1BTpxnlTzwpEWiXGA+UWExEifP0grfhUdaQFCt/m
        pl+zq1biTvDIwdBhcao4MPVo4mN6Q+oerroWMFSUv+HzLn1IkKP/TWN1y60zsNxlu/+G5pd/84E3i
        SDiiCcptdBZPcC0193UO3lPww6PRsXfDMyQfF6g8ggX9lBSSjA7JEEHsh2IaBJHpi16K3bP0g+noc
        h5fSKEuVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZBXL-0002wu-30; Tue, 18 Dec 2018 09:19:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 832A62027DA8E; Tue, 18 Dec 2018 10:19:32 +0100 (CET)
Date:   Tue, 18 Dec 2018 10:19:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218091932.GJ2218@hirez.programming.kicks-ass.net>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217205535.GT25620@tassilo.jf.intel.com>
 <20181217223524.GH2218@hirez.programming.kicks-ass.net>
 <20181217235950.GZ25620@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217235950.GZ25620@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:59:50PM -0800, Andi Kleen wrote:
> BTW I have a user base for LTO and so far noone has reported any issues
> like this.

Because ordering issues are immediately obvious and easy to debug no
doubt.
