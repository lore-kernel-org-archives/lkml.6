Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF3C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D010420848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D010420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeKBJql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:46:41 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:48486 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726886AbeKBJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:46:41 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wA20g6Nt003936;
        Fri, 2 Nov 2018 08:42:06 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Fri, 2 Nov 2018
 08:41:21 +0800
Date:   Fri, 2 Nov 2018 08:41:22 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     Christoph Hellwig <hch@infradead.org>, <anup@brainfault.org>,
        <zong@andestech.com>, <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, <greentime@andestech.com>,
        <linux-kernel@vger.kernel.org>, <vincentc@andestech.com>,
        <linux-riscv@lists.infradead.org>, <deanbo422@gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181102004122.GA22741@andestech.com>
References: <20181101005541.GA25604@andestech.com>
 <mhng-22ded2c8-7f87-4acc-b017-627e369cf874@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-22ded2c8-7f87-4acc-b017-627e369cf874@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wA20g6Nt003936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 10:50:04AM -0700, Palmer Dabbelt wrote:
> On Wed, 31 Oct 2018 17:55:42 PDT (-0700), alankao@andestech.com wrote:
> >On Wed, Oct 31, 2018 at 07:17:45AM -0700, Christoph Hellwig wrote:
> >>On Wed, Oct 31, 2018 at 04:46:10PM +0530, Anup Patel wrote:
> >>> I agree that we need a place for vendor-specific ISA extensions and
> >>> having vendor-specific directories is also good.
> >>
> >>The only sensible answer is that we should not allow vendor specific
> >>extensions in the kernel at all.  ...
> >
> >How can this even be possible if a extension includes an extra register
> >set as some domain-specific context?  In such a case, kernel should
> >at least process the context during any context switch, just like how it
> >deals with the FP context.
> 
> Ya, I think there are cases where vendor-specific extensions are going to be
> necessary to handle within the kernel.  Right now the only one I can think
> of is the performance counter stuff, where we explicitly allow
> vendor-specific counters as part of the ISA spec.
> 
> For stateful extensions, we currently have a standard mechanism where the XS
> bits get set in sstatus and the actual save/restore code is hidden behind an
> SBI call.  That call doesn't currently exist, but if we just go ahead and
> add one it should be easy to support this from within Linux.  We'll need to
> figure out how to enable these custom extensions from userspace, but that
> seems tractable as well.  We'll probably also want some fast-path for the V
> extension (and any other stateful standard extensions), but I think as long
> as the V extension adds a quick check for dirtiness then it's not a big
> deal.
> 
> Do you guys have stateful extensions?  We're trying really hard to avoid
> them at SiFive because they're a huge headache, so unless there's a
> compelling base of software using one I don't want to go add support if we
> can avoid it.

Currently no, but the future is hard to see.  As long as the extensible freedom
claimed by the RISC-V foundation remains true, such extensions may have their
role to play.  Don't worry now, I was just to give a example that in some 
possible vendor-specific cases the kernel cannot keep itself from involving.

